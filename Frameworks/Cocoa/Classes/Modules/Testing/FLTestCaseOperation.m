//
//  FLTestCaseOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 8/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTestCaseOperation.h"
#import "FLTestCaseResult.h"
#import "FLUnitTest.h"

//#import "FLUnitTest.h"
//#import "FLObjcRuntime.h"


@implementation FLTestCaseOperation

@synthesize testCase = _testCase;

- (id) initWithTestCase:(FLTestCase*) testCase {
	self = [super init];
	if(self) {
		_testCase = FLRetain(testCase);
	}
	return self;
}

+ (id) testCaseOperation:(FLTestCase*) testCase {
   return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void)dealloc {
	[_testCase release];
	[super dealloc];
}
#endif

- (FLPromisedResult) performSynchronously {

    FLTestCaseResult* result = [FLTestCaseResult testCaseResult:self.testCase];
    [[FLUnitTest logger] pushLoggerSink:result];
        
    @try {
        if(!self.testCase.isDisabled) {
            if(!FLPerformSelector0(_testCaseTarget, _testCaseSelector)) {
                if(_testCaseBlock) {
                    _testCaseBlock();
                }
            }
        }

        [result setPassed];
    }
    @catch(NSException* ex) {
//                 [[results testResultForKey:testCase.testCaseName] setError:ex.error];
    }
    @finally {
        [[FLUnitTest logger] removeLoggerSink:result];
    }
    
    if(result.passed) {
        if(self.testCase.isDisabled) {
            [[FLUnitTest outputLog] appendLineWithFormat:@"DISABLED: %@", self.testCase.testCaseName];
        }
        else {
            [[FLUnitTest outputLog] appendLineWithFormat:@"Passed: %@", self..testCase.testCaseName];
        }
    }
    else {
        [[FLUnitTest outputLog] appendLineWithFormat:@"FAILED: %@", self..testCase.testCaseName ];
        [[FLUnitTest outputLog] indent:^{
            [[FLUnitTest logger] logEntries:result.logEntries];
        }];
    }

    return result;
}


@end
