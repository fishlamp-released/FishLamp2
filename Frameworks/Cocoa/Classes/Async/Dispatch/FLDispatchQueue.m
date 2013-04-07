//
//  FLDispatchQueue.m
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatchQueue.h"

#import "FLSelectorPerforming.h"
#import "FLFinisher.h"
#import "FLOperation.h"

static void * const s_queue_key = (void*)&s_queue_key;

@implementation FLDispatchQueue

@synthesize dispatch_queue_t = _dispatch_queue;
@synthesize label = _label;

- (id) initWithDispatchQueue:(dispatch_queue_t) queue {
    if(!queue) {
        return nil;
    }
    
    self = [super init];
    if(self) {
        _dispatch_queue = queue;
        dispatch_retain(_dispatch_queue);
        dispatch_queue_set_specific(_dispatch_queue, s_queue_key, bridge_(void*, self), nil);
        _label = [[NSString alloc] initWithCString:dispatch_queue_get_label(_dispatch_queue) encoding:NSASCIIStringEncoding];
    }
    return self;
}

- (id) initWithLabel:(NSString*) label  
                attr:(dispatch_queue_attr_t) attr {

    dispatch_queue_t queue = dispatch_queue_create([label cStringUsingEncoding:NSASCIIStringEncoding], attr);
    if(!queue) {
        return nil;
    }
    @try {
        self = [self initWithDispatchQueue:queue];
    }
    @finally {
        dispatch_release(queue);
    }

    return self;
}

+ (FLDispatchQueue*) dispatchQueue:(dispatch_queue_t) queue {
    return FLAutorelease([[[self class] alloc] initWithDispatchQueue:queue]);
}

+ (FLDispatchQueue*) dispatchQueueWithLabel:(NSString*) label attr:(dispatch_queue_attr_t) attr {
    return FLAutorelease([[[self class] alloc] initWithLabel:label attr:attr]);
}

+ (FLDispatchQueue*) fifoDispatchQueue:(NSString*) label {
    return FLAutorelease([[[self class] alloc] initWithLabel:label attr:DISPATCH_QUEUE_SERIAL]);
}

+ (FLDispatchQueue*) concurrentDispatchQueue:(NSString*) label {
    return FLAutorelease([[[self class] alloc] initWithLabel:label attr:DISPATCH_QUEUE_CONCURRENT]);
}

- (void) dealloc {
    if(_dispatch_queue) {
        dispatch_queue_set_specific(_dispatch_queue, s_queue_key, nil, nil);
        dispatch_release(_dispatch_queue);
    }
    
#if FL_MRC
    [_label release];
    [super dealloc];
#endif
}

+ (FLDispatchQueue*) currentQueue {
    return bridge_(FLDispatchQueue*, dispatch_queue_get_specific(dispatch_get_current_queue(), s_queue_key));
}

- (void) queueBlockWithDelay:(NSTimeInterval) delay
                          block:(FLBlock) block 
                   withFinisher:(FLFinisher*) finisher {

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (delay * NSEC_PER_SEC)), _dispatch_queue, ^{
        @try {
            
            if(block) {
                block();
            }
            [finisher setFinished];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    });
}                                 


