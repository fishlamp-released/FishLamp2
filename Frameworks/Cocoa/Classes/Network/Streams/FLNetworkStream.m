//
//  FLNetworkStream.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLDispatch.h"
#import "FLNotificationSending.h"

@interface FLNetworkStream ()
@property (readwrite, assign, getter=isOpen) BOOL open;
@property (readwrite, strong) FLFifoAsyncQueue* asyncQueue;
@property (readwrite, strong) NSError* error;
@property (readwrite, strong) FLTimer* timer;
@end

@implementation FLNetworkStream
@synthesize asyncQueue = _asyncQueue;
@synthesize open = _open;
@synthesize error = _error;
@synthesize delegate = _delegate;
@synthesize timer = _timer;

- (id) init {
    self = [super init];
    if(self) {
        _timer = [[FLTimer alloc] init];
        _timer.delegate = self;
    }
    return self;
}

- (void) dealloc {
    [_asyncQueue releaseToPool];
    _timer.delegate = nil;
#if FL_MRC
    [_asyncQueue release];
    [_timer release];
    [_error release];
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

- (id) notificationListener {
    return self.delegate;
}

- (void) willOpen {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);

    self.open = NO;
    self.error = nil;
    [self sendNotification:@selector(networkStreamWillOpen:) withObject:self];
}

- (void) didOpen {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);

    self.open = YES;
    [self sendNotification:@selector(networkStreamDidOpen:) withObject:self];
}

- (void) willClose {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);

    [self sendNotification:@selector(networkStreamWillClose:) withObject:self];
}

- (void) didClose {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);

    self.open = NO;
    [self sendNotification:@selector(networkStreamDidClose:) withObject:self];
    [self.timer stopTimer];
}

- (void) encounteredBytesAvailable {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    [self sendNotification:@selector(networkStreamHasBytesAvailable:) withObject:self];
}

- (void) encounteredCanAcceptBytes {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    [self sendNotification:@selector(networkStreamCanAcceptBytes:) withObject:self];
}

- (void) encounteredOpen {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    [self didOpen];
}

- (void) encounteredEnd {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    [self willClose];
}

- (void) encounteredError:(NSError*) error {
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
    self.error = error;
    [self sendNotification:@selector(networkStream:encounteredError:) withObject:self withObject:error];
}

- (NSError*) streamError {
    return nil;
}

- (void) openStreamWithDelegate:(id<FLNetworkStreamDelegate>) delegate 
                     asyncQueue:(FLFifoAsyncQueue*) asyncQueue {
    self.delegate = delegate;
    self.asyncQueue = asyncQueue;
    [self queueSelector:@selector(willOpen)];
    [self queueSelector:@selector(startTimeoutTimer)];
}

- (void) closeStream {
    [self closeStreamWithError:nil];
}

- (void) closeStreamWithError:(NSError*) error {
    if(error) {
        self.error = error;
    }
    [self queueSelector:@selector(willClose)];
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
            if(self.error == nil) {
                self.error = ex.error;
            }
            else {
                FLLog(@"stream encountered secondary error: %@", [ex.error localizedDescription]);
            }
        }
    }];
}

#pragma GCC diagnostic pop

- (void) queueBlock:(dispatch_block_t) block {
    [self.asyncQueue queueBlock:block completion:nil];
}

- (void) timerDidTimeout:(FLTimer*) timer {
    [self queueSelector:@selector(encounteredError:) withObject:[NSError timeoutError]];
}

- (void) touchTimeoutTimestamp {
    [self.timer  touchTimestamp];
}

+ (void) handleStreamEvent:(CFStreamEventType) eventType withStream:(FLNetworkStream*) stream {

    FLConfirmIsNotNil(stream);


//    FLAssertWithComment([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

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
