//
//  FLDispatchQueue.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAsyncQueue.h"
//#import "FLObjectPool.h"
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

#if __MAC_10_8
+ (FLDispatchQueue*) concurrentDispatchQueue:(NSString*) label;
#endif

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

#if __MAC_10_8
+ (void) sleepForTimeInterval:(NSTimeInterval) milliseconds;
#endif
@end

@interface FLFifoAsyncQueue : FLDispatchQueue
+ (id) fifoAsyncQueue;

//+ (FLObjectPool*) pool;

- (void) releaseToPool;
@end


#define FLForegroundQueue       [FLDispatchQueue mainThreadQueue]
#define FLBackgroundQueue       [FLDispatchQueue defaultQueue]
#define FLBackgroundFifoQueue   [FLDispatchQueue fifoQueue]