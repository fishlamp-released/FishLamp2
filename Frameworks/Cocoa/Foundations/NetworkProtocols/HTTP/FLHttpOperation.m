//
//	FLNetworkOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLHttpOperation.h"

@interface FLHttpOperation ()
@property (readwrite, strong) FLHttpRequest* httpRequest;
@end

@implementation FLHttpOperation
@synthesize httpRequestURL = _httpRequestURL;
@synthesize httpRequest = _httpRequest;
@synthesize requestSender = _requestSender;

#if FL_MRC
- (void) dealloc {
    [_httpRequest release];
    [_httpRequestURL release];
    [_requestSender release];
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
    [self.httpRequest requestCancel];
}

- (FLResult) sendHttpRequest:(FLHttpRequest*) request {
    FLAssertNotNil_(request);
    self.httpRequest = request;
    
    @try {
        self.httpRequest.redirector = self;
        [self.httpRequest addObserver:self];
        
        if(self.requestSender) {
            return [self.requestSender sendHttpRequest:request];
        }
        else {
            return [self.httpRequest sendRequest];
        }
    }
    @finally {
        [self.httpRequest removeObserver:self];
        self.httpRequest.redirector = nil;
        self.httpRequest = nil;
    }
}

- (void) httpRequest:(FLHttpRequest*) httpRequest 
     shouldRedirect:(BOOL*) redirect toURL:(NSURL*) url {
}


@end

