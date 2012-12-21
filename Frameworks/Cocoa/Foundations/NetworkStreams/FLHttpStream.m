//
//  FLHttpStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpStream.h"
#import "FLCoreFoundation.h"
#import "FLReadStream.h"

@interface FLHttpStream ()
@property (readwrite, strong) FLHttpResponse* httpResponse;
@property (readwrite, strong) FLHttpRequest* httpRequest;
@property (readwrite, strong) FLReadStream* httpStream;
@property (readwrite, strong) FLDispatchQueue* dispatchQueue;
@property (readwrite, strong) FLFinisher* finisher;

- (void) readResponseHeadersIfNeeded;
- (void) openHttpStreamToURL:(NSURL*) url;
@end

@interface FLHttpResponse (Utils)
// http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
@property (readonly, assign, nonatomic) BOOL wantsRedirect;
@property (readonly, assign, nonatomic) BOOL responseCodeIsRedirect;
@end

@interface FLReadStream (Http)
- (FLHttpMessage*) readResponseHeaders;
@end

@implementation  FLHttpResponse (Utils)
- (BOOL) responseCodeIsRedirect
{
    switch(self.responseStatusCode)
    {
        case 301: // Moved Permanently.
        case 302: // Found.
        case 304: // Not Modified.
        case 307: // Temporary Redirect.
            return YES;
            break;
    }
    
    return NO;
}        

- (BOOL) wantsRedirect {
    return self.responseCodeIsRedirect && FLStringIsNotEmpty([self valueForHeader:@"Location"]); 
}


- (NSURL*) redirectURL {
    return [NSURL URLWithString:[self valueForHeader:@"Location"] relativeToURL:self.requestURL];
}
@end

@implementation FLHttpRequest (Utils)

- (FLReadStream*) createHttpStreamWithURL:(NSURL*) url {

    FLReadStream* httpStream = nil;
    CFReadStreamRef ref = nil;
    @try {
    
        FLHttpMessage* message = [FLHttpMessage httpMessageWithURL:url HTTPMethod:self.HTTPMethod];
        if(message) {
            [message setHeaders:self.allHTTPHeaderFields];
            
            NSInputStream* inputStream = self.HTTPBodyStream;
            if(inputStream) {
                // I don't quite get why we're making a read stream for a httpStream???
                ref = CFReadStreamCreateForStreamedHTTPRequest(kCFAllocatorDefault,
                                        message.messageRef,
                                        bridge_(CFReadStreamRef, inputStream));
            }
            else if(self.HTTPBody) {
                message.bodyData = self.HTTPBody;
                ref = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, message.messageRef);
            }
            
            FLConfirmNotNil_v(ref, @"unable to create CFReadStreamRef - HTTPBody or HTTPBodyStream required");
                    
            httpStream = [FLReadStream readStream:ref];
        }

        FLConfirmNotNil_v(httpStream, @"unable to create FLReadStream");
    }
    @finally {
        if(ref) {
            CFRelease(ref);
        }
    }
    
    return httpStream;
}


@end

@implementation FLHttpStream

@synthesize httpResponse = _response;
@synthesize httpRequest = _request;
@synthesize httpStream = _httpStream;
@synthesize redirector = _redirector;
@synthesize dispatchQueue = _dispatchQueue;
@synthesize finisher = _finisher;

- (id) init {
    self = [super init];
    if(self) {
    }
    
    return self;
}

