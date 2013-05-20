//
//	GtHttpOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/9/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHttpOperation.h"

#if IOS
#import "GtNetworkStatusMonitor.h"
#endif
//#import <libkern/OSAtomic.h>


@implementation GtHttpOperation
@synthesize httpConnection = m_connection;
@synthesize networkRequestFactory = m_requestFactory;
@synthesize responseHandler = m_responseHandler;
@synthesize URL = m_url;
@synthesize serverContext = m_serverDefaults;
@synthesize requestType = m_requestType;
@synthesize activityTimerExplanation = m_activityTimerExplanation;
@synthesize database = m_database;
@synthesize timeoutInterval = m_timeoutInterval;

@synthesize loadFromCacheCallback = m_loadFromCacheCallback;
@synthesize saveToCacheCallback = m_saveToCacheCallback;
@synthesize wasLoadedFromCacheCallback = m_wasLoadedFromCacheCallback;
@synthesize wasLoadedFromCacheMainThreadCallback = m_wasLoadedFromCacheMainThreadCallback;
@synthesize idleCallback = m_idleCallback;
@synthesize sentBytesProgressCallback = m_sentBytesCallback;


GtSynthesizeStructProperty(cacheBehavior, setCacheBehavior, GtHttpOperationCacheBehavior, m_networkFlags);
GtSynthesizeStructProperty(wasLoadedFromCache, setWasLoadedFromCache, BOOL, m_networkFlags);
GtSynthesizeStructProperty(showNetworkActivityIndicator, setShowNetworkActivityIndicator, BOOL, m_networkFlags);
GtSynthesizeStructProperty(isShowingNetworkActivityIndicator, setIsShowingNetworkActivityIndicator, BOOL, m_networkFlags);

- (void) setServerContext:(GtNetworkServerContext *) context
{
	GtAssignObject(m_serverDefaults, context);
	self.networkRequestFactory = context.defaultNetworkRequestFactory;
	self.responseHandler = context.defaultNetworkOperationResponseHandler;
	self.authenticator = context.authenticator;
}

- (NSString*) URLString
{
	return m_url.absoluteString;
}

- (void) setURLString:(NSString*) url
{
	self.URL = [NSURL URLWithString:url];
	
	GtAssert(GtStringsAreEqual(url, self.URLString), @"setting URL failed");
}

- (void) didInit
{
}

- (void) _setDefaults
{
	self.showNetworkActivityIndicator = YES;
	self.timeoutInterval = GtHttpOperationDefaultTimeout;
	self.securityBehavior = GtOperationAuthenticationBehaviorUnknown;
	[self didInit];
}

- (id) init
{
	if((self = [super init]))
	{
		[self _setDefaults];
	}
	
	return self;
}

- (id) initWithURL:(NSURL*) url
{
	if((self = [super init]))
	{	
		[self _setDefaults];
		self.URL = url;
	}
	
	return self;
}

- (id) initWithURLString:(NSString*) url

{
	if((self = [super init]))
	{	
		[self _setDefaults];
		self.URL = [NSURL URLWithString:url];
	}
	
	return self;
}

- (id) initWithNetworkConnectionFactory:(id<GtHttpConnectionFactory>) requestFactory 
	responseHandler:(id<GtHttpOperationResponseHandler>) responseHandler
	authenticator:(id<GtOperationAuthenticator>) authenticator
{
	if((self = [super init]))
	{
		[self _setDefaults];
		self.networkRequestFactory = requestFactory;
		self.responseHandler = responseHandler;
		self.authenticator = authenticator;
	}

	return self;
}

- (id) initWithNetworkConnection:(GtHttpConnection*) connection 
	responseHandler:(id<GtHttpOperationResponseHandler>) responseHandler
	authenticator:(id<GtOperationAuthenticator>) authenticator
{
	if((self = [super init]))
	{
		[self _setDefaults];
		self.httpConnection = connection;
		self.responseHandler = responseHandler;
		self.authenticator = authenticator;
	}

	return self;
}

- (id) initWithServerContext:(GtNetworkServerContext*) context
{
	if((self = [super init]))
	{
		[self _setDefaults];
		self.serverContext = context;
	}
	return self;
}

+ (id) networkOperationWithURLString:(NSString*) url
{
	return GtReturnAutoreleased([[[self class] alloc] initWithURL:[NSURL URLWithString:url]]);
}

+ (id) networkOperationWithURL:(NSURL*) url
{
	return GtReturnAutoreleased([[[self class] alloc] initWithURL:url]);
}

+ (id) networkOperationWithServerContext:(GtNetworkServerContext*) context
{
	return GtReturnAutoreleased([[[self class] alloc] initWithServerContext:context]);
}

