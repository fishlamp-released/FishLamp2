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
@property (readwrite, strong) NSMutableArray* resultsArray;
@property (readonly, strong) NSArray* testCases;
@end

@implementation FLUnitTest

@synthesize resultsArray = _results;
@synthesize testCases = _testCases;
@synthesize verifier = _verifier;

+ (FLUnitTest*) unitTest {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (id) init {
    self = [super init];
    if(self) {
        _testCases = [[NSMutableArray alloc] init];
        _verifier = [[FLTestVerifier alloc] init];
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
    
    for(FLSelectorInfo* selector in methodList) {
        if([selector argumentCount] == 2) {
            FLTestCase* testCase = [FLTestCase testCase:self selector:selector.selector];
            [_testCases addObject:testCase];
        
            [self.verifier addExpectedResult:testCase];
        }
        else {
            FLLog(@"Skipping test case %@ (expecting zero arguments but found %d)", [selector prettyString], [selector argumentCount] - 2);
        }
    }
    
}

+ (NSInteger) unitTestPriority {
    return FLUnitTestPriorityNormal;
}

#if FL_NO_ARC
- (void) dealloc {
    [_verifier release];
    [_testCases release];
    [_results release];
    [super dealloc];
}
#endif

- (FLUnitTestResult*) unitTestResult {
    return [FLUnitTestResult unitTestResult:self];
}

- (void) runSelf {
    @try {
        [_testCases sortUsingSelector:@selector(compare:)];
        for(FLTestCase* testCase in _testCases) {
            [self runSubOperation:testCase];
            [self.verifier addHandledResult:testCase];
        }

        FLConfirm_v([self.verifier checkResults], @"test didn't pass verifier results");
    }
    @catch(NSException* ex) {
    
    }
}

@end

@implementation FLSanityCheck

+ (NSInteger) unitTestPriority {
    return FLUnitTestPrioritySanityCheck;
}

@end




