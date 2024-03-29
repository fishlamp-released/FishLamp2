//
//  FLRunLoopNetworkStreamEventHandler.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/15/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLRunLoopNetworkStreamEventHandler.h"
#import "FLNetworkStream_Internal.h"

@interface FLRunLoopNetworkStreamEventHandler ()
@property (readwrite, assign) NSRunLoop* runLoop;
@property (readwrite, assign) FLNetworkStream* stream;
@property (readwrite, assign) NSThread* thread;
@end

@implementation FLRunLoopNetworkStreamEventHandler

@synthesize runLoop = _runLoop;
@synthesize stream = _stream;
@synthesize thread = _thread;

- (id) init{	
	self = [super init];
	if(self) {
    }
	return self;
}

- (void) dealloc {
#if FL_MRC
    [super dealloc];
#endif
}

+ (id) networkStreamEventHandler {
    return FLAutorelease([[[self class] alloc] init]);
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void) queueSelector:(SEL) selector withObject:(id) object {

    FLAssertNotNil(self.runLoop);
    
    if([NSThread currentThread] == self.thread) {
        FLPerformSelector1(_stream, selector, object);
    }
    else {
        [self.runLoop performSelector:selector target:_stream argument:object order:0 modes:[NSArray arrayWithObject:self.runLoopMode]];
    }
}

- (void) queueSelector:(SEL) selector {
//    [self queueBlock:^{ 
//    
//        @try { 
//            [self performSelector:selector];
//        }
//        @catch(NSException* ex) {
//            _stream.wasTerminated = YES;
//            FLLog(@"stream encountered secondary error: %@", [ex.error localizedDescription]);
//        }
//    }];
//    
    FLAssertNotNil(self.runLoop);
    
    if([NSThread currentThread] == self.thread) {
        FLPerformSelector0(_stream, selector);
    }
    else {
        [self.runLoop performSelector:selector target:_stream argument:nil order:0 modes:[NSArray arrayWithObject:self.runLoopMode]];
    }
}

#pragma GCC diagnostic pop

//- (void) queueBlock:(dispatch_block_t) block {
//    [self.asyncQueue queueBlock:block completion:nil];
//}

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

- (void) streamWillOpen:(FLNetworkStream*) stream 
             completion:(void (^)()) completion{
             
    _stream = stream;
    
    completion = FLCopyWithAutorelease(completion);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.runLoop = [NSRunLoop currentRunLoop]; // Get the runloop
        self.thread = [NSThread currentThread];
        
        if(completion) {
            completion();
        }

        while(self.stream) {
            @autoreleasepool {
                @try {
                    [self.runLoop runMode:self.runLoopMode beforeDate:[NSDate date]];
                }
                @catch(NSException* ex) {
                }
            }
        }
        
        self.runLoop = nil;
    
    });
    
}

- (void) streamDidClose:(FLNetworkStream*) stream {
    self.stream = nil;
}

- (NSString*) runLoopMode {
    return NSDefaultRunLoopMode;
}

@end