+ (id) networkOperationWithNetworkConnectionFactory:(id<GtHttpConnectionFactory>) requestFactory 
	responseHandler:(id<GtHttpOperationResponseHandler>) responseHandler
	authenticator:(id<GtOperationAuthenticator>) authenticator
{
	return GtReturnAutoreleased([[[self class] alloc] initWithNetworkConnectionFactory:requestFactory responseHandler:responseHandler authenticator:authenticator]);
}

+ (id) networkOperationWithNetworkConnection:(GtHttpConnection*) connection 
	responseHandler:(id<GtHttpOperationResponseHandler>) responseHandler
	authenticator:(id<GtOperationAuthenticator>) authenticator
{
	return GtReturnAutoreleased([[[self class] alloc] initWithNetworkConnection:connection responseHandler:responseHandler authenticator:authenticator]);
}

+ (id) networkOperation
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

- (id) setRequestWillPost
{
	self.requestType = @"POST";
	if(self.httpConnection)
	{
		[((id)self.httpConnection) setHTTPMethodToPost];
	}
	
	return self;
}

- (void) requestCancel
{
	[super requestCancel];
    if(m_connection)
    {
        [m_connection cancelRequest];
    }
}

- (BOOL) wasCancelled
{
	if(m_connection)
	{
		return m_connection.wasCancelled;
	}

	return [super wasCancelled];
}

- (void) finalizeOperation
{
    [super finalizeOperation];
    
    GtReleaseBlockWithNil(m_loadFromCacheCallback);
    GtReleaseBlockWithNil(m_saveToCacheCallback);
    GtReleaseBlockWithNil(m_wasLoadedFromCacheCallback);
    GtReleaseBlockWithNil(m_wasLoadedFromCacheMainThreadCallback);
    GtReleaseBlockWithNil(m_idleCallback);
    GtReleaseBlockWithNil(m_sentBytesCallback);
}

- (void) dealloc
{
    GtReleaseBlockWithNil(m_loadFromCacheCallback);
    GtReleaseBlockWithNil(m_saveToCacheCallback);
    GtReleaseBlockWithNil(m_wasLoadedFromCacheCallback);
    GtReleaseBlockWithNil(m_wasLoadedFromCacheMainThreadCallback);
    GtReleaseBlockWithNil(m_idleCallback);
    GtReleaseBlockWithNil(m_sentBytesCallback);
    GtRelease(m_activityTimerExplanation);
	GtRelease(m_database);
	GtRelease(m_requestType);
	GtRelease(m_serverDefaults);
	GtRelease(m_requestFactory);
	GtRelease(m_url);
	GtRelease(m_connection);
	GtRelease(m_responseHandler);
	GtSuperDealloc();
}

- (NSTimeInterval) lastActivityTimestamp
{
	return m_connection.lastActivityTimestamp;
}
    
- (GtHttpConnection*) createNetworkConnection
{
	if(m_requestFactory)
	{
		return [m_requestFactory networkOperationCreateNetworkRequest:self];
	}
    else
    {
        return [GtHttpConnection httpConnection:[GtHttpRequest httpRequestWithURL:self.URL requestMethod:self.requestType]];
    }
	return nil;
}

- (void) createNetworkRequestIfNeeded
{
	if(!self.httpConnection)
	{
		self.httpConnection = [self createNetworkConnection];
		[self didCreateNetworkConnection:self.httpConnection];
	}
}

- (void) prepareOperation
{ 
	if(!self.URL)
	{
		self.URL = [self createURL];
	}
	[super prepareOperation];
}

- (void) operationSetup
{ 
	[super operationSetup];
	[self createNetworkRequestIfNeeded];
}

- (void) _performWasLoadedFromCacheCallbackOnMainThread
{
    if(m_wasLoadedFromCacheMainThreadCallback)
    {
        m_wasLoadedFromCacheMainThreadCallback(); 
    }
}

- (void) setOutputFromCache:(id) output
{
	if(output)
	{
		self.output = output;
		self.wasLoadedFromCache = YES;
		
		if(m_wasLoadedFromCacheCallback)
		{
			m_wasLoadedFromCacheCallback();
		}
		if(m_wasLoadedFromCacheMainThreadCallback)
		{
            [self performSelectorOnMainThread:@selector(_performWasLoadedFromCacheCallbackOnMainThread) withObject:nil waitUntilDone:NO];
		}
	}
}

- (NSURL*) createURL
{
	return nil;
}

- (void) prepareToLoadFromCache
{

}

