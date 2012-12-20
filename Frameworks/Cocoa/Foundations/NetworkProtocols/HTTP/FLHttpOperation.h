//
//	FLNetworkOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCore.h"
#import "FLOperation.h"
#import "FLHttpStream.h"
#import "FLHttpRequest.h"
#import "FLHttpResponse.h"
#import "FLMutableHttpRequest.h"

@interface FLHttpOperation : FLOperation<FLHttpStreamDelegate> {
@private
    id<FLHttpRequestAuthenticator> _requestAuthenticator;
    NSURL* _httpRequestURL;

// only valid while sending request
    FLHttpStream* _httpStream;
    dispatch_semaphore_t _semaphore;
}

@property (readwrite, strong) NSURL* httpRequestURL;

@property (readwrite, strong) id<FLHttpRequestAuthenticator> requestAuthenticator;

- (id) initWithHTTPRequestURL:(NSURL*) url;

+ (id) httpOperation;

+ (id) httpOperationWithHTTPRequestURL:(NSURL*) httpRequestURL;

- (FLHttpResponse*) sendHttpRequest:(FLMutableHttpRequest*) request 
                  withAuthenticator:(id<FLHttpRequestAuthenticator>) authenticator;

- (FLHttpResponse*) sendHttpRequest:(FLHttpRequest*) request;

@end


