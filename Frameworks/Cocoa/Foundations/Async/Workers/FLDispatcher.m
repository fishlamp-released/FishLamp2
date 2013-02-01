//
//  FLAbstractDispatcher.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDispatcher.h"
#import "FLFinisher.h"

@protocol FLDispatcherDelegate <NSObject> 
@optional

- (void) dispatcher:(FLDispatcher*) dispatcher 
 willDispatchObject:(id) object;

- (void) dispatcher:(FLDispatcher*) dispatcher 
  didDispatchObject:(id) object;                                        

- (void) dispatcher:(FLDispatcher*) dispatcher 
dispatchFinishableBlock:(FLDispatcherFinisherBlock) block 
         withFinisher:(FLFinisher*) finisher;
         
- (void) dispatcher:(FLDispatcher*) dispatcher
      dispatchBlock:(FLDispatcherBlock) block 
       withFinisher:(FLFinisher*) finisher;         

@end



@interface FLDispatcher ()
@property (readwrite, assign) id<FLDispatcherDelegate> delegate;
@end

@implementation FLDispatcher 

@synthesize delegate = _delegate;

- (FLFinisher*) dispatchBlock:(FLDispatcherBlock) block {
    return [self dispatchBlock:block completion:nil];
}

- (void) willDispatchObject:(id) object {
    FLPerformSelector2(self.delegate, @selector(dispatcher:willDispatchObject:), self, object);
}

- (void) didDispatchObject:(id) object {
    FLPerformSelector2(self.delegate, @selector(dispatcher:didDispatchObject:), self, object);
}                                        

- (void) dispatchBlock:(FLDispatcherBlock) block 
              withFinisher:(FLFinisher*) finisher {
    
    if(!FLPerformSelector2(self.delegate, @selector(dispatchBlock:withFinisher:), self, finisher)) {
        FLAssertIsImplemented_();
    }
}

- (FLFinisher*) createFinisher:(FLDispatcherResultBlock) completionBlock {
    return [FLFinisher finisher:completionBlock];
}

- (void) dispatchFinishableBlock:(FLDispatcherFinisherBlock) block 
              withFinisher:(FLFinisher*) finisher {

    if(!FLPerformSelector2(self.delegate, @selector(dispatchFinishableBlock:withFinisher:), self, finisher)) {
        FLAssertIsImplemented_();
    }
}

- (FLFinisher*) dispatchBlock:(FLDispatcherBlock) block 
                completion:(FLDispatcherResultBlock) completion {

    FLFinisher* finisher = [self createFinisher:completion];

    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);

    [self dispatchBlock:block withFinisher:finisher];

    return finisher;    
}

- (FLFinisher*) dispatchFinishableBlock:(FLDispatcherFinisherBlock) block {
    return [self dispatchFinishableBlock:block completion:nil];
}

- (FLFinisher*) dispatchFinishableBlock:(FLDispatcherFinisherBlock) block 
                             completion:(FLDispatcherResultBlock) completion {

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
                    completion:(FLDispatcherResultBlock) completion {

    FLAssertNotNil_(object);

    FLSafeguardBlock(completion);

    FLFinisher* finisher = [FLFinisher finisher:^(FLResult result) {
    
        if(completion) {
            completion(result);
        }
    
        [self didDispatchObject:object];
    }];

    FLDispatcherFinisherBlock block = ^(FLFinisher* theFinisher){
        
        [self willDispatchObject:object];
        @try {
            [object startWorking:theFinisher];
        }
        @catch(NSException* ex) {
            [theFinisher setFinishedWithResult:ex.error];
        }
    };

    [self dispatchFinishableBlock:block withFinisher:finisher];

    return finisher;
}

- (void) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(FLDispatcherBlock) block 
                          withFinisher:(FLFinisher*) finisher {
                          
}                          

- (FLFinisher*) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(FLDispatcherBlock) block {

    FLFinisher* finisher = [self createFinisher:nil];
    [self dispatchBlockWithDelay:delay block:block withFinisher:finisher];
    return finisher;
}                          



@end

//- (FLFinisher*) dispatchObject:(id) object 
//                    completion:(FLDispatcherResultBlock) completion {
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

/*
@protocol FLDispatcher <NSObject>

    __unsafe_unretained id<FLDispatcherDelegate> _delegate;


//
// target/selector dispatching
//

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    completion:(FLDispatcherResultBlock) completion;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object
                    completion:(FLDispatcherResultBlock) completion;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    completion:(FLDispatcherResultBlock) completion;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3
                    completion:(FLDispatcherResultBlock) completion;

@end

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
                    completion:(FLDispatcherResultBlock) completion {
    return [self dispatchBlock:^{
        FLPerformSelector(target, selector);
    }
    completion:completion];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object
                    completion:(FLDispatcherResultBlock) completion {
    return [self dispatchBlock:^{
        FLPerformSelector1(target, selector, object);
    }
    completion:completion];

}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    completion:(FLDispatcherResultBlock) completion {
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
                    completion:(FLDispatcherResultBlock) completion {

    return [self dispatchBlock:^{
        FLPerformSelector3(target, selector, object1, object2, object3);
    }
    completion:completion];
}


*/