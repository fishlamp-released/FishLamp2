//
//	FLHttpOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLNetworkOperation.h"
#import "FLHttpConnection.h"
#import "FLNetworkServerContext.h"
#import "FLObjectDatabase.h"

@class FLHttpOperation;

@protocol FLHttpConnectionFactory <NSObject>
- (FLHttpConnection*) networkOperationCreateNetworkRequest:(FLHttpOperation*) operation;
@end

@protocol FLHttpOperationResponseHandler <NSObject>

- (NSError*) networkOperation:(FLHttpOperation*) operation 
   networkConnectionDidFinish:(FLHttpConnection*) request;

- (void) networkOperation:(FLHttpOperation*) operation 
      shouldRedirectToURL:(NSURL*) url
             willRedirect:(BOOL*) willRedirect; 
    
@end

@interface FLHttpOperation : FLNetworkOperation {
@private	
	NSURL* _url;
	id _requestType;

	id<FLHttpConnectionFactory> _requestFactory;
	id<FLHttpOperationResponseHandler> _responseHandler;
	FLNetworkServerContext* _serverDefaults;
}

@property (readwrite, retain, nonatomic) NSURL* URL;
@property (readwrite, retain, nonatomic) NSString* URLString; // convienience wrapper for URL
@property (readwrite, retain, nonatomic) FLHttpConnection* httpConnection; 

@property (readwrite, retain, nonatomic) id requestType; // e.g. POST/GET for HTTP.

// network i/o factories and info.
@property (readwrite, retain, nonatomic) id<FLHttpConnectionFactory> networkRequestFactory;
@property (readwrite, retain, nonatomic) id<FLHttpOperationResponseHandler> responseHandler;
@property (readwrite, retain, nonatomic) FLNetworkServerContext* serverContext;

// creation
- (id) initWithURL:(NSURL*) url;
- (id) initWithURLString:(NSString*) url;

+ (id) networkOperationWithURL:(NSURL*) url;
+ (id) networkOperationWithURLString:(NSString*) url;

- (id) setRequestWillPost;

@end

@interface FLHttpOperation (OptionalOverrides)
- (NSURL*) createURL;

// redirect event.
- (BOOL) httpConnection:(FLHttpConnection*) connection shouldRedirectToURL:(NSURL*) url;

// called by all the init methods.
- (void) didInit;

@end

@interface FLHttpOperation (ExtendedConstruction)

- (id) initWithNetworkConnectionFactory:(id<FLHttpConnectionFactory>) requestFactory 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler
	authenticator:(id<FLOperationAuthenticator>) authenticator;

- (id) initWithNetworkConnection:(FLHttpConnection*) request 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler
	authenticator:(id<FLOperationAuthenticator>) authenticator;

- (id) initWithServerContext:(FLNetworkServerContext*) endpoint;

+ (id) networkOperationWithNetworkConnectionFactory:(id<FLHttpConnectionFactory>) requestFactory 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler
	authenticator:(id<FLOperationAuthenticator>) authenticator;

+ (id) networkOperationWithNetworkConnection:(FLHttpConnection*) request 
	responseHandler:(id<FLHttpOperationResponseHandler>) responseHandler
	authenticator:(id<FLOperationAuthenticator>) authenticator;

+ (id) networkOperationWithServerContext:(FLNetworkServerContext*) endpoint;

@end





