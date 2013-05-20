//
//	GtAction.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/14/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOperationQueue.h"
#import "GtWeakReference.h"
#import "GtActionContext.h"
#import "GtProgressProtocol.h"
#import "GtProgressViewOwner.h"
#import "GtActionDescription.h"
#import "GtErrorDisplayManager.h"
#import "GtWeakReference.h"


#define GtActionDefaultTimeBetweenActivityWarnings 30.0f
#define GtActionMinimumTimeBetweenWarnings 15.0

@class GtAction;
@class GtWeakReference;
@class GtNotificationViewController;
@class GtProgressViewController;

typedef void (^GtProgressCallback)(	unsigned long long amountWritten,
                                    unsigned long long totalAmountWritten,
                                    unsigned long long totalAmountExpectedToWrite);

typedef GtBlock GtActionCallback;

@interface GtAction : GtOperationQueue<GtAction, GtOperationContext> 
{
@private
    NSNumber* m_actionID;
	NSMutableDictionary* m_contextDictionary;
	GtActionDescription* m_actionDescription;
	GtProgressViewController* m_progress;
	GtActionContext* m_context;
	GtWeakReference* m_errorNotification;
	
	NSTimeInterval m_lastWarningTimestamp;
	NSTimeInterval m_minimumTimeBetweenWarnings;
	
	GtProgressCallback m_progressCallback;
	GtActionCallback m_willShowNotificationCallback;
	GtActionCallback m_willBeginCallback;
	GtActionCallback m_willShowProgressCallback;
	GtActionCallback m_didCompleteCallback;
	
	struct {
		unsigned int handledError:1;
		unsigned int disableErrorNotifications:1;
		unsigned int disableWarningNotifications:1;
		unsigned int disableActivityTimer: 1;
		unsigned int isConfiguring: 1;
	} m_actionFlags;
    
}

- (id) init;
- (id) initWithActionType:(NSString*) actionType;
- (id) initWithActionType:(NSString*) actionType itemName:(NSString*) itemName;

+ (id) action;
+ (id) actionWithActionType:(NSString*) actionType;
+ (id) actionWithActionType:(NSString*) actionType itemName:(NSString*) itemName;

@property (readonly, retain, nonatomic) GtActionContext* context;

// progress
@property (readwrite, retain, nonatomic) GtProgressViewController* progressView;
@property (readonly, retain, nonatomic) GtActionDescription* actionDescription; // also used by error handling

// error and warning info
@property (readwrite, assign, nonatomic) BOOL handledError;
@property (readwrite, assign, nonatomic) BOOL disableWarningNotifications;
@property (readwrite, assign, nonatomic) BOOL disableErrorNotifications;
@property (readwrite, assign, nonatomic) BOOL disableActivityTimer;
@property (readwrite, assign, nonatomic) NSTimeInterval lastWarningTimestamp;
@property (readwrite, assign, nonatomic) NSTimeInterval minimumTimeBetweenWarnings;
@property (readwrite, assign, nonatomic) GtNotificationViewController* errorNotificationForUser; // weakref

// these can only be set during configuration state.
@property (readwrite, copy, nonatomic) GtActionCallback didCompleteCallback;
@property (readwrite, copy, nonatomic) GtActionCallback willShowNotificationCallback;
@property (readwrite, copy, nonatomic) GtActionCallback willBeginCallback;
@property (readwrite, copy, nonatomic) GtActionCallback willShowProgressCallback;
@property (readwrite, copy, nonatomic) GtProgressCallback progressCallback;

// misc
- (void) respondToCancelEvent:(id) sender; // wire this up to buttons if you want

	// state 
- (void) setStateObject:(id) object forKey:(id) key;
- (id) stateObjectForKey:(id) key;

// protected
- (void) showProgress;
- (BOOL) willBeginAction;
- (void) willHandleError;
- (void) willReportError;
- (void) willInvokeCompletedCallback;
@end

@interface GtActionReference : GtWeakReference
@property (readwrite, assign, nonatomic) GtAction* action;
@end

typedef GtAction GtNetworkAction; // TODO placeholder.




