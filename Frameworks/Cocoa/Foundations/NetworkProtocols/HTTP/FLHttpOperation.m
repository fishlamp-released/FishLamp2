//
//	FLNetworkOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLHttpOperation.h"
#import "FLHttpConnection.h"

@implementation FLHttpOperation
@synthesize requestAuthenticator = _requestAuthenticator;
@synthesize httpRequestURL = _httpRequestURL;

#if FL_MRC
- (void) dealloc {
    [_httpRequestURL release];
    [_requestAuthenticator release];
    [super dealloc];
}
#endif

- (id) initWithHTTPRequestURL:(NSURL*) url {
    self = [super init];
    if(self) {
        self.httpRequestURL = url;
    }
    return self;
}

- (id) init {
    return [self initWithHTTPRequestURL:nil];
}

+ (id) httpOperation {
    return FLAutorelease([[[self class] alloc] initWithHTTPRequestURL:nil]);
}

+ (id) httpOperationWithHTTPRequestURL:(NSURL*) httpRequestURL {
    return FLAutorelease([[[self class] alloc] initWithHTTPRequestURL:httpRequestURL]);
}

- (FLHttpResponse*) sendHttpRequest:(FLMutableHttpRequest*) request 
                  withAuthenticator:(id<FLHttpRequestAuthenticator>) authenticator {
    
    FLAssertNotNil_(request);

    if(authenticator) {
        FLThrowError([authenticator authenticateHTTPRequest:request]);
    }
    
    return [self sendHttpRequest:request];
}

- (FLHttpResponse*) sendHttpRequest:(FLHttpRequest*) request {

    FLAssertNotNil_(request);

    FLHttpConnection* connection = [FLHttpConnection httpConnection:request];
    
    FLHttpResponse* httpResponse = FLThrowError([self runConnection:connection]);
    FLAssertIsNotNil_(httpResponse);
    FLAssertIsKindOfClass_(httpResponse, FLHttpResponse);

    return httpResponse;

}

@end

