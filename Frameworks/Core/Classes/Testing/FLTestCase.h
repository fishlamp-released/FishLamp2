//
//  FLTestCase.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/27/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"

#define FLTestCaseFlagOffString                 @"_off"

@class FLTestCase;
@class FLUnitTest;

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
}


@property (readwrite, assign, nonatomic) long runOrder;

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

- (void) setDisabledWithReason:(NSString*) reason;

@end

// DEPRECATED
@interface FLTestCase (TestHelpers)

+ (void) runTestWithExpectedFailure:(void (^)()) test
                       checkResults:(void (^)(NSException* ex, BOOL* pass)) checkResults;

+ (void) runTestWithExpectedFailure:(void (^)()) test;

@end
