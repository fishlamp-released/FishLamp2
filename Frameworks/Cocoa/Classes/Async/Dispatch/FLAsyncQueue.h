//
//  FLAbstractDispatcher.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLResult.h"
#import "FLDispatchTypes.h"
#import "FLFinisher.h"
#import "FLDispatchTypes.h"

@protocol FLOperation;

@protocol FLAsyncQueue <NSObject>

- (FLFinisher*) queueBlockWithDelay:(NSTimeInterval) delay 
                              block:(fl_block_t) block
                         completion:(fl_completion_block_t) completionOrNil;

- (FLFinisher*) queueBlock:(fl_block_t) block
                completion:(fl_completion_block_t) completionOrNil;

- (FLFinisher*) queueFinishableBlock:(fl_finisher_block_t) block
                          completion:(fl_completion_block_t) completionOrNil;

- (FLFinisher*) queueOperation:(id<FLOperation>) operation
                    completion:(fl_completion_block_t) completionOrNil;

- (void) dispatchSync:(fl_block_t) block;

- (FLResult) finishSync:(fl_finisher_block_t) block;

- (FLResult) runSynchronously:(id<FLOperation>) operation;

@end                    

NS_INLINE
void FLDispatchSync(id<FLAsyncQueue> queue, dispatch_block_t block) {
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    [queue dispatchSync:block];
}

NS_INLINE
FLFinisher* FLDispatchAsync(id<FLAsyncQueue> queue, dispatch_block_t block, fl_completion_block_t completionOrNil) {
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    return [queue queueBlock:block completion:completionOrNil];
}

NS_INLINE
FLFinisher* FLFinishAsync(id<FLAsyncQueue> queue, fl_finisher_block_t block, fl_completion_block_t completionOrNil) {
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    return [queue queueFinishableBlock:block completion:completionOrNil];
}

NS_INLINE
FLResult FLFinishSync(id<FLAsyncQueue> queue, fl_finisher_block_t block) {
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    return [queue finishSync:block];
}

NS_INLINE
FLResult FLRunOperation(id<FLAsyncQueue> queue, id<FLOperation> operation) {
    FLAssertNotNil(queue);
    FLAssertNotNil(operation);
    return [queue runSynchronously:operation];
}

NS_INLINE
FLFinisher* FLStartOperation(id<FLAsyncQueue> queue, id<FLOperation> operation, fl_completion_block_t completionOrNil) {
    FLAssertNotNil(queue);
    FLAssertNotNil(operation);
    return [queue queueOperation:operation completion:completionOrNil];
}