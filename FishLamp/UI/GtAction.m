//
//  GtAction.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/14/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtAction.h"
#import "GtActionManager.h"
#import "GtNetworkRequest.h"
#import "GtMemoryMonitor.h"
#import "GtActionErrorHandler.h"

@implementation GtAction

@synthesize actionId = m_actionID;
@synthesize bytesWritten = m_bytesWritten; 
@synthesize totalBytesWritten = m_totalBytesWritten;
@synthesize totalBytesExpectedToWrite = m_totalBytesExpectedToWrite;
@synthesize runCount = m_runCount;
@synthesize maxRetryCount = m_maxRetryCount;
@synthesize failedOperation = m_failedOperation;
@synthesize currentOperationIndex = m_currentOperationIndex;

GtSynthesizeStructProperty(isExecuting, setIsExecuting, BOOL, m_flags)
GtSynthesizeStructProperty(isFinished, setIsFinished, BOOL, m_flags)
GtSynthesizeStructProperty(handledError, setHandledError, BOOL, m_flags)
GtSynthesizeStructProperty(attemptRetryOnFailure, setAttemptRetryOnFailure, BOOL, m_flags)
GtSynthesizeStructProperty(didErrorNotification, setDidErrorNotification, BOOL, m_flags)

GtSynthesizeID(userData, setUserData);

@synthesize operations = m_operations;
GtSynthesizeSetter(setOperations, NSMutableArray*, m_operations);
GtSynthesize(completedCallback, setCompletedCallback, GtSimpleCallback, m_completedCallback);
GtSynthesize(progressCallback, setProgressCallback, GtSimpleCallback, m_progressCallback);
GtSynthesize(buttonCallback, setButtonCallback, GtSimpleCallback, m_buttonCallback);
GtSynthesize(startedOperationCallback, setStartedOperationCallback, GtSimpleCallback, m_startedOperationCallback);

GtSynthesizeString(errorStringForUser, setErrorStringForUser);
GtSynthesize(finalizeException, setFinalizeException, NSException, m_exception);
GtSynthesizeSetter(setProgress, GtProgressHandler*, m_progress);

GtSynthesizeWeakRefProperty()

- (void) initAction
{
	m_actionID = gtDefaultActionID;
	m_flags.isExecuting = NO;
    m_maxRetryCount = GtDefaultRetryCount;
}

- (id) init
{
	if(self = [super init])
	{
		[self initAction];
	}

	return self;
}

- (id) initWithActionId:(NSInteger) actionId
{
	if(self = [super init])
	{
		[self initAction];
		m_actionID =  actionId;
	}

	return self;
}

- (id) initWithOperation:(id<GtOperationProtocol>) operation
{
	if(self = [super init])
	{
		[self initAction];
		[self addOperation:operation];
	}
	
	return self;
}

- (id) initWithOperations:(id<GtOperationProtocol>) operation anotherOperation:(id<GtOperationProtocol>) anotherOperation
{
	if(self = [super init])
	{
		[self initAction];
		[self addOperation:operation];
		[self addOperation:anotherOperation];
	}
	
	return self;
}

- (id) initWithOperationAndActionId:(id<GtOperationProtocol>) operation actionId:(int) actionId
{
	if(self = [super init])
	{
		[self initAction];
		self.actionId = actionId;
		[self addOperation:operation];
	}
	
	return self;
}

+ (GtAction*) action
{
	return [[[GtAction alloc] init] autorelease];
}

- (void) closeNotification
{
	if(m_errorNotification)
	{
	 	if(!m_errorNotification.isNil)
		{
			[m_errorNotification.object hide];
		}
		GtReleaseWithNil(m_errorNotification);
	}
}

- (void) dealloc
{
    [m_context.object removeAction:self];
	
	m_weakRefContainer.object = nil;

	[self closeNotification];

	GtRelease(m_completedCallback);
	GtRelease(m_userData);
	GtRelease(m_operations);
	GtRelease(m_weakRefContainer);
	GtRelease(m_progress);
	GtRelease(m_progressCallback);
	GtRelease(m_buttonCallback);
    GtRelease(m_context); 
    GtRelease(m_exception);
	GtRelease(m_errorStringForUser);
    GtRelease(m_startedOperationCallback);
	
	[super dealloc];
}

