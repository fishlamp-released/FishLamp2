//
//	FLHttpOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLHttpOperation.h"

@interface FLHttpOperation ()
@property (readwrite, strong) FLHttpResponse* httpResponse;
@end

@implementation FLHttpOperation
@synthesize URL = _url;
@synthesize requestType = _requestType;
@synthesize isAuthenticated = _isAuthenticated;
@synthesize isSecure = _isSecure;
@synthesize httpResponse = _httpResponse;
@synthesize httpDelegate = _httpDelegate;

- (FLHttpConnection*) httpConnection {
    return (FLHttpConnection*) self.networkConnection;
}

- (void) setHttpConnection:(FLHttpConnection*) connection {
    self.networkConnection = connection;
}

- (NSString*) URLString {
	return _url.absoluteString;
}

- (void) setURLString:(NSString*) url {
	self.URL = [NSURL URLWithString:url];
	
	FLAssert_v(FLStringsAreEqual(url, self.URLString), @"setting URL failed");
}

- (void) didInit {
}

- (id) init {
	if((self = [super init])) {
        [self didInit];
	}
	
	return self;
}

- (id) initWithURL:(NSURL*) url {
	if((self = [super init])) {	
        [self didInit];
		self.URL = url;
	}
	
	return self;
}

- (id) initWithURLString:(NSString*) url {
	if((self = [super init])) {	
        [self didInit];
        self.URL = [NSURL URLWithString:url];
	}
	
	return self;
}

+ (id) networkOperationWithURLString:(NSString*) url {
	return autorelease_([[[self class] alloc] initWithURL:[NSURL URLWithString:url]]);
}

+ (id) networkOperationWithURL:(NSURL*) url {
	return autorelease_([[[self class] alloc] initWithURL:url]);
}

- (id) setRequestWillPost {
	self.requestType = @"POST";
	if(self.httpConnection) {
		[((id)self.httpConnection) setHTTPMethodToPost];
	}
	
	return self;
}

- (void) dealloc {
    release_(_httpResponse);
    release_(_requestType);
	release_(_url);
	super_dealloc_();
}
    
- (FLHttpConnection*) createNetworkConnection {
	FLHttpConnection* connection = nil;
    
    if(_httpDelegate && [((id)self.httpDelegate) respondsToSelector:@selector(httpOperationCreateConnection:)]) {
		connection = [_httpDelegate httpOperationCreateConnection:self];
	}
    else {
        connection = [FLHttpConnection httpConnection:[FLHttpRequest httpRequestWithURL:self.URL]];
    }
    
	return connection;
}

- (FLHttpRequest*) httpRequest {
    return self.httpConnection.httpRequest;
}

- (NSURL*) createURL {
	return nil;
}

- (void) runSelf {

	if(!self.URL) {
		self.URL = [self createURL];
	}

    [((id)self.httpDelegate) performIfRespondsToSelector:@selector(httpOperationWillRun:) withObject:self];
    
    [super runSelf];
}

- (void) handleAsyncResultFromConnection:(id) result {
    FLHttpResponse* httpResponse = result;
    FLAssertIsNotNil_(httpResponse);
    FLAssertIsKindOfClass_(httpResponse, FLHttpResponse);
    self.httpResponse = result;
}

- (void) finishSelf {
    [super finishSelf];
    if(![((id)self.httpDelegate) performIfRespondsToSelector:@selector(httpOperationDidRun:) withObject:self] ) {
        FLThrowIfError_([self.httpResponse simpleHttpResponseErrorCheck]);
    }
}


@end