- (void) queueBlock:(FLBlock) block 
          withFinisher:(FLFinisher*) finisher {

    
    dispatch_async(_dispatch_queue, ^{
        @try {
            if(block) {
                block();
            }
            [finisher setFinished];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    });
}

- (void) queueFinishableBlock:(fl_finisher_block_t) block 
                    withFinisher:(FLFinisher*) finisher {
    
    dispatch_async(_dispatch_queue, ^{
        @try {
            if(block) {
                block(finisher);
            }
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    });
}

+ (void) sleepForTimeInterval:(NSTimeInterval)milliseconds {
    
    if([NSThread isMainThread]) {
        NSTimeInterval timeout = [NSDate timeIntervalSinceReferenceDate] + milliseconds;
        while([NSDate timeIntervalSinceReferenceDate] < timeout) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
        }
    } 
    else {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_semaphore_wait(semaphore, 
                                dispatch_time(DISPATCH_TIME_NOW, (milliseconds * NSEC_PER_MSEC)));
        dispatch_release(semaphore);
    } 
}    

- (void) dispatchSync:(dispatch_block_t) block {

    __block NSError* error = nil;
    
    block = FLCopyWithAutorelease(block);
    
    dispatch_sync(self.dispatch_queue_t, ^{
        @try {
            block();
        }
        @catch(NSException* ex) {
            error = ex.error;
        }
    });
    
    FLThrowIfError(error);
}

- (FLResult) finishSync:(fl_finisher_block_t) block {
    
    FLFinisher* finisher = [FLFinisher finisher];
    
    block = FLCopyWithAutorelease(block);
    
    dispatch_sync(self.dispatch_queue_t, ^{
        @try {
            block(finisher);
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
       }
    });
    
    FLThrowIfError(finisher.result);
    return finisher.result;
}

- (FLFinisher*) queueBlock:(fl_block_t) block 
                completion:(fl_completion_block_t) completion {

    FLFinisher* finisher = [FLFinisher finisher:completion];

    FLAssertNotNil(block);
    FLAssertNotNil(finisher);

    [self queueBlock:block withFinisher:finisher];

    return finisher;    
}

//- (FLFinisher*) queueFinishableBlock:(fl_finisher_block_t) block {
//    return [self queueFinishableBlock:block completion:nil];
//}

- (FLFinisher*) queueFinishableBlock:(fl_finisher_block_t) block 
                          completion:(fl_completion_block_t) completion {

    FLFinisher* finisher = [FLFinisher finisher:completion];
    FLAssertNotNil(block);
    FLAssertNotNil(finisher);
    [self queueFinishableBlock:block withFinisher:finisher];
    return finisher;
}

- (FLFinisher*) queueBlockWithDelay:(NSTimeInterval) delay
                              block:(fl_block_t) block
                         completion:(fl_completion_block_t) completion {

    FLFinisher* finisher = [FLFinisher finisher];
    [self queueBlockWithDelay:delay block:block withFinisher:finisher];
    return finisher;
}                          

- (FLFinisher*) queueOperation:(id<FLOperation>) operation 
                    completion:(fl_result_block_t) completion {

    FLAssertNotNil(operation);
    FLFinisher* finisher = [FLFinisher finisher:completion];

    dispatch_async(_dispatch_queue, ^{
        @try {
            [operation performUntilFinished:finisher];
        }
        @catch(NSException* ex) {
            [finisher setFinishedWithResult:ex.error];
        }
    });
    
    return finisher;
}                  

- (FLResult) runSynchronously:(id<FLOperation>) operation {
    return [self finishSync:^(FLFinisher* finisher) {
        [operation performUntilFinished:finisher];
    }];
}

+ (FLDispatchQueue*) lowPriorityQueue {
    FLReturnStaticObject( [FLDispatchQueue dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)]);
}
+ (FLDispatchQueue*) defaultQueue {
    FLReturnStaticObject( [FLDispatchQueue dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)]);
}
+ (FLDispatchQueue*) highPriorityQueue {
    FLReturnStaticObject([FLDispatchQueue dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)]);
}
+ (FLDispatchQueue*) veryLowPriorityQueue {
    FLReturnStaticObject([FLDispatchQueue dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)]);
}
+ (FLDispatchQueue*) mainThreadQueue {
    FLReturnStaticObject([FLDispatchQueue dispatchQueue:dispatch_get_main_queue()]);
}

+ (FLFifoAsyncQueue*) fifoQueue {
    FLReturnStaticObject([[FLFifoAsyncQueue alloc] init]);
}

@end

@implementation FLFifoAsyncQueue  

+ (id) fifoAsyncQueue {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    static int s_count = 0;
    return [super initWithLabel:[NSString stringWithFormat:@"com.fishlamp.queue.fifo%d", s_count++] attr:DISPATCH_QUEUE_SERIAL];
}

//+ (FLObjectPool*) pool {
//    static FLObjectPoolFactory s_factory = ^{
//        return [FLFifoAsyncQueue fifoAsyncQueue];
//    };
//
//    FLReturnStaticObject([[FLObjectPool alloc] initWithObjectFactory:s_factory]); 
//}

- (void) releaseToPool {

}

@end






