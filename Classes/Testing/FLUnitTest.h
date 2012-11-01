//
//	FLTestCase.h
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright 2009 GreenTongue Software, LLC. All rights reserved.
//
#import "FishLampCore.h"
#import "FLLog.h"
#import "FLTestCase.h"
#import "FLUnitTestResult.h"
#import "FLWorkFinisher.h"
#import "FLTestResultCollection.h"
#import "FLOperation.h"
#import "FLUnitTestGroup.h"

@class FLOperationQueue;

#define FLTestLog(__FORMAT__, ...)   \
        FLLogWithType(FLLogTypeTest, __FORMAT__, ##__VA_ARGS__)

#define UTLog FLTestLog


#define FLTestSetupMethodName       @"testsWillRun"
#define FLTestTeardownMethodName    @"testsDidRun"

/**
    note that subclass with a method in int with the word "test" in it will be run.
    no need to add the test cases yourself, unless you want to add one.
*/
@interface FLUnitTest : FLOperation {
@private
    NSMutableArray* _testCases;
    FLTestResultCollection* _results;
}

@property (readonly, strong) FLTestResultCollection* results;
@property (readonly, strong) NSString* unitTestName;
+ (FLUnitTest*) unitTest;

+ (FLUnitTestGroup*) unitTestGroup;

//- (void) addTestCase:(FLTestCase*) testCase;
//- (FLTestCase*) findTestCaseByName:(NSString*) name;

- (void) discoverTestCases;

@end

@interface FLSanityCheck : FLUnitTest
@end

@interface FLFrameworkUnitTest : FLUnitTest
@end

@interface FLImportantUnitTest : FLUnitTest
@end

@interface FLLastUnitTest : FLUnitTest 
@end