//
//  FLNetworkStream.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"

@interface FLNetworkStream ()
@property (readwrite, assign, getter=isOpen) BOOL open;
@end

@implementation FLNetworkStream

@synthesize open = _open;
@synthesize error = _error;
@synthesize delegate = _delegate;

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_error release];
    [super dealloc];
}
#endif

//- (void) addDelegate:(id<FLNetworkStreamDelegate>) delegate {
//    if(!_delegates) {
//        _delegates = [[NSMutableArray alloc] initWithCapacity:3];
//    }
//
//    [_delegates addObject: [NSValue valueWithNonretainedObject:delegate]];
//}
//- (void) removeDelegate:(id<FLNetworkStreamDelegate>) delegate {
//    [_delegates removeObject: [NSValue valueWithNonretainedObject:delegate]];
//}

- (void) encounteredError:(NSError*) error {
    self.error = error;
        FLPerformSelector2(self.delegate, @selector(networkStream:encounteredError:), self, error);
}

- (void) willOpen {
    self.open = NO;
    self.error = nil;
    FLPerformSelector1(self.delegate, @selector(networkStreamWillOpen:), self);
}

- (void) didOpen {
    self.open = YES;
    FLPerformSelector1(self.delegate, @selector(networkStreamDidOpen:), self);
}

- (void) willClose {
    FLPerformSelector2(self.delegate, @selector(networkStreamWillClose:), self, self.error);
}

- (void) didClose {
    self.open = NO;
    FLPerformSelector1(self.delegate, @selector(networkStreamDidClose:), self);
    _delegate = nil;
}

- (void) encounteredBytesAvailable {
    FLPerformSelector1(self.delegate, @selector(networkStreamHasBytesAvailable:), self);
}

- (void) encounteredCanAcceptBytes {
    FLPerformSelector1(self.delegate, @selector(networkStreamCanAcceptBytes:), self);
}

- (void) encounteredOpen {
    [self didOpen];
}

- (void) encounteredEnd {
    [self closeStream];
}

- (NSError*) streamError {
    return nil;
}

- (void) openStreamWithDelegate:(id<FLNetworkStreamDelegate>) delegate {
    _delegate = delegate;
    [self willOpen];
}

- (void) closeStream {
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
            [stream encounteredOpen];
        break;

        case kCFStreamEventErrorOccurred: 
            [stream encounteredError:[stream streamError]];
        break;
        
        case kCFStreamEventEndEncountered:
            [stream encounteredEnd];
        break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable:
            [stream encounteredBytesAvailable];
        break;
            
        case kCFStreamEventCanAcceptBytes: 
            [stream encounteredCanAcceptBytes];
            break;
    }
}

@end
