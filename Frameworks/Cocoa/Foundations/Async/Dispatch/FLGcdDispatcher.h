//
//  FLGcdDispatcher.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatcher.h"
#import "FLObjectPool.h"

#import <dispatch/dispatch.h>

@interface FLGcdDispatcher : FLDispatcher {
@private
    dispatch_queue_t _dispatch_queue;
    NSString* _label;
}

@property (readonly, assign) dispatch_queue_t dispatch_queue_t;
@property (readonly, strong) NSString* label;

- (id) initWithLabel:(NSString*) label  
                attr:(dispatch_queue_attr_t) attr;

- (id) initWithDispatchQueue:(dispatch_queue_t) queue;

+ (FLGcdDispatcher*) dispatchQueue:(dispatch_queue_t) queue;
+ (FLGcdDispatcher*) dispatchQueueWithLabel:(NSString*) label 
                                       attr:(dispatch_queue_attr_t) attr;
                                       
+ (FLGcdDispatcher*) fifoDispatchQueue:(NSString*) label;
+ (FLGcdDispatcher*) concurrentDispatchQueue:(NSString*) label;

+ (FLGcdDispatcher*) currentQueue;

+ (void)sleepForTimeInterval:(NSTimeInterval) milliseconds;

@end

