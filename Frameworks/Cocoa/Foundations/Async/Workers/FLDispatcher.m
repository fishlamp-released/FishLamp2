//
//  FLAbstractDispatcher.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDispatcher.h"

@implementation FLDispatcher 

@synthesize delegate = _delegate;

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block {
    return [self dispatchBlock:block completion:nil];
}

- (void) willDispatchObject:(id) object {
    FLPerformSelector2(self.delegate, @selector(dispatcher:willDispatchObject:), self, object);
}

- (void) didDispatchObject:(id) object {
    FLPerformSelector2(self.delegate, @selector(dispatcher:didDispatchObject:), self, object);
}                                        

- (void) dispatchBlock:(dispatch_block_t) block 
              withFinisher:(FLFinisher*) finisher {
    
    if(!FLPerformSelector2(self.delegate, @selector(dispatchBlock:withFinisher:), self, finisher)) {
        FLAssertIsImplemented_();
    }
}

- (FLFinisher*) createFinisher:(FLCompletionBlock) completionBlock {
    return [FLMainThreadFinisher finisher:completionBlock];
}

- (void) dispatchFinishableBlock:(FLFinishableBlock) block 
              withFinisher:(FLFinisher*) finisher {

    if(!FLPerformSelector2(self.delegate, @selector(dispatchFinishableBlock:withFinisher:), self, finisher)) {
        FLAssertIsImplemented_();
    }
}

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block 
                completion:(FLCompletionBlock) completion {

    FLFinisher* finisher = [self createFinisher:completion];

    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);

    [self dispatchBlock:block withFinisher:finisher];

    return finisher;    
}

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block {
    return [self dispatchFinishableBlock:block completion:nil];
}

- (FLFinisher*) dispatchFinishableBlock:(FLFinishableBlock) block 
                             completion:(FLCompletionBlock) completion {

    FLFinisher* finisher = [self createFinisher:completion];
    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);
    [self dispatchFinishableBlock:block withFinisher:finisher];
    return finisher;
}

- (FLFinisher*) dispatchObject:(id) object {
    return [self dispatchObject:object completion:nil];
}

- (FLFinisher*) dispatchObject:(id) object 
                    completion:(FLCompletionBlock) completion {

    FLAssertNotNil_(object);

    FLFinisher* finisher = [self createFinisher:completion];

    return [self dispatchBlock: ^{
        
        [self willDispatchObject:object];
        
        FLFinisher* objectFinisher =  [self createFinisher:^(FLResult result) {
            [finisher setFinishedWithResult:result];
            [self didDispatchObject:object];
        }];
        
        @try {
            [object startWorking:objectFinisher];
        }
        @catch(NSException* ex) {
            [objectFinisher setFinishedWithResult:ex.error];
        }
    }];
    
    return finisher;
}

//- (FLFinisher*) dispatchObject:(id) object 
//                    completion:(FLCompletionBlock) completion {
//
//    FLAssertNotNil_(object);
//
//    FLFinisher* finisher = nil;
//
//    id context = self.context;
//    if(context) {
//        FLSafeguardBlock(completion);
//    
//         finisher = [self createFinisher:^(FLResult result) {
//            if(completion) {
//                completion(result));
//            }
//            FLPerformSelector2(context, @selector(dispatcher:didDispatchObject:), self, object);
//        }];
//    }
//    else {
//        finisher = [self createFinisher:completion];
//    }
//
//    return [self dispatchBlock: ^{
//        @try {
//            FLPerformSelector2(context, @selector(dispatcher:willDispatchObject:), self, object);
//            [object startWorking:finisher];
//        }
//        @catch(NSException* ex) {
//            [finisher setFinishedWithResult:ex.error];
//        }
//     }];
//    
//    return finisher;
//}

- (void) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(dispatch_block_t) block 
                          withFinisher:(FLFinisher*) finisher {
                          
}                          

- (FLFinisher*) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(dispatch_block_t) block {

    FLFinisher* finisher = [self createFinisher:nil];
    [self dispatchBlockWithDelay:delay block:block withFinisher:finisher];
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


@end
