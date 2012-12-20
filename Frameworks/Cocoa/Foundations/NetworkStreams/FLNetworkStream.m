//
//  FLStreamController.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLReadStream.h"
#import "FLWriteStream.h"

#define kRunLoopMode NSDefaultRunLoopMode

@interface FLNetworkStream ()
@property (readwrite, assign) BOOL isOpen;
@property (readwrite, assign) BOOL didClose;
@property (readwrite, strong) FLTimeoutTimer* timeoutTimer;
@property (readwrite, assign, getter=wasCancelled) BOOL cancelled;

- (void) openStream;
- (void) closeStreamWithResult:(id) result;
@end

@implementation FLNetworkStream

@synthesize isOpen = _isOpen;
@synthesize didClose = _didClose;
@synthesize timeoutTimer = _timeoutTimer;
@synthesize cancelled = _cancelled;

- (id) init {
    self = [super init];
    if(self) {
        FLAssert_v([self conformsToProtocol:@protocol(FLConcreteNetworkStream)], @"subclasses must implement @protocol FLConcreteNetworkStream")
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_timeoutTimer release];
    [_timeoutTimer removeObserver:self];
    [super dealloc];
}
#endif

- (void) closeNetworkStreamWithResult:(id) result {
    if(!self.didClose) {
        
        [_timeoutTimer stopTimer];
        [_timeoutTimer removeObserver:self];
        self.timeoutTimer = nil;
        
        if(!result) {
            result = FLSuccessfullResult;
        }
        
        [self postObservation:@selector(networkStream:willCloseWithResult:) withObject:result];
        
        [self closeStreamWithResult:result];
        self.didClose = YES;
        self.isOpen = NO;

        [self postObservation:@selector(networkStream:didCloseWithResult:) withObject:result];
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

- (BOOL) checkReachability {
#if IOS
	return [FLReachableNetwork instance].isReachable;
#else
//   FLAssertIsImplemented_();
// TODO: this needs implementing
    return YES;
    
#endif
}
- (void) failIfUnreachable {
   if(![self checkReachability]) {
        NSError* error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet localizedDescription:NSLocalizedString(@"Not Connected to Network", nil)];
        if(error) {
            FLThrowError_(error);
        }
    }
}

- (void) openNetworkStream {
    self.didClose = NO;
    self.isOpen = NO;
    self.cancelled = NO;
    self.timeoutTimer = [FLTimeoutTimer timeoutTimer:FLNetworkStreamDefaultTimeout];
    [self.timeoutTimer addObserver:self forEvent:@selector(timeoutTimerDidTimeout:)];
    [self postObservation:@selector(networkStreamWillOpen:)];
    [self openStream];
}

- (void) openStream {
}

- (void) closeStreamWithResult:(id) result {
}

- (void) requestCancel {
    self.cancelled = YES;
    if(self.isOpen) {
        [self postObservation:@selector(networkStream:encounteredError:) withObject:[NSError cancelError]];
    }
}

- (void) timeoutTimerDidTimeout:(FLTimeoutTimer*) timer {
     [self postObservation:@selector(networkStream:encounteredError:) withObject:[NSError timeoutError]];
}

- (void) touchTimestamp {
    [self.timeoutTimer touchTimestamp];
}

@end

@implementation FLNetworkStream (CFStream)

- (void) handleStreamEvent:(CFStreamEventType) eventType {

//    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

#if TRACE
    FLDebugLog(@"Read Stream got event %d", eventType);
#endif

    switch (eventType)  {
        case kCFStreamEventOpenCompleted: {
            [self.timeoutTimer touchTimestamp];
            self.isOpen = YES;
            [self postObservation:@selector(networkStreamDidOpen:)];
        }
        break;

        case kCFStreamEventErrorOccurred: {
            [self.timeoutTimer touchTimestamp];
            [self postObservation:@selector(networkStream:encounteredError:) withObject:nil];
        }
        break;
        
        case kCFStreamEventEndEncountered:{
            [self.timeoutTimer touchTimestamp];
            [self postObservation:@selector(networkStream:didCloseWithResult:) withObject:FLSuccessfullResult];
        }
        break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable: {
            [self.timeoutTimer touchTimestamp];
            [self postObservation:@selector(networkStreamHasBytesAvailable:)];
        }
        break;
            
        case kCFStreamEventCanAcceptBytes: {
            [self.timeoutTimer touchTimestamp];
            [self postObservation:@selector(networkStreamCanAcceptBytes:)];
            break;
        }
    }
}

@end

//typedef struct {
//    unsigned long lastChunkCount;
//    unsigned long totalCount;
//    unsigned long totalExpectedCount;
//} FLNetworkConnectionByteCount;
//
//extern const FLNetworkConnectionByteCount FLNetworkConnectionByteCountZero;
//

//
//@synthesize writeByteCount = _writeByteCount;
//@synthesize readByteCount = _readByteCount;
//
//const FLNetworkConnectionByteCount FLNetworkConnectionByteCountZero = {0, 0, 0};
//
//- (void) networkStreamDidWriteBytes:(id<FLWriteStream>) stream {
//
//    unsigned long bytes = stream.bytesWritten; 
//
//    FLNetworkConnectionByteCount byteCount = self.writeByteCount;
//    byteCount.lastChunkCount = bytes - byteCount.totalCount;
//    byteCount.totalCount = bytes;
//    self.writeByteCount = byteCount;
//
//    [self postObservation:@selector(networkConnectionDidSendData:)];
//
//}
//
//- (void) networkStreamDidReadBytes:(id<FLReadStream>) stream {
//
//    unsigned long bytes = stream.bytesRead; 
//
//    FLNetworkConnectionByteCount byteCount = self.readByteCount;
//    byteCount.lastChunkCount = bytes - byteCount.totalCount;
//    byteCount.totalCount = bytes;
//    self.readByteCount = byteCount;
//
//    [self postObservation:@selector(networkConnectionDidReadData:)];
//
//}

