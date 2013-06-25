//
//  FLAbstractDispatcher.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAsyncBlockTypes.h"

@class FLPromise;
@class FLPromisedResult;

@protocol FLDispatchable;

@protocol FLAsyncQueue <NSObject>

// async

- (FLPromise*) addBlock:(fl_block_t) block
              withDelay:(NSTimeInterval) delay
         withCompletion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) addBlock:(fl_block_t) block
              withDelay:(NSTimeInterval) delay;

- (FLPromise*) addBlock:(fl_block_t) block
         withCompletion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) addBlock:(fl_block_t) block;

- (FLPromise*) addFinishableBlock:(fl_finisher_block_t) block
                     withCompletion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) addFinishableBlock:(fl_finisher_block_t) block;

- (FLPromise*) addOperation:(id<FLDispatchable>) operation
               withCompletion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) addOperation:(id<FLDispatchable>) operation;

// synchronous

- (void) runBlockSynchronously:(fl_block_t) block;

- (FLPromisedResult*) runFinisherBlockSynchronously:(fl_finisher_block_t) block;

- (FLPromisedResult*) runOperationSynchronously:(id<FLDispatchable>) operation;

@end                    



 
