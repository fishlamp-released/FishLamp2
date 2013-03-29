//
//  FLDispatchQueue.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAsyncQueue.h"
#import "FLObjectPool.h"

#import <dispatch/dispatch.h>

@interface FLDispatchQueue : FLAsyncQueue {
@private
    dispatch_queue_t _dispatch_queue;
    NSString* _label;
}

@property (readonly, assign) dispatch_queue_t dispatch_queue_t;
@property (readonly, strong) NSString* label;

+ (FLDispatchQueue*) currentQueue;

+ (void)sleepForTimeInterval:(NSTimeInterval) milliseconds;

@end

@interface FLDispatchQueue (Creation)

+ (FLDispatchQueue*) fifoDispatchQueue:(NSString*) label;

+ (FLDispatchQueue*) concurrentDispatchQueue:(NSString*) label;

- (id) initWithLabel:(NSString*) label  
                attr:(dispatch_queue_attr_t) attr;

- (id) initWithDispatchQueue:(dispatch_queue_t) queue;

+ (FLDispatchQueue*) dispatchQueue:(dispatch_queue_t) queue;

+ (FLDispatchQueue*) dispatchQueueWithLabel:(NSString*) label 
                                       attr:(dispatch_queue_attr_t) attr;


@end

@interface FLFifoAsyncQueue : FLDispatchQueue
+ (id) fifoAsyncQueue;
+ (FLObjectPool*) pool;

- (void) releaseToPool;
@end

@interface FLAsyncQueue (SharedDispatchQueues) 
+ (FLDispatchQueue*) veryLowPriorityQueue;
+ (FLDispatchQueue*) lowPriorityQueue;
+ (FLDispatchQueue*) defaultQueue;
+ (FLDispatchQueue*) highPriorityQueue;

+ (FLDispatchQueue*) mainThreadQueue;

+ (FLFifoAsyncQueue*) fifoQueue;
@end


// TODO: make the pool a dispatcher. queue the block get the dispatcher back.


extern void FLDispatchSync(FLDispatchQueue* queue, dispatch_block_t block);
