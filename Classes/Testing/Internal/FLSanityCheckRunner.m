//
//  FLSanityCheckRunner.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSanityCheckRunner.h"

#import "FLWeakReference.h"
#import "FLWorkFinisher.h"
#import "FLDispatchQueues.h"

@implementation FLSanityCheckRunner

- (id) init {
    self = [super init];
    if(self) {
        _sanityTests = [[NSMutableSet alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_sanityTests release];
    [super dealloc];
}
#endif

+ (FLSanityCheckRunner*) sanityTestRunner {
    return [self create];
}

- (void) startWorking:(id<FLFinisher>) finisher {
    
    NSMutableArray* tests = FLReturnAutoreleased([[_sanityTests allObjects] mutableCopy]);
    
    [tests sortedArrayUsingSelector:@selector(compare:)];
    
    for(FLTestCase* test in tests) {
        [test runSynchronously];
    }
    
    [finisher setFinished];
}

- (void) addPossibleTestMethod:(FLRuntimeInfo) info {
    if(FLSelectorsAreEqual(info.selector, @selector(addTestCasesToSanityChecks:))) {
        if(info.isMetaClass) {
            [info.class addTestCasesToSanityChecks:_sanityTests];
        }
        else {
            NSLog(@"IGNORING: Sanity Tests [%@ %@] (should be declared at class scope (+), not object scope (-)",
                NSStringFromClass(info.class),
                NSStringFromSelector(info.selector));
        }
    }
}

- (void) addPossibleUnitTestClass:(FLRuntimeInfo) info {

}

@end


@implementation NSObject (UnitTest)
+ (void) addTestCasesToSanityChecks:(NSMutableSet*) list {
}
@end
