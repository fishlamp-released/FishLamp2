//
//	FLAction.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/14/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLAction.h"
#import "FLErrorDescriber.h"
#import "FLHttpOperation.h"

#define TIME_ALL_ACTIONS 0

@implementation FLActionReference

- (FLAction*) action  {
	return (FLAction*) self.object;
}

- (void) setAction:(FLAction*) action {
	self.object = action;
}

@end

@interface FLAction ()
//@property (readwrite, retain, nonatomic) NSMutableDictionary* contextDictionary;
@property (readwrite, retain, nonatomic) FLActionContext* actionContext;
@end

@implementation FLAction

static id<FLActionErrorDelegate> s_errorDisplayDelegate = nil;

+ (void) setActionErrorDelegate:(id<FLActionErrorDelegate>) delegate; {
    s_errorDisplayDelegate = delegate;
}

@synthesize lastWarningTimestamp = _lastWarningTimestamp;
@synthesize minimumTimeBetweenWarnings = _minimumTimeBetweenWarnings;
@synthesize onShowNotification = _willShowNotificationCallback;
@synthesize onUpdateProgress = _progressCallback;
@synthesize actionContext = _context;
@synthesize actionDescription = _actionDescription;
@synthesize actionID = _actionID;
@dynamic wasCancelled;

@synthesize progressController = _progress;

FLSynthesizeStructProperty(handledError, setHandledError, BOOL, _actionFlags)
FLSynthesizeStructProperty(disableErrorNotifications, setDisableErrorNotifications, BOOL, _actionFlags)
FLSynthesizeStructProperty(disableWarningNotifications, setDisableWarningNotifications, BOOL, _actionFlags)
FLSynthesizeStructProperty(disableActivityTimer, setDisableActivityTimer, BOOL, _actionFlags)

- (id) init {
    self = [super init];
	if(self) {
        _minimumTimeBetweenWarnings = FLActionMinimumTimeBetweenWarnings;
		_actionDescription = [[FLActionDescription alloc] init];
	}
	
	return self;
}

- (id) initWithActionType:(NSString*) actionType {
	if((self = [self init])) {
		self.actionDescription.actionType = actionType;
	}
	return self;
}

- (id) initWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName {
	if((self = [self init]))
	{
		self.actionDescription.actionType = actionType;
		self.actionDescription.actionItemName = actionItemName;
	}
	return self;
}

