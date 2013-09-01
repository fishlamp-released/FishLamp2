//
//  FLAbstractDispatcher.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAsyncBlockTypes.h"
#import "FLPromisedResult.h"
#import "FLAsyncEvent.h"

@protocol FLAsyncQueue;

@protocol FLAsyncObject <NSObject>
- (FLAsyncEvent*) asyncEventForQueue:(id<FLAsyncQueue>) queue withDelay:(NSTimeInterval) delay;
@end

@class FLPromise;
@class FLAsyncEvent;

@protocol FLAsyncQueue <NSObject>

- (FLPromise*) queueAsyncEvent:(FLAsyncEvent*) event
                    completion:(fl_completion_block_t) completion;

- (FLPromisedResult) queueSynchronousEvent:(FLAsyncEvent*) event;

- (FLPromise*) queueBlockWithDelay:(NSTimeInterval) delay
                             block:(fl_block_t) block
                        completion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) queueBlockWithDelay:(NSTimeInterval) delay
                             block:(fl_block_t) block;

- (FLPromise*) queueBlock:(fl_block_t) block
               completion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) queueBlock:(fl_block_t) block;

- (FLPromise*) queueFinishableBlock:(fl_finisher_block_t) block
                         completion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) queueFinishableBlock:(fl_finisher_block_t) block;

- (FLPromise*) queueObject:(id<FLAsyncObject>) operation
                 withDelay:(NSTimeInterval) delay
                completion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) queueObject:(id<FLAsyncObject>) operation
                completion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) queueObject:(id<FLAsyncObject>) operation;

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action;

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action
                withObject:(id) object;

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action
                withObject:(id) object1
                withObject:(id) object2;

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action
                withObject:(id) object1
                withObject:(id) object2
                withObject:(id) object3;

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action
                withObject:(id) object1
                withObject:(id) object2
                withObject:(id) object3
                withObject:(id) object4;

- (FLPromisedResult) runBlockSynchronously:(fl_block_t) block;

- (FLPromisedResult) runFinisherBlockSynchronously:(fl_finisher_block_t) block;

- (FLPromisedResult) runSynchronously:(id) asyncObject;

@end

@interface FLAsyncQueue : NSObject<FLAsyncQueue>
@end