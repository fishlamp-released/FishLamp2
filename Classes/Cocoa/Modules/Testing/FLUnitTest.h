//
//	FLTestCase.h
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FLCocoaRequired.h"
#import "FLLog.h"
#import "FLTestCase.h"
#import "FLUnitTestResult.h"
#import "FLFinisher.h"
#import "FLTestResultCollection.h"
#import "FLSynchronousOperation.h"
#import "FLUnitTestGroup.h"
#import "FLDispatchQueue.h"

#define FLLogTypeTest       @"com.fishlamp.unit-test"

#define FLTestLog(__FORMAT__, ...)   \
        FLLogToLogger([FLUnitTest logger], FLLogTypeTest, __FORMAT__, ##__VA_ARGS__)


/**
    note that subclass with a method in int with the word "test" in it will be run.
    no need to add the test cases yourself, unless you want to add one.
*/
@interface FLUnitTest : FLSynchronousOperation {
@private
    NSMutableArray* _testCases;
}

@property (readonly, strong) NSString* unitTestName;

+ (FLUnitTest*) unitTest;

- (void) addTestCase:(FLTestCase*) testCase;

- (FLTestCase*) findTestCaseForName:(NSString*) name;
- (FLTestCase*) findTestCaseForSelector:(SEL) selector;

- (void) setupTests; 
- (void) teardownTests;
- (BOOL) willRunTests;

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

@end

