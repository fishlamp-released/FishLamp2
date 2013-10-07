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

@class FLPromise;
@protocol FLDispatchable;

@protocol FLAsyncQueue <NSObject>

// async

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

- (FLPromise*) queueOperation:(id<FLDispatchable>) operation
                   completion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) queueOperation:(id<FLDispatchable>) operation;

// synchronous

- (void) runBlockSynchronously:(fl_block_t) block;

- (FLPromisedResult) runFinisherBlockSynchronously:(fl_finisher_block_t) block;

- (FLPromisedResult) runOperationSynchronously:(id<FLDispatchable>) operation;

@end                    



 
