//
//	GtBatchActionManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtBatchActionManager.h"

@interface GtBatchActionManager (Private)
- (void) _beginAction;
- (void) setActionContext:(GtActionContext*) context;
@end

@implementation GtBatchActionManager

@synthesize totalActionCount = m_totalCount;
@synthesize completedActionCount = m_count;
@synthesize queuedDataForBatch = m_queue;
@synthesize wasCancelled = m_wasCancelled;
@synthesize error = m_error;
@synthesize didCompleteBatchActionCallback = m_didCompleteCallback;
@synthesize actionID = m_actionID;

- (id) init
{
	if((self = [super init]))
	{
		m_actionContext = [[GtWeakReference alloc] init];
		m_action = [[GtActionReference alloc] init];
		m_count = 0;	
	}
	return self;
}

+ (id) batchActionManager
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

- (void) setQueuedDataForBatch:(NSArray*) array
{
	GtRelease(m_queue);
	m_queue = [array mutableCopy];
    m_totalCount = m_queue.count;
}

- (void) finalizeAction
{
	if(m_actionContext.object)
	{
		[m_actionContext.object removeActionFromContext:self];
		m_actionContext.object = nil;
	}
    
    GtReleaseWithNil(m_error);
	GtReleaseWithNil(m_action);
	GtReleaseWithNil(m_actionContext);
	GtReleaseWithNil(m_progress);
	GtReleaseWithNil(m_queue );
}

- (void) dealloc
{
    GtRelease(m_actionID);
	[self finalizeAction];
	GtSuperDealloc();
}

- (void) beginActionInContext:(GtActionContext*) context
{
	self.actionContext = context;
	[self prepareBatch];
}

- (void) willConfigureAction
{
	m_isConfiguring = YES;
}

- (void) didConfigureAction
{
	m_isConfiguring = NO;
}

- (void) didFinishAction:(GtAction*) action
{
}

- (id) currentQueueObject
{
	return m_queue.count > 0 ? [m_queue objectAtIndex:0] : nil;
}

- (void) _dismiss
{
    GtReturnAutoreleased(GtRetain(self));
    GtInvokeCallback(m_didCompleteCallback, self);
    [self finalizeAction];
}

- (void) _handleFinished
{
    if(self.progressView)
    {
        [self updateProgress:m_totalCount total:m_totalCount];
    }
    
    [self performSelector:@selector(_dismiss) withObject:nil afterDelay:0.5f];
}

- (void) _actionDidComplete:(GtAction*) action
{
	[self didFinishAction:action];
	
	if(action.didFinishWithoutError)
	{
		m_count++;
		[m_queue popFirstObject];
		[self _beginAction];
	}
	else
	{
		GtAssignObject(m_error, [action error]);
		[self _handleFinished];
	}
}

- (void) _beginAction
{
	if(m_queue.count == 0)
	{
		[self _handleFinished];
	}
	else
	{
        [self.actionContext beginAction: [self createActionWithCurrentQueueObject:self.currentQueueObject] 
            configureAction:^(id action) {
                m_action.action = action;
                if(self.progressView)
                {
                    [self updateProgress:m_count total:m_totalCount];
                }

                [action setDidCompleteCallback: ^{ [self _actionDidComplete:action]; }];
		}];	
	}
}

- (void) prepareBatch
{
	[self didPrepareBatch];
}

- (void) didPrepareBatch
{
	if(self.queuedDataForBatch.count > 0)
	{
		m_hasStarted = YES;
		[self _beginAction];
	}
	else
	{	
		[self requestCancel];
	}
}

- (id) progressView
{
	return m_progress ? m_progress.progressView : nil;
}

- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total
{

}


- (void) setProgressView:(id<GtProgressProtocol>) progress
{
	if(!m_progress)
	{
		m_progress = [[GtProgressViewOwner alloc] init];
	}
	
	m_progress.progressView = progress;
}

- (void) setActionContext:(GtActionContext*) context
{
	if(m_actionContext.object != context)
	{
		if(m_actionContext.object)
		{
			[m_actionContext.object removeActionFromContext:self];
		}
	
		m_actionContext.object = context;
		if(m_actionContext.object)
		{
			[m_actionContext.object addAction:self];
		}
	}
}

- (GtActionContext*) actionContext
{
	return m_actionContext.object;
}

- (void) cancelCallback:(id) sender
{
    [self requestCancel];
}

- (void) requestCancel
{
	if(!m_wasCancelled)
	{
        m_wasCancelled = YES;
        [m_action.action requestCancel];
        GtAssignObject(m_error, [NSError cancelError]); 
        [self _dismiss];
    }
}

- (GtAction*) currentAction
{
	return m_action.action;
}

- (GtAction*) createActionWithCurrentQueueObject:(id) object
{
	return nil;
}

- (void) throwIfCancelled
{
	if(self.wasCancelled)
	{
		GtThrowError([NSError cancelError]);
	}	
}

@end
