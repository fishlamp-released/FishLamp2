//
//	FLTestCase.m
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUnitTest.h"
#import "FLTestCase.h"
#import "FLObjcRuntime.h"
#import "FLTestCaseResult.h"
#import "FLObjcRuntime.h"
#import "FLUnitTestResult.h"
#import "FLUnitTestResult_Internal.h"
#import "FLAsyncQueue.h"


@interface FLUnitTest ()
@property (readonly, strong) NSArray* testCases;
- (void) discoverTestCases;
@end

@implementation FLUnitTest

@synthesize testCases = _testCases;

static FLLogger* s_logger = nil;
static FLLogger* s_outputLogger = nil;

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
        [FLUnitTest setLogger:[FLLogLogger instance]];
    }
}

+ (FLUnitTest*) unitTest {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    self = [super init];
    if(self) {
        _testCases = [[NSMutableArray alloc] init];
        [self discoverTestCases];
    }
    
    return self;
}

- (void) addTestCase:(FLTestCase*) testCase {

    if(testCase.testCaseSelector) {
    
    }

    [_testCases addObject:testCase];
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

    SEL ignore_list[] = {
        @selector(willRunTests),
        @selector(setupTests),
        @selector(teardownTests)
    };

    NSArray* methodList = [NSObject methodsForClass:[self class] filter:filter];
    
    NSString* myName = NSStringFromClass([self class]);
    
    for(FLSelectorInfo* selector in methodList) {
        
        BOOL skip = NO;
        for(int i = 0; i < FLArrayLength(ignore_list, SEL); i++) {
            if(FLSelectorsAreEqual(selector.selector, ignore_list[i])) {
                skip = YES;
                continue;
            }
        }
        
        if(skip) {
            continue;
        }
        
        NSString* testName = [NSString stringWithFormat:@"-[%@ %@]", myName, NSStringFromSelector(selector.selector)];

        FLTestCase* testCase = [FLTestCase testCase:testName target:self selector:selector.selector];
        [_testCases addObject:testCase];

        if([selector argumentCount] != 0) {
            [testCase setDisabledWithReason:[NSString stringWithFormat:@"expecting zero arguments but found %d.", [selector argumentCount]]];
        }
    }
    
}

+ (NSInteger) unitTestPriority {
    return FLUnitTestPriorityNormal;
}

#if FL_MRC
- (void) dealloc {
    [_testCases release];
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
    return [self defaultTestGroup];
}

- (FLTestCase*) findTestCaseForName:(NSString*) name {
    for(FLTestCase* testCase in _testCases) {
        if([testCase.testCaseName isEqual:name]) {
            return testCase;
        }
    }
    
    return nil;
}
- (FLTestCase*) findTestCaseForSelector:(SEL) selector {
    for(FLTestCase* testCase in _testCases) {
        if(FLSelectorsAreEqual(testCase.testCaseSelector, selector)) {
            return testCase;
        }
    }
    
    return nil;
}


//- (void) logString:(NSString*) string
//           logInfo:(FLTestLogInfo) logInfo
//           stackTrace:(FLStackTrace*) stackTrace {
//
//    if(_logRedirect) {
//        [_logRedirect logString:string logInfo:logInfo stackTrace:stackTrace];
//    }
//    else {
//        [super logString:string logInfo:logInfo stackTrace:stackTrace];
//    }
//}

- (BOOL) willRunTests {
    return YES;
}

- (id) performSynchronously {
    FLTestResultCollection* results = [FLTestResultCollection testResultCollection];
        
    if([self willRunTests]) {
        
        [self setupTests];
    
        [_testCases sortUsingSelector:@selector(compare:)];
        
        
        for(FLTestCase* testCase in _testCases) {
        
            if(testCase.isDisabled) {
                [[FLUnitTest outputLog] appendLineWithFormat:@"Disabled: %@ (%@)", testCase.testCaseName, testCase.disabledReason];
            }
            else {
                FLTestCaseResult* result = [FLTestCaseResult testCaseResult:testCase];

                [results setTestResult:result forKey:testCase.testCaseName];
                [[FLUnitTest logger] pushLoggerSink:result];
                    
                @try {
                    FLThrowIfError([self runChildSynchronously:testCase]);
                    [result setPassed];
                }
                @catch(NSException* ex) {
                    [[results testResultForKey:testCase.testCaseName] setError:ex.error];
                }

                [[FLUnitTest logger] removeLoggerSink:result];
                
                if(result.passed) {
                    [[FLUnitTest outputLog] appendLineWithFormat:@"Passed: %@", testCase.testCaseName];
                }
                else {
                    [[FLUnitTest outputLog] appendLineWithFormat:@"FAILED: %@", testCase.testCaseName ];
                    [[FLUnitTest outputLog] indent:^{
                        [[FLUnitTest logger] logEntries:result.logEntries];
                    }];
                }
            }
        }
        
        [self teardownTests];
     }
    
    return results;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { group=%@ }", [super description], [[[self class] unitTestGroup] description]];
}

- (void) setupTests {
}

- (void) teardownTests {
}

+ (NSArray*) unitTestDependencies {
    return nil;
}

+ (BOOL) unitTestClassDependsOnUnitTestClass:(Class) class {

    FLConfirmWithComment([self class] != class, @"%@ can't depend on self", NSStringFromClass([self class]));

    NSArray* dependencies = [self unitTestDependencies]; 
    if(!dependencies) {
        return NO;
    }
    
    for(Class aClass in dependencies) {
        FLConfirmWithComment([self class] != aClass, @"%@ can't depend on self", NSStringFromClass([self class]));
   
        if(aClass == class) {
            return YES;
        }
        
        if([aClass unitTestClassDependsOnUnitTestClass:class]) {
            return YES;
        }
    }

    return NO;
}


+ (FLUnitTestGroup*) sanityCheckTestGroup {
    FLReturnStaticObject([[FLUnitTestGroup alloc] initWithGroupName:@"Sanity Checks" priority:FLUnitTestPrioritySanityCheck]);
}

+ (FLUnitTestGroup*) frameworkTestGroup {
    FLReturnStaticObject( [[FLUnitTestGroup alloc] initWithGroupName:@"Framework Tests" priority:FLUnitTestPriorityFramework]);
}

+ (FLUnitTestGroup*) defaultTestGroup {
    FLReturnStaticObject( [[FLUnitTestGroup alloc] initWithGroupName:@"Normal Tests" priority:FLUnitTestPriorityNormal]);
}

+ (FLUnitTestGroup*) importantTestGroup {
    FLReturnStaticObject( [[FLUnitTestGroup alloc] initWithGroupName:@"Important Tests" priority:FLUnitTestPriorityHigh]);
}

+ (FLUnitTestGroup*) lastTestGroup {
    FLReturnStaticObject( [[FLUnitTestGroup alloc] initWithGroupName:@"Last Tests" priority:FLUnitTestPriorityLow]);
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





