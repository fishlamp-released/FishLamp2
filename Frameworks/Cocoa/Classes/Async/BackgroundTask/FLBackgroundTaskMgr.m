//
//  FLBackgroundTaskMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/15/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLBackgroundTaskMgr.h"
#import "FLOperationContext.h"
#import "FLService.h"

#define kDelay 0.5f

@interface FLBackgroundTaskMgr ()
- (void) _handleReadyState;
@end

@implementation FLBackgroundTaskMgr

FLSynthesizeSingleton(FLBackgroundTaskMgr);

@synthesize operations = _operations;
@synthesize enabled = _enabled;

- (id) init {
	if((self = [super init]))
	{
        _queue = [[NSMutableArray alloc] init];
		_operations = [[FLOperationQueue alloc] init];
	    _sequenceQueue = [[NSMutableArray alloc] init];


FIXME("attach to user sessions....");
//        [[FLUserService instance] addObserver:self];
        

    // start events
        
        // action
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                selector:@selector(_possiblyStartTask:) 
//                name: FLActionContextDidFinishAllActionsNotification
//                object: nil];
//
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                selector:@selector(_possiblyStartTask:) 
//                name: FLActionContextWasActivated 
//                object: nil];


     // abort events

        // action
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                selector:@selector(_cancelCurrentTask:) 
//                name: FLActionContextWillBeginActionNotification 
//                object: [FLActionContextManager instance]];

#if IOS
FIXME("operation context");

        FLAssertFailedWithComment(@"need to register for context events");

//        [[FLApplication instance].operationContextManager addObserver:self];

        [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(_possiblyStartTask:) 
                name: UIApplicationDidBecomeActiveNotification
                object: [UIApplication sharedApplication]];

        [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(_cancelCurrentTask:) 
                name: UIApplicationWillResignActiveNotification
                object:  [UIApplication sharedApplication]];
#endif

    }
	
	return self;
}

+ (id) backgroundTaskMgr {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
#if IOS
//    [[FLApplication instance].operationContextManager removeObserver:self];
#endif

FIXME("attach to user sessions....");
//    [[FLUserService instance] removeObserver:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    FLRelease(_sequenceQueue);
	FLRelease(_operations);
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

- (BOOL) canBeginTasks {
    return NO;
//    return [self postQuestion:@selector(backgroundTaskMgr:canStart:) defaultAnswer:YES];
}

- (BOOL) canBeginBackgroundTask:(id<FLBackgroundTask>) task {
    return NO;
//    return [self postQuestion:@selector(backgroundTaskMgr:canStart:backgroundTask:) defaultAnswer:YES withObject:task];
}

- (void) _handleReadyState
{
    FLAssertWithComment([NSThread isMainThread], @"not main thread");
    
    if([NSDate timeIntervalSinceReferenceDate] - _timestamp > kDelay && !_cancelling)
    {
        _timestamp = [NSDate timeIntervalSinceReferenceDate];
        
        FLTrace(@"starting background tasks");

        if([self canBeginTasks])
        {
            // find next one in queue that needs executing
            for(id<FLBackgroundTask> task in _queue)
            {
                if(task.isExecuting)
                {

                    FLDebugLog(@"Task: %@ already excuting", NSStringFromClass([task class]));

                    return;
                }
            }
        
            if(_sequenceQueue.count == 0)
            {

                FLTrace(@"re-populating queue: %@", [_queue description]);
  
                [_sequenceQueue addObjectsFromArray:_queue];
            }
           
            while(_sequenceQueue.count > 0)
            {
                id<FLBackgroundTask> task = [_sequenceQueue objectAtIndex:0];
                [_sequenceQueue removeObjectAtIndex:0];

                if([self canBeginBackgroundTask:task])
                {

                    FLTrace(@"pinging background Task: %@", NSStringFromClass([task class]));
                
                    if([task canBeginBackgroundTask:self])
                    {

                        FLTrace(@"task says yes please, I'll execute: %@", NSStringFromClass([task class]));

                        [task beginBackgroundTask:self];
    
                        if(task.isExecuting)
                        {

                            FLTrace(@"task executing async, stopping queue processing: %@", NSStringFromClass([task class]));
   
                            break;
                        }

                        else
                        {
                            FLTrace(@"task executed sync. All done: %@", NSStringFromClass([task class]));
                        }
                        
                    }

                    else
                    {
                            FLTrace(@"task says no thanks, won't execute: %@", NSStringFromClass([task class]));
                    }
                    
                }
            }
            
        }
    }
    else
    {

        FLTrace(@"delaying ready state");
 
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];
        [self performSelector:@selector(_handleReadyState) withObject:nil afterDelay:(kDelay * 0.5)];
    }
}

