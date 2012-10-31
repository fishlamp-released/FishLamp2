//
//  FLJob.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLJob.h"
#import "NSObject+Blocks.h"
#import "FLCollectionIterator.h"
#import "FLFallible.h"
#import "FLDispatcher.h"

#import "FLDispatchQueues.h"

@interface FLJob ()

@property (readwrite, strong) id<FLDispatcher> queue;
@property (readonly, strong) id<FLDispatcher> targetQueue;
@property (readwrite, assign) id parentJob;
@property (readwrite, strong) id<FLWorker> _worker;

@end

@implementation FLJob

@synthesize parentJob = _parentJob;
@synthesize fallibleDelegate = _errorDelegate;
@synthesize _worker = _worker;
@synthesize queue = _queue; 

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

- (id<FLWorker>) worker {
    return self._worker;
}

- (id<FLDispatcher>) targetQueue {
    return self.queue;
}

- (BOOL) tryHandlingError:(NSError*) error  {

    id walker = self.parentJob;
    while(walker) {

        if(FLTryHandlingErrorForObject(error, walker)) {
            return YES;
        }

        if([walker respondsToSelector:@selector(parentJob)]) {
            walker = [walker parentJob];
        }
        else {
            walker = nil;
        }
    }
    
    return NO;
}


+ (id) job {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

+ (id) job:(id<FLWorker>) worker {
    return FLReturnAutoreleased([[[self class] alloc] initWithWorker:worker]);
}

+ (id) jobWithBlock:(dispatch_block_t) block {
    return FLReturnAutoreleased([[[self class] alloc] initWithBlock:block]);
}

+ (id) jobWithAsyncBlock:(FLAsyncBlock) block {
    return FLReturnAutoreleased([[[self class] alloc] initWithAsyncBlock:block]);
}



//- (void) runNextWorker:(id<FLCollectionIterator>) iterator
//          withFinisher:(id<FLFinisher>) finisher {
//
//    id job = iterator.nextObject;
//    if(job) {
//        FLAssertIsNotNil_(self.targetQueue);
//        
//        [self.targetQueue dispatchWorker:job completion:^(FLResult result){
//            [self runNextWorker:iterator withFinisher:finisher];
//        }];
//    }
//    else {
//        [self.queue dispatchBlock:^{ 
//            [finisher setFinished]; 
//        }];
//        self.queue = nil;
//    }
//}

- (void) setWorkerWithBlock:(dispatch_block_t) block {
    block = FLCopyBlock(block);
    
    [self setWorker:[FLBlockWorker blockWorker:^(id<FLFinisher> finisher) {
        if(block) {
            block();
        }
        [finisher setFinished];
    }]];
}

- (void) setWorkerWithAsyncBlock:(FLAsyncBlock) block {
    [self setWorker:[FLBlockWorker blockWorker:block]];
}

- (void) startWorking:(id<FLFinisher>) finisher {
    self.queue = [FLDispatchQueue currentQueue];

    if(_worker) {
        FLAssertIsNotNil_(self.targetQueue);
        
        [self.targetQueue dispatchWorker:_worker completion:^(FLResult result){
            [finisher setFinishedWithResult:result];
        }];
    }
    else {
        [finisher setFinished]; 
        self.queue = nil;
    }
}

- (void) setParentJob:(id) worker parent:(FLJob*) parent {
   if([worker respondsToSelector:@selector(setParentJob:)]) {

#if DEBUG
        if(parent) {
            FLAssert_v([((id)worker) parentJob] == nil, @"job already has parentJob");
        }
        else {
            FLAssert_v([worker parentJob] == parent, @"removing from wrong job");
        }
        
#endif
        [worker setParentJob:parent];
    }
}


- (void) dealloc {
    if(_worker) {
        [self setParentJob:_worker parent:nil];
    }
#if FL_MRC
    [_queue release];
    [_worker release];
    [super dealloc];
#endif
}


- (void) setWorker:(id<FLWorker>) worker {
    [self setParentJob:worker parent:self];
    self._worker = worker;
}

//- (void) removeWorker:(id<FLWorker>) worker {
//    [self setParentJob:worker parent:nil];
//    [_workers removeObject:worker];
//}

//- (void) removeAllWorkers {
//    for(id worker in _workers) {
//        [self setParentJob:worker parent:nil];
//    }
//    [_workers removeAllObjects];
//}

//- (void) addWorkers:(NSArray*) workers {
//    for(FLJob* worker in workers) {
//        [self addWorker:worker];
//    }
//}

//- (BOOL) visitWorkers:(FLJobVisitor) visitor {
//    BOOL stop = NO;
//    for(FLJob* operation in _workers) {
//        visitor(operation, &stop);
//        
//        if(stop) {
//            return YES;
//        }
//    }
//    return stop;
//}
//
//- (BOOL) visitWorkersInReverse:(FLJobVisitor) visitor {
//
//    BOOL stop = NO;
//    for(FLJob* operation in _workers.reverseObjectEnumerator) {
//        visitor(operation, &stop);
//        
//        if(stop) {
//            return YES;
//        }
//    }
//    return stop;
//    
//}

//- (void) addWorkerWithFactoryBlock:(FLCreateBotBlock) block {
//    if(block) {
//        [self addWorker:block()];
//    }
//}

//
//- (void) addWorkerWithTarget:(id) target action:(SEL) action {
//    [self addWorker:[FLPerformSelectorBot performSelectorBot:target action:action ]];
//}

@end

@implementation FLBackgroundJob

- (id<FLDispatcher>) targetQueue { 
    return [FLDispatchQueue instance];
}

//- (void) finishRunning:(id<FLFinisher>) finisher onThread:(NSThread*) thread {
//    if([NSThread currentThread] == thread) {
//        [finisher setFinished];
//    }
//    else {
//        [self performBlockOnThread:thread
//            block:^{
//                [self finishRunning:finisher onThread:thread];
//            }];
//    }
//}
//
//- (void) _startWorking:(id<FLFinisher>) finisher onThread:(NSThread*) onThread {
//    
//    FLWorkFinisher* newFinisher = [FLWorkFinisher finisher:^(FLResult result){
//        [self finishRunning:finisher onThread:onThread];
//    }];
//    
//    @try {
//        [super startWorking:newFinisher];
//    }
//    @catch(NSException* ex) {
//        if(FLTryHandlingErrorForObject(ex.error, self)) {
//           [newFinisher setFinished];
//        }
//        else {
//            [newFinisher setFinishedWithError:ex.error];
//        }
//    }
//    
//}
//
//- (void) startWorking:(id<FLFinisher>) finisher {
//
//    NSThread* startThread = [NSThread currentThread];
//
//    if([NSThread isMainThread]) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            [self _startWorking:finisher onThread:startThread];
//        });
//    }
//    else {
//        [self _startWorking:finisher onThread:startThread];
//    }
//}

@end

@implementation FLForegroundJob

- (id<FLDispatcher>) targetQueue { 
    return [FLForegroundQueue instance];
}


//- (void) finishRunning:(id<FLFinisher>) completion {
//    if([NSThread isMainThread]) {
//        [completion setFinished];
//    }
//    else {
//        [self performSelectorOnMainThread:@selector(finishRunning:) withObject:completion waitUntilDone:NO];
//    }
//}
//
//- (void) _startWorking:(id<FLFinisher>) finisher {
//   
//    FLWorkFinisher* foregroundFinisher = [FLWorkFinisher finisher:^(FLResult result){
//            [self finishRunning:finisher]; }];
//    @try {
//        [super startWorking:foregroundFinisher];
//    }
//    @catch(NSException* ex) {
//        if(FLTryHandlingErrorForObject(ex.error, self)) {
//           [foregroundFinisher setFinished];
//        }
//        else {
//           [foregroundFinisher setFinishedWithError:ex.error];
//        }    
//    }
//}
//
//- (void) startWorking:(id<FLFinisher>) finisher {
//    [self performSelectorOnMainThread:@selector(_startWorking:) withObject:finisher waitUntilDone:NO];
//}

@end





#