//
//	GtBatchActionManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtAction.h"
#import "GtProgressViewOwner.h"
#import "GtWeakReference.h"
#import "GtCallbackObject.h"
#import "GtActionContext.h"

@protocol GtBatchActionManagerDelegate;

@interface GtBatchActionManager : NSObject<GtAction> {
@private
    NSNumber* m_actionID;
	NSUInteger m_count;
	NSUInteger m_totalCount;
	NSMutableArray* m_queue;
	GtProgressViewOwner* m_progress;
	GtActionReference* m_action;
	GtWeakReference* m_actionContext;
	BOOL m_hasStarted;
	BOOL m_wasCancelled;
	BOOL m_isConfiguring;
	
	GtCallback m_didCompleteCallback;
	NSError* m_error;
}
@property (readonly, retain, nonatomic) NSError* error;

@property (readwrite, copy, nonatomic) NSArray* queuedDataForBatch; 

@property (readwrite, retain, nonatomic) id<GtProgressProtocol> progressView;

@property (readonly, assign, nonatomic) GtActionContext* actionContext;

@property (readonly, assign, nonatomic) NSUInteger completedActionCount;
@property (readonly, assign, nonatomic) NSUInteger totalActionCount;

@property (readonly, assign, nonatomic) GtAction* currentAction;

@property (readonly, retain, nonatomic) id currentQueueObject;

@property (readwrite, assign, nonatomic) GtCallback didCompleteBatchActionCallback;

- (id) init;
+ (id) batchActionManager;

- (void) requestCancel;
- (void) cancelCallback:(id) sender;
- (void) didPrepareBatch; // call this when done preparing, if you need to prepare (see comment for prepareBatch)

// required override
- (GtAction*) createActionWithCurrentQueueObject:(id) object;

// optional overrides
- (void) prepareBatch; // this calls didPrepareBatch by default, if you override it, call didPrepareBatch when done preparing
- (void) didFinishAction:(GtAction*) action; // does nothing by default

- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total;

@end
