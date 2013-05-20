//
//	GtActionContextManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtActionContextManager.h"
#import "GtActionContext.h"

NSString* const GtActionManagerActionWillBegin	 		= @"GtActionManagerActionWillBegin";
NSString* const GtActionManagerActionDidFinish	 		= @"GtActionManagerActionDidFinish";

@implementation GtActionContextManager

GtSynthesizeSingleton(GtActionContextManager);

- (id) init
{
	if((self = [super init]))
	{
		m_contextStack = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) addContext:(GtActionContext*) context
{
	[m_contextStack addObject:[NSValue valueWithNonretainedObject:context]];
}

- (void) removeContext:(GtActionContext*) inContext
{
	for(int i = m_contextStack.count - 1; i >= 0; i--)
	{
		GtActionContext* context = (GtActionContext*)[[m_contextStack objectAtIndex:i] nonretainedObjectValue];
		if(context == inContext)
		{
			[m_contextStack removeObjectAtIndex:i];
		}
	}
}

- (void) deactivateAllManagedContexts
{
	m_flags.disableActivatePrevious = YES;

	for(int i = m_contextStack.count - 1; i >= 0; i--)
	{
		GtActionContext* context = (GtActionContext*)[[m_contextStack objectAtIndex:i] nonretainedObjectValue];
		if(context)
		{
			[context deactivate];	
		} 
	}
	
	m_flags.disableActivatePrevious = NO;

}

- (void) activatePreviousContext:(GtActionContext*) inContext
{
	if(!m_flags.disableActivatePrevious)
	{
		BOOL activateNext = NO;
		for(int i = m_contextStack.count - 1; i >= 0; i--)
		{
			GtActionContext* context = (GtActionContext*)[[m_contextStack objectAtIndex:i] nonretainedObjectValue];
			
			if(activateNext)
			{
				[context activate];
				break;
			}	
			else if(context == inContext)
			{
				activateNext = YES;
			}
			
		}
	}
 }

- (GtActionContext*) activeContext
{
	for(int i = m_contextStack.count - 1; i >= 0; i--)
	{
		GtActionContext* context = (GtActionContext*)[[m_contextStack objectAtIndex:i] nonretainedObjectValue];
		if(context.isActive)
		{
			return context;
		}
	}

	return nil;
}

@end
