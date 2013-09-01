//
//  FLTestCaseRunner.m
//  FishLampCore
//
//  Created by Mike Fullerton on 8/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTestCaseRunner.h"
#import "FLTestCase.h"
#import "FLUnitTestLoggingManager.h"
#import "FLTestCaseResult.h"
#import "FLUnitTest.h"

@implementation FLTestCaseRunner

+ (id) testCaseRunner {
   return FLAutorelease([[[self class] alloc] init]);
}

- (FLTestCaseResult*) performTestCase:(FLTestCase*) testCase {


    FLTestCaseResult* result = [FLTestCaseResult testCaseResult:testCase];

    [[FLUnitTestLoggingManager instance] pushLogger:result.loggerOutput];

    @try {
        [testCase performTest];
        [result setPassed];
    }
    @catch(NSException* ex) {
//                 [[results testResultForKey:testCase.testCaseName] setError:ex.error];
    }
    @finally {
    }

    [[FLUnitTestLoggingManager instance] popLogger];

    if(result.passed) {
        if(testCase.isDisabled) {
            [FLTestOutput appendLineWithFormat:@"DISABLED: %@", testCase.testCaseName];
        }
        else {
            [FLTestOutput appendLineWithFormat:@"Passed: %@", testCase.testCaseName];
        }
    }
    else {
        [FLTestOutput appendLineWithFormat:@"FAILED: %@", testCase.testCaseName];;

        [[FLUnitTestLoggingManager instance] indent:^{
            [FLTestOutput appendStringFormatter:result.loggerOutput];
        }];
    }
}


@end
