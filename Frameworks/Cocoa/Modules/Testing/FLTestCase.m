//  FLTestCase.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestCase.h"
#import "FLStringUtils.h"
#import "FLUnitTest.h"
#import "FLObjcRuntime.h"
#import "FLTestCaseResult_Internal.h"

//#define FLTestCaseFlagBrokenString              @"_broken"
//#define FLTestCaseFlagVerboseString             @"_debug"
//#define FLTestCaseFlagExpectingExceptionString  @"_exception"

@interface FLTestCase ()
@property (readwrite, strong, nonatomic) NSString* testCaseName;
@property (readwrite, assign, nonatomic) SEL testCaseSelector;
@property (readwrite, copy, nonatomic) FLTestBlock testCaseBlock;
@property (readwrite, assign, nonatomic) id testCaseTarget;
@property (readwrite, strong, nonatomic) NSString* disabledReason;
@end

typedef enum {
    FLTestCaseFlagNone                  = 0,
    FLTestCaseFlagDisabled              = (1 << 1),
//    FLTestCaseFlagBroken                = (1 << 2),
//    FLTestCaseFlagDebug                 = (1 << 3),
//    FLTestCaseFlagExpectingException    = (1 << 4),
} FLTestCaseFlag;

typedef struct {
    __unsafe_unretained NSString* name;
    FLTestCaseFlag flag;
} FLTestCaseFlagPair;

FLTestCaseFlagPair s_flagPairs[] = {
    { FLTestCaseFlagOffString,  FLTestCaseFlagDisabled},
//    { FLTestCaseFlagBroken, FLTestCaseFlagBrokenString },
//    { FLTestCaseFlagDebug, FLTestCaseFlagVerboseString },
//    { FLTestCaseFlagExpectingException, FLTestCaseFlagExpectingExceptionString }
};

@implementation FLTestCase
@synthesize disabled = _disabled;
@synthesize priority = _priority;
@synthesize disabledReason = _disabledReason;
@synthesize testCaseBlock = _testCaseBlock;
@synthesize testCaseSelector = _testCaseSelector;
@synthesize testCaseTarget = _testCaseTarget;
@synthesize testCaseName = _testCaseName;


- (void) setDisabledWithReason:(NSString*) reason {
    self.disabled = YES;
    self.disabledReason = reason;
}

- (void) setTestCaseName:(NSString*) string {
    
    // quickly look to see if there's a _ in the method name, search backward
    
    BOOL lookForFlags = NO;
    for(int i = string.length - 1; i >= 0; i--) {
        if([string characterAtIndex:i] == '_') {
            lookForFlags = YES;
            break;
        }
    }

    NSString* theString = string;
    if(lookForFlags) {
        NSMutableString* newString = FLAutorelease([string mutableCopy]);

        for(int i = 0; i < (sizeof(s_flagPairs) / sizeof(FLTestCaseFlagPair)); i++) {
            
            // set the flag and remove the setting from the test case name
            NSRange range = [newString rangeOfString:s_flagPairs[i].name];
            if(range.length) {
                switch(s_flagPairs[i].flag) {
                
                    case FLTestCaseFlagNone:
                        break;
                
                    case FLTestCaseFlagDisabled:
                        self.disabledReason = @"\"_off\" found in test case name";
                        self.disabled = YES;
                        break;
                        
                        
                }
                
//                [newString deleteCharactersInRange:range];
            }
        }
        
        theString = newString;
    }


    FLSetObjectWithRetain(_testCaseName, theString);
}

- (id) initWithName:(NSString*) name testBlock:(FLTestBlock) block {
    self = [super init];
    if(self) {
        self.priority = FLTestCasePriorityNormal; 
        self.testCaseBlock = block;
        self.testCaseName = name;
    }
    return self;
}


- (id) initWithName:(NSString*) name target:(id) target selector:(SEL) selector {
    self = [super init];
    if(self) {
        self.priority = FLTestCasePriorityNormal; 
        self.testCaseTarget = target;
        self.testCaseSelector = selector;
        self.testCaseName = name;
    }
    return self;
}

+ (FLTestCase*) testCase:(NSString*) name target:(id) target selector:(SEL) selector {
    return FLAutorelease([[FLTestCase alloc] initWithName:name target:target selector:selector]);
}

+ (FLTestCase*) testCase:(NSString*) name testBlock:(FLTestBlock) block {
    return FLAutorelease([[FLTestCase alloc] initWithName:name testBlock:block]);
}

- (void) setTestCaseSelector:(SEL) sel {
    _testCaseSelector = sel;

    if(FLSelectorsAreEqual(@selector(setupTests), sel)) {
        self.priority = FLTestCasePriorityHigh + 1;
    }
    else if(FLSelectorsAreEqual(@selector(teardownTests), sel)) {
        self.priority = FLTestCasePriorityLow - 1;
    }
}

#if FL_MRC
- (void) dealloc {
 
    FLRelease(_disabledReason);
 
//    FLRelease(_testCompletionBlock);
    FLRelease(_testCaseName);
    FLRelease(_testCaseBlock);
    FLSuperDealloc();
}
#endif

- (NSComparisonResult) compare:(FLTestCase *)other {

    NSInteger otherPriority = other.priority;

    if(self.priority == otherPriority) {
        return (self.priority > otherPriority) ? NSOrderedAscending : NSOrderedDescending;
    }

//    if(_sortOrder == FLTestSortOrderFirst || otherSortOrder == FLTestSortOrderLast) {
//        return NSOrderedAscending;
//    }
//    
//    if(_sortOrder == FLTestSortOrderLast || otherSortOrder == FLTestSortOrderFirst) {
//        return NSOrderedDescending;
//    }

    return [self.testCaseName compare:other.testCaseName];
}

- (FLResult) performSynchronously {
    if(!FLPerformSelector(_testCaseTarget, _testCaseSelector)) {
        if(_testCaseBlock) {
            _testCaseBlock();
        }
    }
    
    return FLSuccessfullResult;
}


+ (void) runTestWithExpectedFailure:(void (^)()) test
                       checkResults:(void (^)(NSException* ex, BOOL* pass)) checkResults {
 
    BOOL passed = YES;
    @try {
        test();
        passed = NO;
    }
    @catch(NSException* ex) {
        if(checkResults) {
            checkResults(ex, &passed);
        }
    }
    
    FLAssertIsTrueWithComment(passed, @"Didn't catch expected exception");
}


+ (void) runTestWithExpectedFailure:(void (^)()) test {
    [self runTestWithExpectedFailure:test checkResults:nil];
}

+ (void) runTestWithExpectedFailure:(FLAssertionFailure) failureType
                       infoString:(NSString*) infoStringContainsThisOrNil
                               test:(void (^)()) callback {

//    FLAssertionFailure failed = FLAssertionFailureNone;

//    BOOL gotReasonString = infoStringContainsThisOrNil == nil;
    
    @try {
        callback();
    }
    @catch(NSException* ex) {
        
//        if(ex.error.failed) {
//            failed = ex.error.code;
//        }
        
//        gotReasonString = [failure.info loca]
    }
    
//    FLAssertAreEqualWithComment(failed, failureType, nil);
}

@end




