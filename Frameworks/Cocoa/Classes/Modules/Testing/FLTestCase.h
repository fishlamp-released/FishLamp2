//
//  FLTestCase.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/27/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

#import "FLSynchronousOperation.h"

#define FLTestCaseFlagOffString                 @"_off"

@class FLTestCase;
@class FLUnitTest;

typedef void (^FLTestBlock)();

//#define FLTestCasePriorityLow       1
//#define FLTestCasePriorityNormal    (NSIntegerMax / 2)
//#define FLTestCasePriorityHigh      (NSIntegerMax - 1)

@interface FLTestCase : FLSynchronousOperation {
@private
//    NSInteger _priority;
    NSString* _testCaseName;
    FLTestBlock _testCaseBlock;
    SEL _testCaseSelector;
    __unsafe_unretained id _testCaseTarget;
    NSString* _disabledReason;
    BOOL _disabled;
}

- (void) setDisabledWithReason:(NSString*) reason;

@property (readonly, strong, nonatomic) NSString* disabledReason;
@property (readonly, strong, nonatomic) NSString* testCaseName;
@property (readonly, assign, nonatomic) SEL testCaseSelector;
@property (readonly, assign, nonatomic) id testCaseTarget;
@property (readonly, copy, nonatomic) FLTestBlock testCaseBlock;
@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled;

// construction
- (id) initWithName:(NSString*) name target:(id) target selector:(SEL) selector;
+ (id) testCase:(NSString*) name target:(id) target selector:(SEL) selector;

// run by block
- (id) initWithName:(NSString*) name testBlock:(FLTestBlock) block;
+ (id) testCase:(NSString*) name testBlock:(FLTestBlock) block;

@end

@interface FLTestCase (TestHelpers)

+ (void) runTestWithExpectedFailure:(void (^)()) test
                       checkResults:(void (^)(NSException* ex, BOOL* pass)) checkResults;

+ (void) runTestWithExpectedFailure:(void (^)()) test;

@end
