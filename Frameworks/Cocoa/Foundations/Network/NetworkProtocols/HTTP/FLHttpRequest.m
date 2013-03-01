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
#import "FLHttpMessage.h"

//#if IOS
//#import <UIKit/UIKit.h>
//#endif

#define kStreamReadChunkSize 1024

@interface FLHttpRequest ()
@property (readwrite, strong) FLHttpResponse* httpResponse;
@property (readwrite, strong) FLReadStream* networkStream;
@property (readwrite, strong) id<FLDispatcher> dispatcher;
@property (readwrite, strong) id observer;
@property (readwrite, strong) FLFinisher* finisher;

- (void) readResponseHeadersIfNeeded;
- (void) openHttpStreamWithURL:(NSURL*) url;


//- (FLResult) sendSynchronouslyInContext:(id) context
//                         withObserver:(FLFinisher*) observer;
//
//- (FLResult) sendSynchronouslyInContext:(id) context;
//
//- (FLFinisher*) startRequestInContext:(id) context 
//                         withObserver:(FLFinisher*) observer;
//
//- (FLFinisher*) startRequestInContext:(id) context;
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
@synthesize observer = _observer;
@synthesize body = _body;
@synthesize headers = _headers;
@synthesize dispatcher = _dispatcher;
@synthesize dataEncoder = _dataEncoder;
@synthesize dataDecoder = _dataDecoder;
@synthesize authenticator = _authenticator;
@synthesize interceptor = _interceptor;
@synthesize finisher = _finisher;
@synthesize disableAuthenticator = _disableAuthenticator;

- (id) init {
    self = [self initWithRequestURL:nil httpMethod:nil];
    if(self) {
    }
    
    return self;
}

-(id) initWithRequestURL:(NSURL*) url httpMethod:(NSString*) httpMethod {

    FLAssertNotNil_(url);

    if((self = [super init])) {
        _headers = [[FLHttpRequestHeaders alloc] init];
        _body = [[FLHttpRequestBody alloc] initWithHeaders:_headers];

        self.headers.requestURL = url;
        self.headers.httpMethod = httpMethod;
        
        if(FLStringIsEmpty(httpMethod)) {
            self.headers.httpMethod= @"GET";
        }
        else {
            self.headers.httpMethod = httpMethod;
        }
    }
    
    return self;
}

- (id) initWithRequestURL:(NSURL*) url  {
    return [self initWithRequestURL:url httpMethod:nil];
}

- (void) dealloc {
    _networkStream.delegate = nil;
#if FL_MRC
    [_finisher release];
    [_interceptor release];
    [_authenticator release];
    [_dataDecoder release];
    [_dataEncoder release];
    [_dispatcher release];
    [_headers release];
    [_observer release];
    [_body release];
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
    FLHttpRequest* request = [[[self class] alloc] initWithRequestURL:self.headers.requestURL httpMethod:self.headers.httpMethod];

// TODO: copy self
//    [self copyTo:request];
    return request;
}

- (FLReadStream*) createNetworkStreamToURL:(NSURL*) url {

    FLReadStream* networkStream = nil;
    CFReadStreamRef ref = nil;
    @try {
    
        FLHttpMessage* message = [FLHttpMessage httpMessageWithURL:url 
                                                        httpMethod:self.headers.httpMethod];
                                                        
        if(message) {
            [message setHeaders:self.headers.allHeaders];
            
            NSInputStream* inputStream = self.body.bodyStream;
            if(inputStream) {
                ref = CFReadStreamCreateForStreamedHTTPRequest(kCFAllocatorDefault,
                                        message.messageRef,
                                        bridge_(CFReadStreamRef, inputStream));
            }
            else {
                if(self.body.bodyData) {
                    message.bodyData = self.body.bodyData;
                }
                ref = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, message.messageRef);
            }
            
            FLConfirmNotNil_v(ref, @"unable to create CFReadStreamRef");
                    
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
                [self.observer postObservation:@selector(httpRequestDidOpen:) withObject:self];
            }
            
//            [self postObservableEvent:FLHttpRequestDidWriteBytesEvent];
//            [self postObservableEvent:FLHttpRequestDidReadBytesEvent];
        }
    }
}

- (void) releaseStream {
    self.networkStream.delegate = nil;
    self.networkStream = nil;
}

- (FLResult) resultFromHttpResponse:(FLHttpResponse*) httpResponse {
    return httpResponse;
}

