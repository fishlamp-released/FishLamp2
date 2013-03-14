//
//  FLHttpRequestTask.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestWorker.h"
#import "FLHttpRequest.h"
#import "FLHttpResponse.h"

@interface FLHttpRequestWorker ()
@property (readwrite, strong, nonatomic) FLHttpRequest* httpRequest;
@property (readwrite, strong, nonatomic) id<FLAsyncQueue> asyncQueue;
@end

@implementation FLHttpRequestWorker 

@synthesize httpRequest = _httpRequest;
@synthesize asyncQueue = _asyncQueue;

- (id) initWithHttpRequest:(FLHttpRequest*) request asyncQueue:(FLFifoAsyncQueue*) asyncQueue {
    self = [super init];
    if(self) {
        self.httpRequest = request;
        self.asyncQueue = asyncQueue;
    }
        
    return self;
}

+ (id) httpRequestWorker:(FLHttpRequest*) request asyncQueue:(FLFifoAsyncQueue*) asyncQueue{
    return FLAutorelease([[[self class] alloc] initWithHttpRequest:request asyncQueue:asyncQueue]);
}

- (void) dealloc {
    [_asyncQueue releaseToPool];

#if FL_MRC
    [_httpRequest release];
    [super dealloc];
#endif
}
@end

@implementation FLHttpRequestAuthenticationWorker 

- (id) initWithHttpRequest:(FLHttpRequest*) request {
    self = [super initWithHttpRequest:request asyncQueue:[request.authenticator httpRequestAuthenticationDispatcher:request]];
    if(self) {
    }
    return self;
}

+ (id) httpRequestAuthenticationWorker:(FLHttpRequest*) request {
    return FLAutorelease([[[self class] alloc] initWithHttpRequest:request]);
}

- (void) startWorking:(FLFinisher*) finisher {
    id<FLHttpRequestAuthenticator> authenticator = self.httpRequest.authenticator;
    
    [self.httpRequest postObservation:@"httpRequestWillAuthenticate:" toObserver:finisher];
    [self.httpRequest willAuthenticate];
    
    [authenticator httpRequest:self.httpRequest authenticateSynchronouslyInContext:self.workerContext withObserver:finisher.observer];
    
    [self.httpRequest didAuthenticate];
    [self.httpRequest postObservation:@"httpRequestDidAuthenticate:" toObserver:finisher];
    [finisher setFinished];
}

@end

@interface FLHttpStreamWorker ()
@property (readwrite, strong, nonatomic) FLHttpResponse* httpResponse;
@property (readwrite, strong, nonatomic) FLFinisher* finisher;
@property (readwrite, strong, nonatomic) FLHttpStream* httpStream;
@end

@implementation FLHttpStreamWorker 

@synthesize httpResponse = _httpResponse;
@synthesize finisher = _finisher;
@synthesize httpStream = _httpStream;

//- (id) initWithHttpRequest:(FLHttpRequest*) request {
//    self = [super initWithHttpRequest:request];
//    if(self) {
//    }
//    return self;
//}

#if FL_MRC
- (void) dealloc {
    [_httpResponse release];
    [_finisher release];
    [_httpStream release];
    [super dealloc];
}
#endif

- (void) readResponseHeadersIfNeeded  {
    
    if(!_httpResponse.responseHeaders) {
        FLHttpMessage* message = [_httpStream responseHeaders];
        if(message) {
            [_httpResponse setResponseHeadersWithHttpMessage:message];
            
            if(!_httpResponse.redirectedFrom) {
                [self.httpRequest postObservation:@"httpRequestDidOpen:" toObserver:self.finisher];
            }
            
//            [self postObservableEvent:FLHttpRequestDidWriteBytesEvent];
//            [self postObservableEvent:FLHttpRequestDidReadBytesEvent];
        }
    }
}

- (void) requestCancel {
    [super requestCancel];

    if(self.httpRequest.responseReceiver) {
        [self.httpRequest.responseReceiver closeReceiverWithError:[NSError cancelError]];
    }
}

- (void) closeStream {
    [_httpStream closeStream];
    self.httpStream = nil;
}

