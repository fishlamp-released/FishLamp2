//
//  FLTimeoutTimer.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTimeoutTimer.h"

@interface FLTimeoutTimer ()
@property (readwrite, strong) id<FLFinisher> finisher;
@property (readwrite, assign) NSTimeInterval timeoutInterval;
@property (readwrite, strong) NSTimer* timer;
@property (readwrite, assign) NSTimeInterval timestamp;
@property (readwrite, assign) BOOL timedOut;
@property (readwrite, assign) NSThread* thread;
@end

@implementation FLTimeoutTimer
@synthesize timeoutInterval = _timeoutInterval;
@synthesize timestamp = _timestamp;
//@synthesize idle = _idle;
@synthesize thread = _thread;
@synthesize finisher = _finisher;
@synthesize timer = _timer;
@synthesize timedOut = _timedOut;

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
    return autorelease_([[[self class] alloc] initWithTimeoutInterval:timeoutInterval]);
}

+ (FLTimeoutTimer*) timeoutTimer {
    return [self create];
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
        
        [self.finisher setFinishedWithError:[NSError timeoutError]];
        [self requestCancel];
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

- (void) killTimer {
    NSTimer* timer = self.timer;
    if(timer) {
        [timer invalidate];
    }
    self.timer = nil;
}    
    
- (void) startWorking:(id<FLFinisher>) finisher {
    [self killTimer];

// TODO: this .25 for progress. It could be closer to 1 second if
// we don't need to report progress. We should be able to set this per
// connection for sure.        
    self.timer = [NSTimer timerWithTimeInterval:0.25f
            target:self 
            selector:@selector(_handleTimerEvent:) 
            userInfo:nil 
            repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (id<FLPromisedResult>) start:(FLResultBlock) completion {
    FLAssertIsNotNil_v(self.finisher, @"already started");
    
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:completion];
    self.finisher = finisher;
    [self startWorking:finisher];
    return finisher;
}

- (FLResult) runSynchronously {
    return [[self start:nil] waitForResult];
}

- (void) dealloc  {
    if(_timer) {
        [_timer invalidate];
    }

#if FL_MRC
    [_timer release];
    [super dealloc];
#endif
}

- (void) requestCancel {
    @synchronized(self) {
        [self killTimer];
        self.finisher = nil;
    }
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
    return [NSError errorWithDomain:FLFrameworkErrorDomainName
                                   code:FLCancelErrorCode
                   localizedDescription:NSLocalizedString(@"Cancelled", @"used in cancel error localized description")];
}

- (BOOL) isTimeoutError {
	return	FLStringsAreEqual(NSURLErrorDomain, self.domain) && 
			self.code == NSURLErrorTimedOut; 
}
@end
