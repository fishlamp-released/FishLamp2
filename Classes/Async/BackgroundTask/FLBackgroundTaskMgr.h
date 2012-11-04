//
//  FLBackgroundTaskMgr.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/15/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLObservable.h"
#import "FLOperationQueue.h"
#import "FLAnswerable.h"

#import "FLService.h"

@class FLOperationContext;
@class FLBackgroundTaskMgr;

@protocol FLBackgroundTask <NSObject>

@property (readonly, assign, nonatomic) BOOL isExecuting;

/**
    The task manager queries the task to see if can run.
 */
- (BOOL) canBeginBackgroundTask:(FLBackgroundTaskMgr *)taskMgr;

/** 
    begin the task
 */
- (void) beginBackgroundTask:(FLBackgroundTaskMgr*) taskMgr;

/**
    called routinely when something overrides the behavior
 */
- (void) cancelBackgroundTask:(FLBackgroundTaskMgr*) taskMgr;

/** 
    this is called when all state should be dumped. for example, a user logs out;
 */
- (void) resetBackgroundTask:(FLBackgroundTaskMgr*) taskMgr;
@end

/** 
    FLBackgroundTaskMgr runs tasks in the background (from a UI point of view, not threading).
    The tasks actually run on the main thread, though the tasks can and probably 
    will kick off code that will run in a background thread.
    
    The API is not thread safe and expects to be called on the main thread.
 */

@interface FLBackgroundTaskMgr : FLService {
@private
	NSMutableArray* _queue;
    NSMutableArray* _sequenceQueue;
	FLOperationQueue* _operations;
	NSTimeInterval _timestamp;
    BOOL _cancelling;
    BOOL _enabled;
 }

/** 
    We have our own context which isn't tied to any UI element. 
 
    This means the actions are not automatically cancelled.
 */
@property (readonly, strong) FLOperationQueue* operations;

@property (readonly, assign) BOOL isExecutingBackgroundTask;

@property (readwrite, assign, getter=isEnabled) BOOL enabled;


/** add task to list. */
- (void) addBackgroundTask:(id<FLBackgroundTask>) task;

/** remove list from task */
- (void) removeBackgroundTask:(id<FLBackgroundTask>) task;

/**
    This tells the mgr it needs executing. Will schedule as appropriate. 
    Normally this isn't needed as it listens to many events.
 */
- (void) scheduleNextBackgroundTask;
- (void) scheduleNextBackgroundTaskWithDelay:(NSTimeInterval) timeInterval; // subsequent events cancel this out.

/** */
- (void) beginCancellingAllTasks:(FLObjectBlock) finishedBlock;
- (void) resetAllTasks;

@end

@protocol FLBackgroundTaskObserver <FLObserver>
@optional
//- (BOOL) backgroundTaskMgrCanBeginBackgroundTasks:(FLBackgroundTaskMgr*) mgr;
//- (BOOL) backgroundTaskMgr:(FLBackgroundTaskMgr*) mgr canBeginBackgroundTask:(id<FLBackgroundTask>) task;
//
//
- (void) backgroundTaskMgr:(FLBackgroundTaskMgr*) mgr canStart:(id<FLAnswerable>) answer;
- (void) backgroundTaskMgr:(FLBackgroundTaskMgr*) mgr canStart:(id<FLAnswerable>) answer backgroundTask:(id<FLAnswerable>) answer;

@end