//
//	FLActionContext.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLActionContext.h"
#import "FLAction.h"
 
@implementation FLActionContext

@synthesize actionContextDelegate = _delegate;

FLSynthesizeStructProperty(isActive, setIsActive, BOOL, _flags);

- (void) appBecamedInactiveHandler:(id) sender
{
	[self cancelActions];
	
	if([_delegate respondsToSelector:@selector(actionContextAppEnteredBackground:)])
	{
		[_delegate actionContextAppEnteredBackground:self];
	} 
}

- (void) _sendActiveMessage
{
	if(self.isActive)
	{
		if([_delegate respondsToSelector:@selector(actionContextAppEnteredForeground:)])
		{
			[_delegate actionContextAppEnteredForeground:self];
		}
	}
}

//- (void) initContext
//{
//#if IOS
//	[[NSNotificationCenter defaultCenter] addObserver:self
//			selector:@selector(appBecamedInactiveHandler:) 
//			name: UIApplicationWillTerminateNotification 
//			object: [UIApplication sharedApplication]];
//#endif			
//
//	[[NSNotificationCenter defaultCenter] addObserver:self
//			selector:@selector(appBecameActiveHandler:) 
//			name: FLUserSessionDidBecomeActiveNotification 
//			object: [FLUserSession instance]];
//
//	[[NSNotificationCenter defaultCenter] addObserver:self
//			selector:@selector(appBecamedInactiveHandler:) 
//			name: FLUserSessionDidEnterBackgroundNotification 
//			object: [FLUserSession instance]];
//
//	[[NSNotificationCenter defaultCenter] addObserver:self
//			selector:@selector(appBecameActiveHandler:) 
//			name: FLUserSessionWillEnterForegroundNotification 
//			object: [FLUserSession instance]];
//
//	[[NSNotificationCenter defaultCenter] addObserver:self
//			selector:@selector(appBecamedInactiveHandler:) 
//			name: FLUserSessionWillResignActiveNotification 
//			object: [FLUserSession instance]];
//}



// TODO: this is getting called twice when app comes into foreground. 
// Need to break these out into seperate calls into delegate.
// for now, just delay the call to make sure it's called only once.
- (void) appBecameActiveHandler:(id) sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_sendActiveMessage) object:nil];
    [self performSelector:@selector(_sendActiveMessage) withObject:nil afterDelay:0.1f];
}

- (id) initAndActivate:(BOOL) activate
{
	if((self = [super init]))
	{
//		[self initContext];

    FLAssertFailed(@"setup events");
		
//        [_delegate actionContextRegisterForEvents:self];
        
		if(activate)
		{
			[self activate];
		}
	} 
	
	return self;
}

- (id) init
{
	if((self = [super init])) {
// TODO ("check this init context");    
//		[self initContext];
	}
	return self;
}

- (CocoaViewController*) viewController
{
	return [_delegate actionContextGetViewController:self];
}

- (CocoaView*) contextView
{
	return self.viewController.view;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self deactivate];
	_delegate = nil;

	FLReleaseWithNil(_actions);
	
	FLSuperDealloc();
}

- (BOOL) activate
{
	if(!self.isActive)
	{	
		self.isActive = YES;
			
		if([_delegate respondsToSelector:@selector( actionContextActivated:)])
		{
			[_delegate actionContextActivated:self];
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
		
		if( [_delegate respondsToSelector:@selector( actionContextDeactivated:)])
		{
			[_delegate actionContextDeactivated:self];
		}

		return YES;
	}
	
	return NO;
}

- (BOOL) cancelActions
{
	BOOL didSomething = NO;
	if(_actions.count)
	{
        @synchronized(self)
		{
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
        
            @try
            {
                for(FLWeakReference* ref in _actions.objectEnumerator)
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
                if([_delegate respondsToSelector:@selector( didCancelActions:)])
                {
                    [_delegate didCancelActions:self];
                }
            }
        }
	}
	
	return didSomething;
}

- (void) didFinishAllActions
{
}

- (void) willBeginAction:(id<FLAsyncAction>) action
{
}

- (void) didFinishAction:(id<FLAsyncAction>) action
{
}

- (void) _beginActionOnMainThread:(id<FLAsyncAction>) action
{
    [self willBeginAction:action];
    
    if(!action.error && !action.wasCancelled && action.onWillStart){
        action.onWillStart(action);
    }
    
    if(!action.error && !action.wasCancelled) {
        [action beginActionInContext:self];
    }
}

- (void) beginAction:(id<FLAsyncAction>) action 
{
	FLRetain(action);
    FLAutorelease(action);

    static NSInteger s_counter = 0;
    action.actionID = [NSNumber numberWithInt:++s_counter];
    
    [self addAction:action];

    if([NSThread isMainThread])
    {
        [self _beginActionOnMainThread:action];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(_beginActionOnMainThread:) withObject:action waitUntilDone:NO];
    }
	
}

- (void) addAction:(id<FLAsyncAction>) action
{
	@synchronized(self)
	{
        if(!_actions)
        {
            _actions = [[NSMutableDictionary alloc] init];
        }

		FLWeakReference* object = [[FLWeakReference alloc] initWithObject:action];
		[_actions setObject:object forKey:action.actionID];
		FLReleaseWithNil(object);
	}
}

- (id<FLAsyncAction>) actionByID:(id) actionID
{
	@synchronized(self)
    {
        id action = [_actions objectForKey:actionID];
        if(action)
        {
            if([action object])
            {
                return FLReturnAutoreleased(FLReturnRetained([action object]));
            }
            else
            {
                [_actions removeObjectForKey:actionID];
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
#if TRACE
        FLDebugLog(@"Cancelling action: %@", actionID);
#endif        
        [action requestCancel];
    }
}

- (void) removeActionFromContext:(id<FLAsyncAction>) inAction
{
	@synchronized(self)
	{
        if([_actions objectForKey:inAction.actionID])
        {
            [_actions removeObjectForKey:inAction.actionID];
            
            [self didFinishAction:inAction];
            
            if(!_actions.count)
            {
                [self didFinishAllActions];
            }
        }
	}
}

- (NSString*) description
{
#if DEBUG
	return [NSString stringWithFormat:@"FLActionContext for: %@, isActive: %d", NSStringFromClass([_delegate class]), self.isActive];
#else
	return [super description];
#endif
}






@end
