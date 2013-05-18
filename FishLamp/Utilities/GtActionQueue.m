//
//  GtActionQueue.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/5/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtActionQueue.h"
#import "GtSimpleCallback.h"



@interface GtActionQueue (Private)

- (void) scheduleNextOperation;

@end


@implementation GtActionQueue

@synthesize timerDelay = m_timerDelay;

- (id) initWithTimerDelay:(CGFloat) delay
{
	if(self = [super init])
	{
		m_operations = [GtAlloc(NSMutableArray) init];
		m_timerDelay = delay;
	}
	
	return self;
}

- (id) init
{
	return [self initWithTimerDelay:GtDefaultActionQueueTimerDelay];;
}

- (void) cancel
{
	if(m_nextOperationTimer)
	{
		[m_nextOperationTimer invalidate];
		m_nextOperationTimer = nil;	
	}
}

- (void) performNextOperation
{
	m_nextOperationTimer = nil;

	GtSimpleCallback* cb = [m_operations objectAtIndex:0];
	[cb invoke];
	
	[m_operations removeObjectAtIndex:0];
	
	if(m_operations.count > 0)
	{
		[self scheduleNextOperation];
	}
}

- (void) scheduleNextOperation
{
	if(!m_nextOperationTimer)
	{
		m_nextOperationTimer = [NSTimer timerWithTimeInterval:m_timerDelay 
				target:self 
				selector:@selector(performNextOperation) 
				userInfo:nil 
				repeats:NO];
			
		[[NSRunLoop mainRunLoop] addTimer:m_nextOperationTimer forMode:NSRunLoopCommonModes];
	}
}

- (void) queueAction:(GtSimpleCallback*) callback
{
	[m_operations addObject:callback];
	[self scheduleNextOperation];
}

- (void)dealloc 
{
	[self cancel];
	GtRelease(m_operations);
    [super dealloc];
}

@end
