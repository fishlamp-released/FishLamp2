//
//	FLNetworkOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLHttpOperation.h"

@interface FLHttpOperation ()
@property (readwrite, strong) FLHttpStream* httpStream;
@end

@implementation FLHttpOperation
@synthesize requestAuthenticator = _requestAuthenticator;
@synthesize httpRequestURL = _httpRequestURL;
@synthesize httpStream = _httpStream;

#if FL_MRC
- (void) dealloc {
    [_httpStream release];
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

- (void) requestCancel {
	[super requestCancel];
    [self.httpStream requestCancel];
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
    self.httpStream = [FLHttpStream httpStream];
    @try {
        self.httpStream.redirector = self;
        [self.httpStream addObserver:self];
        return FLConfirmResultType([self.httpStream sendSynchronousRequest:request], FLHttpResponse);
    }
    @finally {
        [self.httpStream removeObserver:self];
        self.httpStream.redirector = nil;
        self.httpStream = nil;
    }
}

- (void) httpStream:(FLHttpStream*) httpStream 
     shouldRedirect:(BOOL*) redirect toURL:(NSURL*) url {
}


@end

