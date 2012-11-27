//
//	FLAction.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/14/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLOperationQueue.h"
#import "FLOperation.h"
#import "FLOperationContext.h"
#import "FLActionDescription.h"
#import "FLProgressViewControllerProtocol.h"
#import "FLRunnable.h"

#define FLActionDefaultTimeBetweenActivityWarnings 30.0f
#define FLActionMinimumTimeBetweenWarnings 15.0

@class FLAction;
@class FLWeakReference;

typedef void (^FLActionProgressCallback)(	id action,
                                            unsigned long long amountWritten,
                                            unsigned long long totalAmountWritten,
                                            unsigned long long totalAmountExpectedToWrite);

typedef void (^FLActionBlock)(FLAction* action);

@protocol FLActionErrorDelegate;

@interface FLAction : NSObject<FLActionDescription, FLCancellable, FLWeaklyReferenced, FLRunnable> {
@private
    FLOperationQueue* _operations;

    FLActionDescription* _actionDescription;
	id<FLProgressViewController> _progress;
	FLWeakReference* _errorNotification;
	
	FLActionBlock _willShowNotificationCallback;
	FLActionBlock _startingBlock;
	
    FLActionProgressCallback _progressCallback;

	NSTimeInterval _lastWarningTimestamp;
	NSTimeInterval _minimumTimeBetweenWarnings;
	
	BOOL _handledError;
	BOOL _disableErrorNotifications;
    BOOL _disableWarningNotifications;
	BOOL _disableActivityTimer;
    BOOL _networkRequired;
}


@property (readonly, strong) FLOperationQueue* operations;

// UGH!
@property (readwrite, assign, nonatomic) BOOL networkRequired;
@property (readwrite, assign, nonatomic) BOOL handledError;
@property (readwrite, assign, nonatomic) BOOL disableWarningNotifications;
@property (readwrite, assign, nonatomic) BOOL disableErrorNotifications;
@property (readwrite, assign, nonatomic) BOOL disableActivityTimer;
@property (readwrite, assign, nonatomic) NSTimeInterval lastWarningTimestamp;
@property (readwrite, assign, nonatomic) NSTimeInterval minimumTimeBetweenWarnings;
@property (readwrite, assign, nonatomic) id errorNotificationForUser; // weakref

// progress
@property (readwrite, strong, nonatomic) id<FLProgressViewController> progressController;

// blocks
@property (readwrite, copy) FLActionBlock onShowNotification;
@property (readwrite, copy) FLActionProgressCallback onUpdateProgress;
@property (readwrite, copy) FLActionBlock starting;

- (id) init;
- (id) initWithActionType:(NSString*) actionType;
- (id) initWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName;

+ (id) action;
+ (id) actionWithActionType:(NSString*) actionType;
+ (id) actionWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName;

// optioal overrides
- (void) showProgress;
- (void) willHandleError;
- (void) willReportError;

+ (void) setActionErrorDelegate:(id<FLActionErrorDelegate>) delegate;
+ (void) setGlobalFailedCallback:(id) target action:(SEL) action;

// chooses the right dispatchers for you.
- (FLFinisher*) startAction:(FLResultBlock) resultBlock;

- (FLFinisher*) startActionInContext:(FLOperationContext*) context 
                          completion:(FLResultBlock) resultBlock;

@end


@interface FLAction ()
// backward compatibility
@property (readonly, strong) NSError* error;
@property (readonly, assign) BOOL didSucceed;
- (void) addOperation:(FLOperation*) operation;
- (id) firstOperation;
- (id) lastOperation;
- (id) lastOperationOutput;
@end


// TODO: prob don't need this anymore
#import "FLWeakReference.h"

@interface FLActionReference : FLWeakReference
@property (readwrite, assign, nonatomic) FLAction* action;
@end

typedef FLAction FLNetworkAction; // TODO placeholder.

@protocol FLActionErrorDelegate <NSObject>
- (void) actionShouldDisplayError:(FLAction*) action;
- (void) hideNotification:(id) notification;
- (void) actionDisplayServerNotRespondingMessage:(FLAction*) action 
                                        timeSpan:(NSTimeInterval) timeSpan 
                                     description:(NSString*) description;
@end

