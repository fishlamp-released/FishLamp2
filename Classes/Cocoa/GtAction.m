//
//	GtAction.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/14/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAction.h"
#import "GtHttpConnection.h"
#import "GtSimpleTask.h"
#import "GtCallbackObject.h"
#import "GtErrorDisplayManager.h"
#import "GtErrorDescriber.h"
#import "GtHttpOperation.h"
#import "GtNotificationView.h"
#import "GtProgressViewController.h"

#define TIME_ALL_ACTIONS 0

@implementation GtActionReference

- (GtAction*) action 
{
	return (GtAction*) self.object;
}

- (void) setAction:(GtAction*) action
{
	self.object = action;
}

@end

@interface GtAction ()
@property (readwrite, retain, nonatomic) NSMutableDictionary* contextDictionary;
@property (readwrite, retain, nonatomic) GtActionContext* context;
@end

#define GtActionSetCallback(SET, TYPE, MEMBER) \
	- (void) SET:(TYPE) callback { \
		GtFailIf(!m_actionFlags.isConfiguring, GtActionErrorDomain, GtActionErrorCodeConfigScope, @"Setting Callbacks is only allowing during configuration callback"); \
		if(MEMBER) { GtRelease(MEMBER); MEMBER = nil; }\
		if(callback) { MEMBER = [callback copy]; } \
	}

@implementation GtAction

@synthesize lastWarningTimestamp = m_lastWarningTimestamp;
@synthesize minimumTimeBetweenWarnings = m_minimumTimeBetweenWarnings;
//@synthesize operationQueue = m_operations;
@synthesize willBeginCallback = m_willBeginCallback;
@synthesize willShowNotificationCallback = m_willShowNotificationCallback;
@synthesize progressCallback = m_progressCallback;
@synthesize willShowProgressCallback = m_willShowProgressCallback;
@synthesize didCompleteCallback = m_didCompleteCallback;

@synthesize context = m_context;
@synthesize contextDictionary = m_contextDictionary;

@synthesize actionDescription = m_actionDescription;
@synthesize actionID = m_actionID;
@synthesize progressView = _progressView;

@dynamic wasCancelled;

GtActionSetCallback(setWillShowNotificationCallback, GtActionCallback, m_willShowNotificationCallback)
GtActionSetCallback(setProgressCallback, GtProgressCallback, m_progressCallback)
GtActionSetCallback(setWillBeginCallback, GtActionCallback, m_willBeginCallback)
GtActionSetCallback(setWillShowProgressCallback, GtActionCallback, m_willShowProgressCallback)
GtActionSetCallback(setDidCompleteCallback, GtActionCallback, m_didCompleteCallback)

GtSynthesizeStructProperty(handledError, setHandledError, BOOL, m_actionFlags)
GtSynthesizeStructProperty(disableErrorNotifications, setDisableErrorNotifications, BOOL, m_actionFlags)
GtSynthesizeStructProperty(disableWarningNotifications, setDisableWarningNotifications, BOOL, m_actionFlags)
GtSynthesizeStructProperty(disableActivityTimer, setDisableActivityTimer, BOOL, m_actionFlags)

- (void) willConfigure
{
	m_actionFlags.isConfiguring = YES;
}

- (void) setContext:(GtActionContext*) actionContext
{
	GtAssignObject(m_context, actionContext);
}

- (id) init
{
	if((self = [super init]))
	{
        m_minimumTimeBetweenWarnings = GtActionMinimumTimeBetweenWarnings;
		m_actionDescription = [[GtActionDescription alloc] init];
	}
	
	return self;
}

- (id) initWithActionType:(NSString*) actionType
{
	if((self = [self init]))
	{
		self.actionDescription.actionType = actionType;
	}
	return self;
}

- (id) initWithActionType:(NSString*) actionType itemName:(NSString*) itemName
{
	if((self = [self init]))
	{
		self.actionDescription.actionType = actionType;
		self.actionDescription.itemName = itemName;
	}
	return self;
}

+ (id) action
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

+ (id) actionWithActionType:(NSString*) actionType
{
	return GtReturnAutoreleased([[[self class] alloc] initWithActionType:actionType]);
}

+ (id) actionWithActionType:(NSString*) actionType itemName:(NSString*) itemName
{
	return GtReturnAutoreleased([[[self class] alloc] initWithActionType:actionType itemName:itemName]);
}

