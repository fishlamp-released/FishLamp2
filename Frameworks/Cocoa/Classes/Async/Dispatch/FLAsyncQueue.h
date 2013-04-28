//
//  FLAbstractDispatcher.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLAsyncResult.h"
#import "FLDispatchTypes.h"
#import "FLPromise.h"
#import "FLDispatchTypes.h"

@protocol FLOperation;

@protocol FLAsyncQueue <NSObject>

- (FLPromise*) queueBlockWithDelay:(NSTimeInterval) delay 
                              block:(fl_block_t) block
                         completion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) queueBlock:(fl_block_t) block
                completion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) queueFinishableBlock:(fl_finisher_block_t) block
                          completion:(fl_completion_block_t) completionOrNil;

- (FLPromise*) queueOperation:(id<FLOperation>) operation
                    completion:(fl_completion_block_t) completionOrNil;

- (void) dispatchSync:(fl_block_t) block;

- (FLPromisedResult) finishSync:(fl_finisher_block_t) block;

- (FLPromisedResult) runSynchronously:(id<FLOperation>) operation;

@end                    

NS_INLINE
void FLDispatchSync(id<FLAsyncQueue> queue, 
                    dispatch_block_t block) {
                    
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    [queue dispatchSync:block];
}

NS_INLINE
FLPromise* FLDispatchAsync(id<FLAsyncQueue> queue, 
                            dispatch_block_t block, 
                            fl_completion_block_t completionOrNil) {
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    return [queue queueBlock:block completion:completionOrNil];
}

NS_INLINE
FLPromise* FLFinishAsync(id<FLAsyncQueue> queue, 
                          fl_finisher_block_t block, 
                          fl_completion_block_t completionOrNil) {
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    return [queue queueFinishableBlock:block completion:completionOrNil];
}

NS_INLINE
FLPromisedResult FLFinishSync(id<FLAsyncQueue> queue, 
                      fl_finisher_block_t block) {
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    return [queue finishSync:block];
}

NS_INLINE
FLPromisedResult FLRunOperation(id<FLAsyncQueue> queue, 
                        id<FLOperation> operation) {
    FLAssertNotNil(queue);
    FLAssertNotNil(operation);
    return [queue runSynchronously:operation];
}

NS_INLINE
FLPromise* FLStartOperation(id<FLAsyncQueue> queue, 
                             id<FLOperation> operation, 
                             fl_completion_block_t completionOrNil) {
    FLAssertNotNil(queue);
    FLAssertNotNil(operation);
    return [queue queueOperation:operation completion:completionOrNil];
}


// these return NIL if the target doesn't respond to selector.

FLPromise* FLDispatchSelectorAsync0(id<FLAsyncQueue> queue, 
                                    id target, 
                                    SEL selector, 
                                    fl_completion_block_t completion);

#define FLDispatchSelectorAsync FLDispatchSelectorAsync0

FLPromise* FLDispatchSelectorAsync1(id<FLAsyncQueue> queue, 
                                     id target, 
                                     SEL selector, 
                                     id object, 
                                     fl_completion_block_t completion);


FLPromise* FLDispatchSelectorAsync2(id<FLAsyncQueue> queue, 
                                     id target, 
                                     SEL selector, 
                                     id object1, 
                                     id object2,
                                     fl_completion_block_t completion);

FLPromise* FLDispatchSelectorAsync3(id<FLAsyncQueue> queue, 
                                     id target, 
                                     SEL selector, 
                                     id object1, 
                                     id object2, 
                                     id object3, 
                                     fl_completion_block_t completion);

BOOL FLDispatchSelectorSync0(id<FLAsyncQueue> queue, 
                             id target, 
                             SEL selector);

#define FLDispatchSelectorSync FLDispatchSelectorSync0

BOOL FLDispatchSelectorSync1(id<FLAsyncQueue> queue, 
                             id target, 
                             SEL selector, 
                             id object);

BOOL FLDispatchSelectorSync2(id<FLAsyncQueue> queue, 
                             id target, 
                             SEL selector, 
                             id object1, 
                             id object2);

BOOL FLDispatchSelectorSync3(id<FLAsyncQueue> queue, 
                             id target, 
                             SEL selector, 
                             id object1, 
                             id object2, 
                             id object3);
 
