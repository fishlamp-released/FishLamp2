//
//  GtLengthyTaskProgress.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLengthyTaskProgressView.h"
#import "GtButton.h"

@implementation GtLengthyTaskProgressView

- (id) initWithLengthyTaskOperation:(GtLengthyTaskOperation*) operation
{
	if((self = [super initWithFrame:CGRectZero]))
	{
		operation.lengthyTaskOperationDelegate = self;
		
		self.button.hidden = YES;
	}
	return self;
}

+ (GtLengthyTaskProgressView*) lengthyTaskProgressView:(GtLengthyTaskOperation*) operation
{
	return GtReturnAutoreleased([[GtLengthyTaskProgressView alloc] initWithLengthyTaskOperation:operation]);
}

- (void) _updateProgressOnMainThread
{
    self.title = @"";
	self.secondaryText = m_operation.operationName;
    self.progressBarText = m_task.taskName;
    [self updateProgress:m_task.currentStep totalAmount:m_task.totalStepCount];
}

- (void) _updateProgress:(GtLengthyTaskOperation*) operation task:(GtLengthyTask*) task
{
    m_operation = operation;
    m_task = task;
    [self performSelectorOnMainThread:@selector(_updateProgressOnMainThread) withObject:nil waitUntilDone:YES];
    m_operation = nil;
    m_task = nil;
}

- (void) lengthyTaskOperation:(GtLengthyTaskOperation*) operation lengthyTaskWasPrepared:(GtLengthyTask*) task
{
	[self _updateProgress:operation task:task];
}

- (void) lengthyTaskOperation:(GtLengthyTaskOperation*) operation lengthyTaskDidIncrementStep:(GtLengthyTask*) task
{
	[self _updateProgress:operation task:task];
}

- (void) lengthyTaskOperation:(GtLengthyTaskOperation*) operation lengthyTaskWillBegin:(GtLengthyTask*) task
{
	[self _updateProgress:operation task:task];
}

- (void) lengthyTaskOperation:(GtLengthyTaskOperation*) operation lengthyTaskDidChangeName:(GtLengthyTask*) task
{
	[self _updateProgress:operation task:task];
}

@end
