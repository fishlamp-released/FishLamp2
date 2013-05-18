//
//  GtActionContext.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/8/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtActionContext.h"
#import "GtAction.h"

@implementation GtActionContext

@synthesize delegate = m_delegate;
GtSynthesizeWeakRefProperty();
GtSynthesizeStructProperty(isActive, setIsActive, BOOL, m_flags);

- (void) handleAppQuit:(id) sender
{
#if DEBUG
	GtTrace(GtTraceActionContextChanges, @"Got app quitting event - cancelling actions");
#endif

	[self terminateActions];
}

- (void) handleAppResigned:(id) sender
{
	[self cancelActions];
}

- (void) initContext
{
#if DEBUG
    m_delegateType = @"Unknown";
#endif 

    [[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(handleAppQuit:) 
			name: UIApplicationWillTerminateNotification
			object: [UIApplication sharedApplication]];

    [[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(handleAppResigned:) 
			name: UIApplicationWillResignActiveNotification
			object: [UIApplication sharedApplication]];

}

- (id) initAndActivate:(BOOL) activate
{
    if(self = [super init])
    {
        [self initContext];
        
        if(activate)
        {
            [self activate];
        }
    }
    
    return self;
}

- (id) init
{
	if(self = [super init])
	{
        [self initContext];
	}
	return self;
}

#if DEBUG

- (void) setDelegateTypeWithClass:(Class) class
{
	m_delegateType = NSStringFromClass(class);
	[m_delegateType retain];

	GtTrace(GtTraceActionContextChanges, @"set delegate type for context: %@", m_delegateType);
}

- (void) setDelegate:(id) delegate
{
	m_delegate = delegate;

    [self setDelegateTypeWithClass:[m_delegate class]];
		
}
#endif

- (void) dealloc
{
#if DEBUG
	GtTrace(GtTraceActionContextChanges, @"deleted context for %@", m_delegateType);
#endif 

	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [self deactivate];
	m_delegate = nil;

	GtReleaseWeakRef();
	GtRelease(m_actions);

#if DEBUG
	GtRelease(m_delegateType);
#endif
	
	[super dealloc];
}

- (BOOL) activate
{
	if(!self.isActive)
	{	
		self.isActive = YES;
		
#if DEBUG
		GtTrace(GtTraceActionContextChanges, @"activated context for %@", m_delegateType);
#endif		
		
		if(self.delegate && [self.delegate respondsToSelector:@selector( actionContextActivated:)])
		{
			[self.delegate actionContextActivated:self];
		}
		
		return YES;
	}
	
	return NO;
}

- (BOOL) deactivate
{
	if(self.isActive)
	{
		self.isActive = NO;

		[self terminateActions];
		GtReleaseWithNil(m_actions);
		
#if DEBUG	
		GtTrace(GtTraceActionContextChanges, @"deactivating context for : %@, action count: %d", m_delegateType, [m_actions count]);
#endif
		
		if(self.delegate && [self.delegate respondsToSelector:@selector( actionContextDeactivated:)])
		{
			[self.delegate actionContextDeactivated:self];
		}

		return YES;
	}
	
	return NO;
}

- (BOOL) cancelActions:(BOOL) terminate
{
	BOOL didSomething = NO;
	if(m_actions.count)
	{
#if DEBUG
		GtTrace(GtTraceActionContextChanges, @"Cancelling actions for %@", m_delegateType);
#endif
        @synchronized(self)
        {
            NSMutableArray* cancelledActions = m_actions;
            m_actions = nil;
                    
            @try
            {
                for(int i = cancelledActions.count - 1; i >= 0; i--)
                {
                    GtAction* action = [[cancelledActions objectAtIndex:i] object];
                    if(action)
                    {
                        [action cancelActionButAlreadyRemovedFromContext:terminate];
                        didSomething = YES;
                    }
                    else
                    {
                        [cancelledActions removeObjectAtIndex:i];
                    }
                }
            }
            @finally
            {
                        
                if(self.delegate && [self.delegate respondsToSelector:@selector( actionContextWasCancelled:actionsCancelled:wasTerminated:)])
                {
                    [self.delegate actionContextWasCancelled:self 
                                            actionsCancelled:cancelledActions 
                                               wasTerminated:terminate];
                }
                
                GtRelease(cancelledActions);
            }
        }
	}
	
	return didSomething;
}

- (BOOL) cancelActions
{
    return [self cancelActions:NO];
}

- (BOOL) terminateActions
{
    return [self cancelActions:YES];
}

- (void) addAction:(GtAction*) action
{
	if(!m_actions)
	{
		m_actions = [GtAlloc(NSMutableArray) init];
	}

#if DEBUG
	GtTrace(GtTraceActions, @"added action: %@ to context for %@",  NSStringFromClass([action class]), m_delegateType);
#endif
    
    GtWeakReference* weakRef = [GtAlloc(GtWeakReference) initWithWeakReferenceTo:action];
	[m_actions addObject:weakRef];
    GtRelease(weakRef);
}

- (void) removeAction:(GtAction*) inAction
{
#if DEBUG
	GtTrace(GtTraceActions, @"remove action: %@ from context for %@",  NSStringFromClass([inAction class]), m_delegateType);
#endif
	
    @synchronized(self)
    {
        for(int i = m_actions.count-1; i >= 0; i--)
        {
            GtAction* curAction = [[m_actions objectAtIndex:i] object]; 
        
            if(!curAction)
            {
                [m_actions removeObjectAtIndex:i];
            }
            else if(curAction && curAction == inAction )
            {
                [m_actions removeObjectAtIndex:i];
                return;
            }
        }
    }

#if DEBUG
	GtTrace(GtTraceActions, @"Couldn't remove action");
#endif
}

- (NSString*) description
{
#if DEBUG
	return [NSString stringWithFormat:@"GtActionContext for: %@, isActive: %d", m_delegateType, self.isActive];
#else
	return [super description];
#endif
}


@end