- (void) openStreamWithURL:(NSURL*) url {

    FLHttpRequest* request = self.httpRequest;
    [request postObservation:@"httpRequestWillOpen:" toObserver:self.finisher];
    
    [request willSendHttpRequest]; // this may set requestURL so needs to be before createStreamOpenerWithURL

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

    if(!request.responseReceiver) {
        request.responseReceiver = [FLDataResponseReceiver dataResponseReceiver];
    }

    newResponse.responseReceiver = request.responseReceiver;
    self.httpResponse = newResponse;
    [request.responseReceiver openReceiver];
    
    FLHttpMessage* cfRequest = [FLHttpMessage httpMessageWithURL:request.headers.requestURL httpMethod:request.headers.httpMethod];
    cfRequest.headers = request.headers.allHeaders;
    
    if(request.body.bodyData) {
        cfRequest.bodyData = request.body.bodyData;
    }
    
    self.httpStream  = [FLHttpStream httpStream:cfRequest withBodyStream:request.body.bodyStream];
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
    if(self.httpRequest.authenticator && !self.httpRequest.disableAuthenticator) {
        FLHttpRequestAuthenticationWorker* auth = [FLHttpRequestAuthenticationWorker httpRequestAuthenticationWorker:self.httpRequest];
        [self.workerContext startWorker:auth withObserver:_finisher.observer completion:^(FLResult result) {
            [self openStreamWithURL:url];
        }];
    }
    else {
        [self openStreamWithURL:url];
    }
}

- (void) startWorking:(FLFinisher*) finisher {
    self.finisher = finisher;
    [self openAuthenticatedStreamWithURL:self.httpRequest.headers.requestURL];
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

- (void) networkStream:(FLHttpStream*) readStream encounteredError:(NSError*) error {
    [self closeStream];
    [self.httpRequest postObservation:@"httpRequest:encounteredError:" toObserver:self.finisher withObject:error];
    [_finisher setFinishedWithResult:error];
}

- (void) networkStream:(FLHttpStream*) stream didReadBytes:(NSNumber*) amountRead {
    [self.httpRequest postObservation:@"httpRequest:didReadBytes:" toObserver:self.finisher withObject:amountRead];
}

- (void) networkStreamHasBytesAvailable:(FLHttpStream*) networkStream {
    [self readResponseHeadersIfNeeded];
    [self.httpRequest.responseReceiver readBytesFromStream:_httpStream];
}

- (void) didCloseWithResult:(FLResult) result {
    
    FLAssertNotNil_(result);

    @try {
        if(![result error]) {
            NSError* error = [self.httpRequest checkHttpResponseForError:self.httpResponse];
            if(error) {
                result = error;
            }
        }
        if(![result error]) {
            result = [self.httpRequest resultFromHttpResponse:self.httpResponse];
        }
    }
    @catch(NSException* ex) {
        result = ex.error;
    }
    @finally {

        [self closeStream];
        
        [self.httpRequest postObservation:@"httpRequest:didCloseWithResult:" toObserver:self.finisher withObject:result];
        
        FLFinisher* finisher = FLRetainWithAutorelease(self.finisher);
        self.finisher = nil;
        self.httpResponse = nil;
        [finisher setFinishedWithResult:result];
    }
}


- (void) networkStreamDidClose:(FLHttpStream*) stream {

    if(!self.httpRequest.responseReceiver.isClosed) {
        NSError* error = [self.httpRequest.responseReceiver closeReceiverWithError:stream.error];
        if(error) {
            // TODO: this means deleting a partially downloaded file failed. 
            // Not sure how to handle that...
        }
    }

    if(stream.error) {
        [self didCloseWithResult:stream.error];
    }
    else {

        [self readResponseHeadersIfNeeded];
        [self closeStream];
        
        // FIXME: there was an issue here with progress getting fouled up on redirects.
        //    [self connectionGotTimerEvent];

        BOOL redirect = _httpResponse.wantsRedirect;
        if(redirect) {
            NSURL* redirectURL = self.httpResponse.redirectURL;
            redirect = [self.httpRequest shouldRedirectToURL:redirectURL];
            if(redirect) {
                [self openAuthenticatedStreamWithURL:redirectURL];
            }
        }

        if(!redirect) {
            [self didCloseWithResult:self.httpResponse];
        }
    }
}

@end






