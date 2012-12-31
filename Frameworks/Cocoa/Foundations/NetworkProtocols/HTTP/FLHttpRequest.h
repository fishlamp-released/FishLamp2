//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLObservable.h"
#import "FLDispatcher.h"
#import "FLDispatchQueue.h"
#import "FLResult.h"
#import "FLFinisher.h"

#import "FLHttpResponse.h"
#import "FLHttpRequestBody.h"
#import "FLCancellable.h"

#import "FLReadStream.h"

@class FLDispatchableContext;

@interface FLHttpRequest : FLObservable<FLCancellable, FLReadStreamDelegate, FLDispatchable> {
@private
    FLHttpRequestHeaders* _headers;
    FLHttpRequestBody* _body;
    FLFinisher* _finisher;
    FLMutableHttpResponse* _response;
    FLReadStream* _networkStream;
    FLDispatchQueue* _dispatchQueue;
    id _context;
    id _authenticator;
}

// dispatchable
@property (readonly, strong) id context;
@property (readwrite, strong) id<FLObjectAuthenticator> authenticator;

// http
@property (readonly, strong, nonatomic) FLHttpRequestHeaders* headers;
@property (readonly, strong, nonatomic) FLHttpRequestBody* body;


- (id) initWithRequestURL:(NSURL*) requestURL;

- (id) initWithRequestURL:(NSURL*) requestURL
               httpMethod:(NSString*) httpMethod; // designated

+ (id) httpRequest:(NSURL*) url 
        httpMethod:(NSString*) httpMethod;

+ (id) httpRequest;

// optional overrides

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

// TODO: add max number of redirects.
 
/// this returns YES by default.
- (BOOL) shouldRedirectToURL:(NSURL*) url;

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

