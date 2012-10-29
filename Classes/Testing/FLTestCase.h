//
//  FLTestCase.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOperation.h"

#define FLTestCaseFlagOffString                 @"_off"

@class FLTestCase;
@class FLUnitTest;

typedef void (^FLTestBlock)();

@interface FLTestCase : FLOperation {
@private
    NSString* _testCaseName;
    FLTestBlock _testCaseBlock;
    SEL _testCaseSelector;
    __unsafe_unretained id _target;
    int _selectorType;
    int _sortOrder;
}

@property (readonly, strong, nonatomic) NSString* testCaseName;

// construction
- (id) initWithTarget:(id) target selector:(SEL) selector;
+ (FLTestCase*) testCase:(id) target selector:(SEL) selector;

// run by block
- (id) initWithName:(NSString*) name testBlock:(FLTestBlock) block;
+ (FLTestCase*) testCase:(NSString*) name testBlock:(FLTestBlock) block;

- (NSComparisonResult) compare:(FLTestCase *)other;

@end

@interface FLTestCase (TestHelpers)

+ (void) runTestWithExpectedFailure:(void (^)()) test
                       checkResults:(void (^)(NSException* ex, BOOL* pass)) checkResults;

+ (void) runTestWithExpectedFailure:(void (^)()) test;

@end
