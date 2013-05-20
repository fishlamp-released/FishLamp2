//
//  GtLengthyTask.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLengthyTask.h"

//#define SLOW 1

@implementation GtLengthyTask

+ (id) lengthyTask
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

@synthesize taskName = m_name;
@synthesize currentStep = m_currentStep;
@synthesize totalStepCount = m_totalStepCount;
@synthesize delegate = m_delegate;

- (NSUInteger) calculateTotalStepCount
{
	return 1;
}

- (void) prepareTask
{
	self.wasCancelled = NO;
	m_currentStep = 0;
	m_totalStepCount = [self calculateTotalStepCount];
}

- (void) setTaskName:(NSString*) name
{
	GtAssignObject(m_name, name);
	[m_delegate lengthyTaskDidChangeName:self];
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
    if([self shouldExecuteTask] && (!m_delegate || [m_delegate lengthyTaskShouldBegin:self]))
    {
        [m_delegate lengthyTaskWillBegin:self];
        [self doExecuteTask];
        m_currentStep = self.totalStepCount;
        [m_delegate lengthyTaskDidIncrementStep:self];

    #if SLOW
        [NSThread sleepForTimeInterval:SLOW];
    #endif
    }
}

- (void) incrementStep
{
	[self throwIfCancelled];
	m_currentStep = MIN(m_currentStep + 1, m_totalStepCount);
	[m_delegate lengthyTaskDidIncrementStep:self];

#if SLOW
	[NSThread sleepForTimeInterval:SLOW];
#endif
}

- (void) dealloc
{
	GtRelease(m_name);
	GtSuperDealloc();
}




@end
