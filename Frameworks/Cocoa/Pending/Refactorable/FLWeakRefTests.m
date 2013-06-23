//
//  FLWeakRefTests.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLWeakRefTests.h"

#import "FLCallback.h"
#import "FLDispatchQueue.h"
#import "FLTimeoutTests.h"
#import "FLWeaklyReferenced.h"

#if REFACTOR

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

+ (FLUnitTestGroup*) unitTestGroup {
    return [self sanityCheckTestGroup];
}

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

    FLAssertIsTrue(wasDeleted);
    FLAssertIsNil(obj);

#if FL_ARC    
    FLAssertIsNil(test);
#endif
}

- (void) b_testWeakRefDeleteNotification {

    FLFinisher* notifier = [FLFinisher finisher];
  
    // Note need to run the test on a thread because the associated objects
    // are autoreleased in the thread and running the test in the main
    // loop causes a deadlock.
  
    [FLDefaultQueue dispatchBlock:^{
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
//        FLAssert(ref.object == test);
//        FLAssert(ref.object == obj);

        FLManuallyRelease(&obj);

        FLAssertIsNil(ref.object);

        FLAssertIsTrue(wasDeleted);
        FLAssertIsNil(obj);

#if FL_ARC    
        FLAssertIsNil(test);
#endif
    }];
    
    [notifier waitUntilFinished];
    FLThrowError(notifier.result);
    
//    FLAssertIsNil(weakRef.object);
}


@end

#endif