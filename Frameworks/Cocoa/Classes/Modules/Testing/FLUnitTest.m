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
#import "FLTestCaseList.h"

@interface FLUnitTest ()
@end

@implementation FLUnitTest

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

+ (NSInteger) unitTestPriority {
    return FLUnitTestPriorityNormal;
}

#if FL_MRC
- (void) dealloc {
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

- (void) discoverTestCases:(FLTestCaseList*) list {

    NSMutableSet* set = [NSMutableSet set];

    FLRuntimeVisitEachSelectorInClassAndSuperclass([self class],
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

        FLTestCase* testCase = [FLTestCase testCase:testName target:self selector:NSSelectorFromString(selectorName)];
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

    [self willRunTestCases:testCases withResults:testCaseResults];

    for(FLTestCase* testCase in testCases) {
        FLTestCaseResult* result = [FLTestCaseResult fromPromisedResult:
                                        [self runChildSynchronously:testCase]];

        [testCaseResults setTestResult:result forKey:testCase.testCaseName];
    }

    [self didRunTestCases:testCases withResults:testCaseResults];

    return testCaseResults;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { group=%@ }", [super description], [[[self class] unitTestGroup] description]];
}

- (void) willRunTestCases:(FLTestCaseList*) testCases
              withResults:(FLTestResultCollection*) results {
}

- (void) didRunTestCases:(FLTestCaseList*) testCases
             withResults:(FLTestResultCollection*) results {
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

+ (NSInteger) unitTestRunCount {
    return 1;
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





