//
//	FLHttpOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLNetworkOperation.h"
#import "FLHttpConnection.h"
#import "FLNetworkServerContext.h"
#import "FLObjectDatabase.h"
#import "FLHttpOperationAuthenticator.h"

@class FLHttpOperation;

@protocol FLHttpConnectionFactory <NSObject>
- (FLHttpConnection*) networkOperationCreateNetworkRequest:(FLHttpOperation*) operation;
@end

@protocol FLHttpOperationResponseHandler <NSObject>

- (void) operationDidRun:(FLHttpOperation*) operation;

@optional
- (void) networkOperation:(FLHttpOperation*) operation
            shouldRedirect:(BOOL*) redirect
                     toURL:(NSURL*) url;

@end

@interface FLHttpOperation : FLNetworkOperation {
@private	
	NSURL* _url;
	id _requestType;
	id<FLHttpConnectionFactory> _requestFactory;
	id<FLHttpOperationResponseHandler> _responseHandler;
	FLNetworkServerContext* _serverDefaults;
	id<FLHttpOperationAuthenticator> _authenticator;
  	id _securityCredentials;
    FLHttpResponse* _httpResponse;
    BOOL _isSecure;
    BOOL _isAuthenticated;
}

@property (readwrite, strong) NSURL* URL;
@property (readwrite, strong) NSString* URLString; // convienience wrapper for URL

@property (readwrite, strong) FLHttpConnection* httpConnection;

@property (readwrite, strong) id requestType; // e.g. POST/GET for HTTP.

// network i/o factories and info.
@property (readwrite, strong, nonatomic) id<FLHttpConnectionFactory> networkRequestFactory;
@property (readwrite, strong, nonatomic) id<FLHttpOperationResponseHandler> responseHandler;
@property (readwrite, strong, nonatomic) FLNetworkServerContext* serverContext;

@property (readonly, strong) FLHttpRequest* httpRequest;
@property (readonly, strong) FLHttpResponse* httpResponse;

// creation
- (id) initWithURL:(NSURL*) url;
- (id) initWithURLString:(NSString*) url;

+ (id) networkOperationWithURL:(NSURL*) url;
+ (id) networkOperationWithURLString:(NSString*) url;

- (id) setRequestWillPost;

@property (readwrite, strong) id securityCredentials;
@property (readwrite, strong, nonatomic) id<FLHttpOperationAuthenticator> authenticator;

// these are ignored if operation doesn't have an authenticator.
@property (readwrite, assign) BOOL isSecure;
@property (readwrite, assign) BOOL isAuthenticated;
- (void) authenticateSelf;
@end

@interface FLHttpOperation (OptionalOverrides)
- (NSURL*) createURL;

// called by all the init methods.
- (void) didInit;

@end

@interface FLHttpOperation (ExtendedConstruction)

- (id) initWithNetworkConnectionFactory:(id<FLHttpConnectionFactory>) requestFactory 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler;

- (id) initWithNetworkConnection:(FLHttpConnection*) request 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler;

- (id) initWithServerContext:(FLNetworkServerContext*) endpoint;

+ (id) networkOperationWithServerContext:(FLNetworkServerContext*) endpoint;

@end





