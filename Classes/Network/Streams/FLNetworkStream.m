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
@property (readwrite, assign) BOOL wasCancelled;
@end

@implementation FLNetworkStream

synthesize_(runLoop)
synthesize_(delegate)
synthesize_(isOpen)
synthesize_(wasCancelled);
synthesize_(thread)

- (void) dealloc {
    FLAssert_v(self.thread == nil, @"still running in thread");
    
    self.delegate = nil;
    
#if FL_MRC
    [super dealloc];
#endif
}

- (void) closeStream {
    if(!_didClose) {
        _didClose = YES;
        [self closeSelf];
        
        if(self.wasCancelled) {
            FLPerformSelector2(self.delegate, @selector(networkStreamDidClose:withResult:), self, [FLErrorResult errorResult:[NSError cancelError]]);
        }
        else {
            FLPerformSelector2(self.delegate, @selector(networkStreamDidClose:withResult:), self, self);
        }

        self.runLoop = nil;
        self.thread = nil;
        self.isOpen = NO;
    }
}

- (BOOL) didSucceed {
    return self.error != nil;
}

- (void) openStream {
    self.runLoop = CFRunLoopGetCurrent();
    self.thread = [NSThread currentThread];
    _didClose = NO;
    self.isOpen = NO;
    
    [self openSelf];
}

- (void) openSelf {

}

- (void) closeSelf {

}

- (id) output {
    return nil;
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
        case kCFStreamEventEndEncountered:
            [self closeStream];
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


- (void) connectionGotTimerEvent {
// TODO: ("MF: fix http delegate");

//    if([self.delegate respondsToSelector:@selector(httpConnection:sentBytes:totalSentBytes:totalBytesExpectedToSend:)])
//    {
//        unsigned long long bytesSent = _inputStream.bytesSent;
//        if(bytesSent > self.totalBytesSent)
//        {
//            self.lastBytesSent =  bytesSent - self.totalBytesSent;
//            self.totalBytesSent = bytesSent;
//
//#if TRACE
//            FLDebugLog(@"bytes this time: %qu, total bytes sent: %qu, expected to send: %qu",  
//                self.lastBytesSent,
//                self.totalBytesSent, 
//                [[_requestQueue lastObject] postLength]);
//#endif
//            [self.delegate httpConnection:self 
//                sentBytes:self.lastBytesSent 
//                totalSentBytes:self.totalBytesSent 
//                totalBytesExpectedToSend:[[_requestQueue lastObject] postLength]];
//       }
//    }
}

//- (id<FLReadStream>) readStream {
//    return nil;
//}
//
//- (id<FLReadStream>) writeStream {
//    return nil;
//}

- (id) streamOutput {
    return nil;
}

- (void) requestCancel {
    if(!self.wasCancelled) {
        self.wasCancelled = YES;
        [self performSelector:@selector(closeStream) onThread:self.thread withObject:nil waitUntilDone:NO];
    }
}


@end