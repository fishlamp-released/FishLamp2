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

- (void) dealloc {
    FLAssert_v(self.thread == nil, @"still running in thread");
    
    self.delegate = nil;
    
#if FL_MRC
    [_closeBlock release];
    [super dealloc];
#endif
}

- (void) closeStream:(NSError*) error {
    if(!_didClose) {
        _didClose = YES;
        
        FLPerformSelector2(self.delegate, @selector(networkStreamWillClose:withError:), self, error);

        [self startClosing:error];
        
        FLPerformSelector2(self.delegate, @selector(networkStreamDidClose:withError:), self, error);

        self.runLoop = nil;
        self.thread = nil;
        self.isOpen = NO;
        
        if(self.closeBlock) {
            self.closeBlock(self, error);
            self.closeBlock = nil;
        }
    }
}

- (void) openStream:(FLStreamClosedBlock) didCloseBlock {
    self.closeBlock = didCloseBlock;
    self.runLoop = CFRunLoopGetCurrent();
    self.thread = [NSThread currentThread];
    _didClose = NO;
    self.isOpen = NO;
    FLPerformSelector1(self.delegate, @selector(networkStreamWillOpen:), self);
    
    [self openSelf];
}

- (void) openSelf {
}

- (void) closeSelf:(NSError*) error {
}

- (NSError*) error {
    return nil;
}

- (void) forwardStreamEventToDelegate:(CFStreamEventType) eventType {

    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

#if TRACE
    FLDebugLog(@"Read Stream got event %d", eventType);
#endif

    switch (eventType)  {
        case kCFStreamEventOpenCompleted:
            self.isOpen = YES;
            FLPerformSelectorWithObject(self.delegate, @selector(networkStreamDidOpen:), self);
            break;

        case kCFStreamEventErrorOccurred:
            [self closeStream:[self error]];
            break;

        case kCFStreamEventEndEncountered:
            [self closeStream:nil];
            break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable:
            FLPerformSelectorWithObject(self.delegate, @selector(readStreamHasBytesAvailable:), self);
            break;
            
        case kCFStreamEventCanAcceptBytes:
            FLPerformSelectorWithObject(self.delegate, @selector(writeStreamCanAcceptBytes:), self);
            break;
    }
}

@end