//
//	GtActionContext.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtActionContext.h"
#import "GtAction.h"
#import "GtUserSession.h"

#if IOS
#import <UIKit/UIApplication.h>
#import <UIKit/UIViewController.h>
#endif


@implementation GtActionContext

@synthesize actionContextDelegate = m_delegate;

GtSynthesizeStructProperty(isActive, setIsActive, BOOL, m_flags);

- (void) appBecamedInactiveHandler:(id) sender
{
	[self cancelActions];
	
	if([m_delegate respondsToSelector:@selector(actionContextAppEnteredBackground:)])
	{
		[m_delegate actionContextAppEnteredBackground:self];
	}
}

- (void) _sendActiveMessage
{
	if(self.isActive)
	{
		if([m_delegate respondsToSelector:@selector(actionContextAppEnteredForeground:)])
		{
			[m_delegate actionContextAppEnteredForeground:self];
		}
	}
}

// TODO: this is getting called twice when app comes into foreground. 
// Need to break these out into seperate calls into delegate.
// for now, just delay the call to make sure it's called only once.
- (void) appBecameActiveHandler:(id) sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_sendActiveMessage) object:nil];
    [self performSelector:@selector(_sendActiveMessage) withObject:nil afterDelay:0.1f];
}

- (void) initContext
{
#if IOS
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(appBecamedInactiveHandler:) 
			name: UIApplicationWillTerminateNotification 
			object: [UIApplication sharedApplication]];
#endif			

	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(appBecameActiveHandler:) 
			name: GtUserSessionDidBecomeActiveNotification 
			object: [GtUserSession instance]];

	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(appBecamedInactiveHandler:) 
			name: GtUserSessionDidEnterBackgroundNotification 
			object: [GtUserSession instance]];

	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(appBecameActiveHandler:) 
			name: GtUserSessionWillEnterForegroundNotification 
			object: [GtUserSession instance]];

	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(appBecamedInactiveHandler:) 
			name: GtUserSessionWillResignActiveNotification 
			object: [GtUserSession instance]];
}

- (id) initAndActivate:(BOOL) activate
{
	if((self = [super init]))
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
	if((self = [super init]))
	{
		[self initContext];
	}
	return self;
}

- (UIViewController*) viewController
{
	return [m_delegate actionContextGetViewController:self];
}

- (UIView*) contextView
{
	return self.viewController.view;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self deactivate];
	m_delegate = nil;

	GtReleaseWithNil(m_actions);
	
	GtSuperDealloc();
}

- (BOOL) activate
{
	if(!self.isActive)
	{	
		self.isActive = YES;
			
		if([m_delegate respondsToSelector:@selector( actionContextActivated:)])
		{
			[m_delegate actionContextActivated:self];
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

		[self cancelActions];
		
		if( [m_delegate respondsToSelector:@selector( actionContextDeactivated:)])
		{
			[m_delegate actionContextDeactivated:self];
		}

		return YES;
	}
	
	return NO;
}

- (BOOL) cancelActions
{
	BOOL didSomething = NO;
	if(m_actions.count)
	{
        @synchronized(self)
		{
            @try
            {
                for(GtWeakReference* ref in m_actions.objectEnumerator)
                {
                    if(ref.object)
                    {	
                        [ref.object requestCancel];
                        didSomething = YES;
                    }
                }
            }
            @finally
            {
                if([m_delegate respondsToSelector:@selector( didCancelActions:)])
                {
                    [m_delegate didCancelActions:self];
                }
            }
        }
	}
	
	return didSomething;
}

- (void) didFinishAllActions
{
}

- (void) willBeginAction:(id<GtAction>) action
{
}

- (void) didFinishAction:(id<GtAction>) action
{
}

- (void) _beginActionOnMainThread:(id<GtAction>) action
{
    @try {
        [self willBeginAction:action];
        [action beginActionInContext:self];
    }
    @catch(NSException* ex)
    {
        [action finalizeAction];
    }
}

- (id) beginAction:(id<GtAction>) action 
   configureAction:(GtConfigureActionBlock) configureAction
{
	@try
	{
        GtAutorelease(GtRetain(action));
    
        static NSInteger s_counter = 0;
        action.actionID = [NSNumber numberWithInt:++s_counter];
		
		[action willConfigureAction];
		[self addAction:action];
	
		if(configureAction)
		{
			configureAction(action);
		}
		
		[action didConfigureAction];
		
        if([NSThread isMainThread])
        {
            [self _beginActionOnMainThread:action];
        }
        else
        {
            [self performSelectorOnMainThread:@selector(_beginActionOnMainThread:) withObject:action waitUntilDone:NO];
        }
	}
	@catch(NSException* ex)
	{
		[action finalizeAction];
	}
    
    return [m_actions objectForKey:action.actionID] ? action.actionID : nil;
}

- (void) addAction:(id<GtAction>) action
{
	@synchronized(self)
	{
        if(!m_actions)
        {
            m_actions = [[NSMutableDictionary alloc] init];
        }

		GtWeakReference* object = [[GtWeakReference alloc] initWithObject:action];
		[m_actions setObject:object forKey:action.actionID];
		GtReleaseWithNil(object);
	}
}

- (id<GtAction>) actionByID:(id) actionID
{
	@synchronized(self)
    {
        id action = [m_actions objectForKey:actionID];
        if(action)
        {
            if([action object])
            {
                return GtReturnAutoreleased(GtRetain([action object]));
            }
            else
            {
                [m_actions removeObjectForKey:actionID];
            }
        }
    }
    
    return nil;
}

- (void) cancelActionByID:(id) actionID
{
    id action = [self actionByID:actionID];
    if(action)
    {
        GtLog(@"Cancelling action: %@", actionID);
        [action requestCancel];
    }
}

- (void) removeActionFromContext:(id<GtAction>) inAction
{
	@synchronized(self)
	{
        if([m_actions objectForKey:inAction.actionID])
        {
            [m_actions removeObjectForKey:inAction.actionID];
            
            [self didFinishAction:inAction];
            
            if(!m_actions.count)
            {
                [self didFinishAllActions];
            }
        }
	}
}

- (NSString*) description
{
#if DEBUG
	return [NSString stringWithFormat:@"GtActionContext for: %@, isActive: %d", NSStringFromClass([m_delegate class]), self.isActive];
#else
	return [super description];
#endif
}






@end