- (void) setStateObject:(id) object forKey:(id) key
{
	if(!m_contextDictionary)
	{
		m_contextDictionary = [[NSMutableDictionary alloc] init];
	}
	[m_contextDictionary setObject:object forKey:key];
}

- (id) stateObjectForKey:(id) key
{
	return [m_contextDictionary objectForKey:key];
}

- (void) closeNotification
{
	if(m_errorNotification)
	{
		if(!m_errorNotification.isNil)
		{
			[m_errorNotification.object hideNotification];
		}
		GtReleaseWithNil(m_errorNotification);
	}
}

- (void) _activityUpdate:(GtHttpOperation*) operation idleTimeSpan:(NSTimeInterval) idleTimeSpan
{
	if(!self.disableActivityTimer)
	{
#if DEBUG
//		  if(timeSinceLastActivity > 1)
//		  {
//			  GtLog(@"Activity update: %f", timeSinceLastActivity);
//		  }
#endif		  
       
        if(idleTimeSpan > GtActionDefaultTimeBetweenActivityWarnings)
        {
            if(!m_actionFlags.disableWarningNotifications)
            {
                if(m_willShowNotificationCallback)
                {
                    m_willShowNotificationCallback();
                }
            }

            if(!m_actionFlags.disableWarningNotifications)
            {
                NSString* title = [NSString stringWithFormat:(NSLocalizedString(@"The server hasn't responded for %.0f seconds.", nil)), idleTimeSpan];

                GtNotificationViewController* notification = self.errorNotificationForUser;
                if(!notification)
                {
                    notification = [[GtNotificationDisplayManager defaultDisplayManager] createNotificationWithType:GtDisplayedNotificationTypeWarning];
                    
                    notification.title = title;
                    notification.notificationView.title = title;
                    
                    if(GtStringIsNotEmpty(operation.activityTimerExplanation))
                    {
                        notification.notificationView.text = operation.activityTimerExplanation;
                    }
                    
                    self.errorNotificationForUser = notification;
                    [notification showNotification];
                }
                else
                {
                    notification.title = title;
                }
            }
        }
        else if(self.errorNotificationForUser)
        {
            [self.errorNotificationForUser hideNotification];
        }
    }
}

