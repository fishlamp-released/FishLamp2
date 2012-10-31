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

@interface FLHttpOperation ()
@property (readwrite, strong) FLHttpResponse* httpResponse;
@end

@implementation FLHttpOperation

@synthesize networkRequestFactory = _requestFactory;
@synthesize responseHandler = _responseHandler;
@synthesize URL = _url;
@synthesize serverContext = _serverDefaults;
@synthesize requestType = _requestType;

@synthesize authenticator = _authenticator;
@synthesize securityCredentials = _securityCredentials;
@synthesize isAuthenticated = _isAuthenticated;
@synthesize isSecure = _isSecure;
@synthesize httpResponse = _httpResponse;

- (void) setServerContext:(FLNetworkServerContext *) context {
	
    FLRetainObject_(_serverDefaults, context);
	
    self.networkRequestFactory = context.defaultNetworkRequestFactory;
	self.responseHandler = context.defaultNetworkOperationResponseHandler;
    self.authenticator = context.authenticator;
}

- (void) setAuthenticator:(id<FLHttpOperationAuthenticator>) authenticator {
    FLRetainObject_(_authenticator, authenticator);
    if(_authenticator) {
        [_authenticator setDefaultSecurityForOperation:self];
    }
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
	
	FLAssert_v(FLStringsAreEqual(url, self.URLString), @"setting URL failed");
}

- (void) didInit {
}

- (void) _setDefaults {
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
                        responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler  {
	if((self = [super init])) {
		[self _setDefaults];
		self.networkRequestFactory = requestFactory;
		self.responseHandler = responseHandler;
	}

	return self;
}

- (id) initWithNetworkConnection:(FLHttpConnection*) connection 
                 responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler {
	if((self = [super init])) {
		[self _setDefaults];
		self.httpConnection = connection;
		self.responseHandler = responseHandler;
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
	return autorelease_([[[self class] alloc] initWithURL:[NSURL URLWithString:url]]);
}

+ (id) networkOperationWithURL:(NSURL*) url {
	return autorelease_([[[self class] alloc] initWithURL:url]);
}

+ (id) networkOperationWithServerContext:(FLNetworkServerContext*) context {
	return autorelease_([[[self class] alloc] initWithServerContext:context]);
}

- (id) setRequestWillPost {
	self.requestType = @"POST";
	if(self.httpConnection) {
		[((id)self.httpConnection) setHTTPMethodToPost];
	}
	
	return self;
}

- (void) dealloc {
    mrc_release_(_securityCredentials);
    mrc_release_(_authenticator);
    mrc_release_(_requestType);
	mrc_release_(_serverDefaults);
	mrc_release_(_requestFactory);
	mrc_release_(_url);
	mrc_release_(_responseHandler);
	mrc_super_dealloc_();
}
    
- (FLHttpConnection*) createNetworkConnection {
	FLHttpConnection* connection = nil;
    
    if(_requestFactory) {
		connection = [_requestFactory networkOperationCreateNetworkRequest:self];
	}
    else {
        connection = [FLHttpConnection httpConnection:[FLHttpRequest httpRequestWithURL:self.URL]];
    }
    
   	if(_authenticator && _isSecure && _isAuthenticated) {
        [_authenticator authenticateConnection:connection withAuthenticatedOperation:self];
    }
    
	return connection;
}

- (void) networkConnection:(FLNetworkConnection*) connection
            shouldRedirect:(BOOL*) redirect
                     toURL:(NSURL*) url {
    
    if(_responseHandler && [_responseHandler respondsToSelector:@selector(networkOperation:shouldRedirect:toURL:)]) {
        [_responseHandler networkOperation:self shouldRedirect:redirect toURL:url];
    }
}

- (FLHttpRequest*) httpRequest {
    return self.httpConnection.httpRequest;
}

- (NSURL*) createURL {
	return nil;
}
- (void) authenticateSelf {
    if(_authenticator && _isSecure && !_isAuthenticated) {
        [_authenticator authenticateOperationSynchronously:self];
        _isAuthenticated = YES;
    }
}
- (void) runSelf {

	if(!self.URL) {
		self.URL = [self createURL];
	}

    [self authenticateSelf];
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
    if(self.responseHandler) {
        [self.responseHandler operationDidRun:self];
    }
    else {
        FLThrowIfError_([self.httpResponse simpleHttpResponseErrorCheck]);
    }
}



//- (void) didCloseConnection:(FLNetworkConnection*) connection {
//    if(self.responseHandler) {
//        NSError* error = [self.responseHandler networkOperation:self 
//                                     networkConnectionDidFinish:(FLHttpConnection*) self.networkConnection];
//                                 
//        if(error) {
//            FLThrowError_(error);
//        }
//    }
//}

/*
mrc_release_(_securityCredentials);
	
        if(self.authenticator ) {
            [self.authenticator setDefaultSecurityForOperation:self];
        }

        FLSetBitsAtomic(_state, FLOperationStatePrepared);

        [self visitObservers:^(id observer, BOOL* stop) {
            if([observer respondsToSelector:@selector(willStartSelf:)]) {
                [observer willStartSelf:self];
            }
        }];
            
        AbortIfNeeded();

        [self willStartSelf];

        AbortIfNeeded();

    
        if(self.authenticator) {
            FLTrace(@"starting authentication for operation: %@", [self description]);
            self.error = [self.authenticator authenthicateOperation:self];
        }
*/

@end


