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

#import "FLTrace.h"

@interface ZFBatchPhotoDownloader ()
@property (readwrite, strong) ZFBatchDownloadSpec* downloadSpec; 
@property (readwrite, strong) NSArray* downloadQueue; 
@property (readwrite, strong, nonatomic) ZFGroup* rootGroup;

@end

@implementation ZFBatchPhotoDownloader

@synthesize downloadSpec = _downloadSpec;
@synthesize downloadQueue = _downloadQueue;
@synthesize rootGroup = _rootGroup;


- (id) initWithDownloadSpec:(ZFBatchDownloadSpec*) downloadSpec {	
	self = [super init];
	if(self) {
		self.downloadSpec = downloadSpec;
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

- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
             didDownloadPhotoSet:(ZFPhotoSet*) photoSet {
    
    NSString* folderPath = [_downloadSpec.destinationPath stringByAppendingPathComponent:
                                [_rootGroup relativePathForElement:photoSet]];
    
    for(ZFPhoto* photo in photoSet.Photos) {

        ZFMediaType* mediaType = nil;
        if(_downloadVideos && photo.IsVideoValue) {
            _transferState.videoTotal++;
            _transferState.byteTotal += photo.SizeValue;
            mediaType = [ZFMediaType originalImage];
        }
        else if(_downloadImages && !photo.IsVideoValue) {
            _transferState.photoTotal++;
            _transferState.byteTotal += photo.SizeValue;
            mediaType = [ZFMediaType video];
        }
        else { 
            continue;
        }

        ZFDownloadSpec* download = [ZFDownloadSpec downloadSpec:photo];
        download.mediaType = mediaType;
        NSString* fileName = [mediaType humanReadableFileNameForPhoto:photo inPhotoSet:photoSet];
        download.fullPathToFile = [folderPath stringByAppendingPathComponent:fileName];
        download.tempFolder = [_downloadSpec.destinationPath stringByAppendingPathComponent:@".download"];
        download.rootGroupID = self.downloadSpec.rootGroupID;
        download.photoSetID = photoSet.Id;
        
        [_downloadQueue addObject:download];
        
        if(self.wasCancelled) {
            return;
        }
    }
}        


- (FLOperation*) createOperationForObject:(id) object {
    return [ZFPhotoDownloader photoDownloader:object];
}     

- (void) photoDownloaderDidSkipPhoto:(ZFPhotoDownloader*) downloader {
    FLTrace(@"skipped %@", downloader.downloadSpec.fullPathToFile);
}

- (void) photoDownloaderDidDownloadPhoto:(ZFPhotoDownloader*) downloader {
    FLTrace(@"downloaded %@", downloader.downloadSpec.fullPathToFile);
}

- (void) photoDownloader:(ZFPhotoDownloader*) downloader didReadBytes:(NSNumber*) amount {
}

- (void) didFinishOperation:(FLOperation *)operation withResult:(FLResult)result {
    FLTrace(@"finish %@", [result description]);
}

- (void) didDownloadPhotoSets:(FLResult) result {

    if([result error]) {
        [self setFinishedWithResult:result];
    }
    else {
        [self addObjectsFromArray:_downloadQueue];
    }
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    
    [super performUntilFinished:finisher];
    
    self.downloadSpec.transferState = [ZFTransferState transferState];

    FLAssertNotNil(self.storageService);

    self.rootGroup = [self.storageService readObject:[ZFGroup group:[NSNumber numberWithInt:_downloadSpec.rootGroupID]]]; 
    
    ZFBatchPhotoSetDownloader* loadPhotoSets = [ZFBatchPhotoSetDownloader batchPhotoSetDownloader:self.downloadSpec.photoSets.allObjects withPhotos:YES];
    [self runChildAsynchronously:loadPhotoSets completion:^(FLResult result) {
        [self didDownloadPhotoSets:result];
    }];
    
    
//    FLPrepareDownloadQueueOperation* operation = [FLPrepareDownloadQueueOperation prepareDownloadQueueOperation:self.downloadSpec];
//    
//    operation.asyncObserver = self;
//    
//    [self runChildAsynchronously:operation completion:^(FLResult result) {
//        if([result error] ) {
//            [finisher setFinishedWithResult:result];
//        }
//        else {
//            self.finisher = finisher; 
//            self.downloadQueue = result;
//        
////            FLDispatchSelectorAsync(self.fifoQueue, self, @selector(processQueue), nil);
//        }
//    }];
}



@end
