//
//  FLJob.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLJob.h"
#import "NSObject+Blocks.h"
#import "FLFinisher.h"
#import "FLDispatchQueues.h"

@interface FLJob ()
@property (readwrite, strong) id<FLWorker> _worker;
@end

@implementation FLJob

@synthesize _worker = _worker;

- (id) initWithWorker:(id<FLWorker>) worker {
    self = [super init];
    if(self) {
        [self setWorker:worker];
    }
    return self;
}

- (id) initWithBlock:(dispatch_block_t) block {
    self = [super init];
    if(self) {
        [self setWorkerWithBlock:block];
    }
    return self;
}

- (id) initWithAsyncBlock:(FLAsyncBlock) block {
    self = [super init];
    if(self) {
        [self setWorkerWithAsyncBlock:block];
    }
    return self;
}

+ (id) job {
    return autorelease_([[[self class] alloc] init]);
}

+ (id) job:(id<FLWorker>) worker {
    return autorelease_([[[self class] alloc] initWithWorker:worker]);
}

+ (id) jobWithBlock:(dispatch_block_t) block {
    return autorelease_([[[self class] alloc] initWithBlock:block]);
}

+ (id) jobWithAsyncBlock:(FLAsyncBlock) block {
    return autorelease_([[[self class] alloc] initWithAsyncBlock:block]);
}

- (void) setWorkerWithBlock:(dispatch_block_t) block {
    block = FLCopyBlock(block);
    
    [self setWorker:[FLBlockWorker blockWorker:^(FLFinisher* finisher) {
        if(block) {
            block();
        }
        [finisher setFinished];
    }]];
}

- (void) setWorkerWithAsyncBlock:(FLAsyncBlock) block {
    [self setWorker:[FLBlockWorker blockWorker:block]];
}

- (void) scheduleWorker:(id<FLWorker>) worker finisher:(FLFinisher*) finisher {
    [worker startWorking:finisher];
}

- (FLFinisher*) startWorking:(FLFinisher*) finisher {
    if(_worker) {
        [self scheduleWorker:_worker finisher:finisher];
    }
    else {
        [finisher setFinished]; 
    }
    
    return finisher;
}

- (void) dealloc {
    self.worker = nil; // so it can nil the parent.
#if FL_MRC
//    [_queue release];
    [_worker release];
    [super dealloc];
#endif
}

- (id<FLWorker>) worker {
    return self._worker;
}

- (void) setWorker:(id<FLWorker>) aWorker {
    id<FLWorker> worker = self._worker;
    if(worker) {
        [self willRemoveWorker:worker];
    }
    if(aWorker) {
        [self willAddWorker:aWorker];
    }
    self._worker = aWorker;
}

@end

@implementation FLBackgroundJob
- (void) scheduleWorker:(id<FLWorker>) worker finisher:(FLFinisher*) finisher {
    [[FLDispatchQueue instance] dispatchWorker:worker finisher:finisher];
}
@end

@implementation FLForegroundJob
- (void) scheduleWorker:(id<FLWorker>) worker finisher:(FLFinisher*) finisher {
    [[FLForegroundQueue instance] dispatchWorker:worker finisher:finisher];
}
@end





