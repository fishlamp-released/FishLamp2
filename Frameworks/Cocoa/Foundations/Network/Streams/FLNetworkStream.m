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
@property (readwrite, strong) NSError* error;
@end

@implementation FLNetworkStream
@synthesize asyncQueue = _asyncQueue;
@synthesize open = _open;
@synthesize error = _error;

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
    [self sendMessageToListeners:@selector(networkStreamWillOpen:)];
}

- (void) didOpen {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);

    self.open = YES;
    [self sendMessageToListeners:@selector(networkStreamDidOpen:)];
}

- (void) willClose {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);

    [self sendMessageToListeners:@selector(networkStreamWillClose:)];
}

- (void) didClose {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);

    self.open = NO;
    [self sendMessageToListeners:@selector(networkStreamDidClose:)];
}

- (void) encounteredBytesAvailable {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);
    [self sendMessageToListeners:@selector(networkStreamHasBytesAvailable:)];
}

- (void) encounteredCanAcceptBytes {
    FLAssert_([NSThread currentThread] != [NSThread mainThread]);
    [self sendMessageToListeners:@selector(networkStreamCanAcceptBytes:)];
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
    [self sendMessageToListeners:@selector(networkStream:encounteredError:) withObject:error];
}

- (NSError*) streamError {
    return nil;
}

- (void) openStreamWithDelegate:(id<FLNetworkStreamDelegate>) delegate 
                     asyncQueue:(FLFifoAsyncQueue*) asyncQueue {
    [self addListener:delegate];
    
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
