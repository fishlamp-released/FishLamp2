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
@property (readwrite, strong) id networkStream;
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

//- (FLNetworkConnectionByteCount) writeByteCount {
//    id<FLNetworkStream> networkStream = self.networkStream;
//    return networkStream ? networkStream.writeByteCount : FLNetworkConnectionByteCountZero;
//}
//
//- (FLNetworkConnectionByteCount) readByteCount {
//    id<FLNetworkStream> networkStream = self.networkStream;
//    return networkStream ? networkStream.readByteCount : FLNetworkConnectionByteCountZero;
//}

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

#if FL_NO_ARC
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

- (void) closeConnectionWithError:(NSError*) error {
    [self.timeoutTimer requestCancel];
    
    [self.networkStream setDelegate:nil];
    [self.networkStream closeStream];
    self.networkStream = nil;
    self.thread = nil;
    id<FLResult> result = nil;
    
    if(error) {
        result = [FLResult resultWithError:error];
    }
    
    [self.finisher setFinishedWithResult:result];
    self.finisher = nil;
}

- (void) startWorking:(id<FLFinisher>) finisher {
   @try {
        if(self.networkStream) {
            [self closeConnectionWithError:nil];
        }
       
        self.finisher = finisher;
        self.networkStream = [self createNetworkStream];
    
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
        [self closeConnectionWithError:ex.error];
    }
}

- (id<FLResultPromise>) start:(FLCompletionBlock) completion {
    FLFinisher* finisher = [FLFinisher finisher:completion];
    [self startWorking:finisher];
    return finisher;
}

- (id<FLResult>) runSynchronously {
    return [[self start:nil] waitForResult];
}


//- (id<FLResultPromise>) openConnection:(FLCompletionBlock) completionBlock {
//    FLFinisher* finisher = [FLFinisher finisher:completionBlock];
//    [self startWorking:finisher];
//    return finisher;
//}

- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream {
    [self postObservation:@selector(networkConnectionFinished:)];
    [self closeConnectionWithError:nil];
}

- (void) cancelConnection {
    [self.networkStream closeStream];
    [self closeConnectionWithError:[NSError cancelError]];
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
        [self closeConnectionWithError:error];
    }
}

- (void) networkStreamDidWriteBytes:(id<FLWriteStream>) stream {

    unsigned long bytes = stream.bytesWritten; 

    FLNetworkConnectionByteCount byteCount = self.writeByteCount;
    byteCount.lastChunkCount = bytes - byteCount.totalCount;
    byteCount.totalCount = bytes;
    self.writeByteCount = byteCount;

    [self touchTimestamp];
}

- (void) networkStreamDidReadBytes:(id<FLReadStream>) stream {

    unsigned long bytes = stream.bytesRead; 

    FLNetworkConnectionByteCount byteCount = self.readByteCount;
    byteCount.lastChunkCount = bytes - byteCount.totalCount;
    byteCount.totalCount = bytes;
    self.readByteCount = byteCount;

    [self touchTimestamp];
}

- (void) readStreamHasBytesAvailable:(id<FLReadStream>) networkStream {
    [self touchTimestamp];
    FLAssertFailed_v(@"this should be handled");
}

- (void) writeStreamCanAcceptBytes:(id<FLWriteStream>) networkStream {
    [self touchTimestamp];
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


