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
    NSUInteger _retryCount;
    NSUInteger _maxRetryCount;
    BOOL _canRetry;
    NSTimeInterval _retryDelay;
}
// timeouts
@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;

// retries
@property (readonly, assign) NSUInteger retryCount;
@property (readwrite, nonatomic) NSUInteger maxRetryCount;
@property (readwrite, nonatomic) BOOL canRetry;
@property (readwrite, nonatomic) NSTimeInterval retryDelay;

@property (readwrite, strong, nonatomic) id<FLInputSink> inputSink;
@property (readwrite, strong, nonatomic) id<FLHttpRequestAuthenticator> authenticator;

@property (readwrite, assign, nonatomic) BOOL disableAuthenticator;
@property (readwrite, assign, nonatomic) FLNetworkStreamSecurity streamSecurity;

// http
@property (readonly, strong, nonatomic) FLHttpRequestHeaders* requestHeaders;
@property (readonly, strong, nonatomic) FLHttpRequestBody* requestBody;

- (id) initWithRequestURL:(NSURL*) requestURL;

- (id) initWithRequestURL:(NSURL*) requestURL
               httpMethod:(NSString*) httpMethod; // designated

+ (id) httpRequestWithURL:(NSURL*) url 
               httpMethod:(NSString*) httpMethod;

+ (id) httpRequestWithURL:(NSURL*) url;

//
// optional overrides
//

/// called before the request is started. You may set ALL of the
/// request info here, including the URL
- (void) willSendHttpRequest;
- (void) willAuthenticate;
- (void) didAuthenticate;
- (void) didReadBytes:(unsigned long long) amount;
- (void) requestDidFinishWithResult:(FLPromisedResult) result;

/// did receive the response. If there was an error, this will
/// not be called.
/// if you want to convert the httpRespose.responseData into something
/// else do it here and return it from from your override
- (id) resultFromHttpResponse:(FLHttpResponse*) httpResponse;

- (NSError*) checkHttpResponseForError:(FLHttpResponse*) httpResponse;

/// this returns YES by default.
- (BOOL) shouldRedirectToURL:(NSURL*) url;

@property (readonly, strong) FLHttpRequestByteCount* byteCount;

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

