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
#import "FLHttpRequestContent.h"
#import "FLCancellable.h"

#import "FLReadStream.h"

@class FLRequestContext;

@interface FLHttpRequest : FLObservable<FLCancellable, FLReadStreamDelegate, FLDispatchable> {
@private
    FLHttpRequestContent* _content;
    FLFinisher* _finisher;
    FLMutableHttpResponse* _response;
    FLReadStream* _networkStream;
    FLDispatchQueue* _dispatchQueue;
    FLRequestContext* _requestContext;
}

@property (readwrite, strong, nonatomic) FLRequestContext* requestContext;

@property (readonly, strong, nonatomic) FLHttpRequestHeaders* httpHeaders;
@property (readonly, strong, nonatomic) FLHttpRequestContent* httpBody;

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

@interface FLHttpRequest (RequestSending)

// note that a FLHttpRequest implements FLDispatchable
// so that the FLHttpRequest can be run in the dispatcher of your choice as well.
// See FLDispatchQueue.h

// These are here for convienience.

/// starts in current thread.
- (FLFinisher*) sendRequest:(FLCompletionBlock) completion;

- (FLFinisher*) sendRequest;

/// starts in current thread and blocks thread until complete
- (FLResult) sendRequestSynchronously;

/// starts in current thread but runs in context so the request
/// can be authenticated or cancelled later in batches
- (FLFinisher*) sendRequestWithContext:(FLRequestContext*) requestContext;

/// runs in context and blocks current thread until done.
- (FLResult) sendRequestSynchronouslyWithContext:(FLRequestContext*) requestContext;

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

