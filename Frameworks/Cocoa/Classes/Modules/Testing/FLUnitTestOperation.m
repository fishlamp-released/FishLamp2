//
//	FLTestCase.m
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUnitTestOperation.h"
#import "FLTestCase.h"
#import "FLObjcRuntime.h"
#import "FLTestCaseResult.h"
#import "FLObjcRuntime.h"
#import "FLUnitTestResult.h"
#import "FLUnitTestResult_Internal.h"
#import "FLAsyncQueue.h"
#import "FLTestCaseOperation.h"
#import "FLUnitTest.h"

@implementation FLUnitTestOperation

static FLLogger* s_logger = nil;
static FLLogger* s_outputLogger = nil;

@synthesize unitTest = _unitTest;

- (id) initWithUnitTest:(FLUnitTest*) unitTest {
	self = [super init];
	if(self) {
		_unitTest = FLRetain(unitTest);
	}
	return self;
}

+ (id) unitTestOperation:(FLUnitTest*) unitTest {
   return FLAutorelease([[[self class] alloc] initWithUnitTest:unitTest]);
}

#if FL_MRC
- (void)dealloc {
	[_unitTest release];
	[super dealloc];
}
#endif

+ (FLLogger*) logger {
    return s_logger;
}

+ (void) setLogger:(FLLogger*) logger {
    FLSetObjectWithRetain(s_logger, logger);
}

+ (FLLogger*) outputLog {
    return s_outputLogger;
}

+ (void) setOutputLog:(FLLogger*) logger {
    FLSetObjectWithRetain(s_outputLogger, logger);
}

+ (void) initialize {
    if(s_logger == nil) {
        [FLUnitTestOperation setLogger:[FLLogLogger instance]];
    }
}

- (void) discoverTestCases:(FLTestCaseList*) list {

    NSMutableSet* set = [NSMutableSet set];

    FLRuntimeVisitEachSelectorInClassAndSuperclass([self.unitTest class],
        ^(FLRuntimeInfo info, BOOL* stop) {
            if(!info.isMetaClass) {
                if(info.class == [FLUnitTest class]) {
                    *stop = YES;
                }
                else {

//                    NSRange range =

//                    if([NSStringFromSelector(info.selector) rangeOfString:@"test"
//                                                                    options:NSCaseInsensitiveSearch].length > 0) {

                    NSString* name = NSStringFromSelector(info.selector);

                    if(     [name hasPrefix:@"test"] ||
                            FLStringsAreEqual(name, @"firstTest") ||
                            FLStringsAreEqual(name, @"lastTest")) {

                        [set addObject:NSStringFromSelector(info.selector)];
                    };
                }
            }
        });

    NSString* myName = NSStringFromClass([self class]);
    
    for(NSString* selectorName in set) {

        NSString* testName = [NSString stringWithFormat:@"-[%@ %@]", myName, selectorName];

        FLTestCase* testCase = [FLTestCase testCase:testName target:self.unitTest selector:NSSelectorFromString(selectorName)];
        [list addTestCase:testCase];

//        if([selector argumentCount] != 0) {
//            [testCase setDisabledWithReason:[NSString stringWithFormat:@"expecting zero arguments but found %d.", [selector argumentCount]]];
//        }
    }
}

- (FLPromisedResult) performSynchronously {
//    FLTestResultCollection* results = [FLTestResultCollection testResultCollection];

    FLTestCaseList* testCases = [FLTestCaseList testCaseList];
    [self discoverTestCases:testCases];
    [testCases sort];

    FLTestResultCollection* testCaseResults = [FLTestResultCollection testResultCollection];

    [self.unitTest willRunTestCases:testCases withResults:testCaseResults];

    for(FLTestCase* testCase in testCases) {

        FLTestCaseOperation* testCaseOperation = [FLTestCaseOperation testCaseOperation:testCase];

        FLTestCaseResult* result = [FLTestCaseResult fromPromisedResult:
                                        [self runChildSynchronously:testCaseOperation]];

        [testCaseResults setTestResult:result forKey:testCase.testCaseName];
    }

    [self.unitTest didRunTestCases:testCases withResults:testCaseResults];

    return testCaseResults;
}


@end

//@implementation FLSanityCheck
//+ (FLUnitTestGroup*) unitTestGroup {
//    return [FLUnitTestGroup sanityCheckTestGroup];
//}
//@end
//
//@implementation FLFrameworkUnitTest
//+ (FLUnitTestGroup*) unitTestGroup {
//    return [FLUnitTestGroup frameworkTestGroup];
//}
//@end
//
//@implementation FLImportantUnitTest
//+ (FLUnitTestGroup*) unitTestGroup {
//    return [FLUnitTestGroup importantTestGroup];
//}
//@end
//
//@implementation FLLastUnitTest 
//+ (FLUnitTestGroup*) unitTestGroup {
//    return [FLUnitTestGroup lastTestGroup];
//}
//@end





