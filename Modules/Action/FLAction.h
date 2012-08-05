//
//	FLAction.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/14/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLOperationQueue.h"
#import "FLActionContext.h"
#import "FLActionDescription.h"
#import "FLProgressViewControllerProtocol.h"
#import "FLCocoaCompatibility.h"


#define FLActionDefaultTimeBetweenActivityWarnings 30.0f
#define FLActionMinimumTimeBetweenWarnings 15.0

@class FLAction;
@class FLWeakReference;

typedef void (^FLActionProgressCallback)(	id action,
                                            unsigned long long amountWritten,
                                            unsigned long long totalAmountWritten,
                                            unsigned long long totalAmountExpectedToWrite);

@protocol FLActionErrorDelegate;

@interface FLAction : FLOperationQueue<FLAsyncAction> {
@private
    NSNumber* _actionID;
	FLActionDescription* _actionDescription;
	id<FLProgressViewController> _progress;
	FLActionContext* _context;
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
	} _actionFlags;
}

- (id) init;
- (id) initWithActionType:(NSString*) actionType;
- (id) initWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName;

+ (id) action;
+ (id) actionWithActionType:(NSString*) actionType;
+ (id) actionWithActionType:(NSString*) actionType actionItemName:(NSString*) actionItemName;

// progress
@property (readwrite, retain, nonatomic) id<FLProgressViewController> progressController;

@property (readwrite, retain, nonatomic) FLActionDescription* actionDescription; // also used by error handling

// error and warning info
@property (readwrite, assign, nonatomic) BOOL handledError;
@property (readwrite, assign, nonatomic) BOOL disableWarningNotifications;
@property (readwrite, assign, nonatomic) BOOL disableErrorNotifications;
@property (readwrite, assign, nonatomic) BOOL disableActivityTimer;
@property (readwrite, assign, nonatomic) NSTimeInterval lastWarningTimestamp;
@property (readwrite, assign, nonatomic) NSTimeInterval minimumTimeBetweenWarnings;
@property (readwrite, assign, nonatomic) id errorNotificationForUser; // weakref

// FLAction specific
@property (readwrite, copy, nonatomic) FLActionBlock onShowNotification;
@property (readwrite, copy, nonatomic) FLActionProgressCallback onUpdateProgress;

// misc
- (void) respondToCancelEvent:(id) sender; // wire this up to buttons if you want

// protected
- (void) showProgress;
- (BOOL) willBeginAction;
- (void) willHandleError;
- (void) willReportError;

+ (void) setActionErrorDelegate:(id<FLActionErrorDelegate>) delegate;

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


