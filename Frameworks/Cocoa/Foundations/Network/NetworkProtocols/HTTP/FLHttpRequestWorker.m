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
@end

@implementation FLHttpRequestWorker 

@synthesize httpRequest = _httpRequest;
@synthesize dispatcher = _dispatcher;

- (id) initWithHttpRequest:(FLHttpRequest*) request {
    self = [super init];
    if(self) {
        self.httpRequest = request;
        self.dispatcher = [FLFifoGcdDispatcher fifoDispatchQueue];
    }
        
    return self;
}

+ (id) httpRequestWorker:(FLHttpRequest*) request {
    return FLAutorelease([[[self class] alloc] initWithHttpRequest:request]);
}

#if FL_MRC
- (void) dealloc {
    [_dispatcher release];
    [_httpRequest release];
    [super dealloc];
}
#endif
@end

@implementation FLHttpRequestAuthenticatorWorker 

- (id) initWithHttpRequest:(FLHttpRequest*) request {
    self = [super initWithHttpRequest:request];
    if(self) {
        self.dispatcher = [self.httpRequest.authenticator httpRequestAuthenticationDispatcher:self.httpRequest];
    }
    return self;
}

- (void) startWorking:(FLFinisher*) finisher {
    id<FLHttpRequestAuthenticator> authenticator = self.httpRequest.authenticator;
    [finisher postObservation:@selector(httpRequestWillAuthenticate:) withObject:self.httpRequest];
    [self.httpRequest willAuthenticate];
    
    [authenticator httpRequest:self.httpRequest authenticateSynchronouslyInContext:self.workerContext withObserver:finisher.observer];
    
    [self.httpRequest didAuthenticate];
    [finisher postObservation:@selector(httpRequestDidAuthenticate:) withObject:self];
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

- (id) initWithHttpRequest:(FLHttpRequest*) request {
    self = [super initWithHttpRequest:request];
    if(self) {
    }
    return self;
}

- (void) dealloc {
    _httpStream.delegate = nil;
#if FL_MRC
    [_response release];
    [_finisher release];
    [_httpStream release];
    [super dealloc];
#endif
}
- (void) readResponseHeadersIfNeeded  {
    
    if(!_response.responseHeaders) {
        FLHttpMessage* message = [_httpStream readResponseHeaders];
        if(message.isHeaderComplete) {
            [_response setResponseHeadersWithHttpMessage:message];
            
            if(!_response.redirectedFrom) {
                [_finisher postObservation:@selector(httpRequestDidOpen:) withObject:self.httpRequest];
            }
            
//            [self postObservableEvent:FLHttpRequestDidWriteBytesEvent];
//            [self postObservableEvent:FLHttpRequestDidReadBytesEvent];
        }
    }
}

- (void) readStreamDidOpen:(FLHttpStream*) networkStream {
    [self readResponseHeadersIfNeeded];
}

- (void) requestCancel {
//    if(self.networkStream) {
//        [self.networkStream requestCancel];
//    }
    if(self.httpRequest.responseReceiver) {
        [self.httpRequest.responseReceiver closeReceiverWithError:[NSError cancelError]];
    }
}

- (void) closeStream {
    _httpStream.delegate = nil;
    [_httpStream closeStream];
    self.httpStream = nil;
}

- (void) openStreamWithURL:(NSURL*) url {

    FLHttpRequest* request = self.httpRequest;
    [_finisher postObservation:@selector(httpRequestWillOpen:) withObject:request];
    
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

    FLHttpStream* httpStream = nil;
    if(request.body.bodyStream != nil) {
        httpStream = [FLHttpStream httpStream:request.headers withBodyStream:request.body.bodyStream];
    }
    else {
        httpStream = [FLHttpStream httpStream:request.headers withBodyData:request.body.bodyData];
    }
    
    FLStreamOpener* opener = [FLStreamOpener streamOpener:httpStream];

    [self.workerContext startWorker:opener withObserver:_finisher.observer completion:^(FLResult result){

        if([result error]) {
            [_finisher setFinishedWithResult:result];
        }
        else {
            self.httpStream = httpStream;
            self.httpStream.delegate = self;
        }
    }];
}

- (void) openAuthenticatedStreamWithURL:(NSURL*) url {
    if(self.httpRequest.authenticator && !self.httpRequest.disableAuthenticator) {
        FLHttpRequestAuthenticatorWorker* auth = [FLHttpRequestAuthenticatorWorker httpRequestWorker:self.httpRequest];
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
}

- (void) networkStreamDidOpen:(FLHttpStream*) networkStream {
    [self readResponseHeadersIfNeeded];
}

- (void) networkStream:(FLHttpStream*) readStream encounteredError:(NSError*) error {
    [self closeStream];
    [_finisher postObservation:@selector(httpRequest:encounteredError:) withObject:self.httpRequest withObject:error];
    [_finisher setFinishedWithResult:error];
}

- (void) networkStream:(FLHttpStream*) stream didReadBytes:(NSNumber*) amountRead {
    [_finisher postObservation:@selector(httpRequest:didReadBytes:) withObject:_httpStream withObject:amountRead];
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
        
        [_finisher postObservation:@selector(httpRequest:didCloseWithResult:) withObject:self.httpRequest withObject:result];
        
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

        BOOL redirect = _response.wantsRedirect;
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






