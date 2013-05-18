//
//  GtActionManager.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/1/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtActionManager.h"
#import "GtAction.h"
#import "GtDefaultErrorHandler.h"

@interface GtActionManager (Private) 
- (void) performNextActionInQueue;
- (void) mainThreadCallback:(GtAction*) action;
- (void) threadedCallback:(GtAction*) action;
@end

@implementation GtActionManager

GtSynthesizeSingleton(GtActionManager);

- (id) init
{
	if(self = [super init])
	{
		m_operations = [GtAlloc(NSOperationQueue) init];
		m_executingActions = [GtAlloc(NSMutableArray) init];
		m_queue = [GtAlloc(NSMutableArray) init];
	}
	
	return self;
}	

- (void) dealloc
{
	GtRelease(m_operations);
	GtRelease(m_executingActions);
	GtRelease(m_queue);
	
	[super dealloc];
}

- (void) actionFinished:(GtAction*) action
{
    [m_executingActions removeObject:action];
    [m_queue removeObject:action];
}

- (void) performNextActionInQueue
{
	if(!m_inPerformNextActionInQueue)
	{
		m_needsPerformNextAction = NO;
		m_inPerformNextActionInQueue = YES;

		@try
		{
			while(m_queue.count)
			{
				GtAction* action = [m_queue lastObject];
				if(action.wasCancelled)
				{
					[action retain];
                    [action handleActionCompleted];
					GtRelease(action);
					continue;
				}
				
				if(!action.isExecuting && !action.isFinished)
				{	
					[action beginAction];
				}
				break;
			}
		}
		@finally
		{
			m_inPerformNextActionInQueue = NO;
			
			if(m_needsPerformNextAction)
			{
				[self performSelectorOnMainThread:@selector(performNextActionInQueue) withObject:nil waitUntilDone:NO];
			}
		}
	}
	else
	{
		m_needsPerformNextAction = YES;
	}
}

- (void) mainThreadCallback:(GtAction*) action
{
	NSAutoreleasePool* pool = [GtAlloc(NSAutoreleasePool) init];
    @try
	{
        [action handleActionCompleted];
    }
    @finally
	{
        [self performNextActionInQueue];
    
   		GtRelease(pool);
		// if you get an exception here or BAD_ACCESS
		// you probably overreleased something in your callback
    }
}

- (void) threadedCallback:(GtAction*) action
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

	@try
	{
#if GT_DELAY_ACTION
		NSTimeInterval delay = GtGetEnvironmentVariableInteger(GtDelayActionsBy);
		if(delay > 0)
		{
        	[NSThread  sleepForTimeInterval:delay];
		}
#endif

		[action performOperationInThread];
    
		[self performSelectorOnMainThread:@selector(mainThreadCallback:) withObject:action waitUntilDone:NO];
	}
	@catch(NSException* err)
	{
		[[GtDefaultErrorHandler instance] onHandleUncaughtException:err];
	}
	@finally
	{
		GtRelease(pool);
	}
}

- (void) beginAction:(GtAction*) action
{
	if(!action.wasCancelled)
	{
		[m_executingActions addObject:action];
		
		if(action.operationCount == 0)
		{
			[self performSelectorOnMainThread:@selector(mainThreadCallback:) withObject:action waitUntilDone:NO];
		}
		else
		{
			NSInvocationOperation* op = [GtAlloc(NSInvocationOperation) initWithTarget:self 
				selector:@selector(threadedCallback:) object:action];
			[m_operations addOperation:op];
			GtRelease(op);
		}
	}
    else
    {
        GtAssert(action.isFinished, @"action will never be finished if this is not true");
    }
    
}

- (void) queueAction:(GtAction*) action
{
	[m_queue insertObject:action atIndex:0];
	[self performNextActionInQueue];
}

@end

