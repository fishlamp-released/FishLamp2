//
//  FLNetworkStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLReadStream.h"
#import "FLWriteStream.h"


@interface FLNetworkStream ()
@property (readwrite, assign) NSThread* thread;
@property (readwrite, assign) CFRunLoopRef runLoop;
@property (readwrite, assign) BOOL isOpen;
@property (readwrite, copy) FLStreamClosedBlock closeBlock;
@end

@implementation FLNetworkStream

synthesize_(runLoop)
synthesize_(delegate)
synthesize_(isOpen)
synthesize_(thread)
synthesize_(closeBlock)

- (id) init {
    self = [super init];
    if(self) {
        self.delegate = self;
        _queue = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) dealloc {
    FLAssert_v(self.thread == nil, @"still running in thread");
    
    self.delegate = nil;
    
#if FL_MRC
    [_queue release];
    [_closeBlock release];
    [super dealloc];
#endif
}

- (void) runStreamTasks {
    if(!_busy) {
        _busy = YES;
        
        @try {
            while(_queue.count) {
                FLStreamTask block = nil;
                @synchronized(self) {
                    block = [_queue objectAtIndex:0];
                    mrc_retain_(block);
                    
                    [_queue removeObjectAtIndex:0];
                }
                if(block) {
                    block(self);
                }
                release_(block);
            }
        }
        @catch(NSException* ex) {
        
        }
        
        _busy = NO;
    }
}

- (void) queueStreamTask:(FLStreamTask) task {
    @synchronized(self) {
        [_queue addObject:autorelease_([task copy])];
    }
    [self performSelector:@selector(runStreamTasks) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void) _closeStream:(NSError*) error {
    if(!_didClose) {
        _didClose = YES;
        
        [self postObservation:@selector(networkStreamWillClose:withError:) withObject:error];
        
        [self.delegate networkStreamCloseStream:self withError:error];
        
        [self postObservation:@selector(networkStreamDidClose:withError:) withObject:error];
        
        self.runLoop = nil;
        self.thread = nil;
        self.isOpen = NO;
        
        if(self.closeBlock) {
            self.closeBlock(self, error);
            self.closeBlock = nil;
        }
    }
}

- (void) networkStreamOpenStream:(id<FLNetworkStream>) stream {
}

- (void) networkStreamCloseStream:(id<FLNetworkStream>) stream
                        withError:(NSError*) error {
}

- (void) closeStream:(NSError*) error {
    [self queueStreamTask:^(id stream) {
        [stream _closeStream:error];
    }];
}

- (void) openStream:(FLStreamClosedBlock) didCloseBlock {
    self.closeBlock = didCloseBlock;
    self.runLoop = CFRunLoopGetCurrent();
    self.thread = [NSThread currentThread];
    _didClose = NO;
    self.isOpen = NO;
    [self queueStreamTask:^(id<FLNetworkStream> stream) {
        [stream postObservation:@selector(networkStreamWillOpen:)];
        [stream.delegate networkStreamOpenStream:stream];
    }];
}

- (void) handleStreamEvent:(CFStreamEventType) eventType {

    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

#if TRACE
    FLDebugLog(@"Read Stream got event %d", eventType);
#endif

    switch (eventType)  {
        case kCFStreamEventOpenCompleted:
            self.isOpen = YES;
            [self postObservation:@selector(networkStreamDidOpen:)];
            break;

        case kCFStreamEventErrorOccurred:
        case kCFStreamEventEndEncountered:
            [self closeStream:nil];
            break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable:
            [self postObservation:@selector(readStreamHasBytesAvailable:)];
            break;
            
        case kCFStreamEventCanAcceptBytes:
            [self postObservation:@selector(writeStreamCanAcceptBytes:)];
            break;
    }
    
    [self runStreamTasks];
}

- (NSError*) error {
    return nil;
}

@end

//@implementation FLStreamTask
//
//+ (id) streamTask {
//    return autorelease_([[[self class] alloc] init])l
//}
//
//- (void) performStreamTask:(id) stream {
//}
//@end
//
//@implementation FLStreamOpener
//- (void) performStreamTask:(id) stream {
//}
//@end
//
//@implementation FLStreamCloser
//
//- (void) performStreamTask:(id) stream {
//}
//
//@end