- (void) resetRunState
{
    m_flags.isFinished = NO;
	m_flags.isExecuting = NO;
    m_flags.wasCancelled = NO;
    m_flags.wasTerminated = NO;
    m_flags.handledError = NO;
    m_failedOperation = nil;
}

- (GtNotificationView*) errorNotificationForUser
{
	return m_errorNotification ? m_errorNotification.object : nil;
}

- (void) setErrorNotificationForUser:(GtNotificationView*) notification
{
	if(!m_errorNotification)
	{
		m_errorNotification = [GtAlloc(GtWeakReference) init];
	}
	
	m_flags.didErrorNotification = YES;
	m_errorNotification.object = notification;
}

- (GtActionContext*) context
{
    return m_context == nil ? nil : m_context.object;
}

- (void) setContext:(GtActionContext*) context
{
	if(m_context && m_context.object)
	{
        if(m_context.object == context)
        {
            return;
        }

		[m_context.object removeAction:self];
        m_context.object = nil;
    }
	
    if(context)
    {
        if(!m_context)
        {
            m_context = [GtAlloc(GtWeakReference) initWithWeakReferenceTo:context];
        }
        else
        {
            m_context.object = context;
        }
        
		[m_context.object addAction:self];
	}
}

- (GtProgressHandler*) progress
{
	if(!m_progress)
	{
		m_progress = [GtAlloc(GtProgressHandler) init];
	}
    
	return m_progress;
}

- (void) performOperationInThread
{
	if(!m_flags.wasCancelled && !m_flags.wasTerminated)
	{
		id previousOperation = nil;
		
        for(m_currentOperationIndex = 0; 
            m_currentOperationIndex < m_operations.count;
            m_currentOperationIndex++)
        {
            id<GtOperationProtocol> operation = [m_operations objectAtIndex:m_currentOperationIndex];
        
			operation.previousOperation = previousOperation;

            if(self.startedOperationCallback)
            {
                [self.startedOperationCallback invokeOnMainThread:self];
            }

			[self onPerformOperationInThread:operation];
			
            if(operation.didFail)
			{
				m_failedOperation = operation;
				break;
			}
			
			previousOperation = operation;
		}
	}
}

- (BOOL) canAutoRetry
{
    return m_runCount + 1 <= m_maxRetryCount;
}

- (BOOL) didSucceed
{
#if DEBUG
    m_didCheckSucceededFlag = YES;
#endif

    return self.isFinished && !self.operationFailed && !m_exception && !self.wasCancelled && !self.wasTerminated;
}

- (BOOL) didTimeout
{
	return m_failedOperation && m_failedOperation.didTimeout;
}

- (BOOL) didLoseNetwork
{
    return m_failedOperation && m_failedOperation.didLoseNetwork;
}

- (void) setCompletedCallback:(id) target selector:(SEL) selector
{
	GtAssertNotNil(target);
	GtAssertNotNil(selector);

	GtSimpleCallback* cb = [GtAlloc(GtSimpleCallback) initWithTargetAndAction:target action:selector];
	self.completedCallback = cb;
	GtRelease(cb);
}

- (void) setProgressCallback:(id) target selector:(SEL) selector
{
	GtAssertNotNil(target);
	GtAssertNotNil(selector);

	GtSimpleCallback* cb = [GtAlloc(GtSimpleCallback) initWithTargetAndAction:target action:selector];
	self.progressCallback = cb;
	GtRelease(cb);
}

- (void) setStartedOperationCallback:(id) target selector:(SEL) selector
{
	GtAssertNotNil(target);
	GtAssertNotNil(selector);

	GtSimpleCallback* cb = [GtAlloc(GtSimpleCallback) initWithTargetAndAction:target action:selector];
	self.startedOperationCallback = cb;
	GtRelease(cb);
}

- (CGFloat) currentProgressPercent
{
	return ((float)m_totalBytesWritten) / ((float)m_totalBytesExpectedToWrite);
}

- (void) operation:(id<GtOperationProtocol>) operation 
	operationDidSendBytes:(NSInteger)bytesWritten 
	totalBytesWritten:(NSInteger)totalBytesWritten 
	totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
	m_bytesWritten = bytesWritten;
	m_totalBytesWritten = totalBytesWritten;
	m_totalBytesExpectedToWrite = totalBytesExpectedToWrite;

#if IPHONE
	if(m_progress && m_progress.wantsProgressBar && m_progress.isShowingProgress)
	{
		[m_progress updateProgress: self.currentProgressPercent];
	}
