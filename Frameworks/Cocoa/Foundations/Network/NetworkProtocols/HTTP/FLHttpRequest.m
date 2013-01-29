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
#import "FishLampCore.h"
#import "FLHttpMessage.h"
#import "FLDispatching.h"
#import "FLDispatchQueue.h"

//#if IOS
//#import <UIKit/UIKit.h>
//#endif

#define kStreamReadChunkSize 1024

@interface FLHttpRequest ()
@property (readwrite, strong) FLHttpResponse* httpResponse;
@property (readwrite, strong) FLReadStream* networkStream;
@property (readwrite, strong) id<FLDispatching> dispatcher;
@property (readwrite, strong) id observer;
@property (readwrite, strong) id context;

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
@synthesize observer = _observer;
@synthesize body = _body;
@synthesize context = _context;
@synthesize headers = _headers;
@synthesize dispatcher = _dispatcher;
@synthesize authenticationDisabled = _authenticationDisabled;

- (id) init {
    self = [self initWithRequestURL:nil httpMethod:nil];
    if(self) {
    }
    
    return self;
}

-(id) initWithRequestURL:(NSURL*) url httpMethod:(NSString*) httpMethod {
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
    [_dispatcher release];
    [_headers release];
    [_context release];
    [_observer release];
    [_body release];
    [_response release];
    [_networkStream release];
    [super dealloc];
#endif
}

- (void) didMoveToContext:(id)context {
    if(context != self.context) {
        self.context = context;
    }
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
                // I don't quite get why we're making a read stream for a networkStream???
                ref = CFReadStreamCreateForStreamedHTTPRequest(kCFAllocatorDefault,
                                        message.messageRef,
                                        bridge_(CFReadStreamRef, inputStream));
            }
            else if(self.body.bodyData) {
                message.bodyData = self.body.bodyData;
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
                FLPerformSelector1(self.observer, @selector(httpRequestDidOpen:), self);
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
        FLPerformSelector2(self.observer, @selector(httpRequest:didCloseWithResult:), self, result);
        
        if(self.observer) {
            [self.observer setFinishedWithResult:result];
        }
        
        [self.context httpRequestDidFinish:self];

        self.observer = nil;
        self.networkStream = nil;
        self.httpResponse = nil;
        
        self.dispatcher = nil;
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

- (void) readStream:(FLReadStream*) readStream
   didEncounterError:(NSError*) error {

    [self closeStreamWithResult:error];
}

- (void) readStreamHasBytesAvailable:(id<FLReadStream>) networkStream {
    [self.dispatcher dispatchBlock:^{
        [self readResponseHeadersIfNeeded];
        [self.networkStream readAvailableBytes:_response.mutableResponseData];
    }];
}

- (void) readStream:(id<FLReadStream>) stream didReadBytes:(unsigned long) amountRead {
//    [self postObservableEvent:FLHttpRequestDidReadBytesEvent];

//    FLPerformSelector1(self.observer, @selector(httpRequestDidReadBytes:amount::), self);
}

- (void) willAuthenticateHttpRequest:(id<FLHttpRequestAuthenticator>) authenticator {
    FLPerformSelector1(self.observer, @selector(httpRequestWillAuthenticate:), self);
}

- (void) didAuthenticateHttpRequest {
    FLPerformSelector1(self.observer, @selector(httpRequestDidAuthenticate:), self);
}

- (void) sendRequest {
    FLPerformSelector1(self.observer, @selector(httpRequestWillOpen:), self);
    self.dispatcher = [FLFifoDispatchQueue fifoDispatchQueue];
    [self.dispatcher dispatchBlock:^{
        [self willSendHttpRequest]; // this may set requestURL
        [self openHttpStreamWithURL:self.headers.requestURL];
    }];
}

- (void) startWorking:(FLFinisher*) observer {

    [self.context httpRequestDidStart:self];
    self.observer = observer;

    id<FLDispatching> dispatcher = nil;
    if([self.context respondsToSelector:@selector(httpRequestFifoDispatcher:)]) {
        dispatcher = [self.context httpRequestFifoDispatcher:self];
    }
    
    if(!dispatcher) {
        dispatcher = FLFifoQueue;
    }
    
    [dispatcher dispatchBlock:^{
        @try {
            if(!self.authenticationDisabled) {
                id<FLHttpRequestAuthenticator> authenticator = [self.context httpRequestAuthenticator:self];
                if(authenticator) {
                    [self willAuthenticateHttpRequest:authenticator];
                    [authenticator authenticateHttpRequest:self];
                    [self didAuthenticateHttpRequest];
                }
            }
        
            [self sendRequest];
        }
        @catch(NSException* ex) {
            [self closeStreamWithResult:ex.error];
        }
    }];
    
}

- (NSString*) description {
    NSMutableString* desc = [NSMutableString stringWithFormat:@"%@\r\n", [super description]];
    [desc appendString:[self.headers description]];
    [desc appendString:[self.body description]];
    return desc;
}

- (FLResult) sendSynchronouslyInContext:(id) context 
                         withObserver:(FLFinisher*) observer {

    return [[self startRequestInContext:context withObserver:observer] waitUntilFinished];
}

- (FLResult) sendSynchronouslyInContext:(id) context {
    return [[self startRequestInContext:context withObserver:[FLFinisher finisher]] waitUntilFinished];
}


- (FLFinisher*) startRequestInContext:(id) context 
                         withObserver:(FLFinisher*) observer {

    [self didMoveToContext:context];
    [self startWorking:observer];
    return observer;
}

- (FLFinisher*) startRequestInContext:(id) context {
    return [self startRequestInContext:context withObserver:[FLFinisher finisher]];
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

@implementation FLHttpRequestObserver 
@synthesize willAuthenticate = _willAuthenticate;
@synthesize didAuthenticate = _didAuthenticate;
@synthesize willOpen = _willOpen;
@synthesize didOpen = _didOpen;
@synthesize willClose = _willClose;
@synthesize didClose = _didClose;
@synthesize encounteredError = _encounteredError;
@synthesize didWriteBytes = _didWriteBytes;
@synthesize didReadBytes = _didReadBytes;

#if FL_MRC
- (void) dealloc {
    [_willAuthenticate release];
    [_didAuthenticate release];
    [_willOpen release];
    [_didOpen release];
    [_willClose release];
    [_didClose release];
    [_encounteredError release];
    [_didWriteBytes release];
    [_didReadBytes release];
    [super dealloc];
}
#endif

#define FLInvokeBlock(b, ...) \
    if(b) { \
        dispatch_async(dispatch_get_main_queue(), ^{ \
            b(__VA_ARGS__); \
        }); \
    }

+ (id) httpRequestObserver {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest {
    FLInvokeBlock(self.didAuthenticate);
}

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest {
    FLInvokeBlock(self.willOpen);
}

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest {
    FLInvokeBlock(self.didOpen);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest 
   willCloseWithResult:(FLResult) result {
    FLInvokeBlock(self.willClose, result);
}   

- (void) httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLResult) result {
    FLInvokeBlock(self.didClose, result);
}    

- (void) httpRequest:(FLHttpRequest*) httpRequest
      didEncounterError:(NSError*) error {
    FLInvokeBlock(self.encounteredError, error);
}

- (void) httpRequestDidReadBytes:(FLHttpRequest*) httpRequest  amount:(unsigned long) amount{
    FLInvokeBlock(self.didReadBytes, amount);
}

- (void) httpRequestDidWriteBytes:(FLHttpRequest*) httpRequest  amount:(unsigned long) amount {
    FLInvokeBlock(self.didWriteBytes, amount);
}

@end
