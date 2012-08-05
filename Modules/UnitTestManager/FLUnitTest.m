//
//	FLUnitTest.m
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright 2009 GreenTongue Software, LLC. All rights reserved.
//

#import "FLUnitTest.h"
#import "_FLUnitTestManager.h"
#import "_FLUnitTest.h"
#import "NSString+GUID.h"
#import "_FLUnitTestGroup.h"

@implementation FLUnitTest

@synthesize testCase = _testCase;
@synthesize testState = _state;
@synthesize unitTestGroup = _group;
@synthesize failedReason = _failedReason;

- (id) initWithTestCase:(id) testCase {
    self = [super init];
    if(self) {
        FLAssignObject(_testCase, testCase);
    }
    
    return self;
}

+ (FLUnitTest*) unitTest:(id) testCase {
    return FLReturnAutoreleased([[[self class] alloc] initWithTestCase:testCase]); 
}

- (void) dealloc {
    FLRelease(_testCase);
	FLRelease(_failedReason);
    FLSuperDealloc();
}

- (void) blockUntilUnlocked:(NSTimeInterval) timeout {

    NSTimeInterval started = [NSDate timeIntervalSinceReferenceDate];

	while(self.isLocked) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
        
        if(started + timeout < [NSDate timeIntervalSinceReferenceDate]) {
        
            // fail
        }
    }
}

- (BOOL) isLocked {
    BOOL isLocked = NO;
    @synchronized(self) {
        isLocked = _locked;
    }
    return isLocked;
}

- (void) lock {
    @synchronized(self) {
        _locked = YES;
    }
}

- (void) unlock {
    @synchronized(self) {
        _locked = NO;
    }
}

- (void) runTest {
    
    _state = FLUnitTestStateRunning;

    @try {
        FLPerformBlockInAutoreleasePool(^{
            [_testCase runTest:self];
        });
        
        if(_state == FLUnitTestStateRunning) {
            _state = FLUnitTestStatePassed;
        }
    }
    @catch(NSException* ex) {
        [self setFailed:[ex description]];
    }
}

- (NSString*) testName {
    return [_testCase testName];
}

- (NSString*) failedReason {
    NSString* failedReason = nil;
    @synchronized(self) {
        failedReason = FLReturnAutoreleased(FLReturnRetained(_failedReason));
    }
    return failedReason;
}

- (void) setFailed:(NSString*) format, ... {
    if(format) {
        va_list va;
        va_start(va, format);
        @synchronized(self) {
            FLAssignObject(_failedReason, FLReturnAutoreleased([[NSMutableString alloc] initWithFormat:format arguments:va]));
            _state = FLUnitTestStateFailed;
        }
        va_end(va);
    }
}

- (void) setObject:(id) object forKey:(id) key {
    [self.unitTestGroup setObject:object forKey:key];
}

- (id) objectForKey:(id) key {
    return [self.unitTestGroup objectForKey:key];
}


@end
