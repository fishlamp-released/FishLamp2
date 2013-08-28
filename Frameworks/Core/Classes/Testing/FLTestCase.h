//
//  FLTestCase.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/27/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"

#define FLTestCaseFlagOffString                 @"[off]"

@class FLTestCase;
@class FLUnitTest;
@protocol FLTestCaseRunner;

typedef void (^FLTestBlock)();

#define FLTestCaseOrderDefault  NSIntegerMax

@interface FLTestCase : NSObject {
@private
    long _runOrder;
    NSString* _testCaseName;
    FLTestBlock _testCaseBlock;
    SEL _testCaseSelector;
    __unsafe_unretained id _testCaseTarget;
    NSString* _disabledReason;
    BOOL _disabled;

    __unsafe_unretained FLUnitTest* _unitTest;
}

@property (readonly, assign) FLUnitTest* unitTest;
@property (readonly, strong, nonatomic) NSString* disabledReason;
@property (readonly, strong, nonatomic) NSString* testCaseName;
@property (readonly, assign, nonatomic) SEL testCaseSelector;
@property (readonly, assign, nonatomic) id testCaseTarget;
@property (readonly, copy, nonatomic) FLTestBlock testCaseBlock;

@property (readwrite, assign, nonatomic) long runOrder;
@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled;

- (void) setDisabledWithReason:(NSString*) reason;

- (id) initWithName:(NSString*) name unitTest:(FLUnitTest*) unitTest;
- (id) initWithName:(NSString*) name unitTest:(FLUnitTest*) unitTest testBlock:(FLTestBlock) block;
- (id) initWithName:(NSString*) name unitTest:(FLUnitTest*) unitTest target:(id) target selector:(SEL) selector;

+ (FLTestCase*) testCase:(NSString*) name unitTest:(FLUnitTest*) unitTest target:(id) target selector:(SEL) selector;
+ (FLTestCase*) testCase:(NSString*) name unitTest:(FLUnitTest*) unitTest testBlock:(FLTestBlock) block;

- (id<FLTestCaseRunner>) testCaseRunner;

@end

#if DEPRECATED
@interface FLTestCase (TestHelpers)

+ (void) runTestWithExpectedFailure:(void (^)()) test
                       checkResults:(void (^)(NSException* ex, BOOL* pass)) checkResults;

+ (void) runTestWithExpectedFailure:(void (^)()) test;

@end
#endif