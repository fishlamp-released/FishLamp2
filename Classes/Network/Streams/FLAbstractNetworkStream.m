//
//  FLAbstactNetworkStream.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAbstractNetworkStream.h"

#import "FLReadStream.h"
#import "FLWriteStream.h"

#define kRunLoopMode NSDefaultRunLoopMode

@interface FLAbstractNetworkStream ()
@property (readwrite, assign) NSThread* thread;
@property (readwrite, assign) CFRunLoopRef runLoop;
@property (readwrite, assign) BOOL isOpen;
@property (readwrite, copy) FLStreamClosedBlock closeBlock;


@property (readwrite, strong) NSError* error;
- (void) openNetworkStream;
- (void) closeNetworkStream;

@end

@implementation FLAbstractNetworkStream

synthesize_(runLoop)
synthesize_(isOpen)
synthesize_(thread)
synthesize_(closeBlock)

- (id) init {
    self = [super init];
    if(self) {
        _queue = [[FLSelectorQueue alloc] initWithCapacity:25];

        FLAssert_v([self conformsToProtocol:@protocol(FLConcreteNetworkStream)], @"subclasses must implement @protocol FLConcreteNetworkStream")
    }
    return self;
}

- (void) dealloc {
    FLAssert_v(self.thread == nil, @"still running in thread");
   
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
        
            SEL action = [_queue nextSelector];
            while(action) {
                FLPerformSelector(self, action);
                action = [_queue nextSelector];
            }
        }
        @catch(NSException* ex) {
        
        }
        
        _busy = NO;
    }
}

- (void) queueStreamAction:(SEL) action {
    [_queue addSelector:action];
    
    if([NSThread currentThread] == self.thread) {
        [self runStreamTasks];
    }
    else {
        [self performSelector:@selector(runStreamTasks) onThread:self.thread withObject:nil waitUntilDone:NO];
    }
}

- (void) _closeStream {
    if(!_didClose) {
        _didClose = YES;
        
        [self postObservation:@selector(networkStreamWillClose:)];
        
        [self closeNetworkStream];
        
        [self postObservation:@selector(networkStreamDidClose:)];
        
        self.runLoop = nil;
        self.thread = nil;
        self.isOpen = NO;
        
        if(self.closeBlock) {
            self.closeBlock(self);
            self.closeBlock = nil;
        }
    }
}

- (void) closeStream:(NSError*) error {
    self.error = error;
    [self queueStreamAction:@selector(_closeStream)];
}    

- (void) _openStream {
    [self postObservation:@selector(networkStreamWillOpen:)];
    [self openNetworkStream];
}

- (void) openStream:(FLStreamClosedBlock) didCloseBlock {
    self.closeBlock = didCloseBlock;
    self.runLoop = CFRunLoopGetCurrent();
    self.thread = [NSThread currentThread];
    _didClose = NO;
    self.isOpen = NO;
    [self queueStreamAction:@selector(_openStream)];
}

- (NSError*) error {
    return nil;
}

- (void) setError:(NSError*) error {
}

- (void) openNetworkStream {
}

- (void) closeNetworkStream {
}


@end

@implementation FLAbstractNetworkStream (CFStream)

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

@end
