//
//  FLHttpStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpStream.h"

@interface FLHttpStream ()
@property (readwrite, strong) FLHttpResponse* httpResponse;
@property (readwrite, strong) FLHttpRequest* httpRequest;
@property (readwrite, strong) FLReadStream* readStream;
@property (readwrite, strong) FLByteBuffer* buffer;
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
    [self finalizeHeaders];
    FLHttpMessage* message = [FLHttpMessage httpMessageWithURL:atURL requestMethod:self.requestMethod];
    [message setHeaders:self.requestHeaders];
    return message;
}

- (FLReadStream*) createReadStreamForRequestWithURL:(NSURL*) atURL {

    CFReadStreamRef ref = nil;

    if(!atURL) {
        atURL = self.requestURL;
    }

    FLHttpMessage* message = [self messageForRequest:atURL];
    
    if(FLStringIsNotEmpty(self.postBodyFilePath)) {
        NSInputStream* inputStream = [NSInputStream inputStreamWithFileAtPath:self.postBodyFilePath];

        ref =   CFReadStreamCreateForStreamedHTTPRequest(kCFAllocatorDefault,
                                message.messageRef,
                                (__bridge_fl CFReadStreamRef) inputStream);
    }
    else {
        if(self.postData) {
            message.bodyData = self.postData;
        }
        
        ref = CFReadStreamCreateForHTTPRequest(
            kCFAllocatorDefault,
            message.messageRef);
    }
    FLReadStream* readStream = [FLReadStream readStream:ref];
    
    CFRelease(ref);
    return readStream;
}


@end

@implementation FLHttpStream

@synthesize httpResponse = _response;
@synthesize httpRequest = _request;
@synthesize readStream = _readStream;
@synthesize buffer = _buffer;

- (id) initWithHttpRequest:(FLHttpRequest*) request {
    self = [super init];
    if(self) {
        self.httpRequest = request;
    }
    
    return self;
}

+ (id) httpStream:(FLHttpRequest*) request {
    return FLReturnAutoreleased([[[self class] alloc] initWithHttpRequest:request]);
}

- (void) dealloc  {
    if(_readStream) {
        _readStream.delegate = nil;
        [_readStream closeStream];
    }
    
#if FL_NO_ARC
    [_readBuffer release];
    [_request release];
    [_response release];
    [_readStream release];
    [super dealloc];
#endif
}

#define kStreamReadChunkSize 1024

- (void) setNewReadStream:(FLReadStream*) stream {
    if(self.readStream) {
        self.readStream.delegate = nil;
        [self.readStream closeStream];
    }
    
    self.readStream = stream;
    self.readStream.delegate = self;
}

- (void) openStreamToURL:(NSURL*) url {
    
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
    
    [self setNewReadStream:[self.httpRequest createReadStreamForRequestWithURL:url]];
    
    [self.readStream openStream];
    
}

- (void) openStream {
    [self openStreamToURL:self.httpRequest.requestURL];
    [super openStream];
}
    
- (void) closeStream {
    if(_readStream) {
        _readStream.delegate = nil;
        [_readStream closeStream];
        self.readStream = nil;
    }
    [super closeStream];
}

- (BOOL) isOpen {
    return self.readStream != nil && self.readStream.isOpen;
}

- (BOOL) isRunning {
    return self.readStream != nil;
}

- (void) readResponseHeadersIfNeeded  {
    
    if(!_response.responseHeaders) {
        FLHttpMessage* message = [self.readStream readResponseHeaders];
        if(message.isHeaderComplete) {
            [_response setResponseHeadersWithHttpMessage:message];
            
            if(!_response.redirectedFrom) {
                [self.delegate performIfRespondsToSelector:@selector(networkStreamDidOpen:) withObject:self];
            }
            
            [self.delegate performIfRespondsToSelector:@selector(writeStreamDidWriteBytes:) withObject:self];
            [self.delegate performIfRespondsToSelector:@selector(readStreamDidReadBytes:) withObject:self];
        }
    }

    
}

- (void) readStreamHasBytesAvailable:(id<FLNetworkStream>) networkStream {
    [self readResponseHeadersIfNeeded];

    [self.readStream readAvailableBytesWithBlock:^(BOOL* stop) {
        [self.readStream appendAvailableBytesToData:_response.mutableResponseData chunkSize:1024];
    }];
}

- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream {
    [self readResponseHeadersIfNeeded];
}

- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream {

    [self readResponseHeadersIfNeeded];

// FIXME: there was an issue here with progress getting fouled up on redirects.
//    [self connectionGotTimerEvent];

    [self closeStream];
            
    BOOL redirect = _response.wantsRedirect;
    if(redirect) {
        NSURL* redirectURL = self.httpResponse.redirectURL;

        if([self.delegate respondsToSelector:@selector(httpStream:shouldRedirect:toURL:)]) {
            [self.delegate httpStream:self shouldRedirect:&redirect toURL:redirectURL];
        }
        
        if(redirect) {
            [self openStreamToURL:redirectURL];
        }
    }
    
    if(!redirect) {
        [self.delegate performIfRespondsToSelector:@selector(networkStreamDidClose:) withObject:self];
    }
}

- (void) networkStreamEncounteredError:(id<FLNetworkStream>) networkStream {
    [self.delegate performIfRespondsToSelector:@selector(networkStreamEncounteredError:) withObject:self];
}


- (void) writeStreamCanAcceptBytes:(id<FLNetworkStream>) networkStream {
    // nah, we're taking care of this with our request
}

- (void) writeStreamDidWriteBytes:(id<FLNetworkStream>) stream {
}

- (void) readStreamDidReadBytes:(id<FLNetworkStream>) stream{
    [self.delegate performIfRespondsToSelector:@selector(readStreamDidReadBytes:) withObject:self];
}


@end

@implementation FLReadStream (Http)
- (FLHttpMessage*) readResponseHeaders {
    CFHTTPMessageRef ref = (CFHTTPMessageRef)CFReadStreamCopyProperty(self.readStream, kCFStreamPropertyHTTPResponseHeader);
    FLHttpMessage* message = [FLHttpMessage httpMessageWithHttpMessageRef:ref];
    CFRelease(ref);
    return message;
}

- (unsigned long) bytesWritten {
    CFTypeRef number = CFReadStreamCopyProperty(self.readStream, kCFStreamPropertyHTTPRequestBytesWrittenCount);
    unsigned long value = [((__bridge_fl NSNumber*) number) unsignedLongValue];
    CFRelease(number);
    return value;
}


@end

