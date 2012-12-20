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
@property (readwrite, strong) FLFinisher* synchronousFinisher;

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
@synthesize delegate = _delegate;
@synthesize dispatchQueue = _dispatchQueue;
@synthesize synchronousFinisher = _synchronousFinisher;

- (id) initWithHttpRequest:(FLHttpRequest*) request {
    self = [super init];
    if(self) {
        self.httpRequest = request;
        
        static int s_count = 0;
        
// TODO: make a pool of these?        
        _dispatchQueue = [[FLDispatchQueue alloc] initWithLabel:[NSString stringWithFormat:@"com.fishlamp.queue.network-stream-%d", ++s_count] 
            attr:DISPATCH_QUEUE_SERIAL];
        
    }
    
    return self;
}

+ (id) httpStream:(FLHttpRequest*) request {
    return FLAutorelease([[[self class] alloc] initWithHttpRequest:request]);
}

- (id) output {
    return self.httpResponse;
}

- (void) dealloc  {
    [_httpStream removeObserver:self];
#if FL_MRC
    [_dispatchQueue release];
    [_request release];
    [_response release];
    [_httpStream release];
    [super dealloc];
#endif
}

#define kStreamReadChunkSize 1024

- (void) closeNetworkStreamWithResult:(id) result {
    if(_httpStream) {
        [_httpStream closeNetworkStreamWithResult:result];
    }
}

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
    [self.httpStream addObserver:self];

    [self.httpStream openNetworkStream];
}

- (void) openNetworkStream {
    [self.dispatchQueue dispatchBlock:^{
        [self openHttpStreamToURL:self.httpRequest.requestURL];
    }];
}

- (BOOL) isOpen {
    return self.httpStream != nil && self.httpStream.isOpen;
}

- (void) networkStream:(id<FLNetworkStream>) stream encounteredError:(NSError *)error {
    [self.dispatchQueue dispatchBlock:^{
        [self closeNetworkStreamWithResult:FLSuccessfullResult];
    }];
}

- (void) readResponseHeadersIfNeeded  {
    
    if(!_response.responseHeaders) {
        FLHttpMessage* message = [self.httpStream readResponseHeaders];
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

- (void) networkStreamHasBytesAvailable:(id<FLNetworkStream>) networkStream {
    [self.dispatchQueue dispatchBlock:^{
        [self readResponseHeadersIfNeeded];
        [self.httpStream appendBytesToMutableData:_response.mutableResponseData];
    }];
}

- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream {
    [self.dispatchQueue dispatchBlock:^{
        [self readResponseHeadersIfNeeded];
    }];
}

- (void) releaseStream {
    [_httpStream removeObserver:self];
    self.httpStream = nil;
}

- (void) didCloseWithResult:(id) result {
    [self releaseStream];
    [self postObservation:@selector(networkStream:didCloseWithResult:) withObject:result];
    if(self.synchronousFinisher) {
        [self.synchronousFinisher setFinishedWithResult:result];
    }
}

- (void) networkStream:(id<FLNetworkStream>) networkStream 
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

                [self.delegate httpStream:self shouldRedirect:&redirect toURL:redirectURL];
                
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

- (void) writeStreamDidWriteBytes:(id<FLNetworkStream>) stream {
}

- (void) readStreamDidReadBytes:(id<FLNetworkStream>) stream{
    [self postObservation:@selector(readStreamDidReadBytes:)];
}

- (void) requestCancel {
    return [self.httpStream requestCancel];
}

- (BOOL) hasBytesAvailable {
    return self.httpStream.hasBytesAvailable;
}

- (unsigned long) bytesRead {
    return self.httpStream.bytesRead;
}

- (NSInteger) appendBytesToMutableData:(NSMutableData*) data {
    return [self.httpStream appendBytesToMutableData:data];
}

- (FLResult) connectSynchronously {
    @try{
        self.synchronousFinisher = [FLFinisher finisher];
        [self openNetworkStream];
        return [self.synchronousFinisher waitUntilFinished];
    }
    @finally {
        self.synchronousFinisher = nil;
    }
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
