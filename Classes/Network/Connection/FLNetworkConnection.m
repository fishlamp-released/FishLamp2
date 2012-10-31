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

const FLNetworkConnectionByteCount FLNetworkConnectionByteCountZero = {0, 0, 0};

//typedef enum {
//    FLNetworkConnectionStateNone,
//    FLNetworkConnectionStateConnecting,
//    FLNetworkConnectionStateConnected,
//    FLNetworkConnectionStateDisconnecting,
//    FLNetworkConnectionStateDisconnected
//} FLNetworkConnectionState;


@interface FLNetworkConnection ()
@property (readwrite, assign) NSThread* thread;
@property (readwrite, strong) id<FLNetworkStream> networkStream;
@property (readwrite, strong) id<FLFinisher> finisher;
@property (readwrite, strong) FLTimeoutTimer* timeoutTimer;
@property (readwrite, assign) FLNetworkConnectionByteCount writeByteCount;
@property (readwrite, assign) FLNetworkConnectionByteCount readByteCount;
@end

@implementation FLNetworkConnection

//@synthesize retryCount = _retryCount;

@synthesize finisher = _finisher;
@synthesize networkStream = _networkStream;
@synthesize timeoutTimer = _timeoutTimer;
@synthesize thread = _thread;
@synthesize writeByteCount = _writeByteCount;
@synthesize readByteCount = _readByteCount;

- (id) init {
    if((self = [super init])) {
        self.timeoutTimer = [FLTimeoutTimer timeoutTimer:FLNetworkConnectionDefaultTimeout];
        [self.timeoutTimer addObserver:self];
    }
    
    return self;
}

- (id<FLNetworkStream>) createNetworkStream {
    return nil;
}

- (void) dealloc  {
    if(_networkStream) {
        _networkStream.delegate = nil;
        [_networkStream closeStream];
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
    FLSuperDealloc();
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

- (void) touchTimestamp {
    [self.timeoutTimer touchTimestamp];
}

- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream {
    [self.timeoutTimer touchTimestamp];
    [self postObservation:@selector(networkConnectionConnected:)];
}

- (void) networkStreamWillOpen:(id<FLNetworkStream>) networkStream {
    [self.timeoutTimer touchTimestamp];
    [self postObservation:@selector(networkConnectionConnecting:)];
}

- (void) closeConnection {
    [self.timeoutTimer requestCancel];
    if(self.networkStream) {
        [self.networkStream setDelegate:nil];
        [self.networkStream closeStream];
        self.networkStream = nil;
        self.thread = nil;
        [self postObservation:@selector(networkConnectionDisconnected:)];
    }
}

- (void) setFinishedWithError:(NSError*) error {
    [self closeConnection];

    if(self.finisher) {
        [self postObservation:@selector(networkConnectionFinished:)];
        [self.finisher setFinishedWithError:error];
        self.finisher = nil;
    }
}

- (void) setFinishedWithOutput:(id) output {
    [self closeConnection];
    if(self.finisher) {
        [self postObservation:@selector(networkConnectionFinished:)];
        [self.finisher setFinishedWithOutput:output];
        self.finisher = nil;
    }
}

- (void) startWorking:(id<FLFinisher>) finisher {
   @try {
        FLAssertIsNil_(self.networkStream);
       
        self.finisher = finisher;
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

        [self postObservation:@selector(networkConnectionStarting:)];
        [self.networkStream openStream];
    }
    @catch(NSException* ex) {
        [self setFinishedWithError:ex.error];
    }
}

- (id<FLPromisedResult>) start:(FLResultBlock) completion {
    FLWorkFinisher* finisher = [FLWorkFinisher finisher:completion];
    [self startWorking:finisher];
    return finisher;
}

- (FLResult) runSynchronously {
    return [[self start:nil] waitForResult];
}

- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream {

    if(networkStream.error) {
        [self setFinishedWithError:networkStream.error];
    }
    else {
        [self setFinishedWithOutput:networkStream.output];
    }
}

- (void) cancelConnection {
    [self setFinishedWithError:[NSError cancelError]];
}

- (void) networkStreamEncounteredError:(id<FLNetworkStream>) networkStream {
   
    NSError* error = networkStream.error;
   
    FLDebugLog(@"stream received error: %@", [error localizedDescription]);
    [self touchTimestamp];

    __block BOOL ignoreError = NO;

    [self visitObservers:^(id<FLNetworkConnectionObserver> observer, BOOL* stop) {
        if([observer respondsToSelector:@selector(networkConnection:encounteredError:ignoreError:)]) {
            [observer networkConnection:self encounteredError:error ignoreError:&ignoreError];
        }
    }];

    if(!ignoreError) {
        [self setFinishedWithError:error];
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



//- (BOOL) waitOnceForRunLoop {
//    if(!self.isFinished) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
//        return YES;    
//    }
//    
//    return NO;
//}
//
//- (void) blockUntilFinished {
//    @try {
//        FLRetain(self);
//    
//        while([self waitOnceForRunLoop]) {
//        }
//    }
//    @finally {
//        [self _closeSelf];
//        FLRelease(self);
//    }
//}

//- (void) startWorking:(id<FLFinisher>) finisher {
//
//// TODO: We could define our own thread and run them all on the same thread.
//// We should investigate the perf of this.
//// Perhaps we should have some sort of scheduler abstraction.
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @try {
//            [self openConnectionOnCurrentThread];
//            [self blockUntilFinished];
//        }
//        @catch(NSException* ex) {
//            if(!ex.error.isCancelError) {
//                FLDebugLog(@"Error in network thread: %@", [ex description]);
//            }
//        }
//        @finally {
//            [self _closeSelf];
//            self.thread = nil;
//            
//            [finisher setFinished];
//        }
//    });
//}

//- (void) connect {
//    [self openConnectionAsync:nil];
//    [self blockUntilFinished];
//}




@end


