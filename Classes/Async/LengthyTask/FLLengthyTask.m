//
//  FLLengthyTask.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLLengthyTask.h"

//#define SLOW 1

@interface FLLengthyTask ()
@property (readwrite, assign) BOOL wasCancelled; // needs to be atomic.
@end

@implementation FLLengthyTask

+ (id) lengthyTask
{
	return autorelease_([[[self class] alloc] init]);
}

@synthesize services = _services;
@synthesize taskName = _name;
@synthesize stepCount = _currentStep;
@synthesize totalStepCount = _totalStepCount;
@synthesize delegate = _delegate;
@synthesize wasCancelled = _wasCancelled;

- (void) requestCancel {
    self.wasCancelled = YES;
}

- (NSUInteger) calculateTotalStepCount {
	return 1;
}

- (void) prepareTask {
	self.wasCancelled = NO;
    _started = NO;
	_currentStep = 0;
	_totalStepCount = [self calculateTotalStepCount];
}

- (void) setTaskName:(NSString*) name {
	FLRetainObject_(_name, name);
	[_delegate lengthyTaskDidChangeName:self];
}

- (void) beginSelf {
}

- (BOOL) shouldExecuteTask {
    return YES;
}

- (void) executeTask {
    if([self shouldExecuteTask] && (!_delegate || [_delegate lengthyTaskShouldBegin:self])) {
        _currentStep = 0;
        _started = YES;
        [_delegate lengthyTaskWillBegin:self];
        [self beginSelf];

#if DEBUG
        if(_currentStep < _totalStepCount - 1) {
            FLDebugLog(@"didn't set all the steps, will adjust for you.");
        }
#endif

#if SLOW
        [NSThread sleepForTimeInterval:SLOW];
#endif
        _currentStep = self.totalStepCount;
        [_delegate lengthyTaskDidFinish:self];
    }
}

- (void) setStepCount:(NSUInteger) stepCount {
    [self setStepCount:stepCount totalStepCount:_totalStepCount];
}

- (void) incrementStep {
    [self setStepCount:_currentStep + 1];
}


- (void) setStepCount:(NSUInteger) stepCount
               totalStepCount:(NSUInteger) totalStepCount {

	_currentStep = stepCount;
    _totalStepCount = totalStepCount;
    if(_started ) {
        FLThrowIfCancelled(self);
        FLAssert_v(_currentStep <= _totalStepCount - 1, @"current step exceeded total");
        [_delegate lengthyTaskDidIncrementStep:self];

    #if SLOW
        [NSThread sleepForTimeInterval:SLOW];
    #endif
    }
    
//	_currentStep = MIN(_currentStep + 1, _totalStepCount);
}

#if FL_MRC
- (void) dealloc {
    [_services release];
	release_(_name);
	super_dealloc_();
}
#endif




@end
