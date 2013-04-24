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
        FLPerformSelector2(self.delegate, @selector(batchPhotoDownloader:updateDownloadInfo:), self, FLCopyWithAutorelease(self.transferState));
        _lastProgress = now;
    }
}

- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
            willDownloadPhotoSet:(ZFPhotoSet*) photoSet {
    FLPerformSelector2(self.delegate, @selector(batchPhotoDownloader:willUpdatePhotoSet:), self, photoSet);
    [self updateProgress:NO];
}


- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
             didDownloadPhotoSet:(ZFPhotoSet*) photoSet {
   
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
    
    FLPerformSelector2(self.delegate, @selector(batchPhotoDownloader:didUpdatePhotoSet:), self, photoSet);
    [self updateProgress:YES];
}        

- (void) photoDownloader:(FLHttpRequest*) httpRequest 
   didDownloadPhotoBytes:(NSNumber*) amount {
   
    self.transferState.byteCount += [amount longValue];

    double bps = [httpRequest bytesPerSecond];
    if(bps) {
        self.transferState.bytesPerSecondTotal += httpRequest.bytesPerSecond;
        self.transferState.bytesPerSecondCountForAveraging++; 
    }
    
    [self updateProgress:YES];
}

- (void) updateCountsForMediaType:(ZFMediaType*) mediaType {
    if(mediaType.mediaTypeID == ZFMediaTypeVideo) {
        self.transferState.videoCount++;
    }
    else {
        self.transferState.photoCount++;
    }
}

- (void) photoDownloaderDidSkipPhoto:(ZFPhotoDownloader*) downloader {
    self.transferState.byteTotal += downloader.downloadSpec.photo.SizeValue;
    [self updateCountsForMediaType:downloader.downloadSpec.mediaType];
    FLPerformSelector2(self.delegate, @selector(batchPhotoDownloader:didSkipPhoto:), self, downloader.downloadSpec);
    [self updateProgress:YES];
}

- (void) photoDownloaderDidDownloadPhoto:(ZFPhotoDownloader*) downloader {
    [self updateCountsForMediaType:downloader.downloadSpec.mediaType];

    FLPerformSelector2(self.delegate, @selector(batchPhotoDownloader:didDownloadPhoto:), self, downloader.downloadSpec);
    [self updateProgress:YES];
}

- (void) willStartDownloadingPhoto:(ZFPhotoDownloader *)operation {
}

- (void) willStartOperationInAsyncQueue:(id)operation {
    FLPerformSelector2(self.delegate, @selector(batchPhotoDownloader:willDownloadPhoto:), self, [operation downloadSpec]);
    [self updateProgress:YES];
}

- (FLOperation*) createOperationForObject:(id) object {
    ZFPhotoDownloader* downloader = [ZFPhotoDownloader photoDownloader:object];
    
    FLHttpRequestDelegateSelectors selectors = downloader.delegateSelectors;
    selectors.willOpen = @selector(willStartDownloadingPhoto:);
    selectors.didReadBytes = @selector(photoDownloader:didDownloadPhotoBytes:);
    downloader.delegate = self;
    downloader.delegateSelectors = selectors;
    
    return downloader;
}     

//- (void) didFinishOperation:(FLOperation *)operation withResult:(FLResult)result {
//    FLTrace(@"finish %@", [result description]);
//}

- (void) didProcessAllObjectsInAsyncQueue {
    [self.transferState setFinished];
    [super didProcessAllObjectsInAsyncQueue];
    [self updateProgress:NO];
}

- (void) didDownloadPhotoSets:(FLResult) result {

    if([result error]) {
        [self setFinishedWithResult:result];
    }
    else {
        [self addObjectsFromArray:_downloadQueue];
        [self.transferState setStarted];
        [self startProcessing];
    }
}
    
- (void) startAsyncOperation {

    self.transferState = [ZFTransferState transferState];
    FLAssertNotNil(self.storageService);

    self.rootGroup = [self.storageService readObject:[ZFGroup group:[NSNumber numberWithInt:_downloadSpec.rootGroupID]]]; 
    
    ZFBatchPhotoSetDownloader* loadPhotoSets = [ZFBatchPhotoSetDownloader batchPhotoSetDownloader:self.downloadSpec.photoSets.allObjects withPhotos:YES];

    self.transferState.photoSetTotal = self.downloadSpec.photoSets.count;
    
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
