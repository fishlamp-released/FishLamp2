////
////	FLAction.h
////	FishLamp
////
////	Created by Mike Fullerton on 8/14/09.
////	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
////
//
//#import "FishLampCore.h"
//#import "FLSynchronousOperationQueueOperation.h"
//#import "FLSynchronousOperation.h"
//#import "FLOperationQueue.h"
//#import "FLOperationContext.h"
//#import "FLActionDescription.h"
//#import "FLWeaklyReferenced.h"
//#import "FLDispatch.h"
//
//#define FLActionDefaultTimeBetweenActivityWarnings 30.0f
//#define FLActionMinimumTimeBetweenWarnings 15.0
//
//@class FLAction;
//@class FLWeakReference;
//
//typedef void (^FLActionProgressCallback)(	id action,
//                                            unsigned long long amountWritten,
//                                            unsigned long long totalAmountWritten,
//                                            unsigned long long totalAmountExpectedToWrite);
//
//typedef void (^FLActionBlock)(FLAction* action);
//typedef void (^FLActionErrorBlock)(FLAction* action, NSError* error);
//
//@protocol FLActionErrorDelegate;
//@protocol FLActionDelegate;
//
//@interface FLAction : FLOperation<FLActionDescription, FLWeaklyReferenced> {
//@private
//    FLOperationQueue* _operations;
//
//    FLActionDescription* _actionDescription;
////	id<FLActionDelegate> _delegate;
//	
//	FLActionErrorBlock _willShowNotificationCallback;
//	FLActionBlock _startingBlock;
//	
//    FLActionProgressCallback _progressCallback;
//
//	NSTimeInterval _lastWarningTimestamp;
//	NSTimeInterval _minimumTimeBetweenWarnings;
//	
//	BOOL _handledError;
//	BOOL _disableErrorNotifications;
//    BOOL _disableWarningNotifications;
//	BOOL _disableActivityTimer;
//    BOOL _networkRequired;
//}
//
//@property (readonly, strong) FLSynchronousOperationQueueOperation* operations;
//
//// UGH!
//@property (readwrite, assign, nonatomic) BOOL networkRequired;
//@property (readwrite, assign, nonatomic) BOOL handledError;
//@property (readwrite, assign, nonatomic) BOOL disableWarningNotifications;
//@property (readwrite, assign, nonatomic) BOOL disableErrorNotifications;
//@property (readwrite, assign, nonatomic) BOOL disableActivityTimer;
//
//@property (readwrite, assign, nonatomic) NSTimeInterval lastWarningTimestamp;
//@property (readwrite, assign, nonatomic) NSTimeInterval minimumTimeBetweenWarnings;
//
////@property (readwrite, assign, nonatomic) id errorNotificationForUser; // weakref
//
//// blocks
//@property (readwrite, copy) FLActionErrorBlock onShowNotification;
//@property (readwrite, copy) FLActionProgressCallback onUpdateProgress;
//@property (readwrite, copy) FLActionBlock starting;
//
//- (id) init;
//- (id) initWithActionType:(NSString*) actionType;
//- (id) initWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName;
//
//+ (id) action;
//+ (id) actionWithActionType:(NSString*) actionType;
//+ (id) actionWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName;
//
//+ (void) setActionErrorDelegate:(id<FLActionErrorDelegate>) delegate;
//+ (void) setGlobalFailedCallback:(id) target action:(SEL) action;
//
//// optional overrides
//- (void) showProgress;
//- (void) willHandleError:(NSError*) error;
//- (void) willReportError:(NSError*) error;
//
//@end
//
//@protocol FLActionObserver <NSObject>
//
//- (void) actionShowProgress:(FLAction*) action;
//- (void) actionUpdateProgress:(FLAction*) action;
//- (void) actionHideProgress:(FLAction*) action;
//
//- (void) action:(FLAction*) action showErrorAlert:(NSError*) error;
//- (void) actionHideErrorAlert:(FLAction*) action;
//
//- (void) action:(FLAction*) action showNotification:(id) notification;
//- (void) actionHideNotification:(FLAction*) action;
//
//- (void) action:(FLAction *)action handleError:(NSError *)error;
//
//@end
//
//// TODO: prob don't need this anymore
//#import "FLWeakReference.h"
//
//@interface FLActionReference : FLWeakReference
//@property (readwrite, assign, nonatomic) FLAction* action;
//@end
//
//typedef FLAction FLNetworkAction; // TODO placeholder.
//
//@protocol FLActionErrorDelegate <NSObject>
//- (void) actionShouldDisplayError:(FLAction*) action;
//- (void) hideNotification:(id) notification;
//- (void) actionDisplayServerNotRespondingMessage:(FLAction*) action 
//                                        timeSpan:(NSTimeInterval) timeSpan 
//                                     description:(NSString*) description;
//@end
//
