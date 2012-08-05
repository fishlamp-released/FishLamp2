//
//  FLNetworkConnection.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/4/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLNetworkConnection.h"
#import "FLGlobalNetworkActivityIndicator.h"
#import "FLReachableNetwork.h"

#import "_FLNetworkConnection.h"

const FLNetworkConnectionByteCount FLNetworkConnectionByteCountZero = {0, 0, 0};

@implementation FLNetworkConnection

@synthesize error = _error;
@synthesize timeoutInterval = _timeoutInterval;
@synthesize lastActivityTimestamp = _timestamp;
@synthesize retryCount = _retryCount;
@synthesize readByteCount = _readByteCount;
@synthesize writeByteCount = _writeByteCount;
@synthesize idleTimespan = _lastIdleTimeSpan;
@synthesize currentObserver = _currentObserver;
@synthesize thread = _thread;
@synthesize connectionState = _connectionState;
@synthesize connectionStateFlags = _connectionStateFlags;

- (id) init {
    if((self = [super init])) {
        self.timeoutInterval = FLNetworkConnectionDefaultTimeout;
    }
    
    return self;
}

- (void) visitObservers:(void (^)(FLNetworkConnectionObserver* observer, BOOL* stop)) visitor {
    id walker = _observers.firstObject;
    @try {
        BOOL stop = NO;
        while(walker && !stop) {
            _currentObserver = walker;
            walker = [walker nextObjectInLinkedList];
            visitor(_currentObserver, &stop);
        }
    }
    @finally {
        _currentObserver = nil;
    }
}

- (void) addObserver:(FLNetworkConnectionObserver*) observer {
    if(!_observers) {
        _observers = [[FLLinkedList alloc] init];
    }
    
    [_observers addObject:observer];
    
    FLNotifyObserver(self, observer, FLNetworkEventWillStartObserving);
    
//    if(observer.onStartedObserving) {
//        observer.onStartedObserving(self); 
//    }
}

- (void) addObserversInArray:(NSArray*) listOfObservers {
    for(FLNetworkConnectionObserver* observer in listOfObservers) {
        [self addObserver:observer];
    }
}

- (void) removeObserver:(FLNetworkConnectionObserver*) observer {

    FLNotifyObserver(self, observer, FLNetworkEventDidStopObserving);

//    if(observer.onStoppedObserving) {
//        observer.onStoppedObserving(self); 
//    }
//    [observer releaseBlocks];
    [_observers removeObject:observer];
}

- (void) dealloc  {
    
// these are last ditch safety measures    
    [self closeNetworkStreams];

    [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) { \

        FLNotifyObserver(self, observer, FLNetworkEventDidStopObserving);

//        if(observer.onStoppedObserving) {
//            observer.onStoppedObserving(self);
//        }
//        
//        [observer releaseBlocks];
    }];    

#if FL_DEALLOC
    FLRelease(_observers);
    FLRelease(_error);
    FLSuperDealloc();
#endif
}

- (NSTimeInterval) idleTimeInterval {
    return ([NSDate timeIntervalSinceReferenceDate] - _timestamp);
}

- (BOOL) _checkTimeout:(NSTimeInterval) idleSeconds {
#if TEST_TIMEOUT
    return _retryCount < _maxRetryCount;

    return YES;
#endif

	return (_timeoutInterval > 0.0f) && (idleSeconds > _timeoutInterval);
}

- (BOOL) hasTimedOut {
    return [self _checkTimeout:self.idleTimeInterval];
}

- (BOOL) isConnectionOpen {
    return NO;
}

- (void) connectionWasClosed {
}

- (void) closeNetworkStreams {
}

- (void) setError:(NSError*) error {
    [self updateLastActivityTimestamp];
    
    FLAssignObject(_error, error);
    if(_error) {
        FLDebugLog(@"stream received error: %@", [self.error localizedDescription]);

        [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) { \

            FLNotifyObserver(self, observer, FLNetworkEventOnError);

//            if(observer.onError) {
//                observer.onError(self);
//            }
        }];


// TODO: close on error, maybe should be an behavioral option?            
        if(_error) {
            [self closeConnection];
        }
    }
}

