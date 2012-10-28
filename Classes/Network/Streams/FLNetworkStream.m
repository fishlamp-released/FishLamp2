//
//  FLNetworkStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"

@interface FLNetworkStream ()
@property (readwrite, assign) NSThread* thread;
@property (readwrite, assign) CFRunLoopRef runLoop;
@property (readwrite, assign) BOOL isOpen;

@end

@implementation FLNetworkStream
@synthesize delegate = _delegate;
@synthesize thread = _thread;
@synthesize runLoop = _runLoop;
@synthesize isOpen = _isOpen;

- (BOOL) isRunning {
    return self.thread != nil;
}

- (void) dealloc {
    FLAssert_v(self.thread == nil, @"still running in thread");
    self.delegate = nil;
    
#if FL_NO_ARC
    [super dealloc];
#endif
}

- (void) closeStream {
    self.runLoop = nil;
    self.thread = nil;
}

- (void) openStream {
    self.runLoop = CFRunLoopGetCurrent();
    self.thread = [NSThread currentThread];
    
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
            [self.delegate performIfRespondsToSelector:@selector(networkStreamDidOpen:) withObject:self];
            break;

        case kCFStreamEventEndEncountered:
            self.isOpen = NO;
            [self.delegate performIfRespondsToSelector:@selector(networkStreamDidClose:)  withObject:self];
            break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable:
            [self.delegate performIfRespondsToSelector:@selector(readStreamHasBytesAvailable:) withObject:self];
            break;

        case kCFStreamEventErrorOccurred:
            [self.delegate performIfRespondsToSelector:@selector(networkStreamEncounteredError:) withObject:self];
            break;
            
        case kCFStreamEventCanAcceptBytes:
            [self.delegate performIfRespondsToSelector:@selector(writeStreamCanAcceptBytes:) withObject:self];
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
// TODO: make this better
// from some sample apple code..
+ (NSError *) errorFromStreamError:(CFStreamError)streamError
    // Convert a CFStreamError to a NSError.  This is less than ideal.  I only handle a 
    // limited number of error constant, and I can't use a switch statement because 
    // some of the kCFStreamErrorDomainXxx values are not a constant.  Wouldn't it be 
    // nice if there was a public API to do this mapping <rdar://problem/5845848> 
    // or a CFHost API that used CFError <rdar://problem/6016542>.
{
    NSString *      domainStr = nil;
    NSDictionary *  userInfo = nil;
    NSInteger       code = streamError.error;
    
    if (streamError.domain == kCFStreamErrorDomainPOSIX) {
        domainStr = NSPOSIXErrorDomain;
    }
    else if (streamError.domain == kCFStreamErrorDomainMacOSStatus) {
        domainStr = NSOSStatusErrorDomain;
    }
    else if (streamError.domain == kCFStreamErrorDomainNetServices) {
        domainStr = (__bridge_fl NSString *) kCFErrorDomainCFNetwork;
    }
    else if (streamError.domain == kCFStreamErrorDomainNetDB) {
        domainStr = (__bridge_fl NSString *) kCFErrorDomainCFNetwork;
        code = kCFHostErrorUnknown;
        userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:streamError.error], kCFGetAddrInfoFailureKey, nil];
    }
    else {
        // If it's something we don't understand, we just assume it comes from 
        // CFNetwork.
        domainStr = (__bridge_fl NSString *) kCFErrorDomainCFNetwork;
    }

    NSError* error = [NSError errorWithDomain:domainStr code:code userInfo:userInfo];
    FLAssertIsNotNil_v(error, nil);

    return error;
}

@end

