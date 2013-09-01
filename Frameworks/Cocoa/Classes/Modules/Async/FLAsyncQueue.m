//
//  FLAbstractDispatcher.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAsyncQueue.h"

@implementation FLAsyncQueue

- (FLPromise*) queueAsyncEvent:(FLAsyncEvent*) event completion:(fl_completion_block_t) completion {
    return nil;
}

- (FLPromisedResult) queueSynchronousEvent:(FLAsyncEvent*) event {
    return nil;
}

- (FLPromise*) queueBlockWithDelay:(NSTimeInterval) delay
                             block:(fl_block_t) block
                        completion:(fl_completion_block_t) completion {

    return [self queueAsyncEvent:[FLBlockEvent blockEventWithDelay:delay block:block] completion:completion];
}

- (FLPromise*) queueBlockWithDelay:(NSTimeInterval) delay
                             block:(fl_block_t) block {
    return [self queueAsyncEvent:[FLBlockEvent blockEventWithDelay:delay block:block] completion:nil];
}

- (FLPromise*) queueBlock:(fl_block_t) block {
    return [self queueAsyncEvent:[FLBlockEvent blockEvent:block] completion:nil];
}

- (FLPromise*) queueBlock:(fl_block_t) block
               completion:(fl_completion_block_t) completionOrNil {
    return [self queueAsyncEvent:[FLBlockEvent blockEvent:block] completion:completionOrNil];
}

- (FLPromise*) queueFinishableBlock:(fl_finisher_block_t) block
                         completion:(fl_completion_block_t) completionOrNil {
    return [self queueAsyncEvent:[FLFinisherBlockEvent finisherBlockEvent:block] completion:completionOrNil];
}

- (FLPromise*) queueFinishableBlock:(fl_finisher_block_t) block {
    return [self queueAsyncEvent:[FLFinisherBlockEvent finisherBlockEvent:block] completion:nil];
}

- (FLPromise*) queueObject:(id<FLAsyncObject>) object
                 withDelay:(NSTimeInterval) delay
                completion:(fl_completion_block_t) completionOrNil {

    return [self queueAsyncEvent:[object asyncEventForQueue:self withDelay:delay] completion:completionOrNil];
}

- (FLPromise*) queueObject:(id<FLAsyncObject>) object
                completion:(fl_completion_block_t) completionOrNil {
    return [self queueAsyncEvent:[object asyncEventForQueue:self withDelay:0] completion:completionOrNil];
}

