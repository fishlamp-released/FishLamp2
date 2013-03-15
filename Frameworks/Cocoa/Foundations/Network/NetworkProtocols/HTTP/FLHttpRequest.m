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

//#define kStreamReadChunkSize 1024

@interface FLHttpRequest ()
@property (readwrite, strong, nonatomic) FLFifoAsyncQueue* asyncQueue;
@property (readwrite, strong, nonatomic) FLFinisher* finisher;
@property (readwrite, strong, nonatomic) FLHttpResponse* httpResponse;
@property (readwrite, strong, nonatomic) FLHttpStream* httpStream;
@end

@implementation FLHttpRequest
@synthesize body = _body;
@synthesize headers = _headers;
@synthesize dataEncoder = _dataEncoder;
@synthesize dataDecoder = _dataDecoder;
@synthesize authenticator = _authenticator;
@synthesize disableAuthenticator = _disableAuthenticator;
@synthesize responseReceiver = _responseReceiver;
@synthesize finisher = _finisher;
@synthesize asyncQueue = _asyncQueue;
@synthesize httpStream = _httpStream;
@synthesize httpResponse = _httpResponse;


- (id) init {
    return [self initWithRequestURL:nil httpMethod:nil];
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
        
        self.asyncQueue = [FLFifoAsyncQueue fifoAsyncQueue];
    }
    
    return self;
}

- (id) initWithRequestURL:(NSURL*) url  {
    return [self initWithRequestURL:url httpMethod:nil];
}

