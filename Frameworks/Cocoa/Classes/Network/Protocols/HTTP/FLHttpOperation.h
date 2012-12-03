//
//	FLNetworkOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLNetworkOperation.h"
#import "FLHttpRequest.h"
#import "FLHttpResponse.h"
#import "FLMutableHttpRequest.h"

@interface FLHttpOperation : FLNetworkOperation {
@private
    id<FLHttpRequestAuthenticator> _requestAuthenticator;
    NSURL* _httpRequestURL;
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


