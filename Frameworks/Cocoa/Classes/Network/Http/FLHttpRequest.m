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
#import "FLReachableNetwork.h"

#define FORCE_NO_SSL 1

//#define kStreamReadChunkSize 1024

@interface FLHttpRequest ()
@property (readwrite, strong, nonatomic) FLHttpResponse* previousResponse;
@property (readwrite, strong, nonatomic) FLHttpStream* httpStream;
@property (readwrite, assign) unsigned long long downloadedByteCount;
@property (readwrite, assign) NSTimeInterval startTime;
@property (readwrite, assign) NSTimeInterval lastTime;

- (void) finishRequestWithResult:(id) result;
@end

#define FORCE_NO_SSL 1

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
@synthesize downloadedByteCount = _downloadedByteCount;
@synthesize startTime = _startTime;
@synthesize lastTime = _lastTime;
@synthesize delegateSelectors = _delegateSelectors;

static FLHttpRequestDelegateSelectors s_defaultSelectors;

#if TRACE
static int s_counter = 0;
#endif

- (id) init {
    return [self initWithRequestURL:nil httpMethod:nil];
}

+ (void) initialize {
    static BOOL initialized = NO;
    if(!initialized) {
        initialized = YES;
        
        s_defaultSelectors.willOpen = @selector(httpRequestWillOpen:);
        s_defaultSelectors.didOpen = @selector(httpRequestDidOpen:);
        s_defaultSelectors.willAuthenticate = @selector(httpRequestWillAuthenticate:);
        s_defaultSelectors.didAuthenticate = @selector(httpRequestDidAuthenticate:);
        s_defaultSelectors.didClose = @selector(httpRequestDidAuthenticate:);
        s_defaultSelectors.didReadBytes = @selector(httpRequestDidAuthenticate:);
        s_defaultSelectors.didWriteBytes = @selector(httpRequestDidAuthenticate:);

    }
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

        _delegateSelectors = s_defaultSelectors;
    }

    FLTrace(@"%d created %@ http request: %@", ++s_counter, self.requestHeaders.httpMethod, [url absoluteString]);
    return self;
}

- (id) initWithRequestURL:(NSURL*) url  {
    return [self initWithRequestURL:url httpMethod:nil];
}

- (void) releaseResponseData {
    self.previousResponse = nil;
    self.httpStream = nil;
}

- (void) dealloc {
    FLTrace(@"%d dealloc http request: %@", --s_counter, self.requestHeaders.requestURL);

    [_asyncQueueForStream releaseToPool];
#if FL_MRC
    [_asyncQueueForStream release];
    [_previousResponse release];
    [_httpStream release];
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
    return httpResponse.error;
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

- (void) openStreamWithURL:(NSURL*) url {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FLNetworkActivityStartedNotification object:nil userInfo:[NSDictionary dictionaryWithObject:self forKey:FLNetworkActivitySenderKey]];
    });
    
    FLPerformSelector1(self.delegate, _delegateSelectors.willOpen, self);
        
    [self willSendHttpRequest]; // this may set requestURL so needs to be before createStreamOpenerWithURL

    if(!self.inputSink) {
        self.inputSink = [FLDataSink dataSink];
    }
    
    if(![FLReachableNetwork instance].isReachable) {
        [self finishRequestWithResult:[NSError errorWithDomain:FLNetworkErrorDomain code:FLNetworkErrorCodeNoRouteToHost localizedDescription:NSLocalizedString(@"Network appears to be offline", nil) ]];
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
        FLPerformSelector1(self.delegate, _delegateSelectors.willAuthenticate, self);

        [self willAuthenticate];
            
        [self.authenticator authenticateHttpRequest:self];
        
        [self didAuthenticate];
        FLPerformSelector1(self.delegate, _delegateSelectors.didAuthenticate, self);
    }

    [self openStreamWithURL:url];
}

- (NSTimeInterval) elapsedTime {
    return self.lastTime - self.startTime;
}

- (void) startAsyncOperation {
    self.downloadedByteCount = 0;
    self.startTime = 0;
    self.lastTime = 0;

    [self openAuthenticatedStreamWithURL:self.requestHeaders.requestURL];
}

- (void) networkStreamDidOpen:(FLHttpStream*) networkStream {
    FLPerformSelector1(self.delegate, _delegateSelectors.didOpen, self);
    self.startTime = [NSDate timeIntervalSinceReferenceDate];
}

- (void) didReadBytes:(unsigned long long) amount {

}

- (void) networkStream:(FLHttpStream*) stream didReadBytes:(NSNumber*) amountRead {

    self.downloadedByteCount += [amountRead longLongValue];
    self.lastTime = [NSDate timeIntervalSinceReferenceDate]; 

    [self didReadBytes:amountRead];
    FLPerformSelector2(self.delegate, _delegateSelectors.didReadBytes, self, amountRead);
    
}

- (void) requestDidFinishWithResult:(id) result {
    
}

- (void) finishRequestWithResult:(id) result {

    self.lastTime = [NSDate timeIntervalSinceReferenceDate]; 
        
    @try {
        if(![result error] ) {
            result = [self resultFromHttpResponse:result];
        }
    }
    @catch(NSException* ex) {
        result = FLRetainWithAutorelease(ex.error);
    }
    @finally {

        [self releaseResponseData];
        
        self.previousResponse = nil;
        self.httpStream.delegate = nil;
        self.httpStream = nil;
        
        [self operationDidFinishWithResult:result];
        
        FLPerformSelector2(self.delegate, _delegateSelectors.didClose, self, result);
        [self requestDidFinishWithResult:result];
        [self setFinishedWithResult:result];
                
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:FLNetworkActivityStoppedNotification object:nil userInfo:[NSDictionary dictionaryWithObject:self forKey:FLNetworkActivitySenderKey]];
        });
    }
}

#define kMegaBits 131072

- (double) bytesPerSecond {
    NSTimeInterval elapsedTime = self.elapsedTime;
    unsigned long long downloadedByteCount = self.downloadedByteCount;
    
    if(elapsedTime && downloadedByteCount) {
        return (downloadedByteCount / elapsedTime);
    }
    
    return 0;
}

- (void) requestCancel {
    [self.httpStream terminateStream];
    [self finishRequestWithResult:[NSError cancelError]];
}

- (void) networkStream:(FLHttpStream*) readStream 
      encounteredError:(NSError*) error {
    [self.httpStream terminateStream];
    [self finishRequestWithResult:error];
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
    
    NSError* responseError = [self checkHttpResponseForError:response];
    
    if(responseData.isOpen) {
        [responseData closeSinkWithCommit:responseError == nil];
    }
    
    if(responseError) {
        [self finishRequestWithResult:responseError];
    }
    else {

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
            [self finishRequestWithResult:response];
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