- (void) dealloc {
    [_asyncQueue releaseToPool];
#if FL_MRC
    [_httpStream release];
    [_finisher release];
    [_responseReceiver release];
    [_authenticator release];
    [_dataDecoder release];
    [_dataEncoder release];
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

- (void) didMoveToContext:(id<FLWorkerContext>) context {
    [super didMoveToContext:context];
    
    if(context && !self.authenticator && [context respondsToSelector:@selector(httpRequestAuthenticator)]) {
        self.authenticator = [((id)context) httpRequestAuthenticator];
    }
}

//- (void) startWorking:(FLFinisher*) finisher {
//    FLHttpStreamWorker* worker = [FLHttpStreamWorker httpRequestWorker:self asyncQueue:[FLFifoAsyncQueue fifoAsyncQueue]];
//    [self.workerContext startWorker:worker withFinisher:finisher];
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

- (void) readResponseHeadersIfNeeded  {
    
    if(!_httpResponse.responseHeaders) {
        FLHttpMessage* message = [_httpStream responseHeaders];
        if(message) {
            [_httpResponse setResponseHeadersWithHttpMessage:message];
            
            if(!_httpResponse.redirectedFrom) {
                [self postObservation:@"httpRequestDidOpen:" toObserver:self.finisher];
            }
            
//            [self postObservableEvent:FLHttpRequestDidWriteBytesEvent];
//            [self postObservableEvent:FLHttpRequestDidReadBytesEvent];
        }
    }
}

- (void) closeStreamWithError:(NSError*) error {
    NSError* receiverError = [self.responseReceiver closeReceiverWithError:error];
    if(receiverError) {
        // TODO: this means deleting a partially downloaded file failed. 
        // Not sure how to handle that...
    }
    
    [_httpStream closeStreamWithError:error];
    self.httpStream = nil;
}

- (void) requestCancel {
    NSError* error = [NSError cancelError];
    [self closeStreamWithError:error];
    
    if(self.responseReceiver) {
        [self.responseReceiver closeReceiverWithError:error];
    }
}

- (void) openStreamWithURL:(NSURL*) url {

    [self postObservation:@"httpRequestWillOpen:" toObserver:self.finisher];
    
    [self willSendHttpRequest]; // this may set requestURL so needs to be before createStreamOpenerWithURL

    FLHttpResponse* newResponse = nil;
    FLHttpResponse* prev = self.httpResponse;
    
    if(prev && prev.wantsRedirect) {
        newResponse  = [FLHttpResponse httpResponse:url redirectedFrom:prev];
    }
    else {
        // what if there is a response already, but it's not a redirect??? 
        FLAssertIsNil_(prev);
        newResponse  = [FLHttpResponse httpResponse:url];
    }

    if(!self.responseReceiver) {
        self.responseReceiver = [FLDataResponseReceiver dataResponseReceiver];
    }

    newResponse.responseReceiver = self.responseReceiver;
    self.httpResponse = newResponse;
    [self.responseReceiver openReceiver];
    
    FLHttpMessage* cfRequest = [FLHttpMessage httpMessageWithURL:self.headers.requestURL httpMethod:self.headers.httpMethod];
    cfRequest.headers = self.headers.allHeaders;
    
    if(self.body.bodyData) {
        cfRequest.bodyData = self.body.bodyData;
    }
    
    self.httpStream  = [FLHttpStream httpStream:cfRequest withBodyStream:self.body.bodyStream];
    [self.httpStream openStreamWithDelegate:self asyncQueue:self.asyncQueue];

//    FLStreamOpener* opener = [FLStreamOpener streamOpener:httpStream];
//
//    [self.workerContext startWorker:opener withObserver:_finisher.observer completion:^(FLResult result){
//
//        if([result error]) {
//            [_finisher setFinishedWithResult:result];
//        }
//        else {
//            self.httpStream = httpStream;
//            [self.httpStream addDelegate:self];
//        }
//    }];
}

- (void) openAuthenticatedStreamWithURL:(NSURL*) url {

    if(self.authenticator && !self.disableAuthenticator) {
        [self postObservation:@"httpRequestWillAuthenticate:" toObserver:_finisher];
        [self willAuthenticate];
            
        [self.authenticator authenticateHttpRequest:self];
        
        [self didAuthenticate];
        [self postObservation:@"httpRequestDidAuthenticate:" toObserver:_finisher];
    }

    [self openStreamWithURL:url];
}

- (void) startWorking:(FLFinisher*) finisher {
    self.finisher = finisher;
    [self openAuthenticatedStreamWithURL:self.headers.requestURL];
}

- (void) networkStreamWillOpen:(FLHttpStream*) networkStream {
    if(networkStream.error) {
        [self.finisher setFinishedWithResult:networkStream.error];
        [networkStream closeStream];
    }
}

- (void) networkStreamDidOpen:(FLHttpStream*) networkStream {
    [self readResponseHeadersIfNeeded];
}



- (void) networkStream:(FLHttpStream*) stream didReadBytes:(NSNumber*) amountRead {
    [self postObservation:@"httpRequest:didReadBytes:" toObserver:self.finisher withObject:amountRead];
}

- (void) networkStreamHasBytesAvailable:(FLHttpStream*) networkStream {
    [self readResponseHeadersIfNeeded];
    [self.responseReceiver readBytesFromStream:_httpStream];
}


- (FLResult) finalizeResult {
    NSError* responseError = [self checkHttpResponseForError:self.httpResponse];
    if(responseError) {
        return responseError;
    }
    return [self resultFromHttpResponse:self.httpResponse];
}

- (void) requestDidFinishWithStreamError:(NSError*) streamError {
    
    id result = nil;
    
    @try {
        if(streamError) {
            result = FLRetainWithAutorelease(streamError);
        }
        else {
            result = [self finalizeResult];
        }
        
    }
    @catch(NSException* ex) {
        result = FLRetainWithAutorelease(ex.error);
    }
    @finally {

        FLFinisher* finisher = FLRetainWithAutorelease(self.finisher);
        self.finisher = nil;
        self.httpResponse = nil;
        [self closeStreamWithError:nil];

        [self postObservation:@"httpRequest:didCloseWithResult:" toObserver:self.finisher withObject:result];
        
        [finisher setFinishedWithResult:result];
    }
}

- (void) networkStream:(FLHttpStream*) readStream encounteredError:(NSError*) error {
    [self postObservation:@"httpRequest:encounteredError:" toObserver:self.finisher withObject:error];
    [self requestDidFinishWithStreamError:error];
}

- (void) networkStreamDidClose:(FLHttpStream*) stream {

    NSError* streamError = stream.error;
    if(streamError) {
        [self requestDidFinishWithStreamError:streamError];
    }
    else {

        [self readResponseHeadersIfNeeded];
        [self closeStreamWithError:nil];
        
        // FIXME: there was an issue here with progress getting fouled up on redirects.
        //    [self connectionGotTimerEvent];

        BOOL redirect = _httpResponse.wantsRedirect;
        if(redirect) {
            NSURL* redirectURL = self.httpResponse.redirectURL;
            redirect = [self shouldRedirectToURL:redirectURL];
            if(redirect) {
                [self openAuthenticatedStreamWithURL:redirectURL];
            }
        }

        if(!redirect) {
            [self requestDidFinishWithStreamError:nil];
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




