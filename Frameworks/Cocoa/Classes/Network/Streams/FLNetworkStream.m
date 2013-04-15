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
#import "FLFifoQueueNetworkStreamEventHandler.h"

@interface FLNetworkStream ()
@property (readwrite, assign, getter=isOpen) BOOL open;
@property (readwrite, strong) id<FLNetworkStreamEventHandler> eventHandler;
@property (readwrite, strong) FLTimer* timer;
@end

@implementation FLNetworkStream
@synthesize eventHandler = _eventHandler;
@synthesize open = _open;
@synthesize delegate = _delegate;
@synthesize timer = _timer;
@synthesize streamSecurity = _streamSecurity;
@synthesize wasTerminated = _wasTerminated;

static Class s_eventHandlerClass = nil;

+ (Class) defaultEventHandlerClass {
    return s_eventHandlerClass;
}

+ (void) setDefaultEventHandlerClass:(Class) aClass {
    s_eventHandlerClass  = aClass;
}

+ (void) initialize {
    if(!s_eventHandlerClass) {
        s_eventHandlerClass = [FLFifoQueueNetworkStreamEventHandler class];
    }
}

- (id) init {
    return [self initWithStreamSecurity:FLNetworkStreamSecurityNone];
}

- (id) initWithStreamSecurity:(FLNetworkStreamSecurity) security
                 eventHandler:(id<FLNetworkStreamEventHandler>) eventHandler {
                 
    self = [super init];
    if(self) {
        _timer = [[FLTimer alloc] init];
        _timer.delegate = self;
        _streamSecurity = security;
        
        if(!eventHandler) {
            eventHandler = [s_eventHandlerClass networkStreamEventHandler];
        }
        
        self.eventHandler = eventHandler;
    }
    return self;
}

- (id) initWithStreamSecurity:(FLNetworkStreamSecurity) security {
    return [self initWithStreamSecurity:security eventHandler:nil];
}

- (void) dealloc {
    _timer.delegate = nil;
#if FL_MRC
    [_eventHandler release];
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
    [self.eventHandler streamDidClose:self];
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
    FLPerformSelector2(self.delegate, @selector(networkStream:encounteredError:), self, error);
}

- (NSError*) streamError {
    return nil;
}

- (void) openStream {
}

- (void) closeStream {
}

- (void) openStreamWithDelegate:(id<FLNetworkStreamDelegate>) delegate {
    FLAssertNotNil(delegate);
    FLAssertNotNil(self.eventHandler);

    self.delegate = delegate;
    [self.eventHandler streamWillOpen:self completion:^{
        [self.eventHandler queueSelector:@selector(willOpen)];
        [self.eventHandler queueSelector:@selector(openStream)];
        [self.eventHandler queueSelector:@selector(startTimeoutTimer)];
    }];
}

- (void) terminateStream {
    self.wasTerminated = YES;
    self.delegate = nil;
    [self.eventHandler queueSelector:@selector(closeStream)];
}

- (void) timerDidTimeout:(FLTimer*) timer {
    self.wasTerminated = YES;
    [self.eventHandler queueSelector:@selector(encounteredError:) withObject:[NSError timeoutError]];
}

- (void) touchTimeoutTimestamp {
    [self.timer  touchTimestamp];
}

@end
