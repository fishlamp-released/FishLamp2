//
//  FLAbstractDispatcher.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAsyncQueue.h"
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
    return [queue queueBlock:block withCompletion:completionOrNil];
}

NS_INLINE
FLPromise* FLFinishAsync(id<FLAsyncQueue> queue, 
                          fl_finisher_block_t block, 
                          fl_completion_block_t completionOrNil) {
    FLAssertNotNil(queue);
    FLAssertNotNil(block);
    return [queue queueFinishableBlock:block withCompletion:completionOrNil];
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
    return [queue queueOperation:operation withCompletion:completionOrNil];
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
        } withCompletion:completion];
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
        } withCompletion:completion];
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
        } withCompletion:completion];
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
        } withCompletion:completion];
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
