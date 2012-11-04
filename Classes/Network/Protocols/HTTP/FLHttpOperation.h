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

@protocol FLHttpOperationDelegate <NSObject>
@optional
- (FLHttpConnection*) httpOperationCreateConnection:(FLHttpOperation*) operation;
- (void) httpOperationWillRun:(FLHttpOperation*) operation;
- (void) httpOperationDidRun:(FLHttpOperation*) operation;
@end

@interface FLHttpOperation : FLNetworkOperation {
@private	
	NSURL* _url;
	id _requestType;
    FLHttpResponse* _httpResponse;
    __unsafe_unretained id<FLHttpOperationDelegate> _httpDelegate;
    BOOL _isSecure;
    BOOL _isAuthenticated;
}

@property (readwrite, assign) id<FLHttpOperationDelegate> httpDelegate;

@property (readwrite, strong) NSURL* URL;
@property (readwrite, strong) NSString* URLString; // convienience wrapper for URL

@property (readwrite, strong) FLHttpConnection* httpConnection;

@property (readwrite, strong) id requestType; // e.g. POST/GET for HTTP.

@property (readonly, strong) FLHttpRequest* httpRequest;
@property (readonly, strong) FLHttpResponse* httpResponse;

// creation
- (id) initWithURL:(NSURL*) url; // designated 

- (id) initWithURLString:(NSString*) url;

+ (id) networkOperationWithURL:(NSURL*) url;
+ (id) networkOperationWithURLString:(NSString*) url;

- (id) setRequestWillPost;

// these are ignored if operation doesn't have an authenticator.
@property (readwrite, assign) BOOL isSecure;
@property (readwrite, assign) BOOL isAuthenticated;

@end

@interface FLHttpOperation (OptionalOverrides)

// called by all the init methods.
- (void) didInit;

@end






