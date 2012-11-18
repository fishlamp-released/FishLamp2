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
@property (readwrite, assign) NSThread* thread;
@property (readwrite, strong) id<FLNetworkStream> networkStream;
@property (readwrite, strong) FLFinisher* finisher;
@property (readwrite, strong) FLTimeoutTimer* timeoutTimer;
@property (readwrite, assign) FLNetworkConnectionByteCount writeByteCount;
@property (readwrite, assign) FLNetworkConnectionByteCount readByteCount;
@property (readwrite, assign) BOOL wasCancelled;

- (void) setTimedOut:(FLTimeoutTimer*) timer;
@end

@implementation FLNetworkConnection

//@synthesize retryCount = _retryCount;

@synthesize finisher = _finisher;
@synthesize networkStream = _networkStream;
@synthesize timeoutTimer = _timeoutTimer;
@synthesize thread = _thread;
@synthesize writeByteCount = _writeByteCount;
@synthesize readByteCount = _readByteCount;

synthesize_(wasCancelled);

- (id) init {
    if((self = [super init])) {
        self.timeoutTimer = [FLTimeoutTimer timeoutTimer:FLNetworkConnectionDefaultTimeout];
        
        [self.timeoutTimer addObserver:self forEvent:FLTimeoutTimerTimeoutEvent eventHandler:@selector(setTimedOut:)];
    }
    
    return self;
}

- (id<FLNetworkStream>) createNetworkStream {
    return nil;
}

- (void) dealloc  {
    FLAssert_(!_networkStream.isOpen);

    if(_networkStream) {
        _networkStream.delegate = nil;
    }

//    [self visitObservers:^(id observer, BOOL* stop) {
//        FLPerformSelectorWithObject(observer, @selector(observerWasRemovedFromNetworkConnection:), self);
//    }];

    [_timeoutTimer removeObserver:self];
    [_timeoutTimer requestCancel];

#if FL_MRC
    [_timeoutTimer release];
    [_finisher release];
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
     [self.networkStream closeStream:[NSError timeoutError]];
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

- (void) networkStreamWillClose:(id<FLNetworkStream>) networkStream withError:(NSError*) error {
    [self.timeoutTimer touchTimestamp];
}

- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream withError:(NSError*) error {
    [self.timeoutTimer touchTimestamp];
}

- (id) resultFromStream:(id<FLNetworkStream>) stream {
    return nil;
}

- (void) startWorking:(id) asyncTask {
    FLAssertIsNil_(self.networkStream);
    [self postObservation:@selector(networkConnectionStarting:)];
   
    self.networkStream = [self createNetworkStream];
    
    FLAssertIsNotNil_(self.networkStream);
    
    [self.networkStream setDelegate:self];

    if(![self checkReachability]) {
        NSError* error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet localizedDescription:NSLocalizedString(@"Not Connected to Network", nil)];
        if(error) {
            FLThrowError_(error);
        }
    }

    self.thread = [NSThread currentThread];

    [self.networkStream openStream:^(id closedStream, NSError* error) {
        
        [self.networkStream setDelegate:nil];
        self.networkStream = nil;
        self.thread = nil;
        [self postObservation:@selector(networkConnectionDisconnected:)];
         
        [asyncTask addSubFinisher:[FLFinisher finisherWithResultBlock:^(id result) {
            [self postObservation:@selector(networkConnectionFinished:)];
        }]];

        if(error) {
            FLDebugLog(@"stream received error: %@", [[closedStream error] localizedDescription]);
            [asyncTask setFinishedWithResult:error];
        } 
        else {
            [asyncTask setFinishedWithResult:[self resultFromStream:closedStream]];
        }
    }];
}

- (id) runSynchronously {
    return [self runSynchronouslyWithAsyncTask:[FLFinisher finisher]];;
}

- (id) runSynchronouslyWithAsyncTask:(id) asyncTask {
    [self startWorking:asyncTask];
    [asyncTask waitUntilFinished];
    return [asyncTask result];
}


- (void) requestCancel {
    BOOL shouldCancel = NO;
    if(!self.wasCancelled) {
        @synchronized(self) {
            if(!self.wasCancelled && self.networkStream.isOpen) {
                shouldCancel = YES;
                self.wasCancelled = YES;
            }
        }
    }

    if(shouldCancel) {
        [self.networkStream closeStream:[NSError timeoutError]];
    }
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