+ (id) action {
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

+ (id) actionWithActionType:(NSString*) actionType {
	return FLReturnAutoreleased([[[self class] alloc] initWithActionType:actionType]);
}

+ (id) actionWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName {
	return FLReturnAutoreleased([[[self class] alloc] initWithActionType:actionType actionItemName:actionItemName]);
}

- (void) closeNotification {
    id errorNotification = self.errorNotificationForUser;

    if(errorNotification && s_errorDisplayDelegate)
    {
        [self performBlockOnMainThread:^{
            if(s_errorDisplayDelegate)
            {
                [s_errorDisplayDelegate hideNotification:errorNotification];
            }
        }];
    }

	FLReleaseWithNil(_errorNotification);
}

+ (void) setDisplayErrorForActionCallback:(FLCallback) callback {

}

#if 0

TODO("MF: fix activity updater");

- (void) _activityUpdate:(FLHttpOperation*) operation idleTimeSpan:(NSTimeInterval) idleTimeSpan {
	if(!self.disableActivityTimer)
	{
#if DEBUG
//		  if(timeSinceLastActivity > 1)
//		  {
//			  FLDebugLog(@"Activity update: %f", timeSinceLastActivity);
//		  }
#endif		  
       
        if(idleTimeSpan > FLActionDefaultTimeBetweenActivityWarnings)
        {
            if(!_actionFlags.disableWarningNotifications)
            {
                if(_willShowNotificationCallback)
                {
                    _willShowNotificationCallback(self);
                }
            }

            if(!_actionFlags.disableWarningNotifications)
            {
                if(s_errorDisplayDelegate)
                {
                    [self performBlockOnMainThread:^{
                        if(s_errorDisplayDelegate)
                        {
                            [s_errorDisplayDelegate actionDisplayServerNotRespondingMessage:self
                                timeSpan:idleTimeSpan
                                description:operation.activityTimerExplanation];
                        }
                    }];
                }
            }
        }
        else if(self.errorNotificationForUser)
        {
            [self closeNotification];
        }
    }
}

- (void) willBeginOperation:(id) operation {
    [super willBeginOperation:operation];

    if([operation isKindOfClass:[FLNetworkOperation class]])
    {
        [operation setIdleCallback:^(id theOperation, NSTimeInterval timeSpan) {
                [self performBlockOnMainThread:^{
                    [self _activityUpdate:theOperation idleTimeSpan:timeSpan];
                    }];
                }];
                    
        [operation setSentBytesCallback: ^(id theOperation, unsigned long long bytesWritten, unsigned long long totalBytesWritten, unsigned long long totalBytesExpectedToWrite) 
                {
                    [self performBlockOnMainThread:^{
                        if(self.progressController)
                        {
                            [self.progressController updateProgress:totalBytesWritten totalAmount:totalBytesExpectedToWrite];
                        }
                        if(self.onUpdateProgress)
                        {
                            self.onUpdateProgress(self, bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
                        }	                    
                    }];
                }];
    }
}
#endif

- (void) dealloc {
	if(_context) {
		[_context removeActionFromContext:self];
	}
	[self closeNotification];

    FLRelease(_progressCallback);
    FLRelease(_willShowNotificationCallback);
    FLRelease(_actionID);
	FLRelease(_progress);
	FLRelease(_actionDescription);
	FLRelease(_context); 
	FLSuperDealloc();
}

- (NSString*) itemNameInProgress{
    return self.actionDescription.itemNameInProgress;
}
- (void) setItemNameInProgress:(NSString*) itemName {
    self.actionDescription.itemNameInProgress = itemName;
}
- (NSString*) actionItemName {
    return self.actionDescription.actionItemName;
}
- (void) setActionItemName:(NSString*) itemName {
    self.actionDescription.actionItemName = itemName;
}
- (void) setActionType:(NSString*) actionType {
    self.actionDescription.actionType = actionType;
}
- (NSString*) actionType {
    return self.actionType;
}

- (void) setContext:(FLActionContext*) actionContext {
	FLAssignObject(_context, actionContext);
}


- (void) notificationViewUserClosed:(id) view {
//	  self.disableWarningNotifications = YES;
}

- (id) errorNotificationForUser {
	return _errorNotification ? _errorNotification.object : nil;
}

- (void) setErrorNotificationForUser:(id) notification {
	if(!_errorNotification)
	{
		_errorNotification = [[FLWeakReference alloc] init];
	}
	
	_errorNotification.object = notification;
}

- (void) willHandleError {
}

- (void) willReportError {
	if(!self.handledError && !self.disableErrorNotifications)
	{
		if(_willShowNotificationCallback)
		{
			_willShowNotificationCallback(self);
		}
		
		if(!self.handledError && !self.disableErrorNotifications)
		{
            if(s_errorDisplayDelegate)
            {
                [self performBlockOnMainThread:^{
                    if(s_errorDisplayDelegate)                
                    {
                        [s_errorDisplayDelegate actionShouldDisplayError:self];
                    }
                    
                }];
            }
		}
	}
}

- (void) willInvokeCompletedCallback {
	if(self.onFinished) {
		self.onFinished(self);
	}
}

- (void) respondToCancelEvent:(id) sender {
	[self requestCancel];
}

- (BOOL) willBeginAction {	
	if(!self.actionContext) {
		[self requestCancel];
		return NO;
	}

	if(self.wasCancelled) {
		return NO;
	}
	
    return YES;
}

- (void) finishAction {	
	FLAssert([NSThread isMainThread], @"not completing action on main thread");

	[self.actionContext removeActionFromContext:self];

	if(_progress) {
		[_progress hideProgress];
	}

	@try {
		if(self.didFinishWithoutError || self.wasCancelled) {
			[self closeNotification];
			[self willInvokeCompletedCallback];
		} else {
			[self willHandleError];
			[self willInvokeCompletedCallback];
			
			if(!self.handledError) {
				[self willReportError];
			}
		}
	}
	@catch(NSException* exception) {
		NSError* error = [[NSError alloc] initWithException:exception];
		self.error = error;
		FLReleaseWithNil(error);
	}
}

- (void) _dispatchFinishAction {
    [self performSelectorOnMainThread:@selector(finishAction) withObject:nil waitUntilDone:NO];
}

- (void) _performInBackground {
    @try {
        FLPerformBlockInAutoreleasePool( ^{
            [self performSynchronously];
        });
	}
    @finally {
        [self _dispatchFinishAction];
	};
}

- (void) beginActionInContext:(FLActionContext*) context {
	
    if(context == nil) {
        FLThrowErrorCode(FLActionErrorDomain, FLActionErrorCodeInvalidContext, @"must run a FLAction in a valid context");
    }
	
	FLAssignObject(_context, context);

	if([self willBeginAction]) {
        [self showProgress];
    
    	dispatch_async(
			dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
				[self _performInBackground];
			});
	} else {
		[self _dispatchFinishAction];
	}
}

- (void) showProgress {
	if(_progress) {
		if(_actionDescription) {
			NSString* title = _actionDescription.title;
			FLAssertStringIsNotEmpty(title);
			
			if(FLStringIsNotEmpty(title)) {
				[_progress setTitle:title];
			}
		}

      	[_progress showProgress];
	}
}

- (void) operationWasPerformed {
    // NOOP to prevent onFinished block from getting called at the wrong time (for actions only)
}

- (void) willPerformOperation {
    // NOOP to prevent onWillStart block from getting called at the wrong time (for actions only)
}

@end


