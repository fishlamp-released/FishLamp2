//
//	FLHttpOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLNetworkOperation.h"
#import "FLHttpConnection.h"

@protocol FLHttpOperationDelegate;
@protocol FLHttpOperationAuthenticator;

@interface FLHttpOperation : FLNetworkOperation {
@private	
	NSURL* _url;
    FLHttpResponse* _httpResponse;
    id<FLHttpOperationAuthenticator> _httpAuthenticator;
    BOOL _isSecure;
    BOOL _isAuthenticated;
}

@property (readwrite, strong) id<FLHttpOperationAuthenticator> httpAuthenticator;

@property (readwrite, strong) NSURL* URL;

@property (readwrite, strong) FLHttpConnection* httpConnection;

@property (readonly, strong) FLHttpRequest* httpRequest;
@property (readonly, strong) FLHttpResponse* httpResponse;

// creation
- (id) initWithURL:(NSURL*) url; // designated 

+ (id) networkOperationWithURL:(NSURL*) url;
+ (id) networkOperationWithURLString:(NSString*) url;

// these are ignored if operation doesn't have an authenticator.
@property (readwrite, assign) BOOL isSecure;
@property (readwrite, assign) BOOL isAuthenticated;

- (void) authenticateSelf;
- (void) prepareAuthenticatedConnection:(FLHttpConnection*) connection;

@end

@interface FLHttpOperation (OptionalOverrides)

// called by all the init methods.
- (void) didInit;

@end

@protocol FLHttpOperationAuthenticator <NSObject>
- (void) httpOperationRunAuthentication:(FLHttpOperation*) operation;
- (void) httpOperation:(FLHttpOperation*) operation prepareAuthenticatedConnection:(FLHttpConnection*) connection;
@end

#import "FLService.h"

@interface FLHttpOperationAuthenticator : FLService<FLHttpOperationAuthenticator>
@end

service_declare_(httpAuthenticator, ZFHttpOperationAuthenticator)
