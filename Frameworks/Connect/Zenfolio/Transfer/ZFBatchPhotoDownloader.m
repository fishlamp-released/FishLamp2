//
//  ZFBatchPhotoDownloader.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFBatchPhotoDownloader.h"
#import "FLPrepareDownloadQueueOperation.h"
#import "ZFPhotoDownloader.h"
#import "FLAsyncOperationQueue.h"
#import "ZFPhotoSetDownloader.h"
#import "ZFBatchPhotoSetDownloader.h"
#import "ZFPhotoDownloader.h"
#import "FLAtomic.h"
#import "FLTrace.h"
#import "ZFPhotoDownloaderQueue.h"

//@interface ZFDownloadPhotoSetsForBatchPhotoDownloader : ZFBatchPhotoSetDownloader {
//}
//
//@end
//
//
//@implementation ZFDownloadPhotoSetsForBatchPhotoDownloader
//
//- (void) willStartOperationInAsyncQueue:(id) operation {
//
//    [super willStartOperationInAsyncQueue:operation];
//    
//    FLPerformSelector2(self.delegate, @selector(batchPhotoSetDownloader:willDownloadPhotoSet:), self, nil);
//}
//
//- (void) didFinishOperationInAsyncQueue:(FLOperation*) operation withResult:(FLPromisedResult) result {
//
//    [super didFinishOperationInAsyncQueue:operation withResult:result];
//    
//    if(![result error]) {
//        if(_group) {
//            [_group replaceElement:result.value];
//        }
//        
//        FLPerformSelector2(self.delegate, @selector(batchPhotoSetDownloader:didDownloadPhotoSet:), self, result);
//    }
//}
//
//@end
//

@interface ZFBatchPhotoDownloader ()
@property (readwrite, strong) ZFBatchDownloadSpec* downloadSpec; 
@property (readwrite, strong) NSArray* downloadQueue; 
@property (readwrite, strong, nonatomic) ZFGroup* rootGroup;
@property (readwrite, strong) ZFTransferState* transferState;
@end

@implementation ZFBatchPhotoDownloader

@synthesize downloadSpec = _downloadSpec;
@synthesize downloadQueue = _downloadQueue;
@synthesize rootGroup = _rootGroup;
@synthesize transferState = _transferState;

- (id) initWithDownloadSpec:(ZFBatchDownloadSpec*) downloadSpec {	
	self = [super init];
	if(self) {
		self.downloadSpec = downloadSpec;
        
        _downloadQueue = [[NSMutableArray alloc] init];
        
        _transferState = [[ZFTransferState alloc] init];
        
        _downloadVideos = NO;
        _downloadImages = NO;
        
        for(ZFMediaType* type in _downloadSpec.mediaTypes) {
            if(type.mediaTypeID == ZFMediaTypeVideo) {
                _downloadVideos = YES;
            }
            if(type.mediaTypeID == ZFMediaTypeOriginalImage) {
                _downloadImages = YES;
            }
        }
	}
	return self;
}

+ (id) batchPhotoDownloadOperation:(ZFBatchDownloadSpec*) spec {
    return FLAutorelease([[[self class] alloc] initWithDownloadSpec:spec]);
}

#if FL_MRC
- (void) dealloc {
    [_transferState release];
	[_downloadSpec release];
    [_downloadQueue release];
    [_rootGroup release];
    [super dealloc];
}
#endif

- (void) updateProgress:(BOOL) canDefer {
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    if(!canDefer || ([NSDate timeIntervalSinceReferenceDate] - _lastProgress) > 0.3) {
        [self.observer receiveObservation:@selector(transferStateWasUpdated:forBatchPhotoDownload:) withObject:self.transferState withObject:self.downloadSpec];
        _lastProgress = now;
    }
}

- (void) photoDownloader:(ZFPhotoDownloader*) downloader 
            didReadBytes:(FLHttpRequestByteCount*) amount
                forPhoto:(ZFDownloadSpec*) downloadSpec {
    
    self.transferState.bytesPerSecondTotal += amount.bytesPerSecond;
    self.transferState.bytesPerSecondCountForAveraging++;
    self.transferState.byteCount += [amount lastIncrementAmount];
    [self updateProgress:YES];
}                

- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
   didDownloadPhotoSetWithResult:(FLPromisedResult) result {
   
   if([result error]) {
        return;
   }
   
   ZFPhotoSet* photoSet = result;
   
    NSString* relativePath =  [_rootGroup relativePathForElement:photoSet];
    NSString* folderPath = [_downloadSpec.destinationPath stringByAppendingPathComponent:relativePath];
    
    for(ZFPhoto* photo in photoSet.Photos) {

        ZFMediaType* mediaType = nil;
        if(_downloadVideos && photo.IsVideoValue) {
            _transferState.videoTotal++;
            _transferState.byteTotal += photo.SizeValue;
            mediaType = [ZFMediaType video];
        }
        else if(_downloadImages && !photo.IsVideoValue) {
            _transferState.photoTotal++;
            _transferState.byteTotal += photo.SizeValue;
            mediaType = [ZFMediaType originalImage];
        }
        else { 
            continue;
        }

        ZFDownloadSpec* download = [ZFDownloadSpec downloadSpec:photo];
        download.mediaType = mediaType;
        NSString* fileName = [mediaType humanReadableFileNameForPhoto:photo inPhotoSet:photoSet];
        download.fullPathToFile = [folderPath stringByAppendingPathComponent:fileName];
        download.relativePath = [relativePath stringByAppendingPathComponent:fileName];
        download.tempFolder = [_downloadSpec.destinationPath stringByAppendingPathComponent:@".download"];
        download.rootGroupID = self.downloadSpec.rootGroupID;
        download.photoSetID = photoSet.Id;
        
        [_downloadQueue addObject:download];
        
        if(self.wasCancelled) {
            return;
        }
    }
    
    [self updateProgress:YES];
}        


- (void) beginDownloadingPhotos {
    [self.transferState setStarted];
    ZFPhotoDownloaderQueue* downloadQueue = [ZFPhotoDownloaderQueue photoDownloaderQueue:_downloadQueue];
    [self runChildAsynchronously:downloadQueue completion:^(FLPromisedResult result) {
        [self.finisher setFinishedWithResult:result];
    }];
}

- (void) didDownloadPhotoSets:(FLPromisedResult) result {

    if([result error]) {
        [self.finisher setFinishedWithResult:result];
    }
    else {
        [self beginDownloadingPhotos];
    }
}
    
- (id) startAsyncOperation {

    self.transferState = [ZFTransferState transferState];
    FLAssertNotNil(self.storageService);

    self.rootGroup = [self.storageService readObject:[ZFGroup group:[NSNumber numberWithInt:_downloadSpec.rootGroupID]]]; 
    
    ZFBatchPhotoSetDownloader* loadPhotoSets = 
        [ZFBatchPhotoSetDownloader batchPhotoSetDownloader:self.downloadSpec.photoSets.allObjects withPhotos:YES];

    self.transferState.photoSetTotal = self.downloadSpec.photoSets.count;
    
    [self runChildAsynchronously:loadPhotoSets completion:^(FLPromisedResult result) {
        [self didDownloadPhotoSets:result];
    }];

    return self.rootGroup;
}


- (void) sendFinishMessagesWithResult:(FLPromisedResult)result {
    [self.observer receiveObservation:@selector(didDownloadPhotoBatchWithResult:) withObject:result];
}


@end
