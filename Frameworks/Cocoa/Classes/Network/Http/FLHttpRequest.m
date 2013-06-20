//
//  FLHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHttpRequest.h"
#import "FLAppInfo.h"
#import "FLCoreFoundation.h"
#import "FLReadStream.h"
#import "FLHttpMessage.h"
#import "FLGlobalNetworkActivityIndicator.h"
#import "FLDataSink.h"
#import "FLHttpRequestBody.h"
#import "FLDispatch.h"
#import "FLTimer.h"
#import "FLReachableNetwork.h"
#import "FLHttpRequestByteCount.h"
#import "FLHttpResponse.h"
#import "FLNetworkErrors.h"
#import "FLHttpRequestBehavior.h"
#import "FLRetryHandler.h"

#define FORCE_NO_SSL DEBUG

//#define kStreamReadChunkSize 1024

@interface FLHttpResponse ()
@property (readwrite, strong, nonatomic) FLHttpRequestByteCount* byteCount;
@end

@interface FLHttpRequest ()
@property (readwrite, strong, nonatomic) FLHttpResponse* previousResponse;
@property (readwrite, strong, nonatomic) FLHttpStream* httpStream;
@property (readwrite, strong) FLHttpRequestByteCount* byteCount;

- (void) finishRequestWithHttpResponse:(FLHttpResponse*) response;
- (void) finishRequestWithError:(NSError*) error;

@end

@implementation FLHttpRequest

@synthesize requestBody = _requestBody;
@synthesize requestHeaders = _requestHeaders;
@synthesize authenticator = _authenticator;
@synthesize disableAuthenticator = _disableAuthenticator;
@synthesize inputSink = _inputSink;
@synthesize httpStream = _httpStream;
@synthesize previousResponse = _previousResponse;
@synthesize timeoutInterval = _timeoutInterval;
@synthesize streamSecurity = _streamSecurity;
@synthesize byteCount = _byteCount;
@synthesize behavior = _behavior;
@synthesize retryHandler = _retryHandler;

#if TRACE
static int s_counter = 0;
#endif

- (id) init {
    return [self initWithRequestURL:nil httpMethod:nil];
}
-(id) initWithRequestURL:(NSURL*) url httpMethod:(NSString*) httpMethod {

    FLAssertNotNil(url);

    if((self = [super init])) {
        self.timeoutInterval = FLHttpRequestDefaultTimeoutInterval;
    
        _requestHeaders = [[FLHttpRequestHeaders alloc] init];
        _requestBody = [[FLHttpRequestBody alloc] initWithHeaders:_requestHeaders];
        
        self.requestHeaders.requestURL = url;
        self.requestHeaders.httpMethod = httpMethod;
        
        if(FLStringIsEmpty(httpMethod)) {
            self.requestHeaders.httpMethod= @"GET";
        }
        else {
            self.requestHeaders.httpMethod = httpMethod;
        }
    }

    FLTrace(@"%d created %@ http request: %@", ++s_counter, self.requestHeaders.httpMethod, [url absoluteString]);
    return self;
}

//- (id) initWithRequestURL:(NSURL*) url  {
//    return [self initWithRequestURL:url httpMethod:nil];
//}

- (void) releaseResponseData {
    self.previousResponse = nil;
    self.httpStream.delegate = nil;
    self.httpStream = nil;
}

- (void) dealloc {
    FLTrace(@"%d dealloc http request: %@", --s_counter, self.requestHeaders.requestURL);

    [_asyncQueueForStream releaseToPool];
#if FL_MRC
    [_behavior release];
    [_byteCount release];
    [_asyncQueueForStream release];
    [_previousResponse release];
    [_httpStream release];
    [_inputSink release];
    [_authenticator release];
    [_requestHeaders release];
    [_requestBody release];
    [_retryHandler release];
    [super dealloc];
#endif
}

- (id) initWithRequestBehavior:(id<FLHttpRequestBehavior>) behavior {
    self = [self initWithRequestURL:behavior.httpRequestURL httpMethod:behavior.httpRequestHttpMethod];
    if(self) {
        self.behavior = behavior;
    }

    return self;
}

+ (id) httpRequest:(id<FLHttpRequestBehavior>) behavior {
    return FLAutorelease([[[self class] alloc] initWithRequestBehavior:behavior]);
}

//+ (id) httpGetRequest:(NSURL*) url {
//    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:@"GET"]);
//}

//+ (id) httpRequestWithURL:(NSURL*) url {
//    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:@"GET"]);
//}

