//
//	FLBatchActionManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLBatchActionManager.h"

@interface FLBatchActionManager (Private)
- (void) _beginAction;
- (void) setActionContext:(FLActionContext*) context;
@end

@implementation FLBatchActionManager

@synthesize actionContext = _actionContext;
@synthesize totalActionCount = _totalCount;
@synthesize completedActionCount = _count;
@synthesize queuedDataForBatch = _queue;
@synthesize wasCancelled = _wasCancelled;
@synthesize error = _error;
@synthesize actionID = _actionID;
@synthesize onWillStart = _willBeginCallback;
@synthesize onFinished = _didCompleteCallback;
@synthesize actionDescription = _actionDescription;
@synthesize progressController = _progressController;

- (id) init
{
	if((self = [super init]))
	{
		_action = [[FLActionReference alloc] init];
		_count = 0;	
	}
	return self;
}

+ (id) batchActionManager
{
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) setQueuedDataForBatch:(NSArray*) array
{
	FLRelease(_queue);
	_queue = [array mutableCopy];
    _totalCount = _queue.count;
}

- (void) dealloc
{
    [_progressController hideProgress];
    
    FLReleaseWithNil(_didCompleteCallback);
    FLReleaseWithNil(_willBeginCallback);
    FLReleaseWithNil(_error);
	FLReleaseWithNil(_action);
	FLReleaseWithNil(_actionContext);
	FLReleaseWithNil(_progressController);
	FLReleaseWithNil(_queue );
	FLRelease(_actionDescription);
    FLRelease(_actionID);
	FLSuperDealloc();
}

- (void) beginActionInContext:(FLActionContext*) context
{
	self.actionContext = context;
	[self prepareBatch];
}

- (void) didFinishAction:(FLAction*) action
{
}

- (id) currentQueueObject
{
	return _queue.count > 0 ? [_queue objectAtIndex:0] : nil;
}

- (void) _dismiss
{
    FLReturnAutoreleased(FLReturnRetained(self));

    if(_didCompleteCallback)
    {
        _didCompleteCallback(self);
    }
}

- (void) _handleFinished
{
    if(self.progressController)
    {
        [self updateProgress:_totalCount total:_totalCount];
    }
    
    [self performSelector:@selector(_dismiss) withObject:nil afterDelay:0.5f];
}

- (void) _actionDidComplete:(FLAction*) action
{
	[self didFinishAction:action];
	
	if(action.didFinishWithoutError)
	{
		_count++;
		[_queue popFirstObject];
		[self _beginAction];
	}
	else
	{
		FLAssignObject(_error, [action error]);
		[self _handleFinished];
	}
}

- (void) _beginAction
{
	if(_queue.count == 0)
	{
		[self _handleFinished];
	}
	else
	{
        _action.action = [self createActionWithCurrentQueueObject:self.currentQueueObject];
        [_action.action setOnFinished: ^(id theAction) { 
            [self _actionDidComplete:theAction]; 
            }];

        if(self.progressController)
        {
            [self updateProgress:_count total:_totalCount];
        }
    
        [self.actionContext beginAction:_action.action];	
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
		_hasStarted = YES;
		[self _beginAction];
	}
	else
	{	
		[self requestCancel];
	}
}


- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total
{

}

- (void) cancelCallback:(id) sender
{
    [self requestCancel];
}

- (void) requestCancel
{
	if(!_wasCancelled)
	{
        _wasCancelled = YES;
        [_action.action requestCancel];
        FLAssignObject(_error, [NSError cancelError]); 
        [self _dismiss];
    }
}

- (FLAction*) currentAction
{
	return _action.action;
}

- (FLAction*) createActionWithCurrentQueueObject:(id) object
{
	return nil;
}

- (void) throwIfCancelled
{
	if(self.wasCancelled)
	{
		FLThrowError([NSError cancelError]);
	}	
}

@end
