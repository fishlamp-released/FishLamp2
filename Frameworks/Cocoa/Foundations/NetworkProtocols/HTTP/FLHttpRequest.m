//
//  FLHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLAppInfo.h"
#import "FLCoreFoundation.h"
#import "FLReadStream.h"
#import "FLCore.h"
#import "FLHttpMessage.h"
#import "FLRequestContext.h"

//#if IOS
//#import <UIKit/UIKit.h>
//#endif

#define kStreamReadChunkSize 1024

@interface FLHttpRequest ()
@property (readwrite, strong) FLHttpResponse* httpResponse;
@property (readwrite, strong) FLReadStream* networkStream;
@property (readwrite, strong) FLDispatchQueue* dispatchQueue;
@property (readwrite, strong) FLFinisher* finisher;

- (void) readResponseHeadersIfNeeded;
- (void) openHttpStreamWithURL:(NSURL*) url;

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


@implementation FLHttpRequest
@synthesize httpResponse = _response;
@synthesize networkStream = _networkStream;
@synthesize dispatchQueue = _dispatchQueue;
@synthesize finisher = _finisher;
@synthesize httpBody = _content;
@synthesize requestContext = _requestContext;

- (id) init {
    self = [self initWithRequestURL:nil httpMethod:nil];
    if(self) {
    }
    
    return self;
}

-(id) initWithRequestURL:(NSURL*) url httpMethod:(NSString*) httpMethod {
    if((self = [super init])) {
        _content = [[FLHttpRequestContent alloc] init];

        self.httpHeaders.requestURL = url;
        self.httpHeaders.httpMethod = httpMethod;
        
        if(FLStringIsEmpty(httpMethod)) {
            self.httpHeaders.httpMethod= @"GET";
        }
        else {
            self.httpHeaders.httpMethod = httpMethod;
        }
    }
    
    return self;
}

- (id) initWithRequestURL:(NSURL*) url  {
    return [self initWithRequestURL:url httpMethod:nil];
}

- (void) dealloc {
    _networkStream.delegate = nil;
    FLReleasePooledObject(&_dispatchQueue);

#if FL_MRC
    [_requestContext release];
    [_finisher release];
    [_content release];
    [_response release];
    [_networkStream release];
    [super dealloc];
#endif
}

+ (id) httpGetRequest:(NSURL*) url {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:@"GET"]);
}

+ (id) httpRequest {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) httpRequest:(NSURL*) url httpMethod:(NSString*) httpMethod {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:httpMethod]);
}

+ (id) httpPostRequest:(NSURL*) url {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:@"POST"]);
}

- (FLHttpRequestHeaders*) httpHeaders {
    return _content.httpHeaders;
}

//- (void) copyTo:(FLHttpRequest*) request {
//    request.httpMethod = FLAutorelease([self.httpMethod copy]);
//    request.allHTTPHeaderFields = FLAutorelease([self.allHTTPHeaderFields mutableCopy]);
//    request.requestURL = FLAutorelease([self.requestURL copy]);
//    request.postBodyFilePath = FLAutorelease([self.postBodyFilePath copy]);
//    request.HTTPBody = FLAutorelease([self.HTTPBody copy]);
//    request.postLength = self.postLength;
//    request.HTTPBodyStream = FLAutorelease([self.HTTPBodyStream copy]);
//}

- (id)copyWithZone:(NSZone *)zone {
    FLHttpRequest* request = [[[self class] alloc] initWithRequestURL:self.httpHeaders.requestURL httpMethod:self.httpHeaders.httpMethod];
//    [self copyTo:request];
    return request;
}

- (FLReadStream*) createNetworkStreamToURL:(NSURL*) url {

    FLReadStream* networkStream = nil;
    CFReadStreamRef ref = nil;
    @try {
    
        FLHttpMessage* message = [FLHttpMessage httpMessageWithURL:url 
                                                        httpMethod:self.httpHeaders.httpMethod];
                                                        
        if(message) {
            [message setHeaders:self.httpHeaders.allHeaders];
            
            NSInputStream* inputStream = self.httpBody.bodyStream;
            if(inputStream) {
                // I don't quite get why we're making a read stream for a networkStream???
                ref = CFReadStreamCreateForStreamedHTTPRequest(kCFAllocatorDefault,
                                        message.messageRef,
                                        bridge_(CFReadStreamRef, inputStream));
            }
            else if(self.httpBody.bodyData) {
                message.bodyData = self.httpBody.bodyData;
                ref = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, message.messageRef);
            }
            
            FLConfirmNotNil_v(ref, @"unable to create CFReadStreamRef - HTTPBody or HTTPBodyStream required");
                    
            networkStream = [FLReadStream readStream:ref];
        }

        FLConfirmNotNil_v(networkStream, @"unable to create FLReadStream");
    }
    @finally {
        if(ref) {
            CFRelease(ref);
        }
    }
    
    return networkStream;
}

