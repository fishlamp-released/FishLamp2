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
#import "FLReachableNetwork.h"

#define kRunLoopMode NSDefaultRunLoopMode

@implementation FLNetworkStream

- (id) init {
    self = [super init];
    if(self) {
        self.timeoutInterval = FLNetworkStreamDefaultTimeout;
    }
    return self;
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
        [self didEncounterError:error];
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

