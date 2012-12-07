//
//  FLDispatchQueue.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCore.h"
#import "FLDispatcher.h"
#import <dispatch/dispatch.h>

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

@interface FLSystemDispatchQueues : NSObject
+ (FLDispatchQueue*) lowPriorityQueue;
+ (FLDispatchQueue*) defaultQueue;
+ (FLDispatchQueue*) highPriorityQueue;
+ (FLDispatchQueue*) backgroundQueue;
+ (FLDispatchQueue*) foregroundQueue;
@end

@interface FLFrameworkQueues : NSObject
+ (FLDispatchQueue*) fifoQueue;
@end

#define FLHighPriorityQueue \
            [FLSystemDispatchQueues highPriorityQueue]

#define FLBackgroundQueue \
            [FLSystemDispatchQueues backgroundQueue]

#define FLLowPriorityQueue \
            [FLSystemDispatchQueues lowPriorityQueue]
            
#define FLDefaultQueue \
            [FLSystemDispatchQueues defaultQueue]
            
#define FLForegroundQueue \
            [FLSystemDispatchQueues foregroundQueue]

#define FLFifoQueue \
            [FLFrameworkQueues fifoQueue]