- (void) scheduleNextBackgroundTaskWithDelay:(NSTimeInterval) timeInterval
{
    if(timeInterval > 0)
    {

        FLTrace(@"Delaying executing by: %f seconds", timeInterval);

        _timestamp = [NSDate timeIntervalSinceReferenceDate];
        [self performSelector:@selector(_handleReadyState) withObject:nil afterDelay:timeInterval];
    }
}

- (void) _handleCancelState {

    FLTrace(@"cancelling tasks");
    FLAssertWithComment([NSThread isMainThread], @"not main thread");
	
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];
    for(id<FLBackgroundTask> task in _queue)
	{
		[task cancelBackgroundTask:self];
	}
}

- (void) _cancel {
    _timestamp = [NSDate timeIntervalSinceReferenceDate];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_handleReadyState) object:nil];
    [self performSelectorOnMainThread:@selector(_handleCancelState) withObject:nil waitUntilDone:NO];
}

- (void) _cancelCurrentTask:(NSNotification*) sender
{
    [self _cancel];
    FLTrace(@"got cancel event: new time stamp: %f. event: %@", _timestamp, sender.name);
}

- (void) scheduleNextBackgroundTask {
    _timestamp = [NSDate timeIntervalSinceReferenceDate];
    FLTrace(@"got start event: new time stamp: %f, event: (called manually)", _timestamp);
    [self performSelectorOnMainThread:@selector(_handleReadyState) withObject:nil waitUntilDone:NO];
}

- (void) _possiblyStartTask:(NSNotification*) sender {
    FLTrace(@"got start event: %@", sender.name);
    [self scheduleNextBackgroundTask];
}

FIXME("attach to user sessions....");


- (void) openService {
    [self scheduleNextBackgroundTask];
}

- (void) closeService {
    [self _cancel];
    [self resetAllTasks];
}

- (BOOL) isEnabled {
    @synchronized(self) {
        return _enabled;
    }
}

- (void) setEnabled:(BOOL) enabled {
    @synchronized(self) {
        _enabled = enabled;
        
        if(_enabled) {
            [self scheduleNextBackgroundTask];
        }
        else {
            [self _cancel];
        }
    }
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
    [self _checkCancelState:FLAutorelease([finishedBlock copy])];
}

- (void) resetAllTasks
{
    FLAssertWithComment(!self.isExecutingBackgroundTask, @"can't reset while executing");

    for(id<FLBackgroundTask> task in _queue)
    {
        [task resetBackgroundTask:self];
    }
}

- (void) operationQueue:(FLOperationQueue*) queue operationWillRun:(FLOperation*) operation {
    [self _cancel];
}

- (void) operationQueue:(FLOperationQueue*) queue operationDidFinish:(FLOperation*) operation {
    [self scheduleNextBackgroundTask];
}

- (void) operationContextManager:(FLOperationContextManager*) manager
             contextWasActivated:(FLOperationContext*) queue {
//    [queue addObserver:self];
}

- (void) operationContextManager:(FLOperationContextManager*) manager
           contextWasDeactivated:(FLOperationContext*) queue {
//    [queue removeObserver:self];
}
@end



