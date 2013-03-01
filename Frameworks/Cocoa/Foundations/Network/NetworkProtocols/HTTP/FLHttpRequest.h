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

@class FLHttpRequest;

@protocol FLHttpRequestAuthenticator <NSObject>
// this needs to be synchronous for scheduling reasons amoung concurrent requests.
- (void) httpRequest:(FLHttpRequest*) httpRequest 
        authenticateSynchronouslyInContext:(id) context 
        withObserver:(id) observer;

- (id<FLDispatcher>) httpRequestAuthenticationDispatcher:(FLHttpRequest*) httpRequest;
@end

@protocol FLHttpRequestInterceptor <NSObject>
- (void) httpRequest:(FLHttpRequest*) httpRequest 
     willSendRequest:(FLFinisher*) withFinisher;
                                
- (void) httpRequest:(FLHttpRequest*) httpRequest 
 didFinishWithResult:(FLResult) result;
@end

@protocol FLHttpRequestContext <NSObject>
- (void) httpRequestWillBeginWorking:(FLHttpRequest*) request;
@end

@interface FLHttpRequest : NSObject<FLAsyncWorker, FLReadStreamDelegate> {
@private
    FLHttpRequestHeaders* _headers;
    FLHttpRequestBody* _body;
    id _observer;
    FLFinisher* _finisher;
    FLMutableHttpResponse* _response;
    FLReadStream* _networkStream;
    id<FLDispatcher> _dispatcher;
    
    // helpers
    id<FLDataEncoding> _dataEncoder;
    id<FLDataDecoding> _dataDecoder;
    id<FLHttpRequestAuthenticator> _authenticator;
    id<FLHttpRequestInterceptor> _interceptor;
    
    BOOL _disableAuthenticator;
}

@property (readwrite, strong, nonatomic) id<FLDataEncoding> dataEncoder;
@property (readwrite, strong, nonatomic) id<FLDataDecoding> dataDecoder;
@property (readwrite, strong, nonatomic) id<FLHttpRequestAuthenticator> authenticator;
@property (readwrite, strong, nonatomic) id<FLHttpRequestInterceptor> interceptor;

@property (readwrite, assign, nonatomic) BOOL disableAuthenticator;

// http
@property (readonly, strong, nonatomic) FLHttpRequestHeaders* headers;
@property (readonly, strong, nonatomic) FLHttpRequestBody* body;

- (id) initWithRequestURL:(NSURL*) requestURL;

- (id) initWithRequestURL:(NSURL*) requestURL
               httpMethod:(NSString*) httpMethod; // designated

+ (id) httpRequest:(NSURL*) url 
        httpMethod:(NSString*) httpMethod;

+ (id) httpRequest;

//
// optional overrides
//

/// called before authentication
- (void) willAuthenticateHttpRequest:(id<FLHttpRequestAuthenticator>) authenticator;

/// called after authentication (if no error)
- (void) didAuthenticateHttpRequest;

/// called before the request is started. You may set ALL of the
/// request info here, including the URL
- (void) willSendHttpRequest;

/// did receive the response. If there was an error, this will
/// not be called.
/// if you want to convert the httpRespose.responseData into something
/// else do it here and return it from from your override
- (FLResult) resultFromHttpResponse:(FLHttpResponse*) httpResponse;

/// this returns YES by default.
- (BOOL) shouldRedirectToURL:(NSURL*) url;
@end



//@interface FLWorkerContext (FLHttpRequest)
//
//- (FLResult) sendHttpRequestSynchronously:(FLHttpRequest*) request;
//- (FLResult) sendHttpRequestSynchronously:(FLHttpRequest*) request 
//                             withObserver:(FLHttpRequestObserver*) observer;
//
//
//@end


