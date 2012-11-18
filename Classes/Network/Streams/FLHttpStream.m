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
@property (readwrite, strong) FLReadStream* readStream;
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

- (FLHttpMessage*) messageForRequest:(NSURL*) atURL {
    FLHttpMessage* message = [FLHttpMessage httpMessageWithURL:atURL requestMethod:self.requestMethod];
    [message setHeaders:self.requestHeaders];
    return message;
}

- (FLReadStream*) createReadStreamForRequestWithURL:(NSURL*) atURL {

    if(!atURL) {
        atURL = self.requestURL;
    }

    CFReadStreamRef ref = nil;
    @try {
    
        FLHttpMessage* message = [self messageForRequest:atURL];
        if(!message) {
            return nil;
        }

        if(FLStringIsNotEmpty(self.postBodyFilePath)) {
            NSInputStream* inputStream = [NSInputStream inputStreamWithFileAtPath:self.postBodyFilePath];

            ref =   CFReadStreamCreateForStreamedHTTPRequest(kCFAllocatorDefault,
                                    message.messageRef,
                                    bridge_(CFReadStreamRef, inputStream));
        }
        else {
            if(self.postData) {
                message.bodyData = self.postData;
            }
            
            ref = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, message.messageRef);
        }

        return [FLReadStream readStream:ref];
    }
    @finally {
        if(ref) {
            CFRelease(ref);
        }
    }
    
    return nil;
}


@end

@implementation FLHttpStream

@synthesize httpResponse = _response;
@synthesize httpRequest = _request;
@synthesize readStream = _readStream;

- (id) initWithHttpRequest:(FLHttpRequest*) request {
    self = [super init];
    if(self) {
        self.httpRequest = request;
    }
    
    return self;
}

+ (id) httpStream:(FLHttpRequest*) request {
    return autorelease_([[[self class] alloc] initWithHttpRequest:request]);
}

- (id) output {
    return self.httpResponse;
}

- (void) dealloc  {
        
#if FL_MRC
    [_request release];
    [_response release];
    [_readStream release];
    [super dealloc];
#endif
}

#define kStreamReadChunkSize 1024

- (void) closeReadStream:(NSError*) error {
    if(_readStream) {
        [_readStream removeObserver:self];
        [_readStream closeStream:error];
        self.readStream = nil;
    }
}
- (void) openStreamToURL:(NSURL*) url {

    [self closeReadStream:nil];
    
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
    self.readStream = [self.httpRequest createReadStreamForRequestWithURL:url];
    [self.readStream addObserver:self];
    [self.readStream openStream:nil];
}

- (void) networkStreamOpenStream:(id<FLNetworkStream>) stream {
    [self openStreamToURL:self.httpRequest.requestURL];
}

- (void) networkStreamCloseStream:(id<FLNetworkStream>) stream withError:(NSError*) error {
    [self closeReadStream:error];
}

- (BOOL) isOpen {
    return self.readStream != nil && self.readStream.isOpen;
}

- (NSError*) error {
   return self.readStream.error;
}

- (id) resultFromStream:(id<FLNetworkStream>) stream {
    return [((FLHttpStream*) stream) httpResponse];
}

- (void) readResponseHeadersIfNeeded  {
    
    if(!_response.responseHeaders) {
        FLHttpMessage* message = [self.readStream readResponseHeaders];
        if(message.isHeaderComplete) {
            [_response setResponseHeadersWithHttpMessage:message];
            
            if(!_response.redirectedFrom) {
                [self postObservation:@selector(networkStreamDidOpen:)];
            }
            
            [self postObservation:@selector(writeStreamDidWriteBytes:)];
            [self postObservation:@selector(readStreamDidReadBytes:)];
        }
    }
}

- (void) readStreamHasBytesAvailable:(id<FLNetworkStream>) networkStream {
    
    [self queueStreamTask:^(FLNetworkStream* stream) {
        FLHttpStream* httpStream = (FLHttpStream*) stream;
        [httpStream readResponseHeadersIfNeeded];
        [httpStream.readStream appendBytesToMutableData:_response.mutableResponseData];
    }];
}

- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream {
    [self queueStreamTask:^(FLNetworkStream* stream) {
        FLHttpStream* httpStream = (FLHttpStream*) stream;
        [httpStream readResponseHeadersIfNeeded];
    }];
}

- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream withError:(NSError*) error {

    BOOL redirect = NO;
    
    if(!error) {
        [self readResponseHeadersIfNeeded];

    // FIXME: there was an issue here with progress getting fouled up on redirects.
    //    [self connectionGotTimerEvent];

        redirect = _response.wantsRedirect;
        if(redirect) {
            NSURL* redirectURL = self.httpResponse.redirectURL;

// FIXME
//                if([self.delegate respondsToSelector:@selector(httpStream:shouldRedirect:toURL:)]) {
//                    [self.delegate httpStream:self shouldRedirect:&redirect toURL:redirectURL];
//                }
            
            if(redirect) {
                [self openStreamToURL:redirectURL];
            }
        }
    }

    if(!redirect) {
        [self closeStream:nil];
    }
}

- (void) writeStreamCanAcceptBytes:(id<FLNetworkStream>) networkStream {
    // nah, we're taking care of this with our request
}

- (void) writeStreamDidWriteBytes:(id<FLNetworkStream>) stream {
}

- (void) readStreamDidReadBytes:(id<FLNetworkStream>) stream{
    [self postObservation:@selector(readStreamDidReadBytes:)];
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
    NSNumber* number = autorelease_(bridge_transfer_(NSNumber*,
        CFReadStreamCopyProperty(_streamRef, kCFStreamPropertyHTTPRequestBytesWrittenCount)));
    
    return number.unsignedLongValue;
}


@end

