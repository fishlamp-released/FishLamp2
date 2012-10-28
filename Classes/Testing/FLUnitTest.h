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
#import "FLFinisher.h"
#import "FLTestVerifier.h"
#import "FLOperation.h"

@class FLOperationQueue;

#define FLTestLog(__FORMAT__, ...)   \
        FLLogWithType(FLLogTypeTest, __FORMAT__, ##__VA_ARGS__)

#define UTLog FLTestLog


#define FLTestSetupMethodName       @"testsWillRun"
#define FLTestTeardownMethodName    @"testsDidRun"

#define FLUnitTestPriorityLow           0
#define FLUnitTestPriorityNormal        1000
#define FLUnitTestPriorityHigh          2000
#define FLUnitTestPrioritySanityCheck   3000

/**
    note that subclass with a method in int with the word "test" in it will be run.
    no need to add the test cases yourself, unless you want to add one.
*/
@interface FLUnitTest : FLOperation {
@private
    NSMutableArray* _results;
    NSMutableArray* _testCases;
    FLTestVerifier* _verifier;
}

+ (NSInteger) unitTestPriority;

@property (readonly, strong) FLTestVerifier* verifier;
@property (readonly, strong) FLUnitTestResult* unitTestResult;

+ (FLUnitTest*) unitTest;

//- (void) addTestCase:(FLTestCase*) testCase;
//- (FLTestCase*) findTestCaseByName:(NSString*) name;

- (void) discoverTestCases;

@end

@interface FLSanityCheck : FLUnitTest
@end