//
//  ZFAsyncBatchPhotoDownloader.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFAsyncBatchPhotoDownloader.h"
#import "FLPrepareDownloadQueueOperation.h"
#import "ZFDownloadPhotoOperation.h"
#import "FLAsyncOperationQueueOperation.h"
#import "ZFAsyncPhotoSetDownloader.h"

@interface ZFAsyncBatchPhotoDownloader ()
@property (readwrite, strong) ZFBatchDownloadSpec* downloadSpec; 
@property (readwrite, strong) NSArray* downloadQueue; 
@end

@implementation ZFAsyncBatchPhotoDownloader

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


- (void) performUntilFinished:(FLFinisher*) finisher {
    
    [super performUntilFinished:finisher];
    
    FLAsyncOperationQueueOperation* loadPhotoSets = [FLAsyncOperationQueueOperation asyncOperationQueue:self.downloadSpec.photoSets.allObjects];
    
    loadPhotoSets.operationFactory = ^(id object) {
        return [ZFAsyncPhotoSetDownloader downloadPhotoSet:object];
    };
    
    [self runChildAsynchronously:loadPhotoSets completion:^(FLResult result) {
       
        [self setFinishedWithResult:result];
          
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
