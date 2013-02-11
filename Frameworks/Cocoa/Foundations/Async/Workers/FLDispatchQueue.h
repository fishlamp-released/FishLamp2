//
//  FLDispatchQueue.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLDispatcher.h"
#import "FLObjectPool.h"

@interface FLDispatchQueue : FLDispatcher {
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

+ (void)sleepForTimeInterval:(NSTimeInterval) milliseconds;

@end

@interface FLDispatchQueue (SharedQueues)
+ (FLDispatchQueue*) sharedLowPriorityQueue;
+ (FLDispatchQueue*) sharedDefaultQueue;
+ (FLDispatchQueue*) sharedHighPriorityQueue;
+ (FLDispatchQueue*) sharedBackgroundQueue;
+ (FLDispatchQueue*) sharedForegroundQueue;
+ (FLDispatchQueue*) sharedFifoQueue;
@end

@interface FLFifoDispatchQueue : FLDispatchQueue
+ (id) fifoDispatchQueue;
+ (FLObjectPool*) pool;
@end

//#define FLHighPriorityQueue \
//            [FLDispatchQueue sharedHighPriorityQueue]
//
//#define FLBackgroundQueue \
//            [FLDispatchQueue sharedBackgroundQueue]
//
//#define FLLowPriorityQueue \
//            [FLDispatchQueue sharedLowPriorityQueue]
//            
//#define FLDefaultDispatcher \
//            [FLDispatchQueue sharedDefaultQueue]
//
//#define FLDefaultQueue \
//            FLDefaultDispatcher
//            
//#define FLForegroundQueue \
//            [FLDispatchQueue sharedForegroundQueue]
//
//#define [FLFifoDispatchQueue sharedFifoQueue] \
//            [FLFifoDispatchQueue sharedFifoQueue]



//@interface FLDispatchContext : NSObject {
//@private
//    NSMutableArray* _objects;
//}
//
//@end

