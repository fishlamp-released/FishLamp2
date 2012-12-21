//
//  FLLengthyTask.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLLengthyTask.h"

//#define SLOW 1

@implementation FLLengthyTask

+ (id) lengthyTask {
	return FLAutorelease([[[self class] alloc] init]);
}

@synthesize taskName = _name;
@synthesize stepCount = _currentStep;
@synthesize totalStepCount = _totalStepCount;
@synthesize delegate = _delegate;

#if FL_MRC
- (void) dealloc {
    [_name release];
    [super dealloc];
}
#endif

- (NSUInteger) calculateTotalStepCount {
	return 1;
}

- (void) prepareTask {
    _started = NO;
	_currentStep = 0;
	_totalStepCount = [self calculateTotalStepCount];
}

- (void) setTaskName:(NSString*) name {
	FLAssignObjectWithRetain(_name, name);
	[_delegate lengthyTaskDidChangeName:self];
}

- (void) executeSelf {
}

- (BOOL) shouldExecuteTask {
    return YES;
}

- (FLResult) runOperationWithInput:(id) input {

    if([self shouldExecuteTask] && (!_delegate || [_delegate lengthyTaskShouldBegin:self])) {
        [self prepareTask];
        
        _currentStep = 0;
        _started = YES;
        [_delegate lengthyTaskWillBegin:self];
        [self executeSelf];

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
    
    return FLSuccessfullResult;
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

        [self abortIfNeeded];
        
        FLAssert_v(_currentStep <= _totalStepCount - 1, @"current step exceeded total");
        [_delegate lengthyTaskDidIncrementStep:self];

    #if SLOW
        [NSThread sleepForTimeInterval:SLOW];
    #endif
    }
    
//	_currentStep = MIN(_currentStep + 1, _totalStepCount);
}

@end
