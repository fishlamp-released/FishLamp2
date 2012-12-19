//
//  FLTimeoutTimer.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTimeoutTimer.h"

const NSTimeInterval FLTimeoutTimerDefaultCheckFrequencyInterval = 0.25;
const NSString* FLTimeoutTimerCheckEvent = @"com.fishlamp.timer.check";
const NSString* FLTimeoutTimerTimeoutEvent = @"com.fishlamp.timer.timedout";

@interface FLTimeoutTimer ()
@property (readwrite, strong) FLFinisher* finisher;
@property (readwrite, assign) NSTimeInterval timeoutInterval;
@property (readwrite, strong) NSTimer* timer;
@property (readwrite, assign) NSTimeInterval timestamp;
@property (readwrite, assign) BOOL timedOut;
@property (readwrite, strong) FLFinisher* cancelFinisher;
@end

@implementation FLTimeoutTimer
@synthesize timeoutInterval = _timeoutInterval;
@synthesize timestamp = _timestamp;
@synthesize finisher = _finisher;
@synthesize timer = _timer;
@synthesize timedOut = _timedOut;
@synthesize checkFrequency = _checkFrequency;
@synthesize cancelFinisher = _cancelFinisher;

- (id) initWithTimeoutInterval:(NSTimeInterval) interval {
    self = [super init];
    if(self) {
        self.timeoutInterval = interval;
    }
    return self;
}
- (NSTimeInterval) idleDuration {
    return [NSDate timeIntervalSinceReferenceDate] - self.timestamp;
}

+ (FLTimeoutTimer*) timeoutTimer:(NSTimeInterval) timeoutInterval {
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

- (void) _handleTimerEvent:(NSTimer*) timer {

#if TEST_TIMEOUT
    [NSThread sleepForTimeInterval:1.0f];
#endif
    
    if(self.isLate && !self.timedOut) {
        self.timedOut = YES;
        
        [self postObservation:@selector(timeoutTimerDidTimeout:)];
        
        [self.finisher setFinishedWithResult:[NSError timeoutError]];
        [self stopTimer];
    }
    else {
        [self postObservation:@selector(timeoutTimerCheckTimeout:)];
    }
    
//    if(FLTestAnyBit(_connectionState, FLNetworkConnectionStateConnecting | FLNetworkConnectionStateConnected)) {
//
//        NSTimeInterval idleDuration = [NSDate timeIntervalSinceReferenceDate] - _timestamp;
//        
//        if(CheckTimeout(idleDuration)) {
//            [self setConnectionDidFail:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:nil]];
//        }
//        else  {
//            [self _checkForIdleEvent:idleDuration];
//        }
//
//        [self connectionGotTimerEvent];
//    }
}

   
- (void) startWorking:(id) asyncTask {
    [self stopTimer];

    self.finisher = asyncTask;

    NSTimer* timer = [NSTimer timerWithTimeInterval:_checkFrequency
            target:self 
            selector:@selector(_handleTimerEvent:) 
            userInfo:nil 
            repeats:YES];
    self.timer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    

}

- (FLFinisher*) startTimer:(FLFinisher*) finisher{
    return [self startTimerWithFrequency:FLTimeoutTimerDefaultCheckFrequencyInterval finisher:finisher];
}

- (FLFinisher*) startTimerWithFrequency:(NSTimeInterval) checkFrequency
                                      finisher:(FLFinisher*) finisher  {
                                      
    FLAssertIsNil_v(self.finisher, @"already started");
    
    _checkFrequency = checkFrequency;
    [self startWorking:finisher];
    return finisher;
}

- (void) dealloc  {
    if(_timer) {
        [_timer invalidate];
    }

#if FL_MRC
    [_cancelFinisher release];
    [_timer release];
    [super dealloc];
#endif
}

- (BOOL) wasCancelled {
    return self.cancelFinisher && self.cancelFinisher.isFinished;
}

- (BOOL) cancelWasRequested {
    return self.cancelFinisher != nil;
}

- (void) stopTimer {

    NSTimer* timer = self.timer;
    if(timer) {
        [timer invalidate];
    }
    self.timer = nil;
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


@implementation NSError (FLTimeoutError)

+ (NSError*) timeoutError {
    return [NSError errorWithDomain:[FLFrameworkErrorDomain instance]
                                   code:FLCancelErrorCode
                   localizedDescription:NSLocalizedString(@"Cancelled", @"used in cancel error localized description")];
}

- (BOOL) isTimeoutError {
	return	FLStringsAreEqual(NSURLErrorDomain, self.domain) && 
			self.code == NSURLErrorTimedOut; 
}
@end

#if 0

@interface MyWatchdogTimer {
@private
    dispatch_source_t     _timer;
}

- (id)initWithTimeout:(NSTimeInterval)timeout;
- (void)invalidate;

@end

- (id)initWithTimeout:(NSTimeInterval)timeout {
    self = [super init];
    if (self) {            
        dispatch_queue_t queue = dispatch_get_global_queue(
                                    DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

        // create our timer source
        _timer = dispatch_source_create(
                           DISPATCH_SOURCE_TYPE_TIMER, 0, 0,
                           queue);

        // set the time to fire (we're only going to fire once,
        // so just fill in the initial time).
        dispatch_source_set_timer(_timer,
               dispatch_time(DISPATCH_TIME_NOW, timeout * NSEC_PER_SEC),
               DISPATCH_TIME_FOREVER, 0);

        // Hey, let's actually do something when the timer fires!
        dispatch_source_set_event_handler(_timer, ^{
            NSLog(@"WATCHDOG: task took longer than %f seconds",
                    timeout);
            // ensure we never fire again
            dispatch_source_cancel(_timer);
        });

        // now that our timer is all set to go, start it
        dispatch_resume(_timer);
    }
    return self;
}

- (void)dealloc {
    dispatch_source_cancel(_timer);
    dispatch_release(_timer);
    [super dealloc];
}

- (void)invalidate {
    _dispatch_source_cancel(_timer);
}
#endif
