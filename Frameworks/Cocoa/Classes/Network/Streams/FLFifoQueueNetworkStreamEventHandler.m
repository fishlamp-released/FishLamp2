//
//  FLFifoQueueNetworkStreamEventHandler.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLFifoQueueNetworkStreamEventHandler.h"
#import "FLNetworkStream_Internal.h"

@interface FLFifoQueueNetworkStreamEventHandler ()
@property (readwrite, strong, nonatomic) FLFifoAsyncQueue* asyncQueue;
@end

@implementation FLFifoQueueNetworkStreamEventHandler

@synthesize asyncQueue = _asyncQueue;

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
        [self performSelector:selector withObject:object];
    }];
}

- (void) queueSelector:(SEL) selector {
    [self queueBlock:^{ 
    
        @try { 
            [self performSelector:selector];
        }
        @catch(NSException* ex) {
            _stream.wasTerminated = YES;
            FLLog(@"stream encountered secondary error: %@", [ex.error localizedDescription]);
        }
    }];
}

#pragma GCC diagnostic pop

- (void) queueBlock:(dispatch_block_t) block {
    [self.asyncQueue queueBlock:block completion:nil];
}

- (void) handleStreamEvent:(CFStreamEventType) eventType {

//#if TRACE
//    FLDebugLog(@"Read Stream got event %d", eventType);
//#endif
    [_stream touchTimeoutTimestamp];

    switch (eventType)  {

        // NOTE: HttpStream doesn't get this event.
        case kCFStreamEventOpenCompleted:
            [self queueSelector:@selector(encounteredOpen)];
        break;

        case kCFStreamEventErrorOccurred:  
            _stream.wasTerminated = YES;
            [self queueSelector:@selector(encounteredError:) withObject:[_stream streamError]];
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
    _stream = stream;
    if(completion) completion();
}

- (void) streamDidClose:(FLNetworkStream*) stream {
    if(_stream == stream) {
        _stream = nil;
    }
}

- (NSRunLoop*) runLoop {
    return [NSRunLoop mainRunLoop];
}
- (NSString*) runLoopMode {
    return NSDefaultRunLoopMode;
}

@end
