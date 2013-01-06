//
//  FLStream.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/20/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStream.h"

@interface FLStream ()
@property (readwrite, strong) FLTimeoutTimer* timeoutTimer;
@property (readwrite, assign, getter=wasCancelled) BOOL cancelled;

- (void) openStream;
- (void) closeStreamWithResult:(id) result;
@end

@implementation FLStream

@synthesize timeoutTimer = _timeoutTimer;
@synthesize cancelled = _cancelled;
@synthesize timeoutInterval = _timeoutInterval;

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_timeoutTimer removeObserver:self];
    [_timeoutTimer release];
    [super dealloc];
}
#endif

- (void) openSelfWithInput:(id) input {
}

- (void) closeSelfWithResult:(id) result {
}

- (void) didEncounterError:(NSError*) error {
}

- (BOOL) isOpen {
    return NO;
}

- (void) closeStreamWithResult:(id) result {
    if(self.timeoutTimer) {
        [self.timeoutTimer stopTimer];
        [self.timeoutTimer removeObserver:self];
        self.timeoutTimer = nil;
    }
    
    if(!result) {
        result = FLSuccessfullResult;
    }
    
    [self closeSelfWithResult:result];
}    

- (void) connectionGotTimerEvent {
// TODO: ("MF: fix http implementation");

//    if([self.implementation respondsToSelector:@selector(httpConnection:sentBytes:totalSentBytes:totalBytesExpectedToSend:)])
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
//            [self.implementation httpConnection:self 
//                sentBytes:self.lastBytesSent 
//                totalSentBytes:self.totalBytesSent 
//                totalBytesExpectedToSend:[[_requestQueue lastObject] postLength]];
//       }
//    }
}



- (void) openStreamWithInput:(id) input {
    self.cancelled = NO;
    if(self.timeoutInterval) {
        self.timeoutTimer = [FLTimeoutTimer timeoutTimer:self.timeoutInterval];
        [self.timeoutTimer addObserver:self forEvent:@selector(timeoutTimerDidTimeout:)];
    }
    [self openSelfWithInput:input];
}

- (void) openStream {
    [self openStreamWithInput:nil];
}

- (void) requestCancel {
    self.cancelled = YES;
    if(self.isOpen) {   
        [self didEncounterError:[NSError cancelError]];
    }
}

- (void) timeoutTimerDidTimeout:(FLTimeoutTimer*) timer {
     [self didEncounterError:[NSError timeoutError]];
}

- (void) touchTimestamp {
    if(self.timeoutTimer) {
        [self.timeoutTimer touchTimestamp];
    }
}


@end