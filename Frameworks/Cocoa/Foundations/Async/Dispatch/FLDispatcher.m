//
//  FLAbstractDispatcher.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDispatcher.h"
#import "FLFinisher.h"

//@protocol FLDispatcherDelegate <NSObject> 
//@optional
//
//- (void) dispatcher:(FLDispatcher*) dispatcher 
// willDispatchObject:(id) object;
//
//- (void) dispatcher:(FLDispatcher*) dispatcher 
//  didDispatchObject:(id) object;                                        
//
//- (void) dispatcher:(FLDispatcher*) dispatcher 
//dispatchFinishableBlock:(FLBlockWithFinisher) block 
//         withFinisher:(FLFinisher*) finisher;
//         
//- (void) dispatcher:(FLDispatcher*) dispatcher
//      dispatchBlock:(FLBlock) block 
//       withFinisher:(FLFinisher*) finisher;         
//
//@end



@interface FLDispatcher ()
//@property (readwrite, assign) id<FLDispatcherDelegate> delegate;
@end

@implementation FLDispatcher 

//@synthesize delegate = _delegate;

- (FLFinisher*) dispatchBlock:(FLBlock) block {
    return [self dispatchBlock:block completion:nil];
}

- (void) dispatchBlock:(FLBlock) block 
              withFinisher:(FLFinisher*) finisher {
    FLAssertIsImplemented_();
}

- (void) dispatchFinishableBlock:(FLBlockWithFinisher) block 
              withFinisher:(FLFinisher*) finisher {
    FLAssertIsImplemented_();
}

- (FLFinisher*) dispatchBlock:(FLBlock) block 
                completion:(FLBlockWithResult) completion {

    FLFinisher* finisher = [FLFinisher finisher:completion];

    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);

    [self dispatchBlock:block withFinisher:finisher];

    return finisher;    
}

- (FLFinisher*) dispatchFinishableBlock:(FLBlockWithFinisher) block {
    return [self dispatchFinishableBlock:block completion:nil];
}

- (FLFinisher*) dispatchFinishableBlock:(FLBlockWithFinisher) block 
                             completion:(FLBlockWithResult) completion {

    FLFinisher* finisher = [FLFinisher finisher:completion];
    FLAssertNotNil_(block);
    FLAssertNotNil_(finisher);
    [self dispatchFinishableBlock:block withFinisher:finisher];
    return finisher;
}

- (void) dispatchBlockWithDelay:(NSTimeInterval) delay
                          block:(FLBlock) block 
                   withFinisher:(FLFinisher*) finisher {
                          
}                          

- (FLFinisher*) dispatchBlockWithDelay:(NSTimeInterval) delay
                                 block:(FLBlock) block {

    FLFinisher* finisher = [FLFinisher finisher];
    [self dispatchBlockWithDelay:delay block:block withFinisher:finisher];
    return finisher;
}                          

@end

//- (FLFinisher*) dispatchObject:(id) object 
//                    completion:(FLBlockWithResult) completion {
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
                    completion:(FLBlockWithResult) completion;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object
                    completion:(FLBlockWithResult) completion;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    completion:(FLBlockWithResult) completion;

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3
                    completion:(FLBlockWithResult) completion;

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
                    completion:(FLBlockWithResult) completion {
    return [self dispatchBlock:^{
        FLPerformSelector(target, selector);
    }
    completion:completion];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object
                    completion:(FLBlockWithResult) completion {
    return [self dispatchBlock:^{
        FLPerformSelector1(target, selector, object);
    }
    completion:completion];

}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    completion:(FLBlockWithResult) completion {
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
                    completion:(FLBlockWithResult) completion {

    return [self dispatchBlock:^{
        FLPerformSelector3(target, selector, object1, object2, object3);
    }
    completion:completion];
}


*/