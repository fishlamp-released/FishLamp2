//
//  FLDispatcher.m
//  FLCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatcher.h"

@implementation FLDispatcher 

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block {
    return [self dispatchBlock:block completion:nil];
}

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block 
                completion:(FLCompletionBlock) completion {

    return nil;
}

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block {
    return [self dispatchFinishableBlock:block completion:nil];
}

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block 
                             completion:(FLCompletionBlock) completion {

    return nil;
}

- (FLFinisher*) dispatchObject:(id) object {
    return [self dispatchObject:object completion:nil];
}

- (FLFinisher*) dispatchObject:(id) object 
                   completion:(FLCompletionBlock) completion {

    FLAssertNotNil_(object);

    FLFinisher* finisher = [FLScheduledFinisher finisher:completion];

    return [self dispatchBlock: ^{
    
        [self willDispatchObject:object];
    
        [object startPerforming:^(FLResult result) {
            [finisher setFinishedWithResult:result];

            [self didDispatchObject:object];
        }];
    }];
    
    return finisher;
}


- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector {
    return [self dispatchBlock:^{
        FLPerformSelector(target, selector);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object {
    return [self dispatchBlock:^{
        FLPerformSelector1(target, selector, object);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2 {
    return [self dispatchBlock:^{
        FLPerformSelector2(target, selector, object1, object2);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3 {
    return [self dispatchBlock:^{
        FLPerformSelector3(target, selector, object1, object2, object3);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    completion:(FLCompletionBlock) completion {
    return [self dispatchBlock:^{
        FLPerformSelector(target, selector);
    }
    completion:completion];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object
                    completion:(FLCompletionBlock) completion {
    return [self dispatchBlock:^{
        FLPerformSelector1(target, selector, object);
    }
    completion:completion];

}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    completion:(FLCompletionBlock) completion {
    return [self dispatchBlock:^{
        FLPerformSelector2(target, selector, object1, object2);
    }
    completion:completion];

}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3
                    completion:(FLCompletionBlock) completion {

    return [self dispatchBlock:^{
        FLPerformSelector3(target, selector, object1, object2, object3);
    }
    completion:completion];
}

- (void) willDispatchObject:(id) object {
}

- (void) didDispatchObject:(id) object {

}                                        



@end
