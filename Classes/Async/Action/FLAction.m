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
#import "FLDispatchQueues.h"

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
@property (readwrite, strong) FLOperationQueue* operations;
@end

static FLCallback_t s_failedCallback;
static id<FLActionErrorDelegate> s_errorDisplayDelegate = nil;

@implementation FLAction

+ (void) setActionErrorDelegate:(id<FLActionErrorDelegate>) delegate {
    s_errorDisplayDelegate = delegate;
}

@synthesize lastWarningTimestamp = _lastWarningTimestamp;
@synthesize minimumTimeBetweenWarnings = _minimumTimeBetweenWarnings;
@synthesize onShowNotification = _willShowNotificationCallback;
@synthesize onUpdateProgress = _progressCallback;
@synthesize actionDescription = _actionDescription;
@synthesize progressController = _progress;
@synthesize operations = _operations;
@synthesize didSucceed = _didSucceed;

FLSynthesizeStructProperty(handledError, setHandledError, BOOL, _actionFlags)
FLSynthesizeStructProperty(disableErrorNotifications, setDisableErrorNotifications, BOOL, _actionFlags)
FLSynthesizeStructProperty(disableWarningNotifications, setDisableWarningNotifications, BOOL, _actionFlags)
FLSynthesizeStructProperty(disableActivityTimer, setDisableActivityTimer, BOOL, _actionFlags)
FLSynthesizeStructProperty(networkRequired, setNetworkRequired, BOOL, _actionFlags);

//- (FLOperationQueue*) operations {
//    return self;
//}

- (BOOL) willSendDeallocNotification {
    return YES;
}

