//
//  FLTestCaseRunner.m
//  FishLampCore
//
//  Created by Mike Fullerton on 8/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTestCaseRunner.h"
#import "FLTestCase.h"
#import "FLUnitTestLogger.h"
#import "FLTestCaseResult.h"

@implementation FLTestCaseRunner

- (FLTestCaseResult*) performTestCase:(FLTestCase*) testCase {


    FLTestCaseResult* result = [FLTestCaseResult testCaseResult:self.testCase];

    [[FLUnitTestLogger instance] pushLogger:result.loggerOutput propagate:NO];

    @try {
        [testCase performTest];
        [result setPassed];
    }
    @catch(NSException* ex) {
//                 [[results testResultForKey:testCase.testCaseName] setError:ex.error];
    }
    @finally {
    }

    [[FLUnitTest logger] popLogger:NO];

    if(result.passed) {
        if(self.testCase.isDisabled) {
            [[FLUnitTestLogger instance] appendLineWithFormat:@"DISABLED: %@", self.testCase.testCaseName];
        }
        else {
            [[FLUnitTestLogger instance] appendLineWithFormat:@"Passed: %@", self..testCase.testCaseName];
        }
    }
    else {
        [[FLUnitTestLogger instance] appendLineWithFormat:@"FAILED: %@", self..testCase.testCaseName ];

        [[FLUnitTestLogger instance] indent:^{
            [[FLUnitTestLogger instance] appendStringFormatter:result.loggerOutput];
        }];
    }
}


@end
