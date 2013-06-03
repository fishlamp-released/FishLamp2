////
////	FLAction.m
////	FishLamp
////
////	Created by Mike Fullerton on 8/14/09.
////	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
////
//
//#import "FLAction.h"
//#import "FLAsyncQueue.h"
//
//#define TIME_ALL_ACTIONS 0
//
//@implementation FLActionReference
//
//- (FLAction*) action  {
//	return (FLAction*) self.object;
//}
//
//- (void) setAction:(FLAction*) action {
//	self.object = action;
//}
//
//@end
//
//@interface FLAction ()
//@end
//
//@implementation FLAction
//
//@synthesize lastWarningTimestamp = _lastWarningTimestamp;
//@synthesize minimumTimeBetweenWarnings = _minimumTimeBetweenWarnings;
//@synthesize onShowNotification = _willShowNotificationCallback;
//@synthesize onUpdateProgress = _progressCallback;
////@synthesize uiHandler   = _uiHandler;
//@synthesize operations = _operations;
//@synthesize starting = _startingBlock;
//@synthesize handledError = _handledError;
//@synthesize disableErrorNotifications = _disableErrorNotifications;
//@synthesize disableWarningNotifications = _disableWarningNotifications;
//@synthesize disableActivityTimer = _disableActivityTimer;
//@synthesize networkRequired = _networkRequired;
//
//static FLCallback_t s_failedCallback;
//static id<FLActionErrorDelegate> s_errorDisplayDelegate = nil;
//
//+ (void) setActionErrorDelegate:(id<FLActionErrorDelegate>) delegate {
//    s_errorDisplayDelegate = delegate;
//}
//
//- (BOOL) willSendDeallocNotification {
//    return YES;
//}
//
//- (id) init {
//    return [self initWithActionType:nil];
//}
//
//- (id) initWithActionType:(NSString*) actionType {
//    return [self initWithActionType:nil actionItemName:nil];
//}
//
//- (id) initWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName {
//	if((self = [self init])){
//        _minimumTimeBetweenWarnings = FLActionMinimumTimeBetweenWarnings;
//		_actionDescription = [[FLActionDescription alloc] init];
//        _operations = [[FLSynchronousOperationQueueOperation alloc] init];
//
//		if(FLStringIsNotEmpty(actionType)) {
//            _actionDescription.actionType = actionType;
//        }
//        if(FLStringIsNotEmpty(actionItemName)) {
//            _actionDescription.actionItemName = actionItemName;
//        }
//	}
//	return self;
//}
//
//+ (id) action {
//	return FLAutorelease([[[self class] alloc] init]);
//}
//
//+ (id) actionWithActionType:(NSString*) actionType {
//	return FLAutorelease([[[self class] alloc] initWithActionType:actionType]);
//}
//
//+ (id) actionWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName {
//	return FLAutorelease([[[self class] alloc] initWithActionType:actionType actionItemName:actionItemName]);
//}
//
//+ (void) setGlobalFailedCallback:(id) target action:(SEL) action {
//	s_failedCallback = FLCallbackMake(target, action);
//}
//
//
//
//
//- (void) closeNotification {
////    id errorNotification = self.errorNotificationForUser;
////
////    if(errorNotification && s_errorDisplayDelegate)
////    {
////        [self performBlockOnMainThread:^{
////            if(s_errorDisplayDelegate)
////            {
////                [s_errorDisplayDelegate hideNotification:errorNotification];
////            }
////        }];
////    }
////
////	FLReleaseWithNil(_errorNotification);
//
////    FLPerformSelector(self.delegate, @selector(actionHideNotification:), self);
//}
//
//+ (void) setDisplayErrorForActionCallback:(FLCallback_t) callback {
//
//}
//
//
///*
//TODO("MF: fix activity updater");
//
//- (void) _activityUpdate:(FLNetworkOperation*) operation idleTimeSpan:(NSTimeInterval) idleTimeSpan {
//	if(!self.disableActivityTimer)
//	{
//#if DEBUG
////		  if(timeSinceLastActivity > 1)
////		  {
////			  FLDebugLog(@"Activity update: %f", timeSinceLastActivity);
////		  }
//#endif		  
//       
//        if(idleTimeSpan > FLActionDefaultTimeBetweenActivityWarnings)
//        {
//            if(!_actionFlags.disableWarningNotifications)
//            {
//                if(_willShowNotificationCallback)
//                {
//                    _willShowNotificationCallback(self);
//                }
//            }
//
//            if(!_actionFlags.disableWarningNotifications)
//            {
//                if(s_errorDisplayDelegate)
//                {
//                    [self performBlockOnMainThread:^{
//                        if(s_errorDisplayDelegate)
//                        {
//                            [s_errorDisplayDelegate actionDisplayServerNotRespondingMessage:self
//                                timeSpan:idleTimeSpan
//                                description:operation.activityTimerExplanation];
//                        }
//                    }];
//                }
//            }
//        }
//        else if(self.errorNotificationForUser)
//        {
//            [self closeNotification];
//        }
//    }
//}
//
//- (void) willBeginOperation:(id) operation {
//    [super willBeginOperation:operation];
//
//    if([operation isKindOfClass:[FLNetworkOperation class]])
//    {
//        [operation setIdleCallback:^(id theOperation, NSTimeInterval timeSpan) {
//                [self performBlockOnMainThread:^{
//                    [self _activityUpdate:theOperation idleTimeSpan:timeSpan];
//                    }];
//                }];
//                    
//        [operation setSentBytesCallback: ^(id theOperation, unsigned long long bytesWritten, unsigned long long totalBytesWritten, unsigned long long totalBytesExpectedToWrite) 
//                {
//                    [self performBlockOnMainThread:^{
//                        if(self.progressController)
//                        {
//                            [self.progressController updateProgress:totalBytesWritten totalAmount:totalBytesExpectedToWrite];
//                        }
//                        if(self.onUpdateProgress)
//                        {
//                            self.onUpdateProgress(self, bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
//                        }	                    
//                    }];
//                }];
//    }
//}
//*/
//
//- (void) dealloc {
//
////    FLPerformSelector1(self.delegate, @selector(actionHideNotification:), self);
////    self.delegate = nil;
//
//#if FL_MRC    
//    FLSendDeallocNotification();
//#endif
//
////    [_operations removeObserver:self];
//
//#if FL_MRC  
//    [_actionDescription release];
//    [_startingBlock release];
//    [_operations release];
//    [_progressCallback release];
//    [_willShowNotificationCallback release];
//    [super dealloc];
//#endif        
//}
//
//- (NSString*) itemNameInProgress{
//    return _actionDescription.itemNameInProgress;
//}
//- (void) setItemNameInProgress:(NSString*) actionItemName {
//    _actionDescription.itemNameInProgress = actionItemName;
//}
//- (NSString*) actionItemName {
//    return _actionDescription.actionItemName;
//}
//- (void) setActionItemName:(NSString*) actionItemName {
//    _actionDescription.actionItemName = actionItemName;
//}
//- (void) setActionType:(NSString*) actionType {
//    _actionDescription.actionType = actionType;
//}
//- (NSString*) actionType {
//    return _actionDescription.actionType;
//}
//
////- (id) errorNotificationForUser {
////	return _errorNotification ? _errorNotification.object : nil;
////}
////
////- (void) setErrorNotificationForUser:(id) notification {
////	if(!_errorNotification) {
////		_errorNotification = [[FLWeakReference alloc] init];
////	}
////	
////	_errorNotification.object = notification;
////}
//
//- (void) willHandleError:(NSError*)  error{
//    if(!self.handledError) {
//        FLCallbackPerform1(s_failedCallback, self);
//    }
//    
//    if(!self.handledError) {
////        FLPerformSelector2(self.delegate, @selector(action:handleError:), self, error);
//    }
//    
//}
//
//- (void) willReportError:(NSError*) error {
//	if(!self.handledError && !self.disableErrorNotifications) {
//            
//		if(_willShowNotificationCallback) {
//			_willShowNotificationCallback(self, error);
//		}
//		
//		if(!self.handledError && !self.disableErrorNotifications) {
//            if(s_errorDisplayDelegate) {
//                [self performBlockOnMainThread:^{
//                    if(s_errorDisplayDelegate) {
//                        [s_errorDisplayDelegate actionShouldDisplayError:self];
//                    }
//                }];
//            }
//		}
//	}
//}
//
//- (void) showProgress {
////    FLPerformSelector1(self.delegate, @selector(actionShowProgress:), self))
//
////	if(_progress) {
////		if(_actionDescription) {
////			NSString* title = _actionDescription.title;
////			FLAssertStringIsNotEmptyWithComment(title,nil);
////			
////			if(FLStringIsNotEmpty(title)) {
////				[_progress setTitle:title];
////			}
////		}
////
////      	[_progress showProgress];
////	}
//}
//
//- (void) addOperations:(FLSynchronousOperation*) operation {
//    [self.operations addOperation:operation];
//}
//
//- (void) actionStarted {
//    if(self.starting) {
//        self.starting(self);
//    }
//    [self showProgress];
//}
//
//- (id) actionFinished:(id) result {
////    if(_progress) {
////        [_progress hideProgress];
////    }
//    
////    FLPerformSelector1(self.delegate, @selector(actionHideProgress:), self))
//
//
//    @try {
//        if(![result error]  || [[result error]  isCancelError]) {
//            [self closeNotification];
//        } else {
//            [self willHandleError:[result error] ];
//            
//            if(!self.handledError) {
//                [self willReportError:[result error] ];
//            }
//        }
//    }
//    @catch(NSException* ex) {
//        FLAssertFailedWithComment(@"should never get exception in action finished: %@", [ex description]);
//        @throw;
//    }
//    
//    return result;
//}
//
//- (id) failedOperationInResults:(NSDictionary*) results {
//    for(FLSynchronousOperation* operation in self.operations.reverseIterator) {
//        if([[results objectForKey:operation.identifier] error]) {
//            return operation;
//        }
//    }
//    return nil;
//}
//
//- (void) requestCancel {
//    return [self.operations requestCancel];
//}
//
////- (void) runAsynchronously:(FLFinisher*) finisher {
////    
////    
//////    [[FLAsyncQueue sharedForegroundQueue] queueBlock:^{
//////        [self actionStarted];
//////        
//////        [[FLAsyncQueue sharedHighPriorityQueue] dispatchObject:self.operations
//////                                 completion:^(FLPromisedResult result) {
//////                
//////                [[FLAsyncQueue sharedForegroundQueue] queueBlock:^{
//////                    [finisher setFinishedWithResult:[self actionFinished:result]];
//////                }];
//////            }];
//////    }];
////}
//
////- (FLPromisedResult) runChildSynchronously {
////    FLFinisher* finisher = [FLFinisher finisher:nil];
////    [self runAsynchronously:finisher];
////    return [finisher waitUntilFinished];
////}
//
////- (id) firstOperation {
////    return self.operations.firstOperation;
////}
////
////- (id) lastOperation {
////    return self.operations.lastOperation;
////}
////
////- (id) lastOperationOutput {
////    return self.operations.lastOperationOutput;
////}
//
//- (void) addOperation:(FLSynchronousOperation*) operation {
//    [self.operations addOperation:operation];
//}
//@end
//
