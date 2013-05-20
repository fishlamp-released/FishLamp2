//
//  GtBackgroundTaskMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/15/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtBackgroundTaskMgr.h"
#import "GtManagedActionContext.h"
#import "GtUserSession.h"
#import "GtActionContextManager.h"
#import "GtActionContext.h"

#define kDelay 0.5f
#if 0
#define TRACE DEBUG
#endif

@interface GtBackgroundTaskMgr ()
- (void) _handleReadyState;
@end

@implementation GtBackgroundTaskMgr

GtSynthesizeSingleton(GtBackgroundTaskMgr);

@synthesize actionContext = m_actionContext;

- (id) init
{
	if((self = [super init]))
	{
		m_queue = [[NSMutableArray alloc] init];
		m_actionContext = [[GtActionContext alloc] init];
	    m_sequenceQueue = [[NSMutableArray alloc] init];
    }
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    GtRelease(m_delegates);
    GtRelease(m_sequenceQueue);
	GtRelease(m_actionContext);
	GtRelease(m_queue);
	GtSuperDealloc();
}

- (void) addBackgroundTask:(id<GtBackgroundTask>) task
{
    [m_queue addObject:task];
}

- (void) removeBackgroundTask:(id<GtBackgroundTask>) task
{
    [m_queue removeObject:task];
    [m_sequenceQueue removeObject:task];
}

- (void) addDelegate:(id<GtBackgroundTaskMgrDelegate>) delegate
{
    if(!m_delegates)
    {
        m_delegates = [[NSMutableArray alloc] init];
    }
    
    [m_delegates addObject:[NSValue valueWithNonretainedObject:delegate]];
}

- (void) removeDelegate:(id<GtBackgroundTaskMgrDelegate>) delegate
{
    for(NSInteger i = (m_delegates.count - 1); i >= 0; i--)
    {
        if([[m_delegates objectAtIndex:i] nonretainedObjectValue] == delegate)
        {
            [m_delegates removeObjectAtIndex:i];
        }
    }
}

- (BOOL) isExecutingBackgroundTask
{
    for(id<GtBackgroundTask> task in m_queue)
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
    for(NSValue* value in m_delegates)
    {
        id<GtBackgroundTaskMgrDelegate> delegate = [value nonretainedObjectValue];

        if( [delegate respondsToSelector:@selector(backgroundTaskMgrCanBeginBackgroundTasks:)] &&
            ![delegate backgroundTaskMgrCanBeginBackgroundTasks:self])
        {
#if TRACE
            GtLog(@"Delegate: %@ said no to begining tasks", NSStringFromClass([delegate class]));
#endif
            return NO;
        }
    }

    return YES;
}

- (BOOL) canBeginBackgroundTask:(id<GtBackgroundTask>) task
{
    for(NSValue* value in m_delegates)
    {
        id<GtBackgroundTaskMgrDelegate> delegate = [value nonretainedObjectValue];
        if( [delegate respondsToSelector:@selector(backgroundTaskMgr:canBeginBackgroundTask:)] &&
            ![delegate backgroundTaskMgr:self canBeginBackgroundTask:task])
        {
#if TRACE
            GtLog(@"Delegate: %@ said no to begining task %@", NSStringFromClass([delegate class]), NSStringFromClass([task class]));
#endif
            return NO;
        }
    
    }
    
    return YES;
}

- (void) _handleReadyState
{
    GtAssert([NSThread isMainThread], @"not main thread");
    
    if([NSDate timeIntervalSinceReferenceDate] - m_timestamp > kDelay && !m_cancelling)
    {
        m_timestamp = [NSDate timeIntervalSinceReferenceDate];
        
#if TRACE
        GtLog(@"starting background tasks");
#endif        
        if([self canBeginTasks])
        {
            // find next one in queue that needs executing
            for(id<GtBackgroundTask> task in m_queue)
            {
                if(task.isExecuting)
                {
#if TRACE
                    GtLog(@"Task: %@ already excuting", NSStringFromClass([task class]));
#endif
                    return;
                }
            }
        
            if(m_sequenceQueue.count == 0)
            {
#if TRACE
                GtLog(@"re-populating queue: %@", [m_queue description]);
#endif  
                [m_sequenceQueue addObjectsFromArray:m_queue];
            }
           
            while(m_sequenceQueue.count > 0)
            {
                id<GtBackgroundTask> task = [m_sequenceQueue objectAtIndex:0];
                [m_sequenceQueue removeObjectAtIndex:0];

                if([self canBeginBackgroundTask:task])
                {
#if TRACE
                    GtLog(@"pinging background Task: %@", NSStringFromClass([task class]));
#endif                
                    if([task canBeginBackgroundTask:self])
                    {
#if TRACE
                        GtLog(@"task says yes please, I'll execute: %@", NSStringFromClass([task class]));
#endif
                        [task beginBackgroundTask:self];
    
                        if(task.isExecuting)
                        {
#if TRACE
                            GtLog(@"task executing async, stopping queue processing: %@", NSStringFromClass([task class]));
#endif   
                            break;
                        }
#if TRACE
                        else
                        {
                            GtLog(@"task executed sync. All done: %@", NSStringFromClass([task class]));
                        }
#endif                        
                    }
#if TRACE
                    else
                    {
                            GtLog(@"task says no thanks, won't execute: %@", NSStringFromClass([task class]));
                    }
#endif                    
                }
            }
            
        }
    }
    else
    {
#if TRACE
        GtLog(@"delaying ready state");
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
        GtLog(@"Delaying executing by: %f seconds", timeInterval);
#endif
        m_timestamp = [NSDate timeIntervalSinceReferenceDate];
        [self performSelector:@selector(_handleReadyState) withObject:nil afterDelay:timeInterval];
    }
}

