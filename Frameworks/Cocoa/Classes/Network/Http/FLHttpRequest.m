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
#import "FLGlobalNetworkActivityIndicator.h"
#import "FLDataSink.h"
#import "FLHttpRequestBody.h"
#import "FLDispatch.h"
#import "FLTimer.h"

//#define kStreamReadChunkSize 1024

@interface FLHttpRequest ()
@property (readwrite, strong, nonatomic) FLFifoAsyncQueue* asyncQueueForStream;
@property (readwrite, strong, nonatomic) FLFinisher* finisher;
@property (readwrite, strong, nonatomic) FLHttpResponse* previousResponse;
@property (readwrite, strong, nonatomic) FLHttpStream* httpStream;
@end

#define TRACE 0

@implementation FLHttpRequest
@synthesize requestBody = _requestBody;
@synthesize requestHeaders = _requestHeaders;
@synthesize authenticator = _authenticator;
@synthesize disableAuthenticator = _disableAuthenticator;
@synthesize inputSink = _inputSink;
@synthesize finisher = _finisher;
@synthesize asyncQueueForStream = _asyncQueueForStream;
@synthesize httpStream = _httpStream;
@synthesize previousResponse = _previousResponse;
@synthesize timeoutInterval = _timeoutInterval;
@synthesize streamSecurity = _streamSecurity;

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
        
        self.asyncQueueForStream = [FLFifoAsyncQueue fifoAsyncQueue];
    }

#if TRACE
    FLLog(@"%d created %@ http request: %@", ++s_counter, self.requestHeaders.httpMethod, [url absoluteString]);
#endif    
    return self;
}

- (id) initWithRequestURL:(NSURL*) url  {
    return [self initWithRequestURL:url httpMethod:nil];
}

- (void) releaseResponseData {
    self.previousResponse = nil;
    self.httpStream = nil;
    self.finisher = nil;
}

- (void) dealloc {
#if TRACE
    FLLog(@"%d dealloc http request: %@", --s_counter, self.requestHeaders.requestURL);
#endif    
    [_asyncQueueForStream releaseToPool];
#if FL_MRC
    [_asyncQueueForStream release];
    [_previousResponse release];
    [_httpStream release];
    [_finisher release];
    [_inputSink release];
    [_authenticator release];
    [_requestHeaders release];
    [_requestBody release];
    [super dealloc];
#endif
}

+ (id) httpGetRequest:(NSURL*) url {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:@"GET"]);
}

+ (id) httpRequest:(NSURL*) url {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:@"GET"]);
}

+ (id) httpRequest:(NSURL*) url httpMethod:(NSString*) httpMethod {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:httpMethod]);
}

+ (id) httpPostRequest:(NSURL*) url {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:url httpMethod:@"POST"]);
}

- (FLResult) resultFromHttpResponse:(FLHttpResponse*) httpResponse {
    return httpResponse;
}

- (NSError*) checkHttpResponseForError:(FLHttpResponse*) httpResponse {
    return [httpResponse simpleHttpResponseErrorCheck];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { %@ }", [super description], self.requestHeaders.requestURL];
//    [desc appendString:[self.requestHeaders description]];
//    [desc appendString:[self.requestBody description]];
//    return desc;
}

- (BOOL) shouldRedirectToURL:(NSURL*) url {
    return YES;
}

- (void) willSendHttpRequest {
}

- (void) willAuthenticate {
}

- (void) didAuthenticate {
}

- (void) closeStreamWithError:(NSError*) error {
    [_httpStream closeStreamWithError:error];
    self.httpStream = nil;
}

- (void) requestCancel {
    NSError* error = [NSError cancelError];
    [self closeStreamWithError:error];
}

