//
//  FLHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpConnection.h"
#import "FLGlobalNetworkActivityIndicator.h"
#import "_FLNetworkConnection.h"
#import "FLNetworkConnectionObserver.h"

#if DEBUG
#define TEST_TIMEOUT 0
#endif

@interface FLHttpConnection ()
@property (readwrite, retain, nonatomic) CFHTTPStreamWrapper* inputStream;
@end

@implementation FLHttpConnection

@synthesize inputStream = _inputStream;
@synthesize httpResponse = _response;

- (FLHttpRequest*) httpRequest {
    return [_requestQueue firstObject];
}

- (id) init {
    if((self = [super init])) {
        _requestQueue = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return self;
}

-(id) initWithHttpRequest:(FLHttpRequest*) request {
    if((self = [self init])) {
        [_requestQueue addObject:request];
    }
    
    return self;
}

+ (id) httpConnection:(FLHttpRequest*) request {
    return FLReturnAutoreleased([[[self class] alloc] initWithHttpRequest:request]);
}

- (void) dealloc  {
    FLRelease(_requestQueue);
    FLRelease(_response);
    FLRelease(_inputStream);
    FLSuperDealloc();
}

- (BOOL) isConnectionOpen {
    return self.inputStream != nil && _isOpen;
}

- (void) openNetworkStreams {
    [super openNetworkStreams];
    _isOpen = NO;

    FLReleaseWithNil(_response);
    _response = [[FLHttpResponse alloc] init];

    [self updateLastActivityTimestamp];
    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.inputStream = [[_requestQueue lastObject] openHttpRequest];
    self.inputStream.delegate = self;
}

- (void) closeNetworkStreams {
    [super closeNetworkStreams];
    _isOpen = NO;

    if(self.inputStream) {
        self.inputStream.delegate = nil;
        [[_requestQueue lastObject] closeHttpRequest];
        [self.inputStream close];
        [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.inputStream = nil;
    }
    [self updateLastActivityTimestamp];
}

- (void) readResponseHeaders:(CFHTTPStreamWrapper*) readStream  {
    CFHTTPMessageWrapper* httpMsg = readStream.responseHeader;
    if(httpMsg.isHeaderComplete) {
        _response.responseHeaders = httpMsg.allHeaders;
        _response.responseStatusLine = httpMsg.responseStatusLine;
        _response.responseStatusCode = httpMsg.responseStatusCode;

        [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) { \

             FLNotifyObserver(self, observer, FLNetworkEventWillReadData);

//            if(observer.onWillReadData) {
//                observer.onWillReadData(self);
//            }
        }];
    }

    [self updateLastActivityTimestamp];
}

- (BOOL) shouldRedirectToURL:(NSURL*) url {
    __block BOOL redirect = YES;
        
    [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) {

//         FLNotifyObserver(self, observer, onWillReadData);
//
//
//        if(observer.onWillRedirect) {
//            observer.onWillRedirect(self, &redirect, url); 
//            
//            if(!redirect) {
//                *stop = YES;
//            }
//        }
    }];
    
    return redirect;
}

- (void) startRedirectToURL:(NSURL*) url {
    FLHttpRequest* newRequest = [[_requestQueue lastObject] copy];
    newRequest.requestUrl = url;
    [_requestQueue addObject:newRequest];
    FLRelease(newRequest);
	
    [self openNetworkStreams];
    [self updateLastActivityTimestamp];
}

- (void) readStreamBytesAvailable:(CFHTTPStreamWrapper*) readStream {
    if(!_response.responseHeaders) {
        [self readResponseHeaders:readStream];
    }

    NSInputStream* stream = (NSInputStream*) readStream.readStreamRef;

    FLAssertIsNotNil(stream);
    FLAssertIsType(stream, NSInputStream);

    FLNetworkConnectionByteCount byteCount = self.readByteCount;
    byteCount.lastChunkCount = 0;

    while(stream.hasBytesAvailable) {
// TODO: revisit this number? TODO: Get this from header? 

        static long bufferSize = 16384;
        
    //	if (contentLength > 262144) {
    //		bufferSize = 262144;
    //	} else if (contentLength > 65536) {
    //		bufferSize = 65536;
    //	}

        UInt8 buffer[bufferSize];
        NSInteger bytesRead = [stream read:buffer maxLength:bufferSize];
        if(bytesRead > 0) {
            [_response.responseData appendBytes:buffer length:bytesRead];
        
            byteCount.lastChunkCount += bytesRead;
        }
    }
    
    byteCount.totalCount += byteCount.lastChunkCount;
    self.readByteCount = byteCount;

    [self updateLastActivityTimestamp];
}
            
- (void) readStreamEndEncountered:(CFHTTPStreamWrapper*) readStream {
    [self updateLastActivityTimestamp];
    if(!_response.responseHeaders) {
        [self readResponseHeaders:readStream];
    }
    
    [self connectionGotTimerEvent];
        
    if(_response.wantsRedirect) {
        [self closeNetworkStreams];

        NSURL* redirectURL = [NSURL URLWithString:[_response headerValue:@"Location"] 
                                relativeToURL:[[_requestQueue lastObject] requestUrl]];
    
        if([self shouldRedirectToURL:redirectURL]) {
            [self startRedirectToURL:redirectURL];
            
            return; // else we're done.
        }
    }
    else {
        [self closeConnection];
    }
    [self updateLastActivityTimestamp];
}

- (void) readStreamOpenCompleted:(CFReadStreamWrapper*) readStream {
    _isOpen = YES;
    [self updateLastActivityTimestamp];
    [self connectionDidOpen];
}

- (void) readStreamErrorOccurred:(CFReadStreamWrapper*) readStream {
    self.error = readStream.error;
}
            
- (void) readStreamCanAcceptBytes:(CFReadStreamWrapper*) readStream {
    [self updateLastActivityTimestamp];
    // TODO: add delegate event?
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

- (void) connectionWillOpen {

// TODO: ADD global activity indicator observer

//    [self showActivityIndicator];
    [super connectionWillOpen];
}

@end
