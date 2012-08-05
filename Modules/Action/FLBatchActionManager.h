//
//	FLBatchActionManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAction.h"
#import "FLProgressViewControllerProtocol.h"
#import "FLWeakReference.h"
#import "FLCallbackObject.h"
#import "FLActionContext.h"

@protocol FLBatchActionManagerDelegate;

@interface FLBatchActionManager : FLActionDescription<FLAsyncAction> {
@private
    NSNumber* _actionID;
	NSUInteger _count;
	NSUInteger _totalCount;
	NSMutableArray* _queue;
	FLActionReference* _action;
	FLActionContext* _actionContext;
    id<FLProgressViewController> _progressController;
	
    FLActionBlock _willBeginCallback;
	FLActionBlock _didCompleteCallback;

	BOOL _hasStarted;
	BOOL _wasCancelled;
	
	NSError* _error;
}
@property (readonly, retain, nonatomic) NSError* error;

@property (readwrite, copy, nonatomic) NSArray* queuedDataForBatch; 

@property (readwrite, retain, nonatomic) id<FLProgressViewController> progressController;

@property (readonly, assign, nonatomic) NSUInteger completedActionCount;
@property (readonly, assign, nonatomic) NSUInteger totalActionCount;

@property (readonly, assign, nonatomic) FLAction* currentAction;

@property (readonly, retain, nonatomic) id currentQueueObject;

@property (readwrite, copy, nonatomic) FLActionBlock onWillStart;
@property (readwrite, copy, nonatomic) FLActionBlock onFinished;

- (id) init;
+ (id) batchActionManager;

- (void) requestCancel;
- (void) cancelCallback:(id) sender;
- (void) didPrepareBatch; // call this when done preparing, if you need to prepare (see comment for prepareBatch)

// required override
- (FLAction*) createActionWithCurrentQueueObject:(id) object;

// optional overrides
- (void) prepareBatch; // this calls didPrepareBatch by default, if you override it, call didPrepareBatch when done preparing
- (void) didFinishAction:(FLAction*) action; // does nothing by default

- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total;

@end
