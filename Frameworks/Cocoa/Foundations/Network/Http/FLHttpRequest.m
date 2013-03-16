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
@property (readwrite, strong, nonatomic) FLHttpResponse* previousResponse;
@property (readwrite, strong, nonatomic) FLHttpStream* httpStream;
@end

@implementation FLHttpRequest
@synthesize body = _body;
@synthesize headers = _headers;
@synthesize dataEncoder = _dataEncoder;
@synthesize dataDecoder = _dataDecoder;
@synthesize authenticator = _authenticator;
@synthesize disableAuthenticator = _disableAuthenticator;
@synthesize networkStreamSink = _networkStreamSink;
@synthesize finisher = _finisher;
@synthesize asyncQueue = _asyncQueue;
@synthesize httpStream = _httpStream;
@synthesize previousResponse = _previousResponse;

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
    [_previousResponse release];
    [_httpStream release];
    [_finisher release];
    [_networkStreamSink release];
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

- (void) closeStreamWithError:(NSError*) error {
    [_httpStream closeStreamWithError:error];
    self.httpStream = nil;
}

- (void) requestCancel {
    NSError* error = [NSError cancelError];
    [self closeStreamWithError:error];
}

- (void) openStreamWithURL:(NSURL*) url {
    
    [self sendMessage:@selector(httpRequestWillOpen:) toListener:self.finisher];
    
    [self willSendHttpRequest]; // this may set requestURL so needs to be before createStreamOpenerWithURL

    if(!self.networkStreamSink) {
        self.networkStreamSink = [FLDataStreamSink networkStreamSink];
    }
    
    FLHttpMessage* cfRequest = [FLHttpMessage httpMessageWithURL:self.headers.requestURL httpMethod:self.headers.httpMethod];
    cfRequest.headers = self.headers.allHeaders;
    
    if(self.body.bodyData) {
        cfRequest.bodyData = self.body.bodyData;
    }
    
    self.httpStream  = [FLHttpStream httpStream:cfRequest withBodyStream:self.body.bodyStream];
    self.httpStream.sink = self.networkStreamSink;
        
    [self.httpStream openStreamWithDelegate:self asyncQueue:self.asyncQueue];
}

- (void) openAuthenticatedStreamWithURL:(NSURL*) url {

    if(self.authenticator && !self.disableAuthenticator) {
        [self sendMessage:@selector(httpRequestWillAuthenticate:) toListener:_finisher];
        [self willAuthenticate];
            
        [self.authenticator authenticateHttpRequest:self];
        
        [self didAuthenticate];
        [self sendMessage:@selector(httpRequestDidAuthenticate:) toListener:_finisher];
    }

    [self openStreamWithURL:url];
}

- (void) startWorking:(FLFinisher*) finisher {
    self.finisher = finisher;
    [self openAuthenticatedStreamWithURL:self.headers.requestURL];
}

- (void) networkStreamDidOpen:(FLHttpStream*) networkStream {
    [self sendMessage:@selector(httpRequestDidOpen:) toListener:self.finisher];
}

- (void) networkStream:(FLHttpStream*) stream didReadBytes:(NSNumber*) amountRead {
    [self sendMessage:@selector(httpRequest:didReadBytes:) toListener:self.finisher withObject:amountRead];
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

        [self sendMessage:@selector(httpRequest:didCloseWithResult:) toListener:self.finisher withObject:result];
        
        [finisher setFinishedWithResult:result];
    }
}

- (void) networkStream:(FLHttpStream*) readStream encounteredError:(NSError*) error {
    [self sendMessage:@selector(httpRequest:encounteredError:) toListener:self.finisher withObject:error];
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
                                                   responseData:_networkStreamSink.data
                                            responseDataFileURL:_networkStreamSink.fileURL];

        FLAssert_(response.responseData != nil || response.responseDataFileURL != nil);

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




