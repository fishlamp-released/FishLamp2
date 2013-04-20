//
//  ZFBatchPhotoDownloadOperation.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFBatchPhotoDownloadOperation.h"
#import "FLPrepareDownloadQueueOperation.h"
#import "ZFDownloadPhotoOperation.h"

@interface ZFBatchPhotoDownloadOperation ()
@property (readwrite, strong) ZFBatchDownloadSpec* downloadSpec; 
@property (readwrite, strong) FLFifoAsyncQueue* fifoQueue; 
@property (readwrite, strong) ZFDownloadQueue* downloadQueue; 
@property (readwrite, strong) FLFinisher* finisher; 
- (void) processQueue;
@end

@implementation ZFBatchPhotoDownloadOperation

@synthesize downloadSpec = _downloadSpec;
@synthesize fifoQueue = _fifoQueue;
@synthesize downloadQueue = _downloadQueue;
@synthesize finisher = _finisher;

- (id) initWithDownloadSpec:(ZFBatchDownloadSpec*) downloadSpec {	
	self = [super init];
	if(self) {
		self.downloadSpec = downloadSpec;
        _fifoQueue = [[FLFifoAsyncQueue alloc] init];
        _activeQueue = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (id) batchPhotoDownloadOperation:(ZFBatchDownloadSpec*) downloadSpec {
    return FLAutorelease([[[self class] alloc] initWithDownloadSpec:downloadSpec]);
}

#if FL_MRC
- (void) dealloc {
    [_finisher release];
    [_activeQueue release];
	[_downloadSpec release];
    [_fifoQueue release];
    [_downloadQueue release];
    [super dealloc];
}
#endif

#define MaxCount 3

- (void) downloaderFinished:(ZFDownloadPhotoOperation*) downloader result:(FLResult) result {
    [_activeQueue removeObject:downloader];
}

- (void) processQueue {

    while(_activeQueue.count < MaxCount) {
        
        ZFDownloadPhotoOperation* downloader = [ZFDownloadPhotoOperation downloadPhotoOperation:[self.downloadQueue popDownloadSpec]];
        
        [_activeQueue addObject:downloader];
        
        [self runChildAsynchronously:downloader completion:^(FLResult result){
            FLDispatchSelectorAsync2(self.fifoQueue, self, @selector(downloaderFinished:result:), downloader, result, nil);
        }];
    }
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    
    FLPrepareDownloadQueueOperation* operation = [FLPrepareDownloadQueueOperation prepareDownloadQueueOperation:self.downloadSpec];
    
    operation.asyncObserver = self;
    
    [self runChildAsynchronously:operation completion:^(FLResult result) {
        if([result error]) {
            [finisher setFinishedWithResult:result];
        }
        else {
            self.finisher = finisher; 
            self.downloadQueue = result;
        
            FLDispatchSelectorAsync(self.fifoQueue, self, @selector(processQueue), nil);
        }
    }];
}



@end
