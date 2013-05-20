//
//  GtActionErrorHandler.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtActionErrorHandler.h"
#import "GtNetworkOperation.h"
#import "GtAction.h"
#import "GtAlertView.h"
#import "GtColors.h"
#import "GtWindow.h"

@implementation GtActionErrorHandler

@synthesize delegate = m_delegate;

GtSynthesizeSingleton(GtActionErrorHandler)

- (id) init
{
	if(self = [super init])
	{
		[[NSNotificationCenter defaultCenter] addObserver: self 
            selector: @selector(reachabilityChanged:) 
            name: GtNetworkReachabilityChangedNotification object: [UIApplication sharedApplication]];
    
        m_warningView = [GtAlloc(GtWeakReference) init];
    }
	
	return self;
}	

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	
    GtRelease(m_warningView);
	GtRelease(m_retryAlertQueue);
    GtRelease(m_networkOfflineQueuedActions);
    [super dealloc];
}

- (void) retryOfflineActions
{
    NSArray* actionQueue = m_networkOfflineQueuedActions;
    m_networkOfflineQueuedActions = nil;
    if(actionQueue)
    {
        @try
        {
            for(GtAction* action in actionQueue)
            {
                [action retryAction:NO];
            }
        }
        @finally
        {
            GtRelease(actionQueue);
        }
    }
}

- (void) reachabilityChanged:(NSNotification*) notification
{
    GtReachability* reachability = [notification.userInfo objectForKey:[GtReachability class]];
    
    if(reachability.isReachable)
	{
        [self retryOfflineActions];
    }
    else
    {
    }
}

- (void) queueActionForNetworkRetry:(GtAction*) action
{
    if(!m_networkOfflineQueuedActions)
    {
        m_networkOfflineQueuedActions = [GtAlloc(NSMutableArray) init];
    }
        
    [m_networkOfflineQueuedActions addObject:action];
}

- (void) showNotificationView:(GtAction*) action 
{
	if(!action.didErrorNotification && m_warningView.isNil)
	{
		GtUserNotificationView* view = [GtAlloc(GtUserNotificationView) initAsWarningNotification];
		view.willTryAgain = YES;
        view.location = GtNotificationViewLocationBottomAboveTabBar;
		[view setTextWithErrorUsingFormatters:action.failedOperation.error];
		[view showInDefaultWindow];
		action.errorNotificationForUser = view;
		m_warningView.object = view;
        GtRelease(view);
    }
}

- (BOOL) attemptToRetryOnNetworkError:(GtAction*) action;
{
    id failedOperation = action.failedOperation;
    if( failedOperation &&
        [failedOperation respondsToSelector:@selector(reachability)])
    {
        GtReachability* reachability = [failedOperation reachability];
        if(!reachability || reachability.isReachable)
        {
			if( action.canAutoRetry && 
				[failedOperation canRetryOnFailure])
            {
				[self showNotificationView:action];
			
                [action retryAction:NO];
                return YES;
            }
			else if(m_delegate)
			{
				return [m_delegate actionErrorHandler:self
					attemptToRetryOnNetworkError:action
					reachability: reachability];
			}
        }
        else
        {
            [self queueActionForNetworkRetry:action];
            return YES;
        }
    }
    
    return NO;
}

- (void) reportError:(GtAction*) action
{
	GtUserNotificationView* view = [GtAlloc(GtUserNotificationView) initAsErrorNotification];
	view.willTryAgain = NO;
	
	if(m_delegate && ![m_delegate actionErrorHandler:self
		reportErrorForAction:action
		userNotificationView:view])
	{
		[view setTextWithErrorUsingFormatters:action.failedOperation.error];
	}
	
	[view showInDefaultWindow];
	//action.errorNotificationForUser = view;
	GtRelease(view);
}

/*
- (BOOL) onActionFailed:(GtAction*) action
{
	if(action.wasCancelled)
	{
		return YES;
	}
	id<GtOperationProtocol> failedOperation = action.failedOperation;
	
    GtAssertNotNil(failedOperation);
    
	GtSoapFault11* fault = failedOperation.error.soapFault;
    if(fault)
    {
        UIAlertView* alert = [GtAlloc(UIAlertView) initWithTitle:fault.faultcode 
					message:fault.faultstring
					delegate:nil 
					cancelButtonTitle:NSLocalizedStringFromTable(@"GT_OK_STR", @"FishLamp", nil) otherButtonTitles:nil];
			
		[alert show];
		GtRelease(alert);
	}
    else
    {
    
    
        NSError* error = failedOperation.error;

		if(error)
		{
			switch(error.code)
			{
				case NSURLErrorTimedOut:
					GtLog(@"An operation timed out: %@", NSStringFromClass([failedOperation class])); 
					return YES;
				break;
			
			}
		}
        
        UIAlertView* alert = [GtAlloc(UIAlertView) initWithTitle:NSLocalizedStringFromTable(@"GT_OPERATION_FAILED_STR", @"FishLamp", nil)
					message:[NSString stringWithFormat:@"%@ [%d]", error.domain, error.code]
					delegate:nil 
					cancelButtonTitle:NSLocalizedStringFromTable(@"GT_OK_STR", @"FishLamp", nil) otherButtonTitles:nil
					];
		
        [alert show];
        GtRelease(alert);

	}
    
    return YES;
}
*/

@end
