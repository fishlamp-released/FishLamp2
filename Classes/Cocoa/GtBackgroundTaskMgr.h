//
//  GtBackgroundTaskMgr.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/15/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class GtActionContext;
@class GtBackgroundTaskMgr;

@protocol GtBackgroundTask <NSObject>

@property (readonly, assign, nonatomic) BOOL isExecuting;

/**
    The task manager queries the task to see if can run.
 */
- (BOOL) canBeginBackgroundTask:(GtBackgroundTaskMgr *)taskMgr;

/** 
    begin the task
 */
- (void) beginBackgroundTask:(GtBackgroundTaskMgr*) taskMgr;

/**
    called routinely when something overrides the behavior
 */
- (void) cancelBackgroundTask:(GtBackgroundTaskMgr*) taskMgr;

/** 
    this is called when all state should be dumped. for example, a user logs out;
 */
- (void) resetBackgroundTask:(GtBackgroundTaskMgr*) taskMgr;
@end

@protocol GtBackgroundTaskMgrDelegate <NSObject>
@optional
- (BOOL) backgroundTaskMgrCanBeginBackgroundTasks:(GtBackgroundTaskMgr*) mgr;
- (BOOL) backgroundTaskMgr:(GtBackgroundTaskMgr*) mgr canBeginBackgroundTask:(id<GtBackgroundTask>) task;
@end

/** 
    GtBackgroundTaskMgr runs tasks in the background (from a UI point of view, not threading).
    The tasks actually run on the main thread, though the tasks can and probably 
    will kick off code that will run in a background thread.
    
    The API is not thread safe and expects to be called on the main thread.
 */

@interface GtBackgroundTaskMgr : NSObject {
@private
	NSMutableArray* m_queue;
    NSMutableArray* m_sequenceQueue;
	GtActionContext* m_actionContext;
	NSTimeInterval m_timestamp;
    NSMutableArray* m_delegates;
    BOOL m_cancelling;
}

/** 
    We have our own context which isn't tied to any UI element. 
 
    This means the actions are not automatically cancelled.
 */
@property (readonly, retain, nonatomic) GtActionContext* actionContext;

@property (readonly, assign, nonatomic) BOOL isExecutingBackgroundTask;

GtSingletonProperty(GtBackgroundTaskMgr);

- (void) addDelegate:(id<GtBackgroundTaskMgrDelegate>) delegate;
- (void) removeDelegate:(id<GtBackgroundTaskMgrDelegate>) delegate;

/**
    Call registerForEvents from your application delegate (or GtApplicationDelegate will call it if you're using that).
    This sets up the listeners for the different events that can kick off a background task.
 */
- (void) registerForEvents;

/** add task to list. */
- (void) addBackgroundTask:(id<GtBackgroundTask>) task;

/** remove list from task */
- (void) removeBackgroundTask:(id<GtBackgroundTask>) task;

/**
    This tells the mgr it needs executing. Will schedule as appropriate. 
    Normally this isn't needed as it listens to many events.
 */
- (void) scheduleNextBackgroundTask;
- (void) scheduleNextBackgroundTaskWithDelay:(NSTimeInterval) timeInterval; // subsequent events cancel this out.

/** */
- (void) beginCancellingAllTasks:(GtBlock) finishedBlock;
- (void) resetAllTasks;

@end

