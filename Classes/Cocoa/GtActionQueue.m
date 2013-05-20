//
//	GtActionQueue.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/5/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtActionQueue.h"
#import "GtCallbackObject.h"



@interface GtActionQueue (Private)

- (void) scheduleNextOperation;

@end


@implementation GtActionQueue

@synthesize timerDelay = m_timerDelay;

- (id) initWithTimerDelay:(CGFloat) delay
{
	if((self = [super init]))
	{
		m_operations = [[NSMutableArray alloc] init];
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

	GtCallbackObject* cb = [m_operations objectAtIndex:0];
	[cb invoke:nil];
	
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

- (void) queueAction:(GtCallbackObject*) callback
{
	[m_operations addObject:callback];
	[self scheduleNextOperation];
}

- (void)dealloc 
{
	[self cancel];
	GtReleaseWithNil(m_operations);
	GtSuperDealloc();
}

@end