- (void) didCloseWithResult:(FLResult) result {
    
    FLAssertNotNil_(result);

    [self releaseStream];
    
    @try {
        if(![result error]) {
            result = [self resultFromHttpResponse:self.httpResponse];
        }
    }
    @catch(NSException* ex) {
        result = ex.error;
    }
    @finally {

        if(self.interceptor) {
            [self.interceptor httpRequest:self didFinishWithResult:result];
        }

        [self.observer postObservation:@selector(httpRequest:didCloseWithResult:) withObject:self withObject:result];
        
        FLFinisher* finisher = FLRetainWithAutorelease(self.finisher);
        self.finisher = nil;
        self.observer = nil;
        self.networkStream = nil;
        self.httpResponse = nil;
        self.dispatcher = nil;
        
        [finisher setFinishedWithResult:result];
    }
}

- (void) closeStreamWithResult:(id) result {
    [self.dispatcher dispatchBlock:^{
        [self.networkStream closeStreamWithResult:result];
    }];
}

- (void) requestCancel {
    [self.networkStream requestCancel];
}

- (void) willSendHttpRequest {
}

- (void) readStreamDidOpen:(FLReadStream*) networkStream {
    
    [self.dispatcher dispatchBlock:^{
        [self readResponseHeadersIfNeeded];
    }];
}

- (BOOL) shouldRedirectToURL:(NSURL*) url {
    return YES;
}

- (void) readStream:(FLReadStream*) networkStream 
 didCloseWithResult:(FLResult) result {
    
    FLAssertNotNil_(result);
    
    [self.dispatcher dispatchBlock:^{
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
                redirect = [self shouldRedirectToURL:redirectURL];
                if(redirect) {
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

- (void) readStream:(FLReadStream*) readStream didEncounterError:(NSError*) error {
    [self.observer postObservation:@selector(httpRequest:didEncounterError:) withObject:self withObject:error];
    [self closeStreamWithResult:error];
}

- (void) readStreamHasBytesAvailable:(id<FLReadStream>) networkStream {
    [self.dispatcher dispatchBlock:^{
        [self readResponseHeadersIfNeeded];
        [self.networkStream readAvailableBytes:_response.mutableResponseData];
    }];
}

- (void) readStream:(id<FLReadStream>) stream didReadBytes:(unsigned long) amountRead {
    [self.observer postObservation:@selector(httpRequest:didReadBytes:) withObject:self withObject:[NSNumber numberWithUnsignedLong:amountRead]];
}

- (void) willAuthenticateHttpRequest:(id<FLHttpRequestAuthenticator>) authenticator {
    [self.observer postObservation:@selector(httpRequestWillAuthenticate:) withObject:self];
}

- (void) didAuthenticateHttpRequest {
    [self.observer postObservation:@selector(httpRequestDidAuthenticate:) withObject:self];
}

- (void) sendRequest {
    [self.observer postObservation:@selector(httpRequestWillOpen:) withObject:self];
    
    self.dispatcher = [FLFifoGcdDispatcher fifoDispatchQueue];
    [self.dispatcher dispatchBlock:^{
        @try {
            [self willSendHttpRequest]; // this may set requestURL
            [self openHttpStreamWithURL:self.headers.requestURL];
        }
        @catch(NSException* ex) {
            [self closeStreamWithResult:ex.error];
        }
    }];
}

- (void) startWorkingInContext:(id)context 
                  withObserver:(id)observer 
                      finisher:(FLFinisher *)finisher {
    
    FLPerformSelector1(context, @selector(httpRequestWillBeginWorking:), self);
    
    if(self.interceptor) {
        [self.interceptor httpRequest:self willSendRequest:observer];
    }

    if(!finisher.isFinished) {
        self.observer = observer;
        self.finisher = finisher;
        
        if(self.disableAuthenticator) {
            self.authenticator = nil;
        }

        id<FLHttpRequestAuthenticator> authenticator = self.authenticator;
        if(authenticator) {
            [[authenticator httpRequestAuthenticationDispatcher:self] dispatchBlock:^{
                @try {
                    [self willAuthenticateHttpRequest:authenticator];
                    [authenticator httpRequest:self authenticateSynchronouslyInContext:context withObserver:nil];
                    [self didAuthenticateHttpRequest];
                    [self sendRequest];
                }
                @catch(NSException* ex) {
                    [self closeStreamWithResult:ex.error];
                }
            }];
        }
        else {
            [self sendRequest];
        }
    }
}

- (NSString*) description {
    NSMutableString* desc = [NSMutableString stringWithFormat:@"%@\r\n", [super description]];
    [desc appendString:[self.headers description]];
    [desc appendString:[self.body description]];
    return desc;
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


