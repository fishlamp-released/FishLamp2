//
//	FLHttpOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLHttpOperation.h"

#if IOS
#import "FLReachableNetwork.h"
#endif
//#import <libkern/OSAtomic.h>


@implementation FLHttpOperation

@synthesize networkRequestFactory = _requestFactory;
@synthesize responseHandler = _responseHandler;
@synthesize URL = _url;
@synthesize serverContext = _serverDefaults;
@synthesize requestType = _requestType;

- (void) setServerContext:(FLNetworkServerContext *) context {
	FLAssignObject(_serverDefaults, context);
	self.networkRequestFactory = context.defaultNetworkRequestFactory;
	self.responseHandler = context.defaultNetworkOperationResponseHandler;
	self.authenticator = context.authenticator;
}

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
	
	FLAssert(FLStringsAreEqual(url, self.URLString), @"setting URL failed");
}

- (void) didInit {
}

- (void) _setDefaults {
	self.securityBehavior = FLOperationAuthenticationBehaviorUnknown;
	[self didInit];
}

- (id) init {
	if((self = [super init])) {
		[self _setDefaults];
	}
	
	return self;
}

- (id) initWithURL:(NSURL*) url {
	if((self = [super init])) {	
		[self _setDefaults];
		self.URL = url;
	}
	
	return self;
}

- (id) initWithURLString:(NSString*) url {
	if((self = [super init])) {	
		[self _setDefaults];
		self.URL = [NSURL URLWithString:url];
	}
	
	return self;
}

- (id) initWithNetworkConnectionFactory:(id<FLHttpConnectionFactory>) requestFactory 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler
	authenticator:(id<FLOperationAuthenticator>) authenticator {
	if((self = [super init])) {
		[self _setDefaults];
		self.networkRequestFactory = requestFactory;
		self.responseHandler = responseHandler;
		self.authenticator = authenticator;
	}

	return self;
}

- (id) initWithNetworkConnection:(FLHttpConnection*) connection 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler
	authenticator:(id<FLOperationAuthenticator>) authenticator {
	if((self = [super init])) {
		[self _setDefaults];
		self.httpConnection = connection;
		self.responseHandler = responseHandler;
		self.authenticator = authenticator;
	}

	return self;
}

- (id) initWithServerContext:(FLNetworkServerContext*) context {
	if((self = [super init])) {
		[self _setDefaults];
		self.serverContext = context;
	}
	return self;
}

+ (id) networkOperationWithURLString:(NSString*) url {
	return FLReturnAutoreleased([[[self class] alloc] initWithURL:[NSURL URLWithString:url]]);
}

+ (id) networkOperationWithURL:(NSURL*) url {
	return FLReturnAutoreleased([[[self class] alloc] initWithURL:url]);
}

+ (id) networkOperationWithServerContext:(FLNetworkServerContext*) context {
	return FLReturnAutoreleased([[[self class] alloc] initWithServerContext:context]);
}

+ (id) networkOperationWithNetworkConnectionFactory:(id<FLHttpConnectionFactory>) requestFactory 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler
	authenticator:(id<FLOperationAuthenticator>) authenticator {
	return FLReturnAutoreleased([[[self class] alloc] initWithNetworkConnectionFactory:requestFactory responseHandler:responseHandler authenticator:authenticator]);
}

+ (id) networkOperationWithNetworkConnection:(FLHttpConnection*) connection 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler
	authenticator:(id<FLOperationAuthenticator>) authenticator {
	return FLReturnAutoreleased([[[self class] alloc] initWithNetworkConnection:connection responseHandler:responseHandler authenticator:authenticator]);
}

- (id) setRequestWillPost {
	self.requestType = @"POST";
	if(self.httpConnection) {
		[((id)self.httpConnection) setHTTPMethodToPost];
	}
	
	return self;
}

- (void) dealloc {
    FLRelease(_requestType);
	FLRelease(_serverDefaults);
	FLRelease(_requestFactory);
	FLRelease(_url);
	FLRelease(_responseHandler);
	FLSuperDealloc();
}
    
- (FLHttpConnection*) createNetworkConnection {
	if(_requestFactory) {
		return [_requestFactory networkOperationCreateNetworkRequest:self];
	}
    else {
        return [FLHttpConnection httpConnection:[FLHttpRequest httpRequestWithURL:self.URL 
                                                                    requestMethod:self.requestType]];
    }
	return nil;
}

- (void) willOpenConnection:(FLNetworkConnection*) connection {
    [super willOpenConnection:connection];
    
    FLNetworkConnectionObserver* observer = [FLNetworkConnectionObserver networkConnectionObserver:self];

// TODO: fix redirect

//    observer.onWillRedirect = ^(id theConnection, BOOL* shouldRedirect, NSURL* url) {
//        if(_responseHandler) {
//            [_responseHandler networkOperation:self shouldRedirectToURL:url willRedirect:shouldRedirect];
//        }
//    };
    
    [connection addObserver:observer];
    
}

- (void) willPerformOperation { 
	if(!self.URL) {
		self.URL = [self createURL];
	}
	[super willPerformOperation];
}

- (NSURL*) createURL {
	return nil;
}

- (void) didCloseConnection:(FLNetworkConnection*) connection {
    if(self.responseHandler) {
        NSError* error = [self.responseHandler networkOperation:self 
                                     networkConnectionDidFinish:(FLHttpConnection*) self.networkConnection];
                                 
        if(error) {
            FLThrowError(error);
        }
    }
}

@end


