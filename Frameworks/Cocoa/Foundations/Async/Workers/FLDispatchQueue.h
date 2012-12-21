//
//  FLDispatchQueue.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCore.h"
#import "FLDispatcher.h"
#import "FLObjectPool.h"

@interface FLDispatchQueue: NSObject<FLDispatcher> {
@private
    dispatch_queue_t _dispatch_queue;
    NSString* _label;
}

@property (readonly, assign) dispatch_queue_t dispatch_queue_t;
@property (readonly, strong) NSString* label;

- (id) initWithLabel:(NSString*) label  
                attr:(dispatch_queue_attr_t) attr;

- (id) initWithDispatchQueue:(dispatch_queue_t) queue;

+ (FLDispatchQueue*) dispatchQueue:(dispatch_queue_t) queue;
+ (FLDispatchQueue*) dispatchQueueWithLabel:(NSString*) label 
                                       attr:(dispatch_queue_attr_t) attr;
                                       
+ (FLDispatchQueue*) fifoDispatchQueue:(NSString*) label;
+ (FLDispatchQueue*) concurrentDispatchQueue:(NSString*) label;

+ (FLDispatchQueue*) currentQueue;

@end

@interface FLDispatchQueue (SystemQueues)
+ (FLDispatchQueue*) sharedLowPriorityQueue;
+ (FLDispatchQueue*) sharedDefaultQueue;
+ (FLDispatchQueue*) sharedHighPriorityQueue;
+ (FLDispatchQueue*) sharedBackgroundQueue;
+ (FLDispatchQueue*) sharedForegroundQueue;
@end

@interface FLFifoDispatchQueue : FLDispatchQueue
+ (id) fifoDispatchQueue;
+ (FLDispatchQueue*) sharedFifoQueue;
+ (FLObjectPool*) pool;
@end

#define FLHighPriorityQueue \
            [FLDispatchQueue sharedHighPriorityQueue]

#define FLBackgroundQueue \
            [FLDispatchQueue sharedBackgroundQueue]

#define FLLowPriorityQueue \
            [FLDispatchQueue sharedLowPriorityQueue]
            
#define FLDefaultQueue \
            [FLDispatchQueue sharedDefaultQueue]
            
#define FLForegroundQueue \
            [FLDispatchQueue sharedForegroundQueue]

#define FLFifoQueue \
            [FLFifoDispatchQueue sharedFifoQueue]