- (void) _closeSelf {
    if(self.connectionState >= FLNetworkConnectionStateConnecting) {
        self.connectionState = FLNetworkConnectionStateDisconnecting;
        [self closeNetworkStreams];
        [self connectionWasClosed];

        [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) { \

            FLNotifyObserver(self, observer, FLNetworkEventDidClose);

//            if(observer.onClose) {
//                observer.onClose(self);
//            }
        }];
    
        _connectionState = FLNetworkConnectionStateClosed;
    }

    FLBitSet(_connectionStateFlags, FLNetworkConnectionStateFlagFinished);

    [self _stopTimer];
}

- (void) closeConnection {

    if(_thread == [NSThread currentThread]) {
        [self _closeSelf];
    }
    else {
        [self visitConnection:^(id connection) {
            [connection _closeSelf];
        }];
    }
}

- (void) visitConnection:(void (^)(id connection)) callback {

    FLAssertIsNotNil(_thread);
    FLAssertIsNotNil(callback);

    callback = FLReturnAutoreleased([callback copy]);

    [self performBlock:^{
            if(callback) {
                callback(self);
            }
        }
        onThread:_thread];
}

- (void) _retry {
    _retryCount++;
    FLDebugLog(@"Retrying request. Retry count: %d", _retryCount);

    [self closeNetworkStreams];
    [self openConnectionOnCurrentThread];
}

- (BOOL) retryConnectionIfPossible {
    @synchronized(self) {
        if( _thread) {
            [self performSelector:@selector(_retry) onThread:_thread withObject:nil waitUntilDone:NO];
            return YES;
        }
    }
    return NO;
}

- (void) updateLastActivityTimestamp {
    _timestamp = [NSDate timeIntervalSinceReferenceDate];
}

- (void) _handleTimerEvent:(NSTimer*) timer {
#if TEST_TIMEOUT
    [NSThread sleepForTimeInterval:2.0f];
#endif
    
    if(self.connectionState >= FLNetworkConnectionStateConnecting) {

        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        NSTimeInterval idleSeconds = now - _timestamp;
        
        if([self _checkTimeout:idleSeconds]) {
            self.error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:nil];
        }
        else 
        {
            if(idleSeconds > 1.0f || _lastIdleTimeSpan > 0) {

                // optimization - send close idle event asap (better user experience)
                if(idleSeconds <= 1.0f) {
                    _lastIdleTimeSpan = 0;
                    [self connectionIsIdle];
                }
                else if(((now - _lastIdleEvent) >= 1.0f)) {
                    
                    if(idleSeconds <= 1.0f) {
                        _lastIdleTimeSpan = 0;
                    }
                    else {
                        _lastIdleTimeSpan = idleSeconds;
                    }
                
                    _lastIdleEvent = now;
                    
                    [self connectionIsIdle];
                }
            }
        
            [self connectionGotTimerEvent];
        }
    }
} 

- (void) _stopTimer {
    if(_timeoutTimer) {
        [_timeoutTimer invalidate];
        _timeoutTimer = nil;
    }
}

- (void) connectionGotTimerEvent {
}

- (void) connectionIsIdle {
    [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) { \

        FLNotifyObserver(self, observer, FLNetworkEventOnIdle);

//        if(observer.onIdle) {
//            observer.onIdle(self);
//        }
    }];
}

- (void) _streamFinishedOpening {
    self.connectionState = FLNetworkConnectionStateConnected;

    [self updateLastActivityTimestamp];

    [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) { \
        FLNotifyObserver(self, observer, FLNetworkEventDidOpen);

//        if(observer.onOpen) {
//            observer.onOpen(self);
//        }
    }];
}

- (void) connectionDidOpen {

    __block BOOL authenticating = NO;

//    [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) {
//        if(observer.onWillAuthenticate) {
//            self.connectionState = FLNetworkConnectionStateAuthenticating;
//            authenticating = YES;
//            observer.onWillAuthenticate(self);
//            *stop = YES;
//        }
//    }];

    if(!authenticating) {
        [self _streamFinishedOpening];
    }
}

- (void) connectionWillOpen {

    [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) { \
        FLNotifyObserver(self, observer, FLNetworkEventWillOpen);


//        if(observer.onWillOpen) {
//            observer.onWillOpen(self);
//        }
    }];
}