#endif

	if(m_progressCallback)
	{
		[m_progressCallback invoke:self];
	}
}

- (void) onPerformOperationInThread:(id<GtOperationProtocol>) operation
{
	@try
	{
		operation.delegate = self;
		[operation perform];
	}
	@finally
	{
		operation.delegate = nil;
	}
}

- (void) doCallback
{
	if(m_completedCallback)
	{
		[m_completedCallback invoke:self];

		GtAssert(m_didCheckSucceededFlag == YES, 
			@"didSucceed not checked in %@", 
			[m_completedCallback description]);
	}
}

- (void) handleActionCompleted
{
    @try
    {
        [self stopProgress];
    
		if(!m_flags.isFinished)
        {
            m_flags.isFinished = YES;
            m_flags.isExecuting = NO;
            
            [[GtActionManager instance] actionFinished:self];
            
            if(!m_flags.wasTerminated)
            {
				if(!self.didSucceed && !self.wasCancelled)
                {
                    self.handledError = [[GtActionErrorHandler instance] attemptToRetryOnNetworkError:self];
                    
					if(!self.handledError)
					{
						[self doCallback];
					}	
					
                    if(!self.handledError)
                    {
                        [[GtActionErrorHandler instance] reportError:self];
                    }
                }
				else
				{
					[self closeNotification];
					[self doCallback];
				}
            }
			
            
        }
	}
    @catch(NSException* exception)
    {
        GtReleaseWithNil(m_exception);
        m_exception = [exception copy];
    }
    @finally
    {
    }
}

- (NSString*) description
{
	NSMutableString* outString = [NSMutableString stringWithFormat:@"GtAction:\n ID:%d\n Error:%@\n Operations:\n", 
		m_actionID, 
		m_failedOperation.error];
		
	for(id<GtOperationProtocol> operation in m_operations)
	{
		[outString appendFormat:@"%@\n", NSStringFromClass([operation class])];
	}
	
	return outString;
}

- (void) addOperation:(id<GtOperationProtocol>) operation
{
	if(!m_operations)
	{
		m_operations = [GtAlloc(NSMutableArray) init];
	}

	if([operation operationID] == gtDefaultOperationID)
	{
		[operation setOperationID: m_operations.count];
	}
	
#if DEBUG
	for(id<GtOperationProtocol> op in m_operations)
	{
		GtAssert([op operationID] != [operation operationID],
			@"duplicate operation id found");
	}

#endif	

	[m_operations addObject:operation];
}

- (id) operationAtIndex:(NSUInteger) index
{
	GtAssert(index >= 0 && index < m_operations.count, @"bad index");
	return [m_operations objectAtIndex:index];
}

- (id) operationWithId:(NSInteger) operationId
{
	for(id<GtOperationProtocol> op in m_operations)
	{
		if([op operationID] == operationId)
		{
			return op;
		}
	}
	
	return nil; 
}

- (id) operationByClass:(Class) class
{
	for(id<GtOperationProtocol> op in m_operations)
	{
		if([op isKindOfClass:class])
		{
			return op;
		}
	}
	
	return nil;
}

- (id) operationOutputByClass:(Class) class
{
	id op = [self operationByClass:class];
	return [op output];
}

- (id) lastOperation
{
	return [m_operations lastObject];
}

- (NSUInteger) operationCount
{
	return m_operations ? m_operations.count : 0;
}

- (NSUInteger) operationSucceededCount
{
	NSUInteger count = 0;
	for(id<GtOperationProtocol> op in m_operations)
	{
		if(op.didSucceed)
		{
			++count;
		}
	}
	return count;
}

- (void) cancelActionButAlreadyRemovedFromContext:(BOOL) terminate
{
	if( (!terminate && !m_flags.wasCancelled) ||
        (terminate && !m_flags.wasTerminated))
	{
		@synchronized(self)
		{
            if( (!terminate && !m_flags.wasCancelled) ||
                (terminate && !m_flags.wasTerminated))			
            {
                if(terminate)
                {
#if DEBUG
                    GtTrace(GtTraceActions, @"terminating action: %@", [self description]);
#endif
                    m_flags.wasTerminated = YES;
                }
                else
                {
#if DEBUG
                    GtTrace(GtTraceActions, @"cancelling action: %@", [self description]);
#endif
                    m_flags.wasCancelled = YES;
                }

				for(id<GtOperationProtocol> op in m_operations)
				{
					[op cancelOperation];
				}
			}
		}
	}
}

