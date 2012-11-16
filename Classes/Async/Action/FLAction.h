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

@interface FLAction : NSObject<FLCancellable, FLWeaklyReferenced, FLRunnable> {
@private
    FLOperationQueue* _operations;

    FLActionDescription* _actionDescription;
	id<FLProgressViewController> _progress;
	FLWeakReference* _errorNotification;
	
	FLActionBlock _willShowNotificationCallback;
	FLActionProgressCallback _progressCallback;

	NSTimeInterval _lastWarningTimestamp;
	NSTimeInterval _minimumTimeBetweenWarnings;
	
	struct {
		unsigned int handledError:1;
		unsigned int disableErrorNotifications:1;
		unsigned int disableWarningNotifications:1;
		unsigned int disableActivityTimer: 1;
        unsigned int networkRequired: 1;
	} _actionFlags;
    
    BOOL _didSucceed;
}

- (id) init;
- (id) initWithActionType:(NSString*) actionType;
- (id) initWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName;

+ (id) action;
+ (id) actionWithActionType:(NSString*) actionType;
+ (id) actionWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName;

@property (readonly, strong) FLOperationQueue* operations;


@property (readwrite, assign, nonatomic) BOOL networkRequired;

// this is only set if didSucceed == YES.
// this return either self.operationOutput, or searches backward in queue for first operation
// will output. This is the most common use case.
@property (readonly, strong, nonatomic) id result;

// progress
@property (readwrite, strong, nonatomic) id<FLProgressViewController> progressController;

@property (readwrite, strong, nonatomic) FLActionDescription* actionDescription; // also used by error handling

// error and warning info
@property (readwrite, assign, nonatomic) BOOL handledError;
@property (readwrite, assign, nonatomic) BOOL disableWarningNotifications;
@property (readwrite, assign, nonatomic) BOOL disableErrorNotifications;
@property (readwrite, assign, nonatomic) BOOL disableActivityTimer;
@property (readwrite, assign, nonatomic) NSTimeInterval lastWarningTimestamp;
@property (readwrite, assign, nonatomic) NSTimeInterval minimumTimeBetweenWarnings;
@property (readwrite, assign, nonatomic) id errorNotificationForUser; // weakref

@property (readwrite, copy) FLActionBlock onShowNotification;
@property (readwrite, copy) FLActionProgressCallback onUpdateProgress;

// misc
- (void) respondToCancelEvent:(id) sender; // wire this up to buttons if you want

// protected
- (void) showProgress;
- (void) willHandleError;
- (void) willReportError;

+ (void) setActionErrorDelegate:(id<FLActionErrorDelegate>) delegate;
+ (void) setGlobalFailedCallback:(id) target action:(SEL) action;

- (FLFinisher*) startAction:(FLFinisher*) finisher;

- (FLFinisher*) startActionInContext:(FLOperationContext*) context
                          finisher:(FLFinisher*) finisher;

- (FLFinisher*) startAction:(dispatch_block_t) starting
                 finisher:(FLFinisher*) finisher;

- (FLFinisher*) startActionInContext:(FLOperationContext*) context
                            starting:(dispatch_block_t) starting
                          finisher:(FLFinisher*) finisher;

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

