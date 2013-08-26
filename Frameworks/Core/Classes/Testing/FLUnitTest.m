//
//  FLUnitTest.m
//  FishLampCore
//
//  Created by Mike Fullerton on 8/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLUnitTest.h"

@implementation FLUnitTest

+ (FLUnitTest*) unitTest {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (NSInteger) unitTestPriority {
    return FLUnitTestPriorityNormal;
}

#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif

- (FLUnitTestResult*) unitTestResult {
    return [FLUnitTestResult unitTestResult:self];
}

- (NSString*) unitTestName {
    return NSStringFromClass([self class]);
}

+ (FLUnitTestGroup*) unitTestGroup {
    return [self defaultTestGroup];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { group=%@ }", [super description], [[[self class] unitTestGroup] description]];
}

- (void) willRunTestCases:(FLTestCaseList*) testCases
              withResults:(FLTestResultCollection*) results {
}

- (void) didRunTestCases:(FLTestCaseList*) testCases
             withResults:(FLTestResultCollection*) results {
}

+ (NSArray*) unitTestDependencies {
    return nil;
}

+ (BOOL) unitTestClassDependsOnUnitTestClass:(Class) class {

    FLConfirmWithComment([self class] != class, @"%@ can't depend on self", NSStringFromClass([self class]));

    NSArray* dependencies = [self unitTestDependencies]; 
    if(!dependencies) {
        return NO;
    }
    
    for(Class aClass in dependencies) {
        FLConfirmWithComment([self class] != aClass, @"%@ can't depend on self", NSStringFromClass([self class]));
   
        if(aClass == class) {
            return YES;
        }
        
        if([aClass unitTestClassDependsOnUnitTestClass:class]) {
            return YES;
        }
    }

    return NO;
}

+ (NSInteger) unitTestRunCount {
    return 1;
}

@end
