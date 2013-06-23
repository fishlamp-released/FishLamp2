//
//  FLFifoQueueNetworkStreamEventHandler.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/15/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFifoQueueNetworkStreamEventHandler.h"
#import "FLNetworkStream_Internal.h"

@interface FLFifoQueueNetworkStreamEventHandler ()
@property (readwrite, strong, nonatomic) FLFifoAsyncQueue* asyncQueue;
@property (readwrite, strong) FLNetworkStream* stream;
@end

@implementation FLFifoQueueNetworkStreamEventHandler

@synthesize asyncQueue = _asyncQueue;
@synthesize stream = _stream;

- (id) init{	
	self = [super init];
	if(self) {
        self.asyncQueue = [FLFifoAsyncQueue fifoAsyncQueue];
    }
	return self;
}

- (void) dealloc {
    [_asyncQueue releaseToPool];
#if FL_MRC
    [_stream release];
    [_asyncQueue release];
	[super dealloc];
#endif
}

+ (id) networkStreamEventHandler {
    return FLAutorelease([[[self class] alloc] init]);
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void) queueSelector:(SEL) selector withObject:(id) object {
    [self queueBlock:^{ 
        [self.stream performSelector:selector withObject:object];
    }];
}

- (void) queueSelector:(SEL) selector {
    [self queueBlock:^{ 
    
        @try { 
            [self.stream performSelector:selector];
        }
        @catch(NSException* ex) {
            self.stream.wasTerminated = YES;
            FLLog(@"stream encountered secondary error: %@", [ex.error localizedDescription]);
        }
    }];
}

#pragma GCC diagnostic pop

- (void) didDispatchBlockInStream:(FLNetworkStream*) stream {

}

- (void) queueBlock:(dispatch_block_t) block {
    [self.asyncQueue queueBlock:block completion:^(id result, NSError* error) {
        [self didDispatchBlockInStream:_stream];
    }];
}

- (void) handleStreamEvent:(CFStreamEventType) eventType {

    FLTrace(@"Read Stream got event %d", eventType);

    [self.stream touchTimeoutTimestamp];

    switch (eventType)  {

        // NOTE: HttpStream doesn't get this event.
        case kCFStreamEventOpenCompleted:
            [self queueSelector:@selector(encounteredOpen)];
        break;

        case kCFStreamEventErrorOccurred:  
            self.stream.wasTerminated = YES;
            [self queueSelector:@selector(encounteredError:) withObject:[self.stream streamError]];
        break;
        
        case kCFStreamEventEndEncountered:
            [self queueSelector:@selector(encounteredEnd)];
        break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable:
            [self queueSelector:@selector(encounteredBytesAvailable)];
        break;
            
        case kCFStreamEventCanAcceptBytes: 
            [self queueSelector:@selector(encounteredCanAcceptBytes)];
            break;
    }
}

- (void) streamWillOpen:(FLNetworkStream*) stream  completion:(void (^)()) completion {
    self.stream = stream;
    if(completion) completion();
}

- (void) streamDidClose:(FLNetworkStream*) stream {
    if(self.stream == stream) {
        self.stream = nil;
    }
}

- (NSRunLoop*) runLoop {
    return [NSRunLoop mainRunLoop];
}
- (NSString*) runLoopMode {
    return NSDefaultRunLoopMode;
}

@end
