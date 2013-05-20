//
//	GtHttpOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOperation.h"
#import "GtHttpConnection.h"
#import "GtNetworkServerContext.h"

#import "GtObjectDatabase.h"

#define GtHttpOperationDefaultTimeout 60.0f

typedef void (^GtHttpOperationSaveToCache)();
typedef id (^GtHttpOperationLoadFromCache)();

typedef void (^GtHttpOperationSentBytesProgressCallback)(unsigned long long sentBytes, unsigned long long totalSentBytes, unsigned long long totalBytesExpectedToSend);
typedef void (^GtHttpOperationIdleCallback)(NSTimeInterval idleTime);

@class GtHttpOperation;

typedef enum {
	GtHttpOperationCacheBehaviorNone					= 0,
	GtHttpOperationCacheBehaviorLoad 				= (1 << 1),
	GtHttpOperationCacheBehaviorSave 				= (1 << 2),
	GtHttpOperationCacheBehaviorContinueAfterLoad 	= (1 << 3),
	GtHttpOperationCacheBehaviorLoadAndSave			= GtHttpOperationCacheBehaviorLoad | GtHttpOperationCacheBehaviorSave,
	GtHttpOperationCacheBehaviorAll					= GtHttpOperationCacheBehaviorLoad | GtHttpOperationCacheBehaviorSave | GtHttpOperationCacheBehaviorContinueAfterLoad
} GtHttpOperationCacheBehavior;

@protocol GtHttpConnectionFactory <NSObject>
- (GtHttpConnection*) networkOperationCreateNetworkRequest:(GtHttpOperation*) operation;
@end

@protocol GtHttpOperationResponseHandler <NSObject>
- (NSError*) networkOperation:(GtHttpOperation*) operation networkConnectionDidClose:(GtHttpConnection*) request;

@optional
- (BOOL) networkOperation:(GtHttpOperation*) operation 
      shouldRedirectToURL:(NSURL*) url;
    
@end

@interface GtHttpOperation : GtOperation<GtHttpConnectionDelegate> {
@private	
	NSURL* m_url;
	GtHttpConnection* m_connection;
	id m_requestType;

	id<GtHttpConnectionFactory> m_requestFactory;
	id<GtHttpOperationResponseHandler> m_responseHandler;
	GtNetworkServerContext* m_serverDefaults;
	
	GtObjectDatabase* m_database;
	GtHttpOperationLoadFromCache m_loadFromCacheCallback;
	GtHttpOperationSaveToCache m_saveToCacheCallback;
	GtBlock m_wasLoadedFromCacheCallback;
	GtBlock m_wasLoadedFromCacheMainThreadCallback;
    GtHttpOperationIdleCallback m_idleCallback;
    GtHttpOperationSentBytesProgressCallback m_sentBytesCallback;
    
	struct networkFlags {
		unsigned int showNetworkActivityIndicator:1;
		unsigned int isShowingNetworkActivityIndicator:1;
		unsigned int wasLoadedFromCache: 1;
		GtHttpOperationCacheBehavior cacheBehavior: 4;
	} m_networkFlags;

	NSTimeInterval m_timeoutInterval;
    NSString* m_activityTimerExplanation;
}

@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;
@property (readwrite, retain, nonatomic) NSString* activityTimerExplanation;

@property (readwrite, retain, nonatomic) NSURL* URL;
@property (readwrite, retain, nonatomic) NSString* URLString; // convienience wrapper for URL
@property (readwrite, retain, nonatomic) GtHttpConnection* httpConnection; 

@property (readwrite, retain, nonatomic) id requestType; // e.g. POST/GET for HTTP.

// network i/o factories and info.
@property (readwrite, retain, nonatomic) id<GtHttpConnectionFactory> networkRequestFactory;
@property (readwrite, retain, nonatomic) id<GtHttpOperationResponseHandler> responseHandler;
@property (readwrite, retain, nonatomic) GtNetworkServerContext* serverContext;

// creation
- (id) init;
- (id) initWithURL:(NSURL*) url;
- (id) initWithURLString:(NSString*) url;

+ (id) networkOperation;
+ (id) networkOperationWithURL:(NSURL*) url;
+ (id) networkOperationWithURLString:(NSString*) url;

// optional override points

// called by all the init methods.
- (void) didInit;

- (id) setRequestWillPost;

// connection creation
- (GtHttpConnection*) createNetworkConnection; 
- (void) didCreateNetworkConnection:(GtHttpConnection*) connection;
- (void) willBeginRequestWithNetworkConnection:(GtHttpConnection*) connection;
- (NSError*) didCompleteRequestWithNetworkConnection:(GtHttpConnection*) connection; // by default calls handler
- (NSURL*) createURL;

// redirect event.
- (BOOL) httpConnection:(GtHttpConnection*) connection shouldRedirectToURL:(NSURL*) url;

// caching
- (void) prepareToLoadFromCache;
- (id) loadFromCache;
- (void) saveToCache;

@property (readwrite, assign, nonatomic) BOOL wasLoadedFromCache;
@property (readwrite, retain, nonatomic) GtObjectDatabase* database;
@property (readwrite, assign, nonatomic) GtHttpOperationCacheBehavior cacheBehavior;

@property (readwrite, copy, nonatomic) GtHttpOperationLoadFromCache loadFromCacheCallback;
@property (readwrite, copy, nonatomic) GtBlock saveToCacheCallback;
@property (readwrite, copy, nonatomic) GtBlock wasLoadedFromCacheCallback;
@property (readwrite, copy, nonatomic) GtBlock wasLoadedFromCacheMainThreadCallback;
@property (readwrite, copy, nonatomic) GtHttpOperationIdleCallback idleCallback;
@property (readwrite, copy, nonatomic) GtHttpOperationSentBytesProgressCallback sentBytesProgressCallback;
	
@end

@interface GtHttpOperation (ExtendedConstruction)

- (id) initWithNetworkConnectionFactory:(id<GtHttpConnectionFactory>) requestFactory 
	responseHandler:(id<GtHttpOperationResponseHandler>) responseHandler
	authenticator:(id<GtOperationAuthenticator>) authenticator;

- (id) initWithNetworkConnection:(GtHttpConnection*) request 
	responseHandler:(id<GtHttpOperationResponseHandler>) responseHandler
	authenticator:(id<GtOperationAuthenticator>) authenticator;

- (id) initWithServerContext:(GtNetworkServerContext*) endpoint;

+ (id) networkOperationWithNetworkConnectionFactory:(id<GtHttpConnectionFactory>) requestFactory 
	responseHandler:(id<GtHttpOperationResponseHandler>) responseHandler
	authenticator:(id<GtOperationAuthenticator>) authenticator;

+ (id) networkOperationWithNetworkConnection:(GtHttpConnection*) request 
	responseHandler:(id<GtHttpOperationResponseHandler>) responseHandler
	authenticator:(id<GtOperationAuthenticator>) authenticator;

+ (id) networkOperationWithServerContext:(GtNetworkServerContext*) endpoint;

@end