- (FLPromise*) queueObject:(id<FLAsyncObject>) object {
    return [self queueAsyncEvent:[object asyncEventForQueue:self withDelay:0] completion:nil];
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action {
    return [self queueBlock:^{
        [target performSelector:action];
    }];
}

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action
                withObject:(id) object {
    return [self queueBlock:^{
        [target performSelector:action withObject:object];
    }];
}

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action
                withObject:(id) object1
                withObject:(id) object2 {

    return [self queueBlock:^{
        [target performSelector:action withObject:object1 withObject:object2];
    }];
}

#pragma GCC diagnostic pop

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action
                withObject:(id) object1
                withObject:(id) object2
                withObject:(id) object3 {
    return [self queueBlock:^{
        [target performSelector_fl:action withObject:object1 withObject:object2 withObject:object3];
    }];

}

- (FLPromise*) queueTarget:(id) target
                 action:(SEL) action
                withObject:(id) object1
                withObject:(id) object2
                withObject:(id) object3
                withObject:(id) object4 {
    return [self queueBlock:^{
        [target performSelector_fl:action withObject:object1 withObject:object2 withObject:object3 withObject:object4];
    }];
}

- (FLPromisedResult) runBlockSynchronously:(fl_block_t) block {
    return [self queueSynchronousEvent:[FLBlockEvent blockEvent:block]];
}

- (FLPromisedResult) runFinisherBlockSynchronously:(fl_finisher_block_t) block {
    return [self queueSynchronousEvent:[FLFinisherBlockEvent finisherBlockEvent:block]];
}

- (FLPromisedResult) runSynchronously:(id) object {
    return [self queueSynchronousEvent:[object asyncEventForQueue:self withDelay:0]];
}

/*

- (FLPromise*) queueFinishableBlock:(fl_finisher_block_t) block
                          completion:(fl_completion_block_t) completion {


    FLFinisher* finisher = [FLFinisher finisher];
    FLPromise* promise = [finisher addPromiseWithBlock:completion];
    
    FLAssertNotNil(block);
    FLAssertNotNil(finisher);
    [self queueFinishableBlock:block withFinisher:finisher];
    return promise;
}

- (FLPromise*) queueFinishableBlock:(fl_finisher_block_t) block {
    return [self queueFinishableBlock:block completion:nil];
}

- (FLPromise*) queueOperation:(id<FLDispatchable>) operation {
    return [self queueOperation:operation completion:nil];
}


- (void) queueBlock:(fl_block_t) block
        withDelay:(NSTimeInterval) delay
     withFinisher:(FLFinisher*) finisher {
    FLAssertFailedWithComment(@"override this");
}

- (void) queueBlock:(fl_block_t) block
     withFinisher:(FLFinisher*) finisher {
    FLAssertFailedWithComment(@"override this");
}

- (void) queueFinishableBlock:(fl_finisher_block_t) block
               withFinisher:(FLFinisher*) finisher {
    FLAssertFailedWithComment(@"override this");
}

- (FLPromise*) queueBlock:(fl_block_t) block
               completion:(fl_completion_block_t) completionOrNil {
    FLAssertFailedWithComment(@"override this");
    return nil;
}

- (FLPromise*) queueOperation:(id<FLDispatchable>) operation
                   completion:(fl_completion_block_t) completionOrNil {
    FLAssertFailedWithComment(@"override this");
    return nil;
}

- (FLPromise*) queueOperation:(id<FLDispatchable>) operation
                    withDelay:(NSTimeInterval) delay
                   completion:(fl_completion_block_t) completionOrNil {
    return nil;
}

*/
@end



#if REFACTOR 

#import "FLFinisher.h"

#import "FLSelectorPerforming.h"

NS_INLINE
void FLDispatchSync(id<FLAsyncQueue> queue, 
                    dispatch_block_t block) {
                    
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    [queue runBlockSynchronously:block];
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
    return [queue runFinisherBlockSynchronously:block];
}

NS_INLINE
FLPromisedResult FLRunOperation(id<FLAsyncQueue> queue,
                                 id<FLDispatchable> operation) {
    FLAssertNotNil(queue);
    FLAssertNotNil(operation);
    return [queue runOperationSynchronously:operation];
}

NS_INLINE
FLPromise* FLStartOperation(id<FLAsyncQueue> queue, 
                             id<FLDispatchable> operation, 
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

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

FLPromise* FLDispatchSelectorAsync0(id<FLAsyncQueue> queue, 
                                    id target, 
                                    SEL selector, 
                                    fl_completion_block_t completion) {

    if([target respondsToSelector:selector]) {
        return [queue queueBlock:^{ 
            [target performSelector:selector]; 
        } completion:completion];
    }
    
    return nil;
}

FLPromise* FLDispatchSelectorAsync1(id<FLAsyncQueue> queue, 
                                              id target, 
                                              SEL selector, 
                                              id object, 
                                              fl_completion_block_t completion) {
    
    if([target respondsToSelector:selector]) {
        return [queue queueBlock:^{ 
            [target performSelector:selector withObject:object]; 
        } completion:completion];
    }
    
    return nil;
}

FLPromise* FLDispatchSelectorAsync2(id<FLAsyncQueue> queue, 
                                                  id target, 
                                                  SEL selector, 
                                                  id object1, 
                                                  id object2,
                                                  fl_completion_block_t completion) {
    if([target respondsToSelector:selector]) {
        return [queue queueBlock:^{ 
            [target performSelector:selector withObject:object1 withObject:object2]; 
        } completion:completion];
    }
    
    return nil;
}


FLPromise* FLDispatchSelectorAsync3(id<FLAsyncQueue> queue, 
                                                id target, 
                                                SEL selector, 
                                                id object1, 
                                                id object2, 
                                                id object3, 
                                                fl_completion_block_t completion) {
    
    if([target respondsToSelector:selector]) {
        return [queue queueBlock:^{ 
            [target performSelector_fl:selector withObject:object1 withObject:object2 withObject:object3];
        } completion:completion];
    }
    
    return nil;

}

BOOL FLDispatchSelectorSync0(id<FLAsyncQueue> queue, 
                                    id target, 
                                    SEL selector) {

    if([target respondsToSelector:selector]) {
        [queue runBlockSynchronously:^{ 
            [target performSelector:selector]; 
        }];

        return YES;
    }
    
    return NO;
}

BOOL FLDispatchSelectorSync1(id<FLAsyncQueue> queue, 
                                      id target, 
                                      SEL selector, 
                                      id object) {
                                      
    if([target respondsToSelector:selector]) {
        [queue runBlockSynchronously:^{ 
            [target performSelector:selector withObject:object]; } 
        ];
    }
    
    return NO;
}

BOOL FLDispatchSelectorSync2(id<FLAsyncQueue> queue, 
                                          id target, 
                                          SEL selector, 
                                          id object1, 
                                          id object2) {
                                          
    if([target respondsToSelector:selector]) {
        [queue runBlockSynchronously:^{ 
            [target performSelector:selector withObject:object1 withObject:object2]; } 
        ];
        
        return YES;
    }
    
    return NO;
}


BOOL FLDispatchSelectorSync3(id<FLAsyncQueue> queue, 
                                        id target, 
                                        SEL selector, 
                                        id object1, 
                                        id object2, 
                                        id object3) {
                                        
    if([target respondsToSelector:selector]) {
        [queue runBlockSynchronously:^{ 
            [target performSelector_fl:selector withObject:object1 withObject:object2 withObject:object3]; }
        ];

        return YES;
    }
    
    return NO;
}
#pragma GCC diagnostic pop
#endif