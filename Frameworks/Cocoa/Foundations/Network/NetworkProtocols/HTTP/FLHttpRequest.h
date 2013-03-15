//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDispatch.h"
#import "FLReadStream.h"
#import "FLHttpResponse.h"
#import "FLHttpRequestBody.h"
#import "FLDataEncoding.h"
#import "FLDataDecoding.h"
#import "FLHttpRequestObserver.h"
#import "FLTimer.h"
#import "FLTimedObject.h"
#import "FLHttpStream.h"

#define FLWriteStreamDefaultTimeout 120.0f

@class FLHttpRequest;

@protocol FLHttpRequestAuthenticator <NSObject>
//// this needs to be synchronous for scheduling reasons amoung concurrent requests.
- (FLResult) authenticateHttpRequest:(FLHttpRequest*) request;
@end

@protocol FLHttpRequestContext <NSObject>
- (id<FLHttpRequestAuthenticator>) httpRequestAuthenticator;
@end

@interface FLHttpRequest : FLContextWorker<FLNetworkStreamDelegate> {
@private
    FLHttpRequestHeaders* _headers;
    FLHttpRequestBody* _body;
    FLFifoAsyncQueue* _asyncQueue;
    FLFinisher* _finisher;
    FLHttpResponse* _httpResponse;
    FLHttpStream* _httpStream;
    
    // helpers
    id<FLResponseReceiver> _responseReceiver;
    id<FLDataEncoding> _dataEncoder;
    id<FLDataDecoding> _dataDecoder;
    id<FLHttpRequestAuthenticator> _authenticator;
    BOOL _disableAuthenticator;
}

// by default this is a FLDataResponseReciever.
@property (readwrite, strong, nonatomic) id<FLResponseReceiver> responseReceiver;
@property (readwrite, strong, nonatomic) id<FLDataEncoding> dataEncoder;
@property (readwrite, strong, nonatomic) id<FLDataDecoding> dataDecoder;
@property (readwrite, strong, nonatomic) id<FLHttpRequestAuthenticator> authenticator;

@property (readwrite, assign, nonatomic) BOOL disableAuthenticator;

// http
@property (readonly, strong, nonatomic) FLHttpRequestHeaders* headers;
@property (readonly, strong, nonatomic) FLHttpRequestBody* body;


- (id) initWithRequestURL:(NSURL*) requestURL;

- (id) initWithRequestURL:(NSURL*) requestURL
               httpMethod:(NSString*) httpMethod; // designated

+ (id) httpRequest:(NSURL*) url 
        httpMethod:(NSString*) httpMethod;

+ (id) httpRequest:(NSURL*) url;

/// called before the request is started. You may set ALL of the
/// request info here, including the URL
- (void) willSendHttpRequest;
- (void) willAuthenticate;
- (void) didAuthenticate;

/// did receive the response. If there was an error, this will
/// not be called.
/// if you want to convert the httpRespose.responseData into something
/// else do it here and return it from from your override
- (FLResult) resultFromHttpResponse:(FLHttpResponse*) httpResponse;

- (NSError*) checkHttpResponseForError:(FLHttpResponse*) httpResponse;


/// this returns YES by default.
- (BOOL) shouldRedirectToURL:(NSURL*) url;
@end






