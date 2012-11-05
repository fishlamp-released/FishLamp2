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

//synthesize_(httpDelegate);
synthesize_(httpAuthenticator);

- (void) didInit {
}

- (id) init {
	if((self = [super init])) {
        [self didInit];
	}
	
	return [self initWithURL:nil];
}

- (id) initWithURL:(NSURL*) url {
	if((self = [super init])) {	
		self.URL = url;
        [self didInit];
	}
	
	return self;
}


- (id) initWithURLString:(NSString*) url {
	return [self initWithURL:[NSURL URLWithString:url]];
}

+ (id) networkOperationWithURLString:(NSString*) url {
	return autorelease_([[[self class] alloc] initWithURL:[NSURL URLWithString:url]]);
}

+ (id) networkOperationWithURL:(NSURL*) url {
	return autorelease_([[[self class] alloc] initWithURL:url]);
}

dealloc_(
    [_httpAuthenticator release];
    [_httpResponse release];
    [_requestType release];
	[_url release];
)

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

- (id) setRequestWillPost {
	self.requestType = @"POST";
	if(self.httpConnection) {
		[((id)self.httpConnection) setHTTPMethodToPost];
	}
	
	return self;
} 
    
- (FLHttpConnection*) createNetworkConnection {
    return  [FLHttpConnection httpConnection:[FLHttpRequest httpRequestWithURL:self.URL requestMethod:self.requestType]];
}

- (FLHttpRequest*) httpRequest {
    return self.httpConnection.httpRequest;
}

- (void) prepareAuthenticatedConnection:(FLHttpConnection*) connection {
    FLPerformSelector2(self.httpAuthenticator, @selector(httpOperation:prepareAuthenticatedConnection:), self, connection);
}

- (void) authenticateSelf {
    FLPerformSelector1(self.httpAuthenticator, @selector(httpOperationRunAuthentication:), self);
}

- (void) prepareSelf {
    [self authenticateSelf];
    [super prepareSelf];
}

- (void) runSelf {
    [self prepareAuthenticatedConnection:self.httpConnection];
    [super runSelf];
}

- (void) handleAsyncResultFromConnection:(id) result {
    FLHttpResponse* httpResponse = result;
    FLAssertIsNotNil_(httpResponse);
    FLAssertIsKindOfClass_(httpResponse, FLHttpResponse);
    self.httpResponse = result;
}

@end


