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

@implementation FLTestCaseRunner

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

    [[FLUnitTest logger] popLogger:NO];

    if(result.passed) {
        if(self.testCase.isDisabled) {
            [[FLUnitTestLoggingManager instance] appendLineWithFormat:@"DISABLED: %@", self.testCase.testCaseName];
        }
        else {
            [[FLUnitTestLoggingManager instance] appendLineWithFormat:@"Passed: %@", self..testCase.testCaseName];
        }
    }
    else {
        [[FLUnitTestLoggingManager instance] appendLineWithFormat:@"FAILED: %@", self..testCase.testCaseName ];

        [[FLUnitTestLoggingManager instance] indent:^{
            [[FLUnitTestLoggingManager instance] appendStringFormatter:result.loggerOutput];
        }];
    }
}


@end
