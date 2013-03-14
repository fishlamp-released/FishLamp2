//
//  FLNetworkStream.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLDispatch.h"

@interface FLNetworkStream ()
@property (readwrite, assign, getter=isOpen) BOOL open;
@property (readwrite, strong) FLFifoAsyncQueue* asyncQueue;
@property (readwrite, assign, nonatomic) id<FLNetworkStreamDelegate> delegate;
@property (readwrite, strong) NSError* error;
@end

@implementation FLNetworkStream
@synthesize asyncQueue = _asyncQueue;
@synthesize open = _open;
@synthesize error = _error;
@synthesize delegate = _delegate;

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (void) dealloc {
    [_asyncQueue releaseToPool];
#if FL_MRC
    [_error release];
    [super dealloc];
#endif
}

- (void) willOpen {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);

    self.open = NO;
    self.error = nil;
    FLPerformSelector1(self.delegate, @selector(networkStreamWillOpen:), self);
}

- (void) didOpen {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);

    self.open = YES;
    FLPerformSelector1(self.delegate, @selector(networkStreamDidOpen:), self);
}

- (void) willClose {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);

    FLPerformSelector2(self.delegate, @selector(networkStreamWillClose:), self, self.error);
}

- (void) didClose {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);

    self.open = NO;
    FLPerformSelector1(self.delegate, @selector(networkStreamDidClose:), self);
    _delegate = nil;
}

- (void) encounteredBytesAvailable {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);
    FLPerformSelector1(self.delegate, @selector(networkStreamHasBytesAvailable:), self);
}

- (void) encounteredCanAcceptBytes {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);
    FLPerformSelector1(self.delegate, @selector(networkStreamCanAcceptBytes:), self);
}

- (void) encounteredOpen {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);
    [self didOpen];
}

- (void) encounteredEnd {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);
    [self willClose];
}

- (void) encounteredError:(NSError*) error {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);
    self.error = error;
    FLPerformSelector2(self.delegate, @selector(networkStream:encounteredError:), self, error);
}

- (NSError*) streamError {
    return nil;
}

- (void) openStreamWithDelegate:(id<FLNetworkStreamDelegate>) delegate 
                     asyncQueue:(FLFifoAsyncQueue*) asyncQueue {
    self.delegate = delegate;
    self.asyncQueue = asyncQueue;
    [self queueSelector:@selector(willOpen)];
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

- (void) queueSelector:(SEL) selector withObject:(id) object {
    [self queueBlock:^{ 
        [self performSelector:selector withObject:object];
    }];
}

- (void) queueSelector:(SEL) selector {
    [self queueBlock:^{ 
        [self performSelector:selector];
    }];
}

- (void) queueBlock:(dispatch_block_t) block {
    [self.asyncQueue queueBlock:block];
}


+ (void) handleStreamEvent:(CFStreamEventType) eventType withStream:(FLNetworkStream*) stream {

    FLConfirmIsNotNil_(stream);


//    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

//#if TRACE
//    FLDebugLog(@"Read Stream got event %d", eventType);
//#endif

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
