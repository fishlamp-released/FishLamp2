//
//  FLSanityCheckRunner.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSanityCheckRunner.h"

#import "FLWeakReference.h"
#import "FLFinisher.h"
#import "FLAsyncQueue.h"
#import "FLTestCase.h"

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

+ (id) sanityTestRunner {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) performSynchronously {
    
    NSMutableArray* tests = FLAutorelease([[_sanityTests allObjects] mutableCopy]);
    
    [tests sortedArrayUsingSelector:@selector(compare:)];
    
    for(FLTestCase* test in tests) {
        FLThrowIfError([self runChildSynchronously:test]);
    }
    
    return FLSuccessfullResult;
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
