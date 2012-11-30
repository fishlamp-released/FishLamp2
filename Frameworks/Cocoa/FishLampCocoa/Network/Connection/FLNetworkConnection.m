//
//  FLNetworkConnection.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/4/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLNetworkConnection.h"
#import "FLGlobalNetworkActivityIndicator.h"
#import "FLReachableNetwork.h"
#import "FLNetworkStream.h"
#import "FLReadStream.h"
#import "FLWriteStream.h"

const FLNetworkConnectionByteCount FLNetworkConnectionByteCountZero = {0, 0, 0};

@interface FLNetworkConnection ()
@property (readwrite, strong) id<FLNetworkStream> networkStream;
@property (readwrite, strong) FLCancellable* cancelHandler;
@property (readwrite, strong) FLTimeoutTimer* timeoutTimer;
@property (readwrite, assign) FLNetworkConnectionByteCount writeByteCount;
@property (readwrite, assign) FLNetworkConnectionByteCount readByteCount;

- (void) setTimedOut:(FLTimeoutTimer*) timer;
@end

@implementation FLNetworkConnection

//@synthesize retryCount = _retryCount;

@synthesize cancelHandler = _cancelHandler;
@synthesize networkStream = _networkStream;
@synthesize timeoutTimer = _timeoutTimer;
@synthesize writeByteCount = _writeByteCount;
@synthesize readByteCount = _readByteCount;

- (id) init {
    if((self = [super init])) {
        self.timeoutTimer = [FLTimeoutTimer timeoutTimer:FLNetworkConnectionDefaultTimeout];
        
        [self.timeoutTimer addObserver:self forEvent:FLTimeoutTimerTimeoutEvent eventHandler:@selector(setTimedOut:)];
    
        _cancelHandler = [[FLCancellable alloc] init];
    }
    
    return self;
}

- (id<FLNetworkStream>) createNetworkStream {
    return nil;
}

- (void) dealloc  {
    FLAssert_(!_networkStream.isOpen);

    if(_networkStream) {
        [_networkStream removeObserver:self];
    }

//    [self visitObservers:^(id observer, BOOL* stop) {
//        FLPerformSelectorWithObject(observer, @selector(observerWasRemovedFromNetworkConnection:), self);
//    }];

    [_timeoutTimer stopTimer];
    [_timeoutTimer removeObserver:self];

#if FL_MRC
    [_cancelHandler release];
    [_timeoutTimer release];
    [_cancelFinisher release];
    [_networkStream release];
    super_dealloc_();
#endif
}

//- (void) _retry {
//    _retryCount++;
//    FLDebugLog(@"Retrying request. Retry count: %d", _retryCount);
//
//    [self closeStream];
//    [self openConnectionOnCurrentThread];
//}
//
//- (BOOL) retryConnectionIfPossible {
//    NSThread* thread = self.thread;
//    if( thread) {
//        [self performSelector:@selector(_retry) onThread:thread withObject:nil waitUntilDone:NO];
//        return YES;
//    }
//    return NO;
//}

- (BOOL) checkReachability {
#if IOS
	return [FLReachableNetwork instance].isReachable;
#else
//   FLAssertIsImplemented_();
// TODO: this needs implementing
    return YES;
    
#endif
}

- (void) setTimedOut:(FLTimeoutTimer*) timer {
     [self.networkStream closeStreamWithResult:[NSError timeoutError]];
}

- (void) touchTimestamp {
    [self.timeoutTimer touchTimestamp];
}

- (void) networkStreamWillOpen:(id<FLNetworkStream>) networkStream {
    [self.timeoutTimer touchTimestamp];
    [self postObservation:@selector(networkConnectionConnecting:)];
}

- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream {
    [self.timeoutTimer touchTimestamp];
    [self postObservation:@selector(networkConnectionConnected:)];
}

- (void) networkStreamWillClose:(id<FLNetworkStream>) networkStream {
    [self.timeoutTimer touchTimestamp];
}

- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream {
    [self.timeoutTimer touchTimestamp];
}

- (void) failIfUnreachable {
   if(![self checkReachability]) {
        NSError* error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet localizedDescription:NSLocalizedString(@"Not Connected to Network", nil)];
        if(error) {
            FLThrowError_(error);
        }
    }
}

- (FLFinisher*) openConnection:(FLDispatchQueue*) dispatcher {
   
    return [dispatcher dispatchAsyncBlock:^(FLFinisher* finisher) {
    
        [self postObservation:@selector(networkConnectionStarting:)];

        FLAssertIsNil_(self.networkStream);
        [self failIfUnreachable];

        self.networkStream = [self createNetworkStream];
        FLAssertIsNotNil_(self.networkStream);
        [self.networkStream addObserver:self];
        
        [self.cancelHandler reset];
        [self.cancelHandler addDependent:self.networkStream];
 
        [self.networkStream openStream:dispatcher streamClosedBlock:^(FLResult result) {
            [self.cancelHandler removeDependent:self.networkStream];
 
            [self.networkStream removeObserver:nil];
            self.networkStream = nil;
            [self postObservation:@selector(networkConnectionDisconnected:)];

#if DEBUG
            if([result error]) {
                FLDebugLog(@"stream received error: %@", [result localizedDescription]);
            } 
#endif

            result = [self.cancelHandler setFinished:result];
             
            [finisher setFinishedWithResult:result completion:^{
                [self postObservation:@selector(networkConnection:finishedWithResult:) withObject:result];
                }];

        }];
    }];
}

- (FLFinisher*) requestCancel:(FLResultBlock) completion {
    return [self.cancelHandler requestCancel:completion];
}

- (void) networkStreamDidWriteBytes:(id<FLWriteStream>) stream {

    unsigned long bytes = stream.bytesWritten; 

    FLNetworkConnectionByteCount byteCount = self.writeByteCount;
    byteCount.lastChunkCount = bytes - byteCount.totalCount;
    byteCount.totalCount = bytes;
    self.writeByteCount = byteCount;

    [self touchTimestamp];
    
    [self postObservation:@selector(networkConnectionDidSendData:)];

}

- (void) networkStreamDidReadBytes:(id<FLReadStream>) stream {

    unsigned long bytes = stream.bytesRead; 

    FLNetworkConnectionByteCount byteCount = self.readByteCount;
    byteCount.lastChunkCount = bytes - byteCount.totalCount;
    byteCount.totalCount = bytes;
    self.readByteCount = byteCount;

    [self touchTimestamp];

    [self postObservation:@selector(networkConnectionDidReadData:)];

}

- (void) readStreamHasBytesAvailable:(id<FLReadStream>) networkStream {
    [self touchTimestamp];
    [self postObservation:@selector(networkConnectionWillReadData:)];
}

- (void) writeStreamCanAcceptBytes:(id<FLWriteStream>) networkStream {
    [self touchTimestamp];
    [self postObservation:@selector(networkConnectionWillSendData:)];
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




@end