- (void) willPerformOperation:(id) operation
{
    if([operation isKindOfClass:[GtHttpOperation class]])
    {
        [operation setIdleCallback:^(NSTimeInterval timeSpan) {
                [self performBlockOnMainThread:^{
                    [self _activityUpdate:operation idleTimeSpan:timeSpan];
                    }];
                }];
                    
        [operation setSentBytesProgressCallback: ^(unsigned long long bytesWritten, unsigned long long totalBytesWritten, unsigned long long totalBytesExpectedToWrite) 
                {
                    [self performBlockOnMainThread:^{
                        if(self.progressView)
                        {
                            [self.progressView updateProgress:totalBytesWritten totalAmount:totalBytesExpectedToWrite];
                        }
                        if(self.progressCallback)
                        {
                            self.progressCallback(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
                        }	                    
                    }];
                }];
    }
}

- (void) didPerformOperation:(id) operation
{
}

- (void) finalizeAction
{
    [self finalizeOperation];

    GtReleaseBlockWithNil(m_progressCallback);
    GtReleaseBlockWithNil(m_willShowNotificationCallback);
    GtReleaseBlockWithNil(m_willBeginCallback);
    GtReleaseBlockWithNil(m_willShowProgressCallback);
    GtReleaseBlockWithNil(m_didCompleteCallback);
}

- (void) dealloc
{
	[self closeNotification];
	[self finalizeAction];
	
	if(m_context)
	{
		[m_context removeActionFromContext:self];
	}
    GtRelease(m_actionID);
	GtRelease(m_progress);
	GtRelease(m_actionDescription);
	GtRelease(m_contextDictionary);
	GtRelease(m_context); 
	GtSuperDealloc();
}

- (void) notificationViewUserClosed:(id<GtDisplayedNotification>) view
{
//	  self.disableWarningNotifications = YES;
}

- (GtNotificationViewController*) errorNotificationForUser
{
	return m_errorNotification ? m_errorNotification.object : nil;
}

- (void) setErrorNotificationForUser:(GtNotificationViewController*) notification
{
	if(!m_errorNotification)
	{
		m_errorNotification = [[GtWeakReference alloc] init];
	}
	
	m_errorNotification.object = notification;
}

- (void) willHandleError
{
}

- (void) willReportError
{
	if(!self.handledError && !self.disableErrorNotifications)
	{
		if(m_willShowNotificationCallback)
		{
			m_willShowNotificationCallback();
		}
		
		if(!self.handledError && !self.disableErrorNotifications)
		{
			GtNotificationViewController* view = [[GtNotificationDisplayManager defaultDisplayManager] createNotificationWithType:GtDisplayedNotificationTypeError];

// FIXME
//			view.notificationView.actionContext = self.context;
			view.notificationView.title = self.actionDescription.failureText;
//			view.notificationView.text = [self.error localizedDescription];
				
			NSString* description = [[GtErrorDescriberManager instance] describeError:self.error];
			if(description)
			{	
				if(GtStringIsNotEmpty(description))
				{
					view.notificationView.text = description;
				}
			}
			else
			{
				view.notificationView.text = [NSString stringWithFormat:NSLocalizedString(@"An unexpected error occured.\n\n%@", nil), self.error.localizedDescription];
			}
				
			[view showNotification];
		}
	}
}

- (void) willInvokeCompletedCallback
{
	if(m_didCompleteCallback)
	{
		m_didCompleteCallback(self);
	}
}

- (void) operation:(GtOperation*) operation setStateObject:(id) object forKey:(id) key
{
	[self setStateObject:object forKey:key];
}

- (id) operation:(GtOperation*) operation stateObjectForKey:(id) key
{
	return [self stateObjectForKey:key];
}

- (void) respondToCancelEvent:(id) sender
{
	[self requestCancel];
}

- (BOOL) willBeginAction
{	
	if(!self.context)
	{
		[self requestCancel];
		return NO;
	}

	if(self.wasCancelled)
	{
		return NO;
	}
	
	if(self.operationCount > 0)
	{
		if(m_willBeginCallback)
		{
			m_willBeginCallback();
		}
	
		if(self.wasCancelled)
		{
			return NO;
		}
		
		[self showProgress];
		
		return YES;
	}
//	  else
//	  {
//		  [self finishOperation];
//	  }

	return NO;
}

- (void) finishAction
{	
	GtAssert([NSThread isMainThread], @"not completing action on main thread");

	[self.context removeActionFromContext:self];

	if(m_progress.progressView)
	{
		[m_progress.progressView hideProgress];
	}

	@try
	{
		if(self.didFinishWithoutError || self.wasCancelled)
		{
			[self closeNotification];
			[self willInvokeCompletedCallback];
		}
		else
		{
			[self willHandleError];
			[self willInvokeCompletedCallback];
			
			if(!self.handledError)
			{
				[self willReportError];
			}
		}
	}
	@catch(NSException* exception)
	{
		NSError* error = [[NSError alloc] initWithException:exception];
		self.error = error;
		GtReleaseWithNil(error);
	}

	[self finalizeAction];
}

- (void) _dispatchFinishAction
{
    [self performSelectorOnMainThread:@selector(finishAction) withObject:nil waitUntilDone:NO];
}

- (void) _performInBackground
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	@try {
		[self performSynchronously:self];
	}
	@catch (NSException * e) {
		
	}
	@try {
		[self _dispatchFinishAction];
	}
	@catch (NSException * e) {
		
	}
	
	[pool drain];
}

- (void) willConfigureAction
{
	m_actionFlags.isConfiguring = YES;
}

- (void) didConfigureAction
{
	m_actionFlags.isConfiguring = NO;
}

- (void) beginActionInContext:(GtActionContext*) context
{
	GtFailIf(context == nil, GtActionErrorDomain, GtActionErrorCodeInvalidContext, @"must run a GtAction in a valid context");
	
	GtAssignObject(m_context, context);

	if([self willBeginAction])
	{
		dispatch_async(
			dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
			^{
				[self _performInBackground];
			});
	}
	else
	{
		[self _dispatchFinishAction];
	}
}

- (void) showProgress
{
	if(m_progress)
	{
		if(m_actionDescription)
		{
			NSString* title = m_actionDescription.title;
			GtAssertIsValidString(title);
			
			if(GtStringIsNotEmpty(title))
			{
				[m_progress setTitle:title];
			}
		}

		if(m_willShowProgressCallback)
		{
			m_willShowProgressCallback();
		}
		else
		{
			[m_progress showProgress];
		}
	}
}

@end