+ (id) httpRequestWithURL:(NSURL*) url httpMethod:(NSString*) httpMethod {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:httpMethod]);
}

//+ (id) httpPostRequest:(NSURL*) url {
//    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:@"POST"]);
//}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { %@ }", [super description], self.requestHeaders.requestURL];
//    [desc appendString:[self.requestHeaders description]];
//    [desc appendString:[self.requestBody description]];
//    return desc;
}

- (void) openStreamWithURL:(NSURL*) url {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLNetworkActivityStartedNotification object:nil userInfo:[NSDictionary dictionaryWithObject:self forKey:FLNetworkActivitySenderKey]];
    });
    
    [self.delegate performOptionalSelector:@selector(httpRequestWillOpen:) withObject:self];
    [self.behavior performOptionalSelector:@selector(httpRequestWillOpen:) withObject:self];

    if(!self.inputSink) {
        self.inputSink = [FLDataSink dataSink];
    }
    
    if(![FLReachableNetwork instance].isReachable) {
        [self finishRequestWithError:[NSError errorWithDomain:FLNetworkErrorDomain code:FLNetworkErrorCodeNoRouteToHost localizedDescription:NSLocalizedString(@"Network appears to be offline", nil) ]];
        return;
    }
    
    NSURL* finalURL = url;

#if FORCE_NO_SSL
    if(FLStringsAreEqual(url.scheme, @"https")) {
        NSString* secureURL = [[url absoluteString] stringByReplacingOccurrencesOfString:@"https:" withString:@"http:"];
        finalURL = [NSURL URLWithString:secureURL];
    }
    _streamSecurity = FLNetworkStreamSecurityNone;

#else
    if(_streamSecurity == FLNetworkStreamSecuritySSL) {
        
        if(FLStringsAreNotEqual(url.scheme, @"https")) {
            NSString* secureURL = [[url absoluteString] stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"];
            finalURL = [NSURL URLWithString:secureURL];
        }
    }
    else if(FLStringsAreEqual(url.scheme, @"https")) {
        _streamSecurity = FLNetworkStreamSecuritySSL;
    }
#endif
    
    FLHttpMessage* cfRequest = [FLHttpMessage httpMessageWithURL:finalURL 
                                                      httpMethod:self.requestHeaders.httpMethod];

    cfRequest.headers = self.requestHeaders.allHeaders;
    
    if(self.requestBody.bodyData) {
        cfRequest.bodyData = self.requestBody.bodyData;
    }
    
    self.httpStream  = [FLHttpStream httpStream:cfRequest 
                                 withBodyStream:self.requestBody.bodyStream 
                                 streamSecurity:_streamSecurity
                                      inputSink:self.inputSink];
    
    [self.httpStream openStreamWithDelegate:self];
}

- (void) openAuthenticatedStreamWithURL:(NSURL*) url {

    id context = self.context;
    if(!self.authenticator && (context && [context respondsToSelector:@selector(httpRequestAuthenticator)])) {
        self.authenticator = [context httpRequestAuthenticator];
    }

    if(self.authenticator && !self.disableAuthenticator) {
        [self.behavior performOptionalSelector:@selector(httpRequestWillAuthenticate:) withObject:self];
        [self.delegate performOptionalSelector:@selector(httpRequestWillAuthenticate:) withObject:self];

        [self.authenticator authenticateHttpRequest:self];
        
        [self.behavior performOptionalSelector:@selector(httpRequestDidAuthenticate:) withObject:self];
        [self.delegate performOptionalSelector:@selector(httpRequestDidAuthenticate:) withObject:self];
    }

    [self openStreamWithURL:url];
}


- (id) startAsyncOperation {
    self.byteCount = [FLHttpRequestByteCount httpRequestByteCount];
    [self openAuthenticatedStreamWithURL:self.requestHeaders.requestURL];
    return nil;
}

- (void) networkStreamDidOpen:(FLHttpStream*) networkStream {
    [self.delegate performOptionalSelector:@selector(httpRequestDidOpen:) withObject:self];
    [self.byteCount setStartTime];
}


- (void) networkStream:(FLHttpStream*) stream didReadBytes:(NSNumber*) amountRead {

    [self.byteCount incrementByteCount:amountRead];

    [self.behavior performOptionalSelector:@selector(httpRequest:didReadBytes:) withObject:self withObject:self.byteCount];
    [self.delegate performOptionalSelector:@selector(httpRequest:didReadBytes:) withObject:self withObject:self.byteCount];
}

