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

@class FLFifoAsyncQueue;

@interface FLDispatchQueue : NSObject<FLAsyncQueue> {
@private
    dispatch_queue_t _dispatch_queue;
    NSString* _label;
}

// 
// Info
//

@property (readonly, assign) dispatch_queue_t dispatch_queue_t;

@property (readonly, strong) NSString* label;

// 
// constructors
//

- (id) initWithLabel:(NSString*) label  
                attr:(dispatch_queue_attr_t) attr;

- (id) initWithDispatchQueue:(dispatch_queue_t) queue;

+ (FLDispatchQueue*) fifoDispatchQueue:(NSString*) label;

+ (FLDispatchQueue*) concurrentDispatchQueue:(NSString*) label;

+ (FLDispatchQueue*) dispatchQueue:(dispatch_queue_t) queue;

+ (FLDispatchQueue*) dispatchQueueWithLabel:(NSString*) label 
                                       attr:(dispatch_queue_attr_t) attr;

// 
// Shared Queues
//

+ (FLDispatchQueue*) veryLowPriorityQueue;

+ (FLDispatchQueue*) lowPriorityQueue;

+ (FLDispatchQueue*) defaultQueue;

+ (FLDispatchQueue*) highPriorityQueue;

+ (FLDispatchQueue*) mainThreadQueue; // note this is a fifo queue.

+ (FLFifoAsyncQueue*) fifoQueue;

// 
// Utils
//

+ (FLDispatchQueue*) currentQueue;

+ (void) sleepForTimeInterval:(NSTimeInterval) milliseconds;

@end

@interface FLFifoAsyncQueue : FLDispatchQueue
+ (id) fifoAsyncQueue;

//+ (FLObjectPool*) pool;

- (void) releaseToPool;
@end


