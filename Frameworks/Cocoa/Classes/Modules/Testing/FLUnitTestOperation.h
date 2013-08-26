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
#import "FLTestCaseList.h"

@class FLTestCaseList;
@class FLUnitTest;

#define FLLogTypeTest       @"com.fishlamp.unit-test"


/**
    note that subclass with a method in int with the word "test" in it will be run.
    no need to add the test cases yourself, unless you want to add one.
*/
@interface FLUnitTestOperation : FLSynchronousOperation {
@private
    FLUnitTest* _unitTest;
}

@property (readonly, strong) FLUnitTest* unitTest;

+ (id) unitTestOperation:(FLUnitTest*) unitTest;

+ (FLLogger*) logger;
+ (void) setLogger:(FLLogger*) logger;

+ (FLLogger*) outputLog;
+ (void) setOutputLog:(FLLogger*) logger;

@end

