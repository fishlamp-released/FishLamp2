//
//	FLTimer.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/14/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLCallbackObject.h"
#import "FLWeakReference.h" 
#import "FLCallback_t.h"

@interface FLWeaklyReferencedTimer : NSObject {
@private
	FLWeakReference* _target;
	SEL _action;
	NSTimer* _timer;
}

- (id) initWithWeaklyReferencedTarget:(id) target action:(SEL) action;

- (void)startTimerWithTimeInterval:(NSTimeInterval) interval 
	repeats:(BOOL) repeats
	inRunLoop:(NSRunLoop*) runLoop;
	
- (void) stopTimer;

@end 

@protocol FLTimerDelegate;
 
@interface FLTimer : NSObject {
@private
	NSTimeInterval _startTime;
	NSTimeInterval _endTime;
	NSTimeInterval _lastUpdateTimeStamp;
	NSTimeInterval _timeoutInterval;
	NSTimeInterval _lastTimeoutCheck;
	FLCallback_t _timeoutCallback;
	FLWeaklyReferencedTimer* _timer;
	
    __unsafe_unretained id<FLTimerDelegate> _delegate;
	struct {
		unsigned int isTiming:1;
		unsigned int logEvents:1;
	} _timerFlags;
}

@property (readwrite, assign) id<FLTimerDelegate> delegate;	 
 
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

@protocol FLTimerDelegate <NSObject>
@optional
//- (void) timer:(FLTimer*) timer describeTimedObjectToBuilder:(FLFancyString*) builder;

@end 

