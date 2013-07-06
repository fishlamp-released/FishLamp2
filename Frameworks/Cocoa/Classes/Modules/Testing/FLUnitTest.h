//
//	FLUnitTest.h
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLamp.h"
#import "FLSynchronousOperation.h"

#import "FLUnitTestResult.h"
#import "FLTestResultCollection.h"
#import "FLUnitTestGroup.h"

@class FLTestCaseList;

#define FLLogTypeTest       @"com.fishlamp.unit-test"

#define FLTestLog(__FORMAT__, ...)   \
        FLLogToLogger([FLUnitTest logger], FLLogTypeTest, __FORMAT__, ##__VA_ARGS__)


/**
    note that subclass with a method in int with the word "test" in it will be run.
    no need to add the test cases yourself, unless you want to add one.
*/
@interface FLUnitTest : FLSynchronousOperation {
@private
}

@property (readonly, strong) NSString* unitTestName;

+ (FLUnitTest*) unitTest;

+ (FLUnitTestGroup*) unitTestGroup; // defaultTestGroup by default.

+ (NSArray*) unitTestDependencies;

+ (BOOL) unitTestClassDependsOnUnitTestClass:(Class) unitTestClass;

+ (FLLogger*) logger;
+ (void) setLogger:(FLLogger*) logger;

+ (FLLogger*) outputLog;
+ (void) setOutputLog:(FLLogger*) logger;

+ (FLUnitTestGroup*) sanityCheckTestGroup;
+ (FLUnitTestGroup*) frameworkTestGroup;
+ (FLUnitTestGroup*) importantTestGroup;
+ (FLUnitTestGroup*) defaultTestGroup;
+ (FLUnitTestGroup*) lastTestGroup;

// optional overrides

// NOTE: these are NOT tests. Thrown exceptions will terminate everything.
- (void) setup:(FLTestCaseList*) testCases withResults:(FLTestResultCollection*) results;
- (void) teardown:(FLTestCaseList*) testCases withResults:(FLTestResultCollection*) results;


// any method with "test" in it (no params) will be run.

// tests with "first" and "test" will be run first

// tests with "last" and "test" will be run last;

// all other tests are run in alphebetical order.


@end