- (void) openNetworkStreams {
}

- (void) openConnectionOnThread:(NSThread*) thread {
    if(thread != [NSThread currentThread]) {
        [self performSelector:@selector(openConnectionOnCurrentThread) onThread:thread withObject:nil waitUntilDone:NO];
    }
}

- (void) finishAuthenticatingWithSuccess:(BOOL) success {
    if(success) {
        [self _streamFinishedOpening];

        [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) { \
            
            FLNotifyObserver(self, observer, FLNetworkEventDidAuthenticate);

//            if(observer.onDidAuthenticate) {
//                observer.onDidAuthenticate(self);
//            }
        }];
    }
    else {
        
        self.error = 
            [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorUserAuthenticationRequired localizedDescription:NSLocalizedString(@"Authentication Failed", nil)];

        [self closeConnection];
    }
}

- (BOOL) checkReachability {
#if IOS
	return [FLReachableNetwork instance].isReachable;
#else
    FLNotImplemented(@"check reachablity for OSX");
// TODO: this needs implementing
    return YES;
    
#endif
}

- (void) openConnectionOnCurrentThread {
    @try {
        if(self.connectionState >= FLNetworkConnectionStateConnecting) {
            [self closeNetworkStreams];
        }
        [self _stopTimer];

        _thread = nil;
        self.connectionState = FLNetworkConnectionStateClosed;
        FLReleaseWithNil(_error);

        FLBitClear(_connectionStateFlags, FLNetworkConnectionStateFlagFinished);

        _readByteCount  = FLNetworkConnectionByteCountZero;
        _writeByteCount = FLNetworkConnectionByteCountZero;
                
        if(![self checkReachability]) {
            NSError* error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet localizedDescription:NSLocalizedString(@"Not Connected to Network", nil)];
            if(error) {
                FLThrowError(error);
            }
        }
    
        self.connectionState = FLNetworkConnectionStateConnecting;
        
        _thread = [NSThread currentThread];
        
        [self updateLastActivityTimestamp];
        [self connectionWillOpen];
        [self openNetworkStreams];
                        
// TODO: this .25 for progress. It could be closer to 1 second if
// we don't need to report progress. We should be able to set this per
// connection for sure.        
        _timeoutTimer = [NSTimer timerWithTimeInterval:0.25f 
            target:self 
            selector:@selector(_handleTimerEvent:) 
            userInfo:nil 
            repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timeoutTimer forMode:NSDefaultRunLoopMode];
    }
    @catch(NSException* ex) {
        self.error = ex.error;
    }
}

//- (void) setFinishedAtomic {
//    FLBitSetAtomic(_stateInfo, FLNetworkConnectionStateFlagFinished);
//}
//
//- (BOOL) isFinished {
//    return FLBitTestAtomic(_stateInfo, FLNetworkConnectionStateFlagFinished);
//}

- (void) connectionDidFinish {
    [self closeConnection];
}

- (BOOL) waitOnceForRunLoop {
    if(!FLBitTest(_connectionStateFlags, FLNetworkConnectionStateFlagFinished)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        return YES;    
    }
    
    return NO;
}

- (void) blockUntilFinished {
    @try {
        FLRetain(self);
    
        while([self waitOnceForRunLoop]) {
        }
    }
    @finally {
        [self _closeSelf];
        FLRelease(self);
    }
}

- (void) openConnectionAsync:(FLNetworkConnectionBlock) finishedBlock {

    if(finishedBlock) {
        finishedBlock = FLReturnAutoreleased([finishedBlock copy]); 
    }   

// TODO: We could define our own thread and run them all on the same thread.
// We should investigate the perf of this.
// Perhaps we should have some sort of scheduler abstraction.

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
            [self openConnectionOnCurrentThread];
            [self blockUntilFinished];
        }
        @catch(NSException* ex) {
            if(!ex.error.isCancelError) {
                FLDebugLog(@"Error in network thread: %@", [ex description]);
            }
        }
        @finally {
            [self _closeSelf];
            _thread = nil;    

            if(finishedBlock) {
                finishedBlock(self);
            }
        }
    });
}


@end


