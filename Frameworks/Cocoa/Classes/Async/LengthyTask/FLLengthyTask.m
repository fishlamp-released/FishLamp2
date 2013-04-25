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

#if FL_MRC
- (void) dealloc {
    [_name release];
    [super dealloc];
}
#endif

- (id)delegate {
    return nil;
}

- (NSUInteger) calculateTotalStepCount {
	return 1;
}

- (void) prepareTask {
    _started = NO;
	_currentStep = 0;
	_totalStepCount = [self calculateTotalStepCount];
}

- (void) setTaskName:(NSString*) name {
	FLSetObjectWithRetain(_name, name);
	[self.delegate lengthyTaskDidChangeName:self];
}

- (void) executeSelf {
}

- (BOOL) shouldExecuteTask {
    return YES;
}

- (id) performSynchronously {

    if([self shouldExecuteTask] && (!self.delegate || [self.delegate lengthyTaskShouldBegin:self])) {
        [self prepareTask];
        
        _currentStep = 0;
        _started = YES;
        [self.delegate lengthyTaskWillBegin:self];
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
        [self.delegate lengthyTaskDidFinish:self];
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
        
        FLAssertWithComment(_currentStep <= _totalStepCount - 1, @"current step exceeded total");
        [self.delegate lengthyTaskDidIncrementStep:self];

    #if SLOW
        [NSThread sleepForTimeInterval:SLOW];
    #endif
    }
    
//	_currentStep = MIN(_currentStep + 1, _totalStepCount);
}

@end
