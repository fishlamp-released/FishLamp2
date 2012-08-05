//
//  FLBackgroundTaskMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/15/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLBackgroundTaskMgr.h"
#import "FLManagedActionContext.h"
#import "FLUserSession.h"
#import "FLActionContextManager.h"
#import "FLActionContext.h"

#define kDelay 0.5f
#if 0
#define TRACE DEBUG
#endif

@interface FLBackgroundTaskMgr ()
- (void) _handleReadyState;
@end

@implementation FLBackgroundTaskMgr

FLSynthesizeSingleton(FLBackgroundTaskMgr);

@synthesize actionContext = _actionContext;

- (id) init
{
	if((self = [super init]))
	{
		_queue = [[NSMutableArray alloc] init];
		_actionContext = [[FLActionContext alloc] init];
	    _sequenceQueue = [[NSMutableArray alloc] init];
    }
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    FLRelease(_delegates);
    FLRelease(_sequenceQueue);
	FLRelease(_actionContext);
	FLRelease(_queue);
	FLSuperDealloc();
}

- (void) addBackgroundTask:(id<FLBackgroundTask>) task
{
    [_queue addObject:task];
}

- (void) removeBackgroundTask:(id<FLBackgroundTask>) task
{
    [_queue removeObject:task];
    [_sequenceQueue removeObject:task];
}

- (void) addDelegate:(id<FLBackgroundTaskMgrDelegate>) delegate
{
    if(!_delegates)
    {
        _delegates = [[NSMutableArray alloc] init];
    }
    
    [_delegates addObject:[NSValue valueWithNonretainedObject:delegate]];
}

- (void) removeDelegate:(id<FLBackgroundTaskMgrDelegate>) delegate
{
    for(NSInteger i = (_delegates.count - 1); i >= 0; i--)
    {
        if([[_delegates objectAtIndex:i] nonretainedObjectValue] == delegate)
        {
            [_delegates removeObjectAtIndex:i];
        }
    }
}

- (BOOL) isExecutingBackgroundTask
{
    for(id<FLBackgroundTask> task in _queue)
    {
        if(task.isExecuting)
        {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL) canBeginTasks
{
    for(NSValue* value in _delegates)
    {
        id<FLBackgroundTaskMgrDelegate> delegate = [value nonretainedObjectValue];

        if( [delegate respondsToSelector:@selector(backgroundTaskMgrCanBeginBackgroundTasks:)] &&
            ![delegate backgroundTaskMgrCanBeginBackgroundTasks:self])
        {
#if TRACE
            FLDebugLog(@"Delegate: %@ said no to begining tasks", NSStringFromClass([delegate class]));
#endif
            return NO;
        }
    }

    return YES;
}

- (BOOL) canBeginBackgroundTask:(id<FLBackgroundTask>) task
{
    for(NSValue* value in _delegates)
    {
        id<FLBackgroundTaskMgrDelegate> delegate = [value nonretainedObjectValue];
        if( [delegate respondsToSelector:@selector(backgroundTaskMgr:canBeginBackgroundTask:)] &&
            ![delegate backgroundTaskMgr:self canBeginBackgroundTask:task])
        {
#if TRACE
            FLDebugLog(@"Delegate: %@ said no to begining task %@", NSStringFromClass([delegate class]), NSStringFromClass([task class]));
#endif
            return NO;
        }
    
    }
    
    return YES;
}

- (void) _handleReadyState
{
    FLAssert([NSThread isMainThread], @"not main thread");
    
    if([NSDate timeIntervalSinceReferenceDate] - _timestamp > kDelay && !_cancelling)
    {
        _timestamp = [NSDate timeIntervalSinceReferenceDate];
        
#if TRACE
        FLDebugLog(@"starting background tasks");
#endif        
        if([self canBeginTasks])
        {
            // find next one in queue that needs executing
            for(id<FLBackgroundTask> task in _queue)
            {
                if(task.isExecuting)
                {
#if TRACE
                    FLDebugLog(@"Task: %@ already excuting", NSStringFromClass([task class]));
#endif
                    return;
                }
            }
        
            if(_sequenceQueue.count == 0)
            {
#if TRACE
                FLDebugLog(@"re-populating queue: %@", [_queue description]);
#endif  
                [_sequenceQueue addObjectsFromArray:_queue];
            }
           
            while(_sequenceQueue.count > 0)
            {
                id<FLBackgroundTask> task = [_sequenceQueue objectAtIndex:0];
                [_sequenceQueue removeObjectAtIndex:0];

                if([self canBeginBackgroundTask:task])
                {
#if TRACE
                    FLDebugLog(@"pinging background Task: %@", NSStringFromClass([task class]));
#endif                
                    if([task canBeginBackgroundTask:self])
                    {
#if TRACE
                        FLDebugLog(@"task says yes please, I'll execute: %@", NSStringFromClass([task class]));
#endif
                        [task beginBackgroundTask:self];
    
                        if(task.isExecuting)
                        {
#if TRACE
                            FLDebugLog(@"task executing async, stopping queue processing: %@", NSStringFromClass([task class]));
#endif   
                            break;
                        }
#if TRACE
                        else
                        {
                            FLDebugLog(@"task executed sync. All done: %@", NSStringFromClass([task class]));
                        }
#endif                        
                    }
#if TRACE
                    else
                    {
                            FLDebugLog(@"task says no thanks, won't execute: %@", NSStringFromClass([task class]));
                    }
#endif                    
                }
            }
            
        }
    }
    else
    {
#if TRACE
        FLDebugLog(@"delaying ready state");
#endif 
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];
        [self performSelector:@selector(_handleReadyState) withObject:nil afterDelay:(kDelay * 0.5)];
    }
}

- (void) scheduleNextBackgroundTaskWithDelay:(NSTimeInterval) timeInterval
{
    if(timeInterval > 0)
    {
#if TRACE
        FLDebugLog(@"Delaying executing by: %f seconds", timeInterval);
#endif
        _timestamp = [NSDate timeIntervalSinceReferenceDate];
        [self performSelector:@selector(_handleReadyState) withObject:nil afterDelay:timeInterval];
    }
}

- (void) _handleCancelState
{
#if TRACE
    FLDebugLog(@"cancelling tasks");
#endif 

    FLAssert([NSThread isMainThread], @"not main thread");
	
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];
    for(id<FLBackgroundTask> task in _queue)
	{
		[task cancelBackgroundTask:self];
	}
}

