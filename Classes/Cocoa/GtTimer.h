//
//	GtTimer.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/14/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtCallbackObject.h"
#import "GtWeakReference.h" 
#import "GtCallback.h"
 
@interface GtWeaklyReferencedTimer : NSObject {
	GtWeakReference* m_target;
	SEL m_action;
	NSTimer* m_timer;
}

- (id) initWithWeaklyReferencedTarget:(id) target action:(SEL) action;

- (void)startTimerWithTimeInterval:(NSTimeInterval) interval 
	repeats:(BOOL) repeats
	inRunLoop:(NSRunLoop*) runLoop;
	
- (void) stopTimer;

@end 

@protocol GtTimerDelegate;
 
@interface GtTimer : NSObject {
@private
	NSTimeInterval m_startTime;
	NSTimeInterval m_endTime;
	NSTimeInterval m_lastUpdateTimeStamp;
	NSTimeInterval m_timeoutInterval;
	NSTimeInterval m_lastTimeoutCheck;
	GtCallback m_timeoutCallback;
	GtWeaklyReferencedTimer* m_timer;
	
	id<GtTimerDelegate> m_delegate;
	struct {
		unsigned int isTiming:1;
		unsigned int logEvents:1;
	} m_timerFlags;
}

@property (readwrite, assign) id<GtTimerDelegate> delegate;	 
 
@property (readwrite, assign) BOOL logEvents;

@property (readonly, assign) NSTimeInterval timeoutInterval;
@property (readonly, assign) NSTimeInterval startTime;
@property (readonly, assign) NSTimeInterval endTime;
@property (readonly, assign) NSTimeInterval lastUpdateTimeStamp;
@property (readonly, assign) BOOL isTiming;
@property (readonly, assign) NSTimeInterval elapsedTime;

- (void) startTiming:(NSRunLoop*) inRunLoop;
- (void) startTimeoutTimer:(NSRunLoop*) inRunLoop timeout:(NSTimeInterval) timeout target:(id) target action:(SEL) action;
- (void) stopTiming;

- (void) updateTimeStamp;

// only need to call this to manually restart timer after callback (from your timeout callback).
- (void) restartTimeoutTimer:(NSRunLoop*) inRunLoop;

@end

@protocol GtTimerDelegate <NSObject>
@optional
- (void) timer:(GtTimer*) timer describeTimedObjectToBuilder:(GtStringBuilder*) builder;

@end 

