//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLObservable.h"
#import "FLDispatching.h"
#import "FLReadStream.h"
#import "FLResult.h"
#import "FLHttpResponse.h"
#import "FLHttpRequestBody.h"

@class FLHttpRequest;
@class FLFinisher;

@protocol FLHttpRequestAuthenticator <NSObject>
// this needs to be synchronous for scheduling reasons amoung concurrent requests.
- (void) authenticateHttpRequest:(FLHttpRequest*) httpRequest;
@end

@protocol FLHttpRequestDispatchingContext <NSObject>
- (id<FLDispatching>) httpRequestFifoDispatcher:(FLHttpRequest*) request;
- (id<FLHttpRequestAuthenticator>) httpRequestAuthenticator:(FLHttpRequest*) request;
- (void) httpRequestDidStart:(FLHttpRequest*) request;
- (void) httpRequestDidFinish:(FLHttpRequest*) request;
@end


@interface FLHttpRequest : FLObservable<FLReadStreamDelegate, FLDispatchable, FLContextual> {
@private
    FLHttpRequestHeaders* _headers;
    FLHttpRequestBody* _body;
    FLFinisher* _finisher;
    FLMutableHttpResponse* _response;
    FLReadStream* _networkStream;
    id _context;
    id<FLDispatching> _dispatcher;
    BOOL _authenticationDisabled;
}

@property (readwrite, assign, nonatomic) BOOL authenticationDisabled;

@property (readonly, strong) id context;

// http
@property (readonly, strong, nonatomic) FLHttpRequestHeaders* headers;
@property (readonly, strong, nonatomic) FLHttpRequestBody* body;

- (id) initWithRequestURL:(NSURL*) requestURL;

- (id) initWithRequestURL:(NSURL*) requestURL
               httpMethod:(NSString*) httpMethod; // designated

+ (id) httpRequest:(NSURL*) url 
        httpMethod:(NSString*) httpMethod;

+ (id) httpRequest;


@end

@interface FLHttpRequest () // Sending

// by default the request is run in global FIFO queue (FLFifoDispatchQueue) 
// if the context provides a dispatcher, that one will be used instead.
- (void) requestCancel;

- (FLResult) sendSynchronouslyInContext:(id) context;

- (FLFinisher*) startRequestInContext:(id) context 
                      completionBlock:(FLCompletionBlock) completionBlock;
@end

@interface FLHttpRequest () // optional overrides

- (void) willAuthenticateHttpRequest:(id<FLHttpRequestAuthenticator>) authenticator;
- (void) didAuthenticateHttpRequest;

/// called before the request is started. You may set ALL of the
/// request info here, including the URL
- (void) willSendHttpRequest;

/// did receive the response. If there was an error, this will
/// not be called.
/// if you want to convert the httpRespose.responseData into something
/// else do it here and return it from from your override
- (id) didReceiveHttpResponse:(FLHttpResponse*) httpResponse;

//
// Redirects
//

/// this returns YES by default.
- (BOOL) shouldRedirectToURL:(NSURL*) url;
- (void) didMoveToContext:(id) context;
@end


@protocol FLHttpRequestObserver <NSObject>

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
   willCloseWithResult:(FLResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest
      didEncounterError:(NSError*) error;

- (void) httpRequestDidReadBytes:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidWriteBytes:(FLHttpRequest*) httpRequest;

@end



