//
//  FLWeakRefTests.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWeakRefTests.h"

#import "FLCallback.h"
#import "FLDispatchQueues.h"
#import "FLTimeoutTests.h"

@interface FLWeakRefTestObject : FLCallback<FLWeaklyReferenced> {
@private
}

@end

@implementation FLWeakRefTestObject
- (void) dealloc {
    @try {
        [self invoke:nil];
    }
    @catch(NSException* ex) {
        NSLog(@"exeption in weakRefTestObject: %@", [ex description]);
    }

#if FL_MRC
    [self sendDeallocNotification];
    [super dealloc];
#endif

}

- (BOOL) willSendDeallocNotification {
    return YES;
}

@end


@implementation FLCriticalWeakRefTest

+ (NSArray*) unitTestDependencies {
    return [NSArray arrayWithObject:[FLTimeoutTests class]];
}

- (void) a_testWeakRefDelete {
    __block BOOL wasDeleted = NO;

    FLWeakRefTestObject* obj = [[FLWeakRefTestObject alloc] initWithBlock:^(id sender){
        wasDeleted = YES;
    }];

#if FL_ARC    
    __weak id test = obj;
#endif
    
    FLManuallyRelease(&obj);

    FLAssertIsTrue_(wasDeleted);
    FLAssertIsNil_(obj);

#if FL_ARC    
    FLAssertIsNil_(test);
#endif
}

- (void) b_testWeakRefDeleteNotification {


    FLFinisher* notifier = [FLFinisher finisher];
  
    // Note need to run the test on a thread because the associated objects
    // are autoreleased in the thread and running the test in the main
    // loop causes a deadlock.
  
    [FLDispatchQueue dispatchBlock:^{
        __block BOOL wasDeleted = NO;
    
        FLWeakRefTestObject* obj = [[FLWeakRefTestObject alloc] initWithBlock:^(id sender){
            wasDeleted = YES;
        }];

#if FL_ARC    
        __weak id test = obj;
#endif
        
        FLWeakReference* ref = [FLWeakReference weakReference:obj];
        [ref addNotifierWithBlock:^(id sender) {
            [notifier setFinished];
        }];

// assert here takes a ref on obj, causing it not to delete.
//        FLAssert_(ref.object == test);
//        FLAssert_(ref.object == obj);

        FLManuallyRelease(&obj);

        FLAssertIsNil_(ref.object);

        FLAssertIsTrue_(wasDeleted);
        FLAssertIsNil_(obj);

#if FL_ARC    
        FLAssertIsNil_(test);
#endif
    }];
    
    [notifier waitUntilFinished];
    FLThrowError_(notifier.result);
    
//    FLAssertIsNil_(weakRef.object);
}


@end