- (void) _handleCancelState
{
#if TRACE
    GtLog(@"cancelling tasks");
#endif 

    GtAssert([NSThread isMainThread], @"not main thread");
	
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];
    for(id<GtBackgroundTask> task in m_queue)
	{
		[task cancelBackgroundTask:self];
	}
}

- (void) _cancelCurrentTask:(NSNotification*) sender
{
    m_timestamp = [NSDate timeIntervalSinceReferenceDate];
#if TRACE
    GtLog(@"got cancel event: new time stamp: %f. event: %@", m_timestamp, sender.name);
#endif
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];
    [self performSelectorOnMainThread:@selector(_handleCancelState) withObject:nil waitUntilDone:NO];
}

- (void) scheduleNextBackgroundTask
{
    m_timestamp = [NSDate timeIntervalSinceReferenceDate];
#if TRACE
    GtLog(@"got start event: new time stamp: %f, event: (called manually)", m_timestamp);
#endif

    [self performSelectorOnMainThread:@selector(_handleReadyState) withObject:nil waitUntilDone:NO];
}

- (void) _possiblyStartTask:(NSNotification*) sender
{
#if TRACE
    GtLog(@"got start event: %@", sender.name);
#endif

    [self scheduleNextBackgroundTask];
}

- (void) registerForEvents
{
// start events
	
	// action
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: GtActionContextDidFinishAllActionsNotification
			object: [GtActionContextManager instance]];

	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: GtActionContextWasActivated 
			object: [GtActionContextManager instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: GtUserSessionWillEnterForegroundNotification 
			object: [GtUserSession instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: GtUserSessionDidBecomeActiveNotification 
			object: [GtUserSession instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_possiblyStartTask:) 
			name: GtUserSessionOpenedNotification 
			object: [GtUserSession instance]];

// abort events

	// action
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_cancelCurrentTask:) 
			name: GtActionContextWillBeginActionNotification 
			object: [GtActionContextManager instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_cancelCurrentTask:) 
			name: GtUserSessionDidEnterBackgroundNotification 
			object: [GtUserSession instance]];

	// user session
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(_cancelCurrentTask:) 
			name: GtUserSessionWillResignActiveNotification 
			object: [GtUserSession instance]];

//	// user session
//	[[NSNotificationCenter defaultCenter] addObserver:self
//			selector:@selector(_abortCurrentTask:) 
//			name: GtUserSessionClosedNotification 
//			object: [GtUserSession instance]];
//
//	// user session
//	[[NSNotificationCenter defaultCenter] addObserver:self
//			selector:@selector(_abortCurrentTask:) 
//			name: GtUserSessionUserLoggedOutNotification 
//			object: [GtUserSession instance]];

}

- (void) _checkCancelState:(GtBlock) finishedBlock
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];

    m_timestamp = [NSDate timeIntervalSinceReferenceDate];
    m_cancelling = self.isExecutingBackgroundTask;

    if(m_cancelling)
    {
        [self performBlockWithDelay:0.25 block:^{
            [self _checkCancelState:finishedBlock];
            }];
    }
}

- (void) beginCancellingAllTasks:(GtBlock) finishedBlock
{
    [self _checkCancelState:GtReturnAutoreleased([finishedBlock copy])];
}

- (void) resetAllTasks
{
    GtAssert(!self.isExecutingBackgroundTask, @"can't reset while executing");

    for(id<GtBackgroundTask> task in m_queue)
    {
        [task resetBackgroundTask:self];
    }
}

@end



