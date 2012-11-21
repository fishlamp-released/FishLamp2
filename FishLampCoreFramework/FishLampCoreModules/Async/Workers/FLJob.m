//
//  FLJob.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
//#import "FLJob.h"
//#import "NSObject+Blocks.h"
//#import "FLFinisher.h"
//#import "FLDispatchQueues.h"
//#import "FLAsyncBlockWorker.h"
//
//@interface FLJob ()
//@property (readwrite, strong) id<FLWorker> _worker;
//@end
//
//@implementation FLJob
//
//@synthesize _worker = _worker;
//
//- (id) initWithWorker:(id<FLWorker>) worker {
//    self = [super init];
//    if(self) {
//        [self setWorker:worker];
//    }
//    return self;
//}
//
//- (id) initWithBlock:(dispatch_block_t) block {
//    self = [super init];
//    if(self) {
//        [self setWorkerWithBlock:block];
//    }
//    return self;
//}
//
//- (id) initWithResultBlock:(FLAsyncTaskBlock) block {
//    self = [super init];
//    if(self) {
//        [self setWorkerWithAsyncBlock:block];
//    }
//    return self;
//}
//
//+ (id) job {
//    return autorelease_([[[self class] alloc] init]);
//}
//
//+ (id) job:(id<FLWorker>) worker {
//    return autorelease_([[[self class] alloc] initWithWorker:worker]);
//}
//
//+ (id) jobWithBlock:(dispatch_block_t) block {
//    return autorelease_([[[self class] alloc] initWithBlock:block]);
//}
//
//+ (id) jobWithAsyncBlock:(FLAsyncTaskBlock) block {
//    return autorelease_([[[self class] alloc] initWithResultBlock:block]);
//}
//
//- (void) setWorkerWithBlock:(dispatch_block_t) block {
//    block = FLCopyBlock(block);
//    
//    [self setWorker:[FLAsyncBlockWorker asyncBlockWorker:^(id asyncTask) {
//        if(block) {
//            block();
//        }
//        [asyncTask setFinished];
//    }]];
//}
//
//- (void) setWorkerWithAsyncBlock:(FLAsyncTaskBlock) block {
//    [self setWorker:[FLAsyncBlockWorker asyncBlockWorker:block]];
//}
//
//- (void) scheduleWorker:(id<FLWorker>) worker finisher:(FLFinisher*) finisher {
//    [worker startWorking:finisher];
//}
//
//- (void) startWorking:(id) asyncTask {
//    if(_worker) {
//        [self scheduleWorker:_worker finisher:asyncTask];
//    }
//    else {
//        [asyncTask setFinished]; 
//    }
//    
//
//}
//
//- (void) dealloc {
//    self.worker = nil; // so it can nil the parent.
//#if FL_MRC
////    [_queue release];
//    [_worker release];
//    [super dealloc];
//#endif
//}
//
//- (id<FLWorker>) worker {
//    return self._worker;
//}
//
//- (void) setWorker:(id<FLWorker>) aWorker {
//    id<FLWorker> worker = self._worker;
//    if(worker) {
//        [self willRemoveWorker:worker];
//    }
//    if(aWorker) {
//        [self willAddWorker:aWorker];
//    }
//    self._worker = aWorker;
//}
//
//@end
//
//@implementation FLBackgroundJob
//- (void) scheduleWorker:(id<FLWorker>) worker finisher:(FLFinisher*) finisher {
//    [FLDispatchQueue dispatch:worker finisher:finisher];
//}
//@end
//
//@implementation FLForegroundJob
//- (void) scheduleWorker:(id<FLWorker>) worker finisher:(FLFinisher*) finisher {
//    [FLForegroundQueue dispatch:worker finisher:finisher];
//}
//@end