- (void) cancelAction
{
 	self.context = nil;
    [self cancelActionButAlreadyRemovedFromContext:NO];
}

- (void) terminateAction
{
 	self.context = nil;
    [self cancelActionButAlreadyRemovedFromContext:YES];
}


- (BOOL) wasCancelled
{
	return m_flags.wasCancelled;
}	

- (BOOL) wasTerminated
{
	return m_flags.wasCancelled;
}

- (BOOL) beginAction
{
    BOOL isDone = NO;
    
#if DEBUG
	if(!self.context)
	{
        GtLog(@"Warning: action has no context in setFinishedPrivate: %@\nSet action.context to a GtActionContext (probably self.actionContext)\n", [self description]);
        GtPrintStackTrace();
    }
#endif

    ++m_runCount;

	if(m_flags.wasCancelled || m_flags.wasTerminated)
	{	
		[self handleActionCompleted];
        isDone = YES;
	}
	else
	{
        [self resetRunState];
    
		m_flags.isExecuting = YES;
		BOOL foundOne = NO;
		for(id<GtOperationProtocol> operation in m_operations)
		{
			foundOne |= [operation onPrepareOperationInMainThread];
		}

		if(foundOne || self.operationCount == 0)
		{
			[self startProgress];
			[[GtActionManager instance] beginAction:self];
		}
		else
		{
			[self handleActionCompleted];
            isDone = YES;
		}
	}
    
    return isDone;
}

- (void) retryAction:(BOOL) resetAllOperations
{
    
    if(resetAllOperations)
    {
        for(id<GtOperationProtocol> operation in m_operations)
		{
            [operation resetPerformState];
        }
    }
    else
    {
        if(self.failedOperation)
        {
            [self.failedOperation resetPerformState];
        }
    }
    
    [self resetRunState];
    [self beginAction];
    
    GtLog(@"retrying action: %d of %d attempts: %@", m_runCount, m_maxRetryCount, [self description]);
}


- (void) queueAction
{
#if DEBUG
	if(!self.context)
	{
        GtLog(@"Warning: action has no context in queueAction: %@", [self description]);
    }
#endif

	[[GtActionManager instance] queueAction:self];
}

- (id) operationOutputAtIndex:(NSUInteger) index
{
	return [[self operationAtIndex:index] output];
}

// get the operation output by its operation id 
- (id) operationOutputWithId:(NSInteger) operationId
{
	GtOperation* operation = [self operationWithId:operationId];
	return operation ? [operation output] : nil;
}

- (id) lastOperationOutput
{
	return [[m_operations lastObject] output];
}

// PROGRESS
- (void) createProgressHandler:(UIView*) hostView
{
	if(!m_progress)
	{
		m_progress = [GtAlloc(GtProgressHandler) init];
	}
	
	m_progress.superview = hostView;
}

- (BOOL) hasProgress
{
	return m_progress != nil;
}

- (BOOL) progressHidden
{
	return m_flags.progressHidden;
}

- (void) setProgressHidden:(BOOL) hidden
{
	if(hidden != m_flags.progressHidden)
	{
		m_flags.progressHidden = hidden;

		if(m_flags.isExecuting)
		{
			if(m_flags.progressHidden)
			{
				[m_progress stopProgress];
			}
			else
			{
				[m_progress startProgress];
			}
		}
	}
}
- (void) myButtonCallback:(id) sender
{
	if(m_buttonCallback)
	{
		[m_buttonCallback invoke:self];
	}
}
- (void) startProgress
{
	if(m_progress && !m_flags.progressHidden)
	{
		if(m_progress.buttonTarget && m_progress.buttonAction)
		{
			GtSimpleCallback* cb = [GtAlloc(GtSimpleCallback) initWithTargetAndAction:m_progress.buttonTarget  action:m_progress.buttonAction];
			self.buttonCallback = cb;
			GtRelease(cb);
			
            [m_progress setButtonInfo:m_progress.buttonText
                buttonTarget:self
                buttonAction:@selector(myButtonCallback:)];
        }
	
		[m_progress startProgress];
	}
}

- (void) stopProgress
{
	if(m_progress)
	{
		[m_progress stopProgress];
	}
}

- (BOOL) operationFailed
{
    return m_failedOperation != nil;
}



@end

