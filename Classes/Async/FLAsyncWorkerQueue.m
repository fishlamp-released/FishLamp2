//
//  FLAsyncWorkerQueue.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAsyncWorkerQueue.h"

//@interface FLQueuedWorker : NSObject {
//@private
//    FLFinisher* _finisher;
//    id<FLAsyncWorker> _worker;
//}
//@property (readwrite, strong) id<FLAsyncWorker> worker;
//@property (readwrite, strong) FLFinisher* finisher;
//
//+ (FLQueuedWorker*) queuedWorker;
//@end
//
//@implementation FLQueuedWorker
//@synthesize worker = _worker;
//@synthesize finisher = _finisher;
//
//#if FL_NO_ARC
//- (void) dealloc {
//    [_finisher release];
//    [_worker release];
//    [super dealloc];
//}
//#endif
//@end
//
//
//@implementation FLAsyncWorkerQueue
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        _queue = [[NSMutableArray alloc] init];
//    }
//    return self;
//}
//
//- (void) startNext {
//
//}
//
//- (void) workerFinished:(FLQueuedWorker*) worker {
//    @synchronized(self) {
//        [_queue removeObject:worker];
//    }
//    [self startNext];
//}
//
//- (FLFinisher*) addWorker:(id<FLAsyncWorker>) aWorker completion:(FLCompletionBlock) completion {
//    
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//    
//    FLQueuedWorker* worker = [FLQueuedWorker queuedWorker];
//    worker.worker = aWorker;
//    worker.finisher = [FLFinisher finisher:^{
//        [self workerFinished:worker];
//        [finisher setFinished];
//    }];
//    
//    @synchronized(self) {
//        [_queue addObject:worker];
//    }
//    [self startNext];
//    
//    return finisher;
//}
//
//
//@end
