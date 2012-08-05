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

+ (id) lengthyTask
{
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

@synthesize taskName = _name;
@synthesize currentStep = _currentStep;
@synthesize totalStepCount = _totalStepCount;
@synthesize delegate = _delegate;

- (NSUInteger) calculateTotalStepCount
{
	return 1;
}

- (void) prepareTask
{
	self.wasCancelled = NO;
	_currentStep = 0;
	_totalStepCount = [self calculateTotalStepCount];
}

- (void) setTaskName:(NSString*) name
{
	FLAssignObject(_name, name);
	[_delegate lengthyTaskDidChangeName:self];
}

- (void) doExecuteTask
{

}

- (BOOL) shouldExecuteTask
{
    return YES;
}

- (void) executeTask
{
    if([self shouldExecuteTask] && (!_delegate || [_delegate lengthyTaskShouldBegin:self]))
    {
        [_delegate lengthyTaskWillBegin:self];
        [self doExecuteTask];
        _currentStep = self.totalStepCount;
        [_delegate lengthyTaskDidIncrementStep:self];

    #if SLOW
        [NSThread sleepForTimeInterval:SLOW];
    #endif
    }
}

- (void) incrementStep
{
	[self throwIfCancelled];
	_currentStep = MIN(_currentStep + 1, _totalStepCount);
	[_delegate lengthyTaskDidIncrementStep:self];

#if SLOW
	[NSThread sleepForTimeInterval:SLOW];
#endif
}

- (void) dealloc
{
	FLRelease(_name);
	FLSuperDealloc();
}




@end
