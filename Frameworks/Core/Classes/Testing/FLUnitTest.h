//
//  FLUnitTest.h
//  FishLampCore
//
//  Created by Mike Fullerton on 8/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreRequired.h"
#import "FLUnitTestDefines.h"
#import "FLUnitTestGroup.h"
#import "FLTestCaseList.h"
#import "FLTestResultCollection.h"
#import "FLTestCase.h"
#import "FLTestCaseResult.h"
#import "FLUnitTestLoggingManager.h"

@interface FLUnitTest : NSObject

+ (id) unitTest;

@property (readonly, strong) NSString* unitTestName;

+ (FLUnitTestGroup*) unitTestGroup; // defaultTestGroup by default.

+ (NSArray*) unitTestDependencies;
+ (BOOL) unitTestClassDependsOnUnitTestClass:(Class) unitTestClass;

// optional overrides

// NOTE: these are NOT tests. Thrown exceptions will terminate everything.
- (void) willRunTestCases:(FLTestCaseList*) testCases
              withResults:(FLTestResultCollection*) results;

- (void) didRunTestCases:(FLTestCaseList*) testCases
             withResults:(FLTestResultCollection*) results;

// any method with "test" in it (no params) will be run.

// tests with "first" and "test" will be run first

// tests with "last" and "test" will be run last;

// all other tests are run in alphebetical order.

+ (NSInteger) unitTestRunCount;

@end

