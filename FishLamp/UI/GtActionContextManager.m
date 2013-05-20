//
//  GtActionContextManager.m
//  MyZen
//
//  Created by Mike Fullerton on 12/9/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtActionContextManager.h"

@implementation GtActionContextManager

GtSynthesizeSingleton(GtActionContextManager);

- (id) init
{
	if(self = [super init])
	{
		m_contextStack = [GtAlloc(NSMutableArray) init];
	}
	
	return self;
}

- (void) addContext:(GtActionContext*) context
{
	GtWeakReference* ref = [GtAlloc(GtWeakReference) initWithWeakReferenceTo:context];
	[m_contextStack addObject:ref];
	GtRelease(ref);
}

- (void) removeContext:(GtActionContext*) inContext
{
	for(int i = m_contextStack.count - 1; i >= 0; i--)
	{
		GtActionContext* context = (GtActionContext*)[[m_contextStack objectAtIndex:i] object];
		if(context == inContext || !context)
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
		GtActionContext* context = (GtActionContext*)[[m_contextStack objectAtIndex:i] object];
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
            GtActionContext* context = (GtActionContext*)[[m_contextStack objectAtIndex:i] object];
            
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
		GtActionContext* context = (GtActionContext*)[[m_contextStack objectAtIndex:i] object];
		if(context.isActive)
		{
			return context;
		}
	}

	return nil;
}

@end
