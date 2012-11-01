//
//	FLTestCase.m
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright 2009 GreenTongue Software, LLC. All rights reserved.
//

#import "FLUnitTest.h"
#import "FLTestCase.h"
#import "FLObjcRuntime.h"
#import "FLTestCaseResult.h"
#import "FLTestCaseResult_Internal.h"
#import "FLObjcRuntime.h"
#import "FLUnitTestResult.h"
#import "FLUnitTestResult_Internal.h"
#import "FLOperationQueue.h"

@interface FLUnitTest ()
@property (readwrite, strong) FLTestResultCollection* results;
@property (readonly, strong) NSArray* testCases;
@end

@implementation FLUnitTest

@synthesize testCases = _testCases;
@synthesize results = _results;

+ (FLUnitTest*) unitTest {
    return autorelease_([[[self class] alloc] init]);
}

- (id) init {
    self = [super init];
    if(self) {
        _testCases = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) discoverTestCases {
    FLRuntimeFilterBlock filter = ^(FLRuntimeInfo info, BOOL* passed, BOOL* stop) {
        if(!info.isMetaClass) {
            if(info.class == [FLUnitTest class]) {
                *stop = YES;
            }
            else {
                *passed = [NSStringFromSelector(info.selector) rangeOfString:@"test"
                                                                options:NSCaseInsensitiveSearch].length > 0;
            }
        }
    };

    NSArray* methodList = [NSObject methodsForClass:[self class] filter:filter];
    
//    NSString* myName = NSStringFromClass([self class]);
    
    for(FLSelectorInfo* selector in methodList) {

        NSString* testName = selector.prettyString;
        
//        [NSString stringWithFormat:@"- [%@ %@]", myName, NSStringFromSelector(selector.selector)];

        FLTestCase* testCase = [FLTestCase testCase:testName target:self selector:selector.selector];
        [_testCases addObject:testCase];

        if([selector argumentCount] != 2) {
            [testCase setDisabledWithReason:[NSString stringWithFormat:@"expecting zero arguments but found %d.", [selector argumentCount] - 2]];
        }
    }
    
}

+ (NSInteger) unitTestPriority {
    return FLUnitTestPriorityNormal;
}

#if FL_MRC
- (void) dealloc {
    [_testLog]
    [_results release];
    [_testCases release];
    [_results release];
    [super dealloc];
}
#endif

- (FLUnitTestResult*) unitTestResult {
    return [FLUnitTestResult unitTestResult:self];
}

- (NSString*) unitTestName {
    return NSStringFromClass([self class]);
}

+ (FLUnitTestGroup*) unitTestGroup {
    return [FLUnitTestGroup defaultTestGroup];
}

//- (void) logString:(NSString*) string
//           logInfo:(FLLogInfo) logInfo
//           stackTrace:(FLStackTrace*) stackTrace {
//
//    if(_logRedirect) {
//        [_logRedirect logString:string logInfo:logInfo stackTrace:stackTrace];
//    }
//    else {
//        [super logString:string logInfo:logInfo stackTrace:stackTrace];
//    }
//}

- (void) runSelf {
    [_testCases sortUsingSelector:@selector(compare:)];
    
    self.results = [FLTestResultCollection create];
    
    for(FLTestCase* testCase in _testCases) {
        if(testCase.isDisabled) {
            FLLog(@"DISABLED: %@ (%@)", testCase.testCaseName, testCase.disabledReason);
        }
        else {
            FLTestCaseResult* result = [FLTestCaseResult testCaseResult:testCase];

            [self.results setTestResult:result forKey:testCase.testCaseName];

            @try {
                
                [[FLLogger instance] pushLoggerSink:result];
                
                FLLog(@"STARTING %@", testCase.testCaseName);

                [self runSubOperation:testCase];
                [result setPassed];
                FLLog(@"PASS!")
            }
            @catch(NSException* ex) {
                [[self.results testResultForKey:testCase.testCaseName] setError:ex.error];
                FLLog(@"FAIL: %@", [ex.error description]);
            }
            @finally {
                [[FLLogger instance] removeLoggerSink:result];
            }
            
            if(result.passed) {
                FLLog(@"passed: %@", testCase.testCaseName);
            }
            else {
                [[FLLogger instance] sendEntriesToSinks:result.logEntries];
            }
        }
    }
    
    FLConfirmIsYes_v([self.results allTestsPassed], @"tests failed");
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { group=%@, results:%@ }", [super description], [[[self class] unitTestGroup] description], [self.results description]];
}

@end

@implementation FLSanityCheck
+ (FLUnitTestGroup*) unitTestGroup {
    return [FLUnitTestGroup sanityTestGroup];
}
@end

@implementation FLFrameworkUnitTest
+ (FLUnitTestGroup*) unitTestGroup {
    return [FLUnitTestGroup frameworkTestGroup];
}
@end

@implementation FLImportantUnitTest
+ (FLUnitTestGroup*) unitTestGroup {
    return [FLUnitTestGroup importantTestGroup];
}
@end

@implementation FLLastUnitTest 
+ (FLUnitTestGroup*) unitTestGroup {
    return [FLUnitTestGroup lastTestGroup];
}
@end





