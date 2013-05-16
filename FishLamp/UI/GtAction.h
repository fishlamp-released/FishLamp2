//
//  GtAction.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/14/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtOperation.h"
#import "GtActionContext.h"
#import "GtWeakReference.h"
#import "GtProgressHandler.h"
#import "GtSimpleCallback.h"
#import "GtReachability.h"
#import "GtActionErrorHandler.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"


#define gtDefaultActionID 0
#define GtDefaultRetryCount 3

@interface GtAction : NSObject<GtWeaklyReferencedObject, GtOperationProgressDelegate> {
@private
	NSInteger m_actionID;
	
	NSMutableArray* m_operations;
	id m_userData;
	id<GtOperationProtocol> m_failedOperation;
	
	GtSimpleCallback* m_completedCallback; 
	GtSimpleCallback* m_progressCallback;
	GtSimpleCallback* m_buttonCallback;
    GtSimpleCallback* m_startedOperationCallback;

	NSInteger m_bytesWritten;
	NSInteger m_totalBytesWritten;
	NSInteger m_totalBytesExpectedToWrite;
    NSUInteger m_runCount;
	NSUInteger m_maxRetryCount;
    NSUInteger m_currentOperationIndex;
        	
	GtWeaklyReferencedObjectContainer* m_weakRefContainer;
	GtProgressHandler* m_progress;
	
	GtWeakReference* m_context;
	
	struct {
        unsigned int wasTerminated:1;
		unsigned int wasCancelled:1;
		unsigned int isFinished:1;
		unsigned int isExecuting:1;
		unsigned int handledError:1;
		unsigned int progressHidden:1;
        unsigned int attemptRetryOnFailure:1;
		unsigned int didErrorNotification:1;
	} m_flags;
    
    NSException* m_exception;
    NSString* m_errorStringForUser;
	GtWeakReference* m_errorNotification;
    

#if DEBUG
    BOOL m_didCheckSucceededFlag;
#endif
}

@property (readwrite, assign, nonatomic) NSInteger actionId;

// misc
@property (readwrite, assign, nonatomic) id userData;
@property (readwrite, assign, nonatomic) GtActionContext* context;

// error handling 

@property (readonly, assign, nonatomic) NSException* finalizeException;

// progress
@property (readonly, assign, nonatomic) GtProgressHandler* progress;
@property (readonly, assign, nonatomic) BOOL hasProgress;
@property (readwrite, assign, nonatomic) BOOL progressHidden;

@property (readonly, assign, nonatomic) NSInteger bytesWritten; 
@property (readonly, assign, nonatomic) NSInteger totalBytesWritten;
@property (readonly, assign, nonatomic) NSInteger totalBytesExpectedToWrite;
@property (readonly, assign, nonatomic) CGFloat currentProgressPercent;

// callbacks
@property (readwrite, assign, nonatomic) GtSimpleCallback* progressCallback;
@property (readwrite, assign, nonatomic) GtSimpleCallback* completedCallback; // firstParameter is always the action
@property (readwrite, retain, nonatomic) GtSimpleCallback* buttonCallback; // firstParameter is always the action
@property (readwrite, retain, nonatomic) GtSimpleCallback* startedOperationCallback; // firstParameter is always the action

- (void) setCompletedCallback:(id) target selector:(SEL) selector;
- (void) setProgressCallback:(id) target selector:(SEL) selector;
- (void) setStartedOperationCallback:(id) target selector:(SEL) selector;

- (void) retryAction:(BOOL) resetAllOperations;
- (BOOL) beginAction; // returns true if finished immediately.
- (void) queueAction;

- (void) cancelAction; // user cancels, action completed callback IS called
- (void) terminateAction; // application terminates (e.g. context goes away), action completed callback IS NOT called

// state
@property (readonly, assign, nonatomic) NSUInteger runCount;
@property (readwrite, assign, nonatomic) NSUInteger maxRetryCount;
@property (readonly, assign, nonatomic) BOOL canAutoRetry;
@property (readonly, assign, nonatomic) BOOL isExecuting;
@property (readonly, assign, nonatomic) BOOL isFinished;
@property (readonly, assign, nonatomic) BOOL attemptRetryOnFailure; // defaults to YES

@property (readwrite, assign, nonatomic) BOOL handledError;

@property (readwrite, assign, nonatomic) NSString* errorStringForUser;
@property (readwrite, assign, nonatomic) GtNotificationView* errorNotificationForUser;
@property (readonly, assign, nonatomic) BOOL didErrorNotification;

// results
@property (readonly, assign, nonatomic) BOOL didSucceed;
@property (readonly, assign, nonatomic) BOOL wasCancelled;
@property (readonly, assign, nonatomic) BOOL wasTerminated;
@property (readonly, assign, nonatomic) BOOL didTimeout;
@property (readonly, assign, nonatomic) BOOL didLoseNetwork;

@property (readonly, assign, nonatomic) BOOL operationFailed;

@property (readonly, assign, nonatomic) id<GtOperationProtocol> failedOperation;

// instantiation
- (id) init;
- (id) initWithActionId:(NSInteger) actionId;
- (id) initWithOperation:(id<GtOperationProtocol>) operation;
- (id) initWithOperations:(id<GtOperationProtocol>) operation anotherOperation:(id<GtOperationProtocol>) anotherOperation;
- (id) initWithOperationAndActionId:(id<GtOperationProtocol>) operation actionId:(int) actionId;

// operations

@property (readonly, assign, nonatomic) NSArray* operations;
@property (readonly, assign, nonatomic) NSUInteger operationCount;
- (void) addOperation:(id<GtOperationProtocol>) operation;
- (id) operationAtIndex:(NSUInteger) index;
- (id) operationWithId:(NSInteger) operationId;
- (id) operationByClass:(Class) class;

// only valid after action is finished
@property (readonly, assign, nonatomic) NSUInteger operationSucceededCount;
@property (readonly, assign, nonatomic) id lastOperation; 
@property (readonly, assign, nonatomic) id lastOperationOutput;
- (id) operationOutputByClass:(Class) class;
- (id) operationOutputAtIndex:(NSUInteger) index; // get the operation output by operation index (e.g. order put in the queue)
- (id) operationOutputWithId:(NSInteger) operationId; // get the operation output by its operation id 

// only valid while Action is running
@property (readonly, assign, nonatomic) NSUInteger currentOperationIndex;

@end


@interface GtAction (Internal)
- (void) performOperationInThread;
- (void) handleActionCompleted;
- (void) cancelActionButAlreadyRemovedFromContext:(BOOL) terminate;

//- (void) setFinished;
//- (BOOL) handleActionFailedWithError;
@end

@interface GtAction (Protected)
- (void) startProgress;
- (void) stopProgress;	
- (void) onPerformOperationInThread:(id<GtOperationProtocol>) operation;
@end