- (void) _cancelCurrentTask:(NSNotification*) sender
{
    _timestamp = [NSDate timeIntervalSinceReferenceDate];
#if TRACE
    FLDebugLog(@"got cancel event: new time stamp: %f. event: %@", _timestamp, sender.name);
#endif
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];
    [self performSelectorOnMainThread:@selector(_handleCancelState) withObject:nil waitUntilDone:NO];
}

- (void) scheduleNextBackgroundTask
{
    _timestamp = [NSDate timeIntervalSinceReferenceDate];
#if TRACE
    FLDebugLog(@"got start event: new time stamp: %f, event: (called manually)", _timestamp);
#endif

    [self performSelectorOnMainThread:@selector(_handleReadyState) withObject:nil waitUntilDone:NO];
}

- (void) _possiblyStartTask:(NSNotification*) sender
{
#if TRACE
    FLDebugLog(@"got start event: %@", sender.name);
#endif

    [self scheduleNextBackgroundTask];
}

- (void) registerForEvents
{
// start events
	
	// action
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: FLActionContextDidFinishAllActionsNotification
			object: [FLActionContextManager instance]];

	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: FLActionContextWasActivated 
			object: [FLActionContextManager instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: FLUserSessionWillEnterForegroundNotification 
			object: [FLUserSession instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: FLUserSessionDidBecomeActiveNotification 
			object: [FLUserSession instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: FLUserSessionOpenedNotification 
			object: [FLUserSession instance]];

// abort events

	// action
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_cancelCurrentTask:) 
			name: FLActionContextWillBeginActionNotification 
			object: [FLActionContextManager instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_cancelCurrentTask:) 
			name: FLUserSessionDidEnterBackgroundNotification 
			object: [FLUserSession instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_cancelCurrentTask:) 
			name: FLUserSessionWillResignActiveNotification 
			object: [FLUserSession instance]];

//	// user session
//	[[NSNotificationCenter defaultCenter] addObserver:self
//			selector:@selector(_abortCurrentTask:) 
//			name: FLUserSessionClosedNotification 
//			object: [FLUserSession instance]];
//
//	// user session
//	[[NSNotificationCenter defaultCenter] addObserver:self
//			selector:@selector(_abortCurrentTask:) 
//			name: FLUserSessionUserLoggedOutNotification 
//			object: [FLUserSession instance]];

}

- (void) _checkCancelState:(FLObjectBlock) finishedBlock
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];

    _timestamp = [NSDate timeIntervalSinceReferenceDate];
    _cancelling = self.isExecutingBackgroundTask;

    if(_cancelling)
    {
        [self performBlockWithDelay:0.25 block:^{
            [self _checkCancelState:finishedBlock];
            }];
    }
    else
    {
        if(finishedBlock)
        {
            finishedBlock(self);
        }
    }
}

- (void) beginCancellingAllTasks:(FLObjectBlock) finishedBlock
{
    [self _checkCancelState:FLReturnAutoreleased([finishedBlock copy])];
}

- (void) resetAllTasks
{
    FLAssert(!self.isExecutingBackgroundTask, @"can't reset while executing");

    for(id<FLBackgroundTask> task in _queue)
    {
        [task resetBackgroundTask:self];
    }
}

@end