+ (id) httpStream {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc  {
    _httpStream.delegate = nil;
    FLReleasePooledObject(&_dispatchQueue);
#if FL_MRC
    [_request release];
    [_response release];
    [_httpStream release];
    [super dealloc];
#endif
}

#define kStreamReadChunkSize 1024

//- (void) networkStream:(FLNetworkStream*) stream 
// closeStreamWithResult:(id) result {
// 
//    if(_httpStream) {
//        [_httpStream closeStreamWithResult:result];
//    }
//}

- (void) openHttpStreamToURL:(NSURL*) url {

    FLMutableHttpResponse* newResponse = nil;
    FLHttpResponse* prev = self.httpResponse;
    
    if(prev && prev.wantsRedirect) {
        newResponse  = [FLMutableHttpResponse httpResponse:url redirectedFrom:prev];
    }
    else {
        // what if there is a response already, but it's not a redirect??? 
        FLAssertIsNil_(prev);
        newResponse  = [FLMutableHttpResponse httpResponse:url];
    }

    newResponse.mutableResponseData = [NSMutableData dataWithCapacity:kStreamReadChunkSize]; 
    self.httpResponse = newResponse;
    self.httpStream = [self.httpRequest createHttpStreamWithURL:url];
    self.httpStream.delegate = self;

    [self.httpStream openStreamWithInput:self.httpRequest];
}

- (BOOL) isOpen {
    return self.httpStream != nil && self.httpStream.isOpen;
}

- (void) readResponseHeadersIfNeeded  {
    
    if(!_response.responseHeaders) {
        FLHttpMessage* message = [self.httpStream readResponseHeaders];
        if(message.isHeaderComplete) {
            [_response setResponseHeadersWithHttpMessage:message];
            
            if(!_response.redirectedFrom) {
                [self postObservation:@selector(httpStreamDidOpen:)];
            }
            
            [self postObservation:@selector(httpStreamDidWriteBytes:)];
            [self postObservation:@selector(httpStreamDidReadBytes:)];
        }
    }
}

- (void) releaseStream {
    self.httpStream.delegate = nil;
    self.httpStream = nil;
}

- (void) didCloseWithResult:(id) result {
    [self releaseStream];
    [self postObservation:@selector(httpStream:didCloseWithResult:) withObject:result];
    
    if(![result error]) {
        result = self.httpResponse;
    }
    
    if(self.finisher) {
        [self.finisher setFinishedWithResult:result];
    }
    
    self.httpRequest = nil;
    self.finisher = nil;
    self.httpStream = nil;
    self.httpResponse = nil;
}

- (void) closeStreamWithResult:(id) result {
    [self.dispatchQueue dispatchBlock:^{
        [self.httpStream closeStreamWithResult:result];
    }];
}

- (void) requestCancel {
    [self.httpStream requestCancel];
}

- (FLResult) sendSynchronousRequest:(FLHttpRequest*) request {
    return [[self sendRequest:request] waitUntilFinished];
}

- (void) startRequest {
    [self.dispatchQueue dispatchBlock:^{
        [self openHttpStreamToURL:self.httpRequest.requestURL];
    }];
}

- (FLFinisher*) sendRequest:(FLHttpRequest*) request {
    self.httpRequest = request;
    self.finisher = [FLFinisher finisher];
    
    if(!self.dispatchQueue) {
        [[FLFifoDispatchQueue pool] requestPooledObject:^(id<FLDispatcher> dispatcher) {
            self.dispatchQueue = dispatcher;
            [self startRequest];
        }];
    }
    else {
        [self startRequest];
    }
    
    return self.finisher;
}


- (void) readStreamDidOpen:(FLReadStream*) httpStream {
    [self.dispatchQueue dispatchBlock:^{
        [self readResponseHeadersIfNeeded];
    }];
}

- (void) readStream:(FLReadStream*) networkStream 
    didCloseWithResult:(FLResult) result {
    
    [self.dispatchQueue dispatchBlock:^{
        if([result error]) {
            [self didCloseWithResult:result];
        }
        else {

            [self readResponseHeadersIfNeeded];
            
            // FIXME: there was an issue here with progress getting fouled up on redirects.
            //    [self connectionGotTimerEvent];

            BOOL redirect = _response.wantsRedirect;
            if(redirect) {
                
                NSURL* redirectURL = self.httpResponse.redirectURL;

                [self.redirector httpStream:self shouldRedirect:&redirect toURL:redirectURL];
                
                if(redirect) {
                    [self releaseStream];
                    [self openHttpStreamToURL:redirectURL];
                }
            }

            if(!redirect) {
                [self didCloseWithResult:result];
            }
        }
    }];      
}

- (void) readStream:(FLReadStream*) readStream
   didEncounterError:(NSError*) error {

    [self closeStreamWithResult:error];
}

- (void) readStreamHasBytesAvailable:(id<FLReadStream>) httpStream {
    [self.dispatchQueue dispatchBlock:^{
        [self readResponseHeadersIfNeeded];
        [self.httpStream readAvailableBytes:_response.mutableResponseData];
    }];
}

- (void) readStream:(id<FLReadStream>) stream didReadBytes:(unsigned long) amountRead {
    [self postObservation:@selector(httpStreamDidReadBytes:)];
}


@end

@implementation FLReadStream (Http)
- (FLHttpMessage*) readResponseHeaders {
    
    CFHTTPMessageRef ref = (CFHTTPMessageRef)CFReadStreamCopyProperty(_streamRef, kCFStreamPropertyHTTPResponseHeader);
    @try {
        return [FLHttpMessage httpMessageWithHttpMessageRef:ref];
    }
    @finally {
        if(ref) {
            CFRelease(ref);
        }
    }
}

- (unsigned long) bytesWritten {
    NSNumber* number = FLAutorelease(bridge_transfer_(NSNumber*,
        CFReadStreamCopyProperty(_streamRef, kCFStreamPropertyHTTPRequestBytesWrittenCount)));
    
    return number.unsignedLongValue;
}


@end

//- (void) httpStream:(FLHttpStream*) httpStream
//        shouldRedirect:(BOOL*) redirect
//                 toURL:(NSURL*) url {
//
//    [httpStream touchTimestamp];
//   
//    // FIXME
//      
///*    
//    [self visitObservers:^(id<FLNetworkConnectionObserver> observer, BOOL* stop) { 
//        
//        if([observer respondsToSelector:@selector(networkConnection:shouldRedirect:toURL:)]) {
//            [observer networkConnection:self shouldRedirect:redirect toURL:url];
//        }
//        
//        if(*redirect) {
//            *stop = YES;
//        }
//    }];
// */
//}
