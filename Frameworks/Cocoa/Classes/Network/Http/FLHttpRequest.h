//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLamp.h"
#import "FLAsyncOperation.h"
#import "FLHttpStream.h"

#define FLHttpRequestDefaultTimeoutInterval 120.0f

@class FLHttpRequest;
@class FLHttpStream;
@class FLHttpRequestBody;
@class FLFifoAsyncQueue;
@class FLTimer;
@class FLHttpRequestByteCount;
@class FLHttpRequestHeaders;
@class FLHttpRequestBody;
@class FLHttpStream;
@class FLInputSink;
@class FLHttpResponse;

@protocol FLHttpRequestBehavior;
@protocol FLRetryHandler;

@protocol FLHttpRequestAuthenticator <NSObject>
//// this needs to be synchronous for scheduling reasons amoung concurrent requests.
- (void) authenticateHttpRequest:(FLHttpRequest*) request;
@end

@protocol FLHttpRequestContext <NSObject>
- (id<FLHttpRequestAuthenticator>) httpRequestAuthenticator;
@end

@interface FLHttpRequest : FLAsyncOperation<FLHttpStreamDelegate> {
@private
    FLHttpRequestHeaders* _requestHeaders;
    FLHttpRequestBody* _requestBody;
    FLFifoAsyncQueue* _asyncQueueForStream;
    FLHttpResponse* _previousResponse; // if redirected
    FLHttpStream* _httpStream;
    NSTimeInterval _timeoutInterval;
    
    // helpers
    id<FLInputSink> _inputSink;
    id<FLHttpRequestAuthenticator> _authenticator;
    BOOL _disableAuthenticator;
    
    FLNetworkStreamSecurity _streamSecurity;
    
    FLHttpRequestByteCount* _byteCount;

    id<FLHttpRequestBehavior> _behavior;
    id<FLRetryHandler> _retryHandler;
}

@property (readwrite, nonatomic, strong) id<FLHttpRequestBehavior> behavior;
@property (readwrite, nonatomic, strong) id<FLRetryHandler> retryHandler;
@property (readwrite, strong, nonatomic) id<FLInputSink> inputSink;
@property (readwrite, strong, nonatomic) id<FLHttpRequestAuthenticator> authenticator;

// timeouts
@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;

@property (readwrite, assign, nonatomic) BOOL disableAuthenticator;
@property (readwrite, assign, nonatomic) FLNetworkStreamSecurity streamSecurity;

// http
@property (readonly, strong, nonatomic) FLHttpRequestHeaders* requestHeaders;
@property (readonly, strong, nonatomic) FLHttpRequestBody* requestBody;

@property (readonly, strong) FLHttpRequestByteCount* byteCount;

- (id) initWithRequestURL:(NSURL*) requestURL
               httpMethod:(NSString*) httpMethod; // designated

+ (id) httpRequestWithURL:(NSURL*) url 
               httpMethod:(NSString*) httpMethod;

- (id) initWithRequestBehavior:(id<FLHttpRequestBehavior>) behavior;

+ (id) httpRequest:(id<FLHttpRequestBehavior>) behavior;

@end


@protocol FLHttpRequestDelegate <NSObject>
@optional

- (void) httpRequestWillAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLPromisedResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(FLHttpRequestByteCount*) amount;

- (void) httpRequest:(FLHttpRequest*) httpRequest didWriteBytes:(NSNumber*) amount;

@end