- (void) openHttpStreamWithURL:(NSURL*) url {

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
    self.networkStream = [self createNetworkStreamToURL:url];
    self.networkStream.delegate = self;
    [self.networkStream openStreamWithInput:nil];
}

- (BOOL) isOpen {
    return self.networkStream != nil && self.networkStream.isOpen;
}

- (void) readResponseHeadersIfNeeded  {
    
    if(!_response.responseHeaders) {
        FLHttpMessage* message = [self.networkStream readResponseHeaders];
        if(message.isHeaderComplete) {
            [_response setResponseHeadersWithHttpMessage:message];
            
            if(!_response.redirectedFrom) {
                [self postObservation:@selector(httpRequestDidOpen:)];
            }
            
            [self postObservation:@selector(httpRequestDidWriteBytes:)];
            [self postObservation:@selector(httpRequestDidReadBytes:)];
        }
    }
}

- (void) releaseStream {
    self.networkStream.delegate = nil;
    self.networkStream = nil;
}

- (id) didReceiveHttpResponse:(FLHttpResponse*) httpResponse {
    return httpResponse;
}

- (void) didCloseWithResult:(FLResult) result {
    [self releaseStream];
    
    @try {
        if(![result error]) {
            result = [self didReceiveHttpResponse:self.httpResponse];
        }
    }
    @catch(NSException* ex) {
        result = ex.error;
    }
    @finally {
        [self postObservation:@selector(httpRequest:didCloseWithResult:) withObject:result];
        
        if(self.finisher) {
            [self.finisher setFinishedWithResult:result];
        }
        
        self.finisher = nil;
        self.networkStream = nil;
        self.httpResponse = nil;
    }
}

- (void) closeStreamWithResult:(id) result {
    [self.dispatchQueue dispatchBlock:^{
        [self.networkStream closeStreamWithResult:result];
    }];
}

- (void) requestCancel {
    [self.networkStream requestCancel];
}

- (void) willSendHttpRequest {
}

- (void) wasStartedInHttpRequestContext:(FLRequestContext*) context {

}

- (void) readStreamDidOpen:(FLReadStream*) networkStream {
    [self.dispatchQueue dispatchBlock:^{
        [self readResponseHeadersIfNeeded];
    }];
}

- (BOOL) shouldRedirectToURL:(NSURL*) url {
    return YES;
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
                if([self shouldRedirectToURL:redirectURL]) {
                    [self releaseStream];
                    [self openHttpStreamWithURL:redirectURL];
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

- (void) readStreamHasBytesAvailable:(id<FLReadStream>) networkStream {
    [self.dispatchQueue dispatchBlock:^{
        [self readResponseHeadersIfNeeded];
        [self.networkStream readAvailableBytes:_response.mutableResponseData];
    }];
}

- (void) readStream:(id<FLReadStream>) stream didReadBytes:(unsigned long) amountRead {
    [self postObservation:@selector(httpRequestDidReadBytes:)];
}

- (void) startRequest {
    [self.dispatchQueue dispatchBlock:^{
        [self willSendHttpRequest]; // this may set requestURL
        [self openHttpStreamWithURL:self.httpHeaders.requestURL];
    }];
}

- (void) wasDispatched:(FLFinisher*) finisher {

    self.finisher = finisher;
    
    if(!self.dispatchQueue) {
        [[FLFifoDispatchQueue pool] requestPooledObject:^(id<FLDispatcher> dispatcher) {
            self.dispatchQueue = dispatcher;
            [self startRequest];
        }];
    }
    else {
        [self startRequest];
    }
}

- (FLFinisher*) sendRequest:(FLCompletionBlock) completion {
    return [self dispatch:completion];
}

- (FLFinisher*) dispatch:(FLCompletionBlock) completion {
    
    FLFinisher* finisher = [FLFinisher finisher:completion];

    if(_requestContext) {
        [_requestContext sendRequest:self finisher:finisher];
    }
    else {
        [self wasDispatched:finisher];
    }
    
    return finisher;
}


- (FLFinisher*) sendRequest {
    return [self sendRequest:nil];
}

- (FLResult) runSynchronously {
    return [[self sendRequest] waitUntilFinished];
}

- (FLResult) sendRequestSynchronously {
    return [self runSynchronously];
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