- (void) finalizeRequestWithResult:(id) result {
    [self releaseResponseData];
                
    [self.delegate performOptionalSelector:@selector(httpRequest:didCloseWithResult:) withObject:self withObject:result];
    [self.behavior performOptionalSelector:@selector(httpRequest:didFinishWithResult:) withObject:self withObject:result];
    [self.finisher setFinishedWithResult:result];
    
    [self.retryHandler resetRetryCount];

// TODO: move this?
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLNetworkActivityStoppedNotification object:nil userInfo:[NSDictionary dictionaryWithObject:self forKey:FLNetworkActivitySenderKey]];
    });
}

- (void) finishRequestWithError:(NSError*) error {
    [self.byteCount setFinishTime];    
    [self finalizeRequestWithResult:error];
}

- (void) finishRequestWithHttpResponse:(FLHttpResponse*) response {

    [self.byteCount setFinishTime];    

    id result = response;

    @try {
        if([self.behavior respondsToSelector:@selector(httpRequest:convertResponse:toResult:)]) {
            [self.behavior httpRequest:self convertResponse:result toResult:&result];
        }
    }
    @catch(NSException* ex) {
        result = ex.error;
    }

    if(!result) {
        result = response;
    }

    [self finalizeRequestWithResult:result];
}

- (void) requestCancel {
    [super requestCancel];
    [self.httpStream terminateStream];
    [self finishRequestWithError:[NSError cancelError]];
}

- (BOOL) tryRetry {
    return [self.retryHandler retryWithBlock:^{
        [self releaseResponseData];
        [self startAsyncOperation];
    }];
}

- (void) networkStream:(FLHttpStream*) readStream 
      encounteredError:(NSError*) error {
    [self.httpStream terminateStream];
    
    if( [error isCancelError] || self.wasCancelled || ![self tryRetry]) {       
        [self finishRequestWithError:error];
    }
    
}

- (void) networkStreamDidClose:(FLHttpStream*) stream {

}

- (NSTimeInterval) networkStreamGetTimeoutInterval:(FLNetworkStream*) stream {
    return self.timeoutInterval;
}

- (void) httpStream:(FLHttpStream*) stream 
willCloseWithResponseHeaders:(FLHttpMessage*) responseHeaders 
       responseData:(id<FLInputSink>) responseData {
       
    FLHttpResponse* response = [FLHttpResponse httpResponse:[[self requestHeaders] requestURL]
                                                    headers:responseHeaders 
                                             redirectedFrom:self.previousResponse
                                                  inputSink:responseData];
    
    response.byteCount = self.byteCount;
    
    NSError* responseError = nil;
    if([self.behavior respondsToSelector:@selector(httpRequest:throwErrorIfResponseIsError:)]) {
        @try {
            [self.behavior httpRequest:self throwErrorIfResponseIsError:response];
        }
        @catch(NSException* ex) {
            responseError = FLRetainWithAutorelease(ex.error);
        }
    }
    
    if(responseData.isOpen) {
        [responseData closeSinkWithCommit:responseError == nil];
    }
    
    if(responseError) {
        [self finishRequestWithError:responseError];
    }
    else {

        // FIXME: there was an issue here with progress getting fouled up on redirects.
        //    [self connectionGotTimerEvent];

        BOOL redirect = response.wantsRedirect;
        if(redirect) {
            NSURL* redirectURL = response.redirectURL;
            if([self.behavior respondsToSelector:@selector(httpRequest:shouldRedirect:toURL:)]) {
                [self.behavior httpRequest:self shouldRedirect:&redirect toURL:redirectURL];
            }
            if(redirect) {
                self.previousResponse = response;
                [self openAuthenticatedStreamWithURL:redirectURL];
            }
        }

        if(!redirect) {
            [self finishRequestWithHttpResponse:response];
        }
    }
}
@end





//- (void) wasIdleForTimeInterval:(NSTimeInterval) timeInterval {

// TODO: ("MF: fix http implementation");

//    if([self.implementation respondsToSelector:@selector(httpConnection:sentBytes:totalSentBytes:totalBytesExpectedToSend:)])
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
//            [self.implementation httpConnection:self 
//                sentBytes:self.lastBytesSent 
//                totalSentBytes:self.totalBytesSent 
//                totalBytesExpectedToSend:[[_requestQueue lastObject] postLength]];
//       }
//    }
// }