- (BOOL) willPerformOperation
{
	if(GtBitMaskTest(self.cacheBehavior, GtHttpOperationCacheBehaviorLoad))
	{
		[self prepareToLoadFromCache];
	
		id object = nil;
		if(m_loadFromCacheCallback)
		{
			object = m_loadFromCacheCallback();
		}
		else
		{
			object = [self loadFromCache];
		}
		
		[self setOutputFromCache:object];
		
		if(self.wasLoadedFromCache && !GtBitMaskTest(self.cacheBehavior, GtHttpOperationCacheBehaviorContinueAfterLoad))
		{
			return NO;
		}
		
		self.wasLoadedFromCache = NO;
	}

#if IOS
	if(![GtNetworkStatusMonitor instance].networkIsReachable)
	{
		NSError* error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:nil];
		self.error = error;
		GtReleaseWithNil(error);
	}
#endif

	return YES;
}

- (NSError*) didCompleteRequestWithNetworkConnection:(GtHttpConnection*) connection;
{
	NSError* error = connection.error;
	if(!error)
	{
		error = [connection.httpResponse simpleHttpResponseErrorCheck];
	}

	return error;
}

- (void) willBeginRequestWithNetworkConnection:(GtHttpConnection*) connection
{
}

- (void) didCreateNetworkConnection:(GtHttpConnection*) connection
{
    
}

- (void) saveToCache
{
	if(m_database && self.output)
	{
		[m_database saveObject:self.output];
	}
}

- (id) loadFromCache
{
	id object = nil;
	if(m_database && self.input)
	{
		object = [self.database loadObject:self.input];
	}

	return object;
}

- (BOOL) httpConnection:(GtHttpConnection*) connection shouldRedirectToURL:(NSURL*) url
{
	if([m_responseHandler respondsToSelector:@selector(networkOperation:shouldRedirectToURL:)])
	{
		return [m_responseHandler networkOperation:self shouldRedirectToURL:url];
	}

    return YES;
}

- (void) httpConnectionWillBegin:(GtHttpConnection*) connection
{
}

- (void) httpConnectionDidComplete:(GtHttpConnection*) connection
{
    if(self.responseHandler)
    {
        self.error = [self.responseHandler networkOperation:self networkConnectionDidClose:self.httpConnection];
    }
    else
    {
        self.error = [self didCompleteRequestWithNetworkConnection:self.httpConnection];
    }
    
    if(!self.error && 
        GtBitMaskTest(self.cacheBehavior, GtHttpOperationCacheBehaviorSave) && 
        !self.wasLoadedFromCache)
    {
        if(m_saveToCacheCallback)
        {
            m_saveToCacheCallback();
        }
        else 
        {
            [self saveToCache];
        }
    }
}

- (void) httpConnection:(GtHttpConnection*) connection
       didFailWithError:(NSError*) error
{
    self.error = error;
}

- (void) httpConnectionWasCancelled:(GtHttpConnection*) connection
{
    self.error = connection.error;
}

- (void) httpConnectionDidTimeout:(GtHttpConnection*) connection
{
    self.error = connection.error;
}

- (void) httpConnection:(GtHttpConnection*) connection 
     didReceiveResponse:(GtHttpResponse*) response
{
}

- (void) httpConnection:(GtHttpConnection*) connection 
                 isIdle:(NSTimeInterval) lastActivityTimestamp
{
    GtHttpOperationIdleCallback callback = self.idleCallback;
    if(callback)
    {
        callback(lastActivityTimestamp);
    }
}

- (void) httpConnection:(GtHttpConnection*) connection 
              sentBytes:(unsigned long long) sentBytes 
         totalSentBytes:(unsigned long long) totalSentBytes 
totalBytesExpectedToSend:(unsigned long long) totalBytesExpectedToSend
{
    GtHttpOperationSentBytesProgressCallback callback = self.sentBytesProgressCallback;
    if(callback)
    {
        callback(sentBytes, totalSentBytes, totalBytesExpectedToSend);
    }
}
    
- (BOOL) httpConnectionShouldRetry:(GtHttpConnection*) connection
{
    return YES;
}

- (void) performSelf
{
	GtAssertNotNil(self.URL);
	GtAssertIsValidString(self.URLString);
	GtAssertNotNil(self.httpConnection);
	
	self.httpConnection.timeoutInterval = self.timeoutInterval;
	if(!self.error)
	{	
		[self willBeginRequestWithNetworkConnection:self.httpConnection];
        @try {
            self.httpConnection.delegate = self;
            [self.httpConnection performSynchronously];	   
        }
        @catch(NSException* ex){
            self.error = ex.error;
        }
        @finally {
            self.httpConnection.delegate = nil;
        }
	}
}


@end


