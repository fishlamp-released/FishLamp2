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

typedef enum {
    FLTestSortOrderNormal,
    FLTestSortOrderFirst,
    FLTestSortOrderLast
} FLTestSortOrder;

@interface FLTestCase ()
@property (readwrite, strong, nonatomic) NSString* testCaseName;
@property (readwrite, assign, nonatomic) SEL testCaseSelector;
@property (readwrite, copy, nonatomic) FLTestBlock testCaseBlock;
@property (readwrite, assign, nonatomic) id testCaseTarget;
@property (readonly, assign, nonatomic) int sortOrder;
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

@synthesize testCaseName = _testCaseName;
@synthesize testCaseTarget = _target;
@synthesize testCaseSelector = _testCaseSelector;
@synthesize testCaseBlock = _testCaseBlock;
//@synthesize selectorType = _selectorType;
@synthesize sortOrder = _sortOrder;

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
        NSMutableString* newString = autorelease_([string mutableCopy]);

        for(int i = 0; i < (sizeof(s_flagPairs) / sizeof(FLTestCaseFlagPair)); i++) {
            
            // set the flag and remove the setting from the test case name
            NSRange range = [newString rangeOfString:s_flagPairs[i].name];
            if(range.length) {
                switch(s_flagPairs[i].flag) {
                
                    case FLTestCaseFlagNone:
                        break;
                
                    case FLTestCaseFlagDisabled:
                        self.disabled = YES;
                        break;
                        
                        
                }
                
                [newString deleteCharactersInRange:range];
            }
        }
        
        theString = newString;
    }


    FLRetainObject_(_testCaseName, theString);
}

- (id) initWithName:(NSString*) name testBlock:(FLTestBlock) block {
    self = [super init];
    if(self) {
        self.testCaseName = name;
        self.testCaseBlock = block;
    }
    return self;
}


- (id) initWithTarget:(id) target selector:(SEL) selector {
    self = [super init];
    if(self) {
        self.testCaseTarget = target;
        self.testCaseSelector = selector;
        self.testCaseName = [NSString stringWithFormat:@"[%@ %@]", NSStringFromClass([target class]), NSStringFromSelector(selector)];
    }
    return self;
}

+ (FLTestCase*) testCase:(id) target selector:(SEL) selector {
    return autorelease_([[FLTestCase alloc] initWithTarget:target selector:selector]);
}

+ (FLTestCase*) testCase:(NSString*) name testBlock:(FLTestBlock) block {
    return autorelease_([[FLTestCase alloc] initWithName:name testBlock:block]);
}

- (void) setTestCaseSelector:(SEL) sel {
    _testCaseSelector = sel;
//    _selectorType = [NSObject argumentCountForSelector:sel];
    
    NSString* selectorName = NSStringFromSelector(sel);
    
    _sortOrder = FLTestSortOrderNormal;

    if([selectorName rangeOfString:FLTestSetupMethodName options:NSCaseInsensitiveSearch].length > 0) {
        _sortOrder = FLTestSortOrderFirst;
    }
    else if([selectorName rangeOfString:FLTestTeardownMethodName options:NSCaseInsensitiveSearch].length > 0) {
        _sortOrder = FLTestSortOrderLast;
    }
}

#if FL_MRC
- (void) dealloc {
 
//    mrc_release_(_testCompletionBlock);
    mrc_release_(_testCaseName);
    mrc_release_(_testCaseBlock);
    mrc_super_dealloc_();
}
#endif

- (NSComparisonResult) compare:(FLTestCase *)other {

    int otherSortOrder = other.sortOrder;

    if(_sortOrder == FLTestSortOrderFirst || otherSortOrder == FLTestSortOrderLast) {
        return NSOrderedAscending;
    }
    
    if(_sortOrder == FLTestSortOrderLast || otherSortOrder == FLTestSortOrderFirst) {
        return NSOrderedDescending;
    }

    NSComparisonResult result = [self.testCaseName compare:other.testCaseName];
//    if(result == NSOrderedSame) {
//        return _selectorType > other.selectorType ? NSOrderedAscending : NSOrderedDescending;
//    }
    
    return result;
}

- (void) runSelf {
    
    FLSelectorInfo* info = [FLSelectorInfo selectorInfoWithClass:[_target class] selector:_testCaseSelector];
    NSString* prettyString = info.prettyString;
    FLLog(@"STARTING %@", prettyString)
    
//    FLLog(@"    test case: ", info.prettyString);
    @try {
        if(_target) {
            [_target performSelectorSafely:_testCaseSelector];
        }
        else if(_testCaseBlock) {
            _testCaseBlock();
        }
        FLLog(@"PASS!")
    }
    @catch(NSException* ex) {
        self.error = ex.error;
        FLLog(@"FAIL: %@", [ex.error description]);
        
        @throw;
    }
    
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
    
    FLAssertIsTrue_v(passed, @"Didn't catch expected exception");
}


+ (void) runTestWithExpectedFailure:(void (^)()) test {
    [self runTestWithExpectedFailure:test checkResults:nil];
}

+ (void) runTestWithExpectedFailure:(FLFailureType) failureType
                       infoString:(NSString*) infoStringContainsThisOrNil
                               test:(void (^)()) callback {

    FLFailureType failed = FLFailureTypeNone;

//    BOOL gotReasonString = infoStringContainsThisOrNil == nil;
    
    @try {
        callback();
    }
    @catch(NSException* ex) {
        
//        if(ex.error.isFailure) {
//            failed = ex.error.code;
//        }
        
//        gotReasonString = [failure.info loca]
    }
    
    FLAssertAreEqual_v(failed, failureType, nil);
}

@end