- (void) openStreamWithURL:(NSURL*) url {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLNetworkActivityStartedNotification object:nil userInfo:[NSDictionary dictionaryWithObject:self forKey:FLNetworkActivitySenderKey]];
        
        [self sendObservation:@selector(httpRequestWillOpen:)];
    });
        
    [self willSendHttpRequest]; // this may set requestURL so needs to be before createStreamOpenerWithURL

    if(!self.inputSink) {
        self.inputSink = [FLDataSink dataSink];
    }
    
    NSURL* finalURL = url;
    
    if(_streamSecurity == FLNetworkStreamSecuritySSL) {
        
        if(FLStringsAreNotEqual(url.scheme, @"https")) {
            NSString* secureURL = [[url absoluteString] stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"];
            finalURL = [NSURL URLWithString:secureURL];
        }
    }
    else if(FLStringsAreEqual(url.scheme, @"https")) {
        _streamSecurity = FLNetworkStreamSecuritySSL;
    }
    
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
    
    [self.httpStream openStreamWithDelegate:self asyncQueue:self.asyncQueueForStream];
}

- (void) openAuthenticatedStreamWithURL:(NSURL*) url {

    id context = self.context;
    if(!self.authenticator && (context && [context respondsToSelector:@selector(httpRequestAuthenticator)])) {
        self.authenticator = [context httpRequestAuthenticator];
    }

    if(self.authenticator && !self.disableAuthenticator) {
        [self sendObservation:@selector(httpRequestWillAuthenticate:)];
        [self willAuthenticate];
            
        [self.authenticator authenticateHttpRequest:self];
        
        [self didAuthenticate];
        [self sendObservation:@selector(httpRequestDidAuthenticate:)];
    }

    [self openStreamWithURL:url];
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    self.finisher = finisher;
    [self openAuthenticatedStreamWithURL:self.requestHeaders.requestURL];
}

- (void) networkStreamDidOpen:(FLHttpStream*) networkStream {
    [self sendObservation:@selector(httpRequestDidOpen:)];
}

- (void) networkStream:(FLHttpStream*) stream didReadBytes:(NSNumber*) amountRead {
    [self sendObservation:@selector(httpRequest:didReadBytes:) withObject:amountRead];
}

- (FLResult) finalizeResult:(FLHttpResponse*) response {
    NSError* responseError = [self checkHttpResponseForError:response];
    if(responseError) {
        return responseError;
    }
    return [self resultFromHttpResponse:response];
}

- (void) requestDidFinishWithResult:(id) result {
        
    @try {
        if(![result error]) {
            result = [self finalizeResult:result];
        }
        
    }
    @catch(NSException* ex) {
        result = FLRetainWithAutorelease(ex.error);
    }
    @finally {

        FLFinisher* finisher = FLRetainWithAutorelease(self.finisher);
        [self releaseResponseData];
        
        self.finisher = nil;
        self.previousResponse = nil;
        [self closeStreamWithError:nil];
        [self operationDidFinish];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self sendObservation:@selector(httpRequest:didCloseWithResult:) withObject:result];
            [finisher setFinishedWithResult:result];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:FLNetworkActivityStoppedNotification object:nil userInfo:[NSDictionary dictionaryWithObject:self forKey:FLNetworkActivitySenderKey]];
        });
        
    }
}

- (void) networkStream:(FLHttpStream*) readStream encounteredError:(NSError*) error {
    [self sendObservation:@selector(httpRequest:encounteredError:) withObject:error];
    [self requestDidFinishWithResult:error];
}

- (void) networkStreamDidClose:(FLHttpStream*) stream {

    NSError* streamError = stream.error;
    if(streamError) {
        [self requestDidFinishWithResult:streamError];
    }
    else {
    
        FLHttpResponse* response = [FLHttpResponse httpResponse:[[stream requestHeaders] requestURL]
                                                        headers:[stream requestHeaders] 
                                                 redirectedFrom:self.previousResponse
                                                      inputSink:self.inputSink];

        [self closeStreamWithError:nil];
    
        // FIXME: there was an issue here with progress getting fouled up on redirects.
        //    [self connectionGotTimerEvent];

        BOOL redirect = response.wantsRedirect;
        if(redirect) {
            NSURL* redirectURL = response.redirectURL;
            redirect = [self shouldRedirectToURL:redirectURL];
            if(redirect) {
                self.previousResponse = response;
                [self openAuthenticatedStreamWithURL:redirectURL];
            }
        }

        if(!redirect) {
            [self requestDidFinishWithResult:response];
        }
    }
}

- (NSTimeInterval) networkStreamGetTimeoutInterval:(FLNetworkStream*) stream {
    return self.timeoutInterval;
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




