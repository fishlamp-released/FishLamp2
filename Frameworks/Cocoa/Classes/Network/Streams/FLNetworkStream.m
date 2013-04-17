//
//  FLNetworkStream.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream_Internal.h"
#import "FLDispatch.h"
#import "FLNotificationSending.h"

@interface FLNetworkStream ()
@property (readwrite, assign, getter=isOpen) BOOL open;
@property (readwrite, strong) FLFifoAsyncQueue* asyncQueue;
@property (readwrite, strong) FLTimer* timer;
@property (readwrite, assign) NSTimeInterval idleDuration;
@end

@implementation FLNetworkStream
@synthesize asyncQueue = _asyncQueue;
@synthesize open = _open;
@synthesize delegate = _delegate;
@synthesize timer = _timer;
@synthesize streamSecurity = _streamSecurity;
@synthesize wasTerminated = _wasTerminated;
@synthesize idleDuration = _idleDuration;

- (id) init {
    return [self initWithStreamSecurity:FLNetworkStreamSecurityNone];
}

- (id) initWithStreamSecurity:(FLNetworkStreamSecurity) security {
    self = [super init];
    if(self) {
        _timer = [[FLTimer alloc] init];
        _timer.delegate = self;
        _streamSecurity = security;
    }
    return self;
}

- (void) dealloc {
    [_asyncQueue releaseToPool];
    _timer.delegate = nil;
#if FL_MRC
    [_asyncQueue release];
    [_timer release];
    [super dealloc];
#endif
}

- (void) startTimeoutTimer {
    NSTimeInterval timeoutInterval = [self.delegate networkStreamGetTimeoutInterval:self]; 
    if(timeoutInterval) {
        self.timer.timeoutInterval = timeoutInterval;
        [self.timer startTimer];
    }
}

- (void) willOpen {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);

    self.open = NO;
    self.wasTerminated = NO;
    FLPerformSelector1(self.delegate, @selector(networkStreamWillOpen:), self);
}

- (void) didOpen {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);

    self.open = YES;
    FLPerformSelector1(self.delegate, @selector(networkStreamDidOpen:), self);
}

- (void) didClose {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);

    self.open = NO;
    FLPerformSelector1(self.delegate, @selector(networkStreamDidClose:), self);
    [self.timer stopTimer];
    
    self.delegate = nil;
}

- (void) encounteredBytesAvailable {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    FLPerformSelector1(self.delegate, @selector(networkStreamHasBytesAvailable:), self);
}

- (void) encounteredCanAcceptBytes {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    FLPerformSelector1(self.delegate, @selector(networkStreamCanAcceptBytes:), self);
}

- (void) encounteredOpen {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    [self didOpen];
}

- (void) encounteredEnd {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    [self closeStream];
}

- (void) propagateError:(NSError*) error {
}

- (void) encounteredError:(NSError*) error {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    self.wasTerminated = YES;
    
// may already be set. all that matters is that the last error 
    FLPerformSelector2(self.delegate, @selector(networkStream:encounteredError:), self, error);
}

- (NSError*) streamError {
    return nil;
}

- (void) openStream {
}

- (void) closeStream {
}

- (void) openStreamWithDelegate:(id<FLNetworkStreamDelegate>) delegate 
                     asyncQueue:(FLFifoAsyncQueue*) asyncQueue {
    
    self.delegate = delegate;
    self.asyncQueue = asyncQueue;
    [self queueSelector:@selector(willOpen)];
    [self queueSelector:@selector(openStream)];
    [self queueSelector:@selector(startTimeoutTimer)];
}


- (void) terminateStream {
    self.wasTerminated = YES;
    self.delegate = nil;
    [self queueSelector:@selector(closeStream)];
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void) queueSelector:(SEL) selector withObject:(id) object {
    [self queueBlock:^{ 
        [self performSelector:selector withObject:object];
    }];
}

- (void) queueSelector:(SEL) selector {
    [self queueBlock:^{ 
    
        @try { 
            [self performSelector:selector];
        }
        @catch(NSException* ex) {
            self.wasTerminated = YES;
            FLLog(@"stream encountered secondary error: %@", [ex.error localizedDescription]);
        }
    }];
}

#pragma GCC diagnostic pop

- (void) queueBlock:(dispatch_block_t) block {
    [self.asyncQueue queueBlock:block completion:nil];
}

- (void) timerDidTimeout:(FLTimer*) timer {
    self.wasTerminated = YES;
    [self queueSelector:@selector(encounteredError:) withObject:[NSError timeoutError]];
}

- (void) touchTimeoutTimestamp {
    [self.timer  touchTimestamp];
}

- (void) timerWasUpdated:(FLTimer*) timer {

#if DEBUG
    if(timer.idleDuration - self.idleDuration > 5.0f) {
        FLLog(@"Server hasn't responded for %f seconds", timer.idleDuration);
        self.idleDuration = timer.idleDuration;
    }
#endif

}

+ (void) handleStreamEvent:(CFStreamEventType) eventType withStream:(FLNetworkStream*) stream {

    FLConfirmIsNotNil(stream);

//#if TRACE
//    FLDebugLog(@"Read Stream got event %d", eventType);
//#endif
    [stream touchTimeoutTimestamp];

    switch (eventType)  {

        // NOTE: HttpStream doesn't get this event.
        case kCFStreamEventOpenCompleted:
            [stream queueSelector:@selector(encounteredOpen)];
        break;

        case kCFStreamEventErrorOccurred:  
            stream.wasTerminated = YES;
            [stream queueSelector:@selector(encounteredError:) withObject:[stream streamError]];
        break;
        
        case kCFStreamEventEndEncountered:
            [stream queueSelector:@selector(encounteredEnd)];
        break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable:
            [stream queueSelector:@selector(encounteredBytesAvailable)];
        break;
            
        case kCFStreamEventCanAcceptBytes: 
            [stream queueSelector:@selector(encounteredCanAcceptBytes)];
            break;
    }
}

@end