- (id) init {
//    self = [super initWithRunner:[FLOperationQueueRunner instance]];
    self = [super init];
	if(self) {
        _minimumTimeBetweenWarnings = FLActionMinimumTimeBetweenWarnings;
		_actionDescription = [[FLActionDescription alloc] init];
        _operations = [[FLOperationQueue alloc] init];
        [_operations addObserver:self];
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
	if((self = [self init])){
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

+ (void) setGlobalFailedCallback:(id) target action:(SEL) action {
	s_failedCallback = FLCallbackMake(target, action);
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

+ (void) setDisplayErrorForActionCallback:(FLCallback_t) callback {

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

- (id) result {
    if(self.didSucceed) {
//        if(!output) {
            for(FLOperation* operation in self.operations.reverseIterator) {
                id operationOutput = operation.operationOutput;
                if(operationOutput) {
                    return operationOutput;
                }
            };
//        }
    }
    
    return nil;
}

- (void) dealloc {
    FLSendDeallocNotification();
	[self closeNotification];
    [_operations removeObserver:self];
#if FL_MRC
    [_operations release];
    FLRelease(_progressCallback);
    FLRelease(_willShowNotificationCallback);
	FLRelease(_progress);
	FLRelease(_actionDescription);
	FLSuperDealloc();
#endif
}

- (NSString*) itemNameInProgress{
    return self.actionDescription.itemNameInProgress;
}
- (void) setItemNameInProgress:(NSString*) actionItemName {
    self.actionDescription.itemNameInProgress = actionItemName;
}
- (NSString*) actionItemName {
    return self.actionDescription.actionItemName;
}
- (void) setActionItemName:(NSString*) actionItemName {
    self.actionDescription.actionItemName = actionItemName;
}
- (void) setActionType:(NSString*) actionType {
    self.actionDescription.actionType = actionType;
}
- (NSString*) actionType {
    return self.actionType;
}

- (void) notificationViewUserClosed:(id) view {
//	  self.disableWarningNotifications = YES;
}

- (id) errorNotificationForUser {
	return _errorNotification ? _errorNotification.object : nil;
}

- (void) setErrorNotificationForUser:(id) notification {
	if(!_errorNotification) {
		_errorNotification = [[FLWeakReference alloc] init];
	}
	
	_errorNotification.object = notification;
}

- (void) willHandleError {
	FLInvokeCallback(s_failedCallback, self);
}

- (void) willReportError {
	if(!self.handledError && !self.disableErrorNotifications) {
		if(_willShowNotificationCallback) {
			_willShowNotificationCallback(self);
		}
		
		if(!self.handledError && !self.disableErrorNotifications) {
            if(s_errorDisplayDelegate) {
                [self performBlockOnMainThread:^{
                    if(s_errorDisplayDelegate) {
                        [s_errorDisplayDelegate actionShouldDisplayError:self];
                    }
                }];
            }
		}
	}
}

- (void) respondToCancelEvent:(id) sender {
	[self requestCancel];
}

- (void) showProgress {
	if(_progress) {
		if(_actionDescription) {
			NSString* title = _actionDescription.title;
			FLAssertStringIsNotEmpty_v(title,nil);
			
			if(FLStringIsNotEmpty(title)) {
				[_progress setTitle:title];
			}
		}

      	[_progress showProgress];
	}
}

- (void) addOperations:(FLOperation*) operation {
    [self.operations addOperation:operation];
}

- (void) actionStarted {
    [self showProgress];
}

- (void) actionFinished {
    if(_progress) {
        [_progress hideProgress];
    }

    @try {
        if(self.didSucceed || self.wasCancelled) {
            [self closeNotification];
        } else {
            [self willHandleError];
            
            if(!self.handledError) {
                [self willReportError];
            }
        }
    }
    @catch(NSException* ex) {
    // derp
    }
}

- (id) failedOperation {
    for(FLOperation* operation in self.operations.reverseIterator) {
        if(operation.error) {
            return operation;
        }
    }
    return nil;
}

- (BOOL) wasCancelled {
    for(FLOperation* operation in self.operations.reverseIterator) {
        if(operation.wasCancelled) {
            return YES;
        }
    }
    
    return NO;
}

- (NSError*) error {
    return [self.failedOperation error];
}

- (void) requestCancel {
    [self.operations cancelAllOperations];
}

- (id<FLPromisedResult>) startAction:(FLResultBlock) completion {
    return [self startActionInContext:nil starting:nil completion:completion ];
}

- (id<FLPromisedResult>) startAction:(dispatch_block_t) starting
                 completion:(FLResultBlock) completion {
    return [self startActionInContext:nil starting:starting completion:completion];
}

- (id<FLPromisedResult>) startActionInContext:(FLOperationContext*) context
                          completion:(FLResultBlock) completion {
    return [self startActionInContext:context starting:nil completion:completion];
}

- (id<FLPromisedResult>) startActionInContext:(FLOperationContext*) context
                                 starting:(dispatch_block_t) starting
                               completion:(FLResultBlock) completion {

    FLOperationQueueRunner* runner = [FLOperationQueueRunner operationQueueRunner:self.operations];
    if(context) {
        [context addOperation:runner];
    }
    
    FLWorkFinisher* actionFinisher = [FLWorkFinisher finisher:completion];
    
    [[FLForegroundQueue instance] dispatchAsyncBlock:^(id<FLFinisher> finisher) { 
        if(starting) {
            starting();
        }
        [self actionStarted]; 
        
        [[FLHighPriorityQueue instance] dispatchWorker:runner completion:^(FLResult result) {
            [finisher setFinished];
        }];
    }
    completion:^(FLResult result) {
        [self actionFinished];
        [actionFinisher setFinishedWithResult:result];
    }];
    
    return actionFinisher;
    
//    FLBackgroundJob* bgJob = [FLBackgroundJob job];
//    [fgJob addWorker:bgJob];
//
//
//    [bgJob addWorker:runner];
//    
//    return [[FLForegroundQueue instance] dispatchWorker:fgJob completion:completion];


//    _didSucceed = NO;
//    
//    starting = FLCopyBlock(starting);
//    
//    FLWorkFinisher* actionFinisher = [FLWorkFinisher finisher:completion];
//    
//    
//    FLAsyncBlock finishActionInMainThread = ^(FLFinisher finisher){
//        [self actionFinished];
//
//        if(context) {
//            [context removeOperation:runner];
//        }
//
//        [actionFinisher setFinished];
//        [finisher setFinished];
//    };
//
//    FLAsyncBlock startActionInMainThread = ^(FLFinisher finisher){
//        if(starting) {
//            starting();
//        }
//        [self actionStarted];
//        [[FLDispatchQueue instance] dispatchWorker:runner completion: ^(FLResult result) {
//            [[FLForegroundQueue instance] dispatchAsyncBlock:finishActionInMainThread]; }];
//        
//        [finisher setFinished];
//    };
//    
//
//    [[FLForegroundQueue instance] dispatchAsyncBlock:startActionInMainThread];
//
//    return actionFinisher;
}

- (id) firstOperation {
    return self.operations.firstOperation;
}
- (id) lastOperation {
    return self.operations.lastOperation;
}
- (id) lastOperationOutput {
    return self.operations.lastOperationOutput;
}
- (void) addOperation:(FLOperation*) operation {
    [self.operations addOperation:operation];
}
@end

#if TEST

@interface FLActionUnitTests : FLUnitTest
@end

@implementation FLActionUnitTests

- (void) testsWillRun {
   [self.results setTestResult:[FLCountedTestResult countedTestResult:6] forKey:@"counter"];
}

- (void) runOneAction {
    FLAction* action = [FLAction action];

    [action.operations addOperationWithBlock:^(FLOperation* block) {
        FLAssert_(![NSThread isMainThread]);
        
        [[self.results testResultForKey:@"counter"] setPassed];
    }];

    id<FLPromisedResult> actionFinisher = [action startAction:^{ 
                    FLAssert_([NSThread isMainThread]); 
                    [[self.results testResultForKey:@"counter"] setPassed];
                    
                }
                completion:^(FLResult result) { 
                    FLAssert_([NSThread isMainThread]); 
                    [[self.results testResultForKey:@"counter"] setPassed];
                }]; 

    [actionFinisher waitForResult];
 }

- (void) testBasicScheduling {
    [self runOneAction];
}

- (void) testBackgroundThreadStart {
    [[[FLDispatchQueue instance] dispatchBlock:^{
        [self runOneAction];
    }] waitForResult];
}

@end

#endif
