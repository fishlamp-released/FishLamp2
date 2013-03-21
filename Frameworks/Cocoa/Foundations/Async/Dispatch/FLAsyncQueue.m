//
//  FLAbstractDispatcher.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncQueue.h"
#import "FLFinisher.h"

//@protocol FLAsyncQueueDelegate <NSObject> 
//@optional
//
//- (void) dispatcher:(FLAsyncQueue*) dispatcher 
// willDispatchObject:(id) object;
//
//- (void) dispatcher:(FLAsyncQueue*) dispatcher 
//  didDispatchObject:(id) object;                                        
//
//- (void) dispatcher:(FLAsyncQueue*) dispatcher 
//queueFinishableBlock:(FLBlockWithFinisher) block 
//         withFinisher:(FLFinisher*) finisher;
//         
//- (void) dispatcher:(FLAsyncQueue*) dispatcher
//      queueBlock:(FLBlock) block 
//       withFinisher:(FLFinisher*) finisher;         
//
//@end



@interface FLAsyncQueue ()
//@property (readwrite, assign) id<FLAsyncQueueDelegate> delegate;
@end

@implementation FLAsyncQueue 

//@synthesize delegate = _delegate;

- (FLFinisher*) queueBlock:(FLBlock) block {
    return [self queueBlock:block completion:nil];
}

- (void) queueBlock:(FLBlock) block 
              withFinisher:(FLFinisher*) finisher {
    FLAssertIsImplemented();
}

- (void) queueFinishableBlock:(FLBlockWithFinisher) block 
              withFinisher:(FLFinisher*) finisher {
    FLAssertIsImplemented();
}

- (FLFinisher*) queueBlock:(FLBlock) block 
                completion:(FLBlockWithResult) completion {

    FLFinisher* finisher = [FLFinisher finisher:completion];

    FLAssertNotNil(block);
    FLAssertNotNil(finisher);

    [self queueBlock:block withFinisher:finisher];

    return finisher;    
}

- (FLFinisher*) queueFinishableBlock:(FLBlockWithFinisher) block {
    return [self queueFinishableBlock:block completion:nil];
}

- (FLFinisher*) queueFinishableBlock:(FLBlockWithFinisher) block 
                             completion:(FLBlockWithResult) completion {

    FLFinisher* finisher = [FLFinisher finisher:completion];
    FLAssertNotNil(block);
    FLAssertNotNil(finisher);
    [self queueFinishableBlock:block withFinisher:finisher];
    return finisher;
}

- (void) queueBlockWithDelay:(NSTimeInterval) delay
                          block:(FLBlock) block 
                   withFinisher:(FLFinisher*) finisher {
                          
}                          

- (FLFinisher*) queueBlockWithDelay:(NSTimeInterval) delay
                                 block:(FLBlock) block {

    FLFinisher* finisher = [FLFinisher finisher];
    [self queueBlockWithDelay:delay block:block withFinisher:finisher];
    return finisher;
}                          

@end

//- (FLFinisher*) dispatchObject:(id) object 
//                    completion:(FLBlockWithResult) completion {
//
//    FLAssertNotNil(object);
//
//    FLFinisher* finisher = nil;
//
//    id context = self.context;
//    if(context) {
//       completion = FLCopyWithAutorelease(completion);
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
//    return [self queueBlock: ^{
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
@protocol FLAsyncQueue <NSObject>

    __unsafe_unretained id<FLAsyncQueueDelegate> _delegate;


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
    return [self queueBlock:^{
        FLPerformSelector(target, selector);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object {
    return [self queueBlock:^{
        FLPerformSelector1(target, selector, object);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2 {
    return [self queueBlock:^{
        FLPerformSelector2(target, selector, object1, object2);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    withObject:(id) object3 {
    return [self queueBlock:^{
        FLPerformSelector3(target, selector, object1, object2, object3);
    }];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    completion:(FLBlockWithResult) completion {
    return [self queueBlock:^{
        FLPerformSelector(target, selector);
    }
    completion:completion];
}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object
                    completion:(FLBlockWithResult) completion {
    return [self queueBlock:^{
        FLPerformSelector1(target, selector, object);
    }
    completion:completion];

}

- (FLFinisher*) dispatchTarget:(id) target 
                      selector:(SEL) selector
                    withObject:(id) object1
                    withObject:(id) object2
                    completion:(FLBlockWithResult) completion {
    return [self queueBlock:^{
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

    return [self queueBlock:^{
        FLPerformSelector3(target, selector, object1, object2, object3);
    }
    completion:completion];
}


*/