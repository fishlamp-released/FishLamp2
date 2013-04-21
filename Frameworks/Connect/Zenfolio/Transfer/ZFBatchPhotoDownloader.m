//
//  ZFBatchPhotoDownloader.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFBatchPhotoDownloader.h"
#import "FLPrepareDownloadQueueOperation.h"
#import "ZFDownloadPhotoOperation.h"
#import "FLAsyncOperationQueue.h"
#import "ZFPhotoSetDownloader.h"
#import "ZFBatchPhotoSetDownloader.h"

#import "FLTrace.h"

@interface ZFBatchPhotoDownloader ()
@property (readwrite, strong) ZFBatchDownloadSpec* downloadSpec; 
@property (readwrite, strong) NSArray* downloadQueue; 
@end

@implementation ZFBatchPhotoDownloader

@synthesize downloadSpec = _downloadSpec;
@synthesize downloadQueue = _downloadQueue;

- (id) initWithDownloadSpec:(ZFBatchDownloadSpec*) downloadSpec {	
	self = [super init];
	if(self) {
		self.downloadSpec = downloadSpec;
	}
	return self;
}

+ (id) batchPhotoDownloadOperation:(ZFBatchDownloadSpec*) spec {
    return FLAutorelease([[[self class] alloc] initWithDownloadSpec:spec]);
}

#if FL_MRC
- (void) dealloc {
	[_downloadSpec release];
    [_downloadQueue release];
    [super dealloc];
}
#endif

- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
             didDownloadPhotoSet:(ZFPhotoSet*) photoSet {
    FLTrace(@"downloaded photoset: %@", photoSet.Title);
}             

- (void) didDownloadPhotoSets:(FLResult) result {
    FLTrace(@"downloaded photo sets");
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    
    [super performUntilFinished:finisher];
    
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
