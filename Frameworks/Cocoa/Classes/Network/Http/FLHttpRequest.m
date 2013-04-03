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

@implementation FLHttpRequest
@synthesize body = _body;
@synthesize headers = _headers;
@synthesize authenticator = _authenticator;
@synthesize disableAuthenticator = _disableAuthenticator;
@synthesize inputSink = _inputSink;
@synthesize finisher = _finisher;
@synthesize asyncQueueForStream = _asyncQueueForStream;
@synthesize httpStream = _httpStream;
@synthesize previousResponse = _previousResponse;
@synthesize timeoutInterval = _timeoutInterval;


- (id) init {
    return [self initWithRequestURL:nil httpMethod:nil];
}

-(id) initWithRequestURL:(NSURL*) url httpMethod:(NSString*) httpMethod {

    FLAssertNotNil(url);

    if((self = [super init])) {
        self.timeoutInterval = FLHttpRequestDefaultTimeoutInterval;
    
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
        
        self.asyncQueueForStream = [FLFifoAsyncQueue fifoAsyncQueue];
    }
    
    return self;
}

- (id) initWithRequestURL:(NSURL*) url  {
    return [self initWithRequestURL:url httpMethod:nil];
}

- (void) dealloc {
    [_asyncQueueForStream releaseToPool];
#if FL_MRC
    [_previousResponse release];
    [_httpStream release];
    [_finisher release];
    [_inputSink release];
    [_authenticator release];
    [_headers release];
    [_body release];
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

//- (void) runAsynchronously:(FLFinisher*) finisher {
//    FLHttpStreamWorker* worker = [FLHttpStreamWorker httpRequestWorker:self asyncQueue:[FLFifoAsyncQueue fifoAsyncQueue]];
//    [self.operationContext startWorker:worker withFinisher:finisher];
//}

- (NSString*) description {
    NSMutableString* desc = [NSMutableString stringWithFormat:@"%@\r\n", [super description]];
    [desc appendString:[self.headers description]];
    [desc appendString:[self.body description]];
    return desc;
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
    
    FLHttpMessage* cfRequest = [FLHttpMessage httpMessageWithURL:self.headers.requestURL httpMethod:self.headers.httpMethod];
    cfRequest.headers = self.headers.allHeaders;
    
    if(self.body.bodyData) {
        cfRequest.bodyData = self.body.bodyData;
    }
    
    self.httpStream  = [FLHttpStream httpStream:cfRequest withBodyStream:self.body.bodyStream];
    self.httpStream.inputSink = self.inputSink;
        
    
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
    [self openAuthenticatedStreamWithURL:self.headers.requestURL];
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
        self.finisher = nil;
        self.previousResponse = nil;
        [self closeStreamWithError:nil];

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
                                                        headers:[stream responseHeaders] 
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




