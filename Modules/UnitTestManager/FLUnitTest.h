//
//	FLUnitTest.h
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright 2009 GreenTongue Software, LLC. All rights reserved.
//
#import "FishLampCocoa.h"

#import "FLUnitTestCase.h"
#import "FLUnitTestManager.h"
#import "FLUnitTestGroup.h"
#import "FLUnitTestLogger.h"

@class FLUnitTest;

@protocol FLUnitTestProtocol <NSObject>
@optional
+ (void) _willStartUnitTestsForGroup:(FLUnitTestGroup*) unitTest;
+ (void) _didFinishUnitTestsForGroup:(FLUnitTestGroup*) unitTest;

// + (void) _unitTestMyTestName:(FLUnitTest*) unitTest;
@end

typedef enum {
    FLUnitTestStateNone,
    FLUnitTestStateRunning,
    FLUnitTestStatePassed,
    FLUnitTestStateFailed
} FLUnitTestState;

@interface FLUnitTest : FLUnitTestLogger {
@private
    id _testCase;
	NSString* _failedReason;
    FLUnitTestState _state;
    BOOL _locked;
    __weak FLUnitTestGroup* _group;
    NSUInteger _priority;
}

@property (readonly, retain, nonatomic) NSString* testName;

@property (readonly, assign, nonatomic) FLUnitTestState testState;
@property (readonly, assign, nonatomic) FLUnitTestGroup* unitTestGroup;

- (void) setFailed:(NSString*) reasonFormat, ...;
@property (readonly, retain) NSString* failedReason;

- (void) setObject:(id) object forKey:(id) key;
- (id) objectForKey:(id) key;

// for async tests
// call on test thread only.
- (void) blockUntilUnlocked:(NSTimeInterval) timeout;

// these are thread safe
@property (readonly, assign) BOOL isLocked;
- (void) lock;
- (void) unlock;
@end



