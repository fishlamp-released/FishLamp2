//
//  FLTimer.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "NSError+FLTimeout.h"

extern NSString* const FLTimedOutNotification;

#define FLTimerDefaultCheckTimestampInterval 1.0f

@interface FLTimer : NSObject {
@private
    NSTimeInterval _timestamp;
    NSTimeInterval _timeoutInterval;
    NSTimeInterval _checkTimestampInterval;
    NSTimeInterval _startTime;
    NSTimeInterval _endTime;
    
    BOOL _timedOut;
    BOOL _timing;
    BOOL _postNotifications;
    dispatch_source_t _timer;
    
    __unsafe_unretained id _delegate;
    SEL _timerDidTimeout;
    SEL _timerWasUpdated;
}

// config
@property (readwrite, assign) NSTimeInterval timeoutInterval;
@property (readwrite, assign) NSTimeInterval checkTimestampInterval;

/// this will post to the NSNotificationCenter when timed out.
@property (readwrite, assign, nonatomic) BOOL postNotifications;

// info
@property (readonly, assign) NSTimeInterval startTime;
@property (readonly, assign) NSTimeInterval elapsedTime;
@property (readonly, assign, getter=hasTimedOut) BOOL timedOut;

// delegate
@property (readwrite, assign, nonatomic) id delegate;
@property (readwrite, assign, nonatomic) SEL timerDidTimeout;
@property (readwrite, assign, nonatomic) SEL timerWasUpdated;

// timer control
@property (readonly, assign, getter=isTiming) BOOL timing;
- (void) startTimer;
- (void) stopTimer;
- (void) restartTimer;

// last activity
@property (readonly, assign) NSTimeInterval timestamp;
- (void) touchTimestamp;

// construction
- (id) initWithTimeoutInterval:(NSTimeInterval) interval;
+ (FLTimer*) timer;
+ (FLTimer*) timer:(NSTimeInterval) timeoutInterval;
@end

@protocol FLTimerDelegate <NSObject>
@optional
- (void) timerDidTimeout:(FLTimer*) timer;
- (void) timerWasUpdated:(FLTimer*) timer;
@end