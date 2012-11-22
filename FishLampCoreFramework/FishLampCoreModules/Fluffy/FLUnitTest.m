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

- (BOOL) willRunTests {
    return YES;
}

- (void) runSelf {
    if([self willRunTests]) {
        self.results = [FLTestResultCollection create];
        
        [self setupTests];
    
        [_testCases sortUsingSelector:@selector(compare:)];
        
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
                    [self teardownTests];
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
        
        self.output = self.results;
    }
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { group=%@, results:%@ }", [super description], [[[self class] unitTestGroup] description], [self.results description]];
}

- (void) setupTests {
}

- (void) teardownTests {
}

+ (NSArray*) unitTestDependencies {
    return nil;
}

+ (BOOL) unitTestClassDependsOnUnitTestClass:(Class) class {

    FLConfirm_v([self class] != class, @"%@ can't depend on self", NSStringFromClass([self class]));

    NSArray* dependencies = [self unitTestDependencies]; 
    if(!dependencies) {
        return NO;
    }
    
    for(Class aClass in dependencies) {
        FLConfirm_v([self class] != aClass, @"%@ can't depend on self", NSStringFromClass([self class]));
   
        if(aClass == class) {
            return YES;
        }
        
        if([aClass unitTestClassDependsOnUnitTestClass:class]) {
            return YES;
        }
    }

    return NO;
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





