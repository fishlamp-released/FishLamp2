//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLAsyncOperation.h"
#import "FLHttpResponse.h"
#import "FLInputSink.h"
#import "FLHttpStream.h"
#import "FLHttpRequestBody.h"
#import "FLHttpRequestHeaders.h"
#import "FLHttpErrors.h"
#import "FLNetworkErrors.h"

#define FLHttpRequestDefaultTimeoutInterval 120.0f

@class FLHttpRequest;
@class FLHttpStream;
@class FLHttpRequestBody;
@class FLFifoAsyncQueue;
@class FLTimer;

@protocol FLHttpRequestAuthenticator <NSObject>
//// this needs to be synchronous for scheduling reasons amoung concurrent requests.
- (void) authenticateHttpRequest:(FLHttpRequest*) request;
@end

@protocol FLHttpRequestContext <NSObject>
- (id<FLHttpRequestAuthenticator>) httpRequestAuthenticator;
@end

typedef struct {
    SEL willAuthenticate;
    SEL didAuthenticate;
    SEL willOpen;
    SEL didOpen;
    SEL didClose;
    SEL didReadBytes;
    SEL didWriteBytes;
} FLHttpRequestDelegateSelectors;

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
    
    unsigned long long _downloadedByteCount;
    NSTimeInterval _lastTime;
    NSTimeInterval _startTime;
    
    FLHttpRequestDelegateSelectors _delegateSelectors; 
}
@property (readwrite, assign, nonatomic) FLHttpRequestDelegateSelectors delegateSelectors;

@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;

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

+ (id) httpRequest:(NSURL*) url 
        httpMethod:(NSString*) httpMethod;

+ (id) httpRequest:(NSURL*) url;

//
// optional overrides
//

/// called before the request is started. You may set ALL of the
/// request info here, including the URL
- (void) willSendHttpRequest;
- (void) willAuthenticate;
- (void) didAuthenticate;
- (void) didReadBytes:(unsigned long long) amount;
- (void) requestDidFinishWithResult:(id) result;

/// did receive the response. If there was an error, this will
/// not be called.
/// if you want to convert the httpRespose.responseData into something
/// else do it here and return it from from your override
- (FLResult) resultFromHttpResponse:(FLHttpResponse*) httpResponse;

- (NSError*) checkHttpResponseForError:(FLHttpResponse*) httpResponse;

/// this returns YES by default.
- (BOOL) shouldRedirectToURL:(NSURL*) url;

// info
@property (readonly, assign) unsigned long long downloadedByteCount;
@property (readonly, assign) NSTimeInterval startTime;
@property (readonly, assign) NSTimeInterval lastTime;
@property (readonly, assign) NSTimeInterval elapsedTime;
@property (readonly, assign) double bytesPerSecond;

@end


@protocol FLHttpRequestDelegate <NSObject>
@optional

- (void) httpRequestWillAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount;

- (void) httpRequest:(FLHttpRequest*) httpRequest didWriteBytes:(NSNumber*) amount;

@end