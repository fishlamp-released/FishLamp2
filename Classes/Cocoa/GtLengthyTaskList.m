//
//  GtLengthyTaskList.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLengthyTaskList.h"


@implementation GtLengthyTaskList

- (id) init
{
	if((self = [super init]))
	{
		m_taskList = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) requestCancel
{
	[super requestCancel];
	
	for(GtLengthyTask* task in m_taskList)
	{
		[task requestCancel];
	}
}

- (NSUInteger) calculateTotalStepCount
{
	NSUInteger totalCount = m_taskList.count;
	for(GtLengthyTask* task in m_taskList)
	{
		[task prepareTask];
		totalCount += task.totalStepCount;
	}
	return totalCount;
}

- (void) lengthyTaskWillBegin:(GtLengthyTask*) task
{
}

- (BOOL) lengthyTaskShouldBegin:(GtLengthyTask *)task
{
    return [self.delegate lengthyTaskShouldBegin:task];
}

- (void) lengthyTaskDidChangeName:(GtLengthyTask*) task
{
	[self.delegate lengthyTaskDidChangeName:self];
}

- (void) lengthyTaskDidIncrementStep:(GtLengthyTask*) task
{
	[self incrementStep];
}

- (void) setTaskName:(NSString*) taskName
{
	GtAssertFailed(@"setting task name not support for list");
}	

- (NSString*) taskName 
{
	if(m_currentTask)
	{
		return m_currentTask.taskName;
	}
	
	return nil;
}

- (void) doExecuteTask
{
	for(GtLengthyTask* task in m_taskList)
	{
		@try
		{
			m_currentTask = task;
			task.delegate = self;
			[task executeTask];
			[self incrementStep];
			
		}
		@finally
		{
			m_currentTask = nil;
			task.delegate = nil;
		}
	}
}

- (void) dealloc
{
	GtRelease(m_taskList);
	GtSuperDealloc();
}

- (void) addLengthyTask:(GtLengthyTask*) task
{
	[m_taskList addObject:task];
}

- (NSUInteger) count
{
	return m_taskList.count;
}

@end
