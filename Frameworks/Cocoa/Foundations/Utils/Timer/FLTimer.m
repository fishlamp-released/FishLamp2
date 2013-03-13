//
//  FLTimer.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTimer.h"

NSString* const FLTimerCheckEvent = @"com.fishlamp.timer.check";
NSString* const FLTimerTimeOutNotification = @"FLTimerTimeOutNotification";

@interface FLTimer ()
@property (readwrite, assign) NSTimeInterval startTime;
@property (readwrite, assign) NSTimeInterval endTime;
@property (readwrite, assign) BOOL timedOut;
@property (readwrite, assign) NSTimeInterval timestamp;
@property (readwrite, assign, getter=isTiming) BOOL timing;
@end

@implementation FLTimer
@synthesize timeoutInterval = _timeoutInterval;
@synthesize timestamp = _timestamp;
@synthesize timedOut = _timedOut;
@synthesize checkTimestampInterval = _checkTimestampInterval;
@synthesize postNotifications = _postNotifications;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize timing = _timing;

@synthesize delegate = _delegate;
@synthesize timerDidTimeout = _timerDidTimeout;
@synthesize timerWasUpdated = _timerWasUpdated;

- (id) init {
    return [self initWithTimeoutInterval:FLTimerDefaultCheckTimestampInterval];
}

- (id) initWithTimeoutInterval:(NSTimeInterval) interval {
    self = [super init];
    if(self) {
        self.timeoutInterval = interval;
        self.timerDidTimeout = @selector(timerDidTimeout:);
        self.timerWasUpdated = @selector(timerWasUpdated:);
    }
    return self;
}

- (NSTimeInterval) idleDuration {
    return [NSDate timeIntervalSinceReferenceDate] - self.timestamp;
}

+ (FLTimer*) timeoutTimer:(NSTimeInterval) timeoutInterval {
    return FLAutorelease([[[self class] alloc] initWithTimeoutInterval:timeoutInterval]);
}

+ (id) timeoutTimer {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) isLate {

#if TEST_TIMEOUT
    return YES;
#endif

    return ((_timeoutInterval > 0.0f) && (self.idleDuration > _timeoutInterval));
}

//- (void) _handleTimerEvent:(NSTimer*) timer {
//
//#if TEST_TIMEOUT
//    [NSThread sleepForTimeInterval:1.0f];
//#endif
//    
//    
////    if(FLTestAnyBit(_connectionState, FLNetworkConnectionStateConnecting | FLNetworkConnectionStateConnected)) {
////
////        NSTimeInterval idleDuration = [NSDate timeIntervalSinceReferenceDate] - _timestamp;
////        
////        if(CheckTimeout(idleDuration)) {
////            [self setConnectionDidFail:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:nil]];
////        }
////        else  {
////            [self _checkForIdleEvent:idleDuration];
////        }
////
////        [self connectionGotTimerEvent];
////    }
//}

- (void) checkForTimeout {
    
    FLPerformSelector1(_delegate, _timerWasUpdated, self);

    if(self.isLate) {
        if(!FLPerformSelector1(_delegate, _timerDidTimeout, self)) {
            self.timedOut = YES;
            [self stopTimer];
        }
        
        if(_postNotifications) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:FLTimedOutNotification object:self];
            });
        }
    }
}

- (NSTimeInterval) elapsedTime {
    return self.isTiming ? 
        [NSDate timeIntervalSinceReferenceDate] - self.startTime :
        self.endTime - self.startTime;
}
   
- (void) startTimer {
    self.timedOut = NO;
    self.timing = YES;
    self.startTime = [NSDate timeIntervalSinceReferenceDate];
    self.endTime = 0;
    
    [self stopTimer];

    dispatch_queue_t queue = dispatch_get_global_queue(
                                    DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // create our timer source
    _timer = dispatch_source_create(
                       DISPATCH_SOURCE_TYPE_TIMER, 0, 0,
                       queue);

    // set the time to fire (we're only going to fire once,
    // so just fill in the initial time).
    dispatch_source_set_timer(_timer,
           dispatch_time(DISPATCH_TIME_NOW, _checkTimestampInterval * NSEC_PER_SEC),
           DISPATCH_TIME_FOREVER, 
           0);

    // Hey, let's actually do something when the timer fires!
    dispatch_source_set_event_handler(_timer, ^{
        [self checkForTimeout];
    });

    // now that our timer is all set to go, start it
    dispatch_resume(_timer);
}

- (void) dealloc  {
    [self stopTimer];

#if FL_MRC
    [super dealloc];
#endif
}

- (void) stopTimer {
    if(_timer) {
        dispatch_source_cancel(_timer);
        dispatch_release(_timer);
    }
    _timer = nil;
    self.timing = NO;
    self.endTime = [NSDate timeIntervalSinceReferenceDate];
}

- (void) restartTimer {
    [self stopTimer];
    [self startTimer];
}

- (void) touchTimestamp {
    self.timestamp = [NSDate timeIntervalSinceReferenceDate];
}

#if 0
- (void) _checkForIdleEvent:(NSTimeInterval) idleDuration {
    
    if(idleDuration <= 1.0 && self.isIdle) {
        self.idle = NO;
        [self connectionIsIdle:0];
    }

    if(idleDuration > 1.0f) {
        self.idle = YES;
        [self connectionIsIdle:idleDuration];
    }
}

- (void) connectionIsIdle:(NSTimeInterval) idleDuration {
    [self visitObservers:^(id observer, BOOL* stop) {
        if([observer respondsToSelector:@selector(networkConnection:idleSince:idleDuration:)]) {
            [observer networkConnection:self idleSince:self.lastActivityTimestamp idleDuration:idleDuration];
        }
    }];
}

#endif


@end


//#if 0
//
//@interface MyWatchdogTimer {
//@private
//    dispatch_source_t     _timer;
//}
//
//- (id)initWithTimeout:(NSTimeInterval)timeout;
//- (void)invalidate;
//
//@end
//
//- (id)initWithTimeout:(NSTimeInterval)timeout {
//    self = [super init];
//    if (self) {            
//        dispatch_queue_t queue = dispatch_get_global_queue(
//                                    DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//        // create our timer source
//        _timer = dispatch_source_create(
//                           DISPATCH_SOURCE_TYPE_TIMER, 0, 0,
//                           queue);
//
//        // set the time to fire (we're only going to fire once,
//        // so just fill in the initial time).
//        dispatch_source_set_timer(_timer,
//               dispatch_time(DISPATCH_TIME_NOW, timeout * NSEC_PER_SEC),
//               DISPATCH_TIME_FOREVER, 0);
//
//        // Hey, let's actually do something when the timer fires!
//        dispatch_source_set_event_handler(_timer, ^{
//            NSLog(@"WATCHDOG: task took longer than %f seconds",
//                    timeout);
//            // ensure we never fire again
//            dispatch_source_cancel(_timer);
//        });
//
//        // now that our timer is all set to go, start it
//        dispatch_resume(_timer);
//    }
//    return self;
//}
//
//- (void)dealloc {
//    dispatch_source_cancel(_timer);
//    dispatch_release(_timer);
//    [super dealloc];
//}
//
//- (void)invalidate {
//    _dispatch_source_cancel(_timer);
//}
//#endif

