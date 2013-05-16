//
//  GtNetworkOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/9/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtNetworkOperation.h"
#import "GtApplication.h"

#include <libkern/OSAtomic.h>

@implementation GtNetworkOperation


@synthesize networkRequest = m_request;

GtSynthesizeStructProperty(canSaveToCache, setCanSaveToCache, BOOL, m_networkFlags);
GtSynthesizeStructProperty(canLoadFromCache, setCanLoadFromCache, BOOL, m_networkFlags);
GtSynthesizeStructProperty(transportSecurityOverride, setTransportSecurityOverride, GtTransportSecurityOverride, m_networkFlags);
GtSynthesizeStructProperty(showNetworkActivityIndicator, setShowNetworkActivityIndicator, BOOL, m_networkFlags);
GtSynthesizeStructProperty(isShowingNetworkActivityIndicator, setIsShowingNetworkActivityIndicator, BOOL, m_networkFlags);
GtSynthesizeStructProperty(didLoadFromCache, setDidLoadFromCache, BOOL, m_networkFlags);

GtSynthesize(reachability, setReachability, GtReachability, m_reachability);
GtSynthesizeIDWithProtocol(cache, setCache, GtDatabaseCacheProtocol); 

- (void) cancelOperation
{
	[super cancelOperation];
	if(m_request)
	{
		[m_request cancel];
	}
}

- (void) initNetworkOperation
{
	self.canSaveToCache = YES;
	self.canLoadFromCache = YES;
	self.showNetworkActivityIndicator = YES;
}

- (id) init
{
	if(self = [super init])
	{
		[self initNetworkOperation];
	}
	return self;
}

- (id) initWithInput:(id) input
{
	if(self = [super initWithInput:input])
	{
		[self initNetworkOperation];
	}
	return self;
}

- (void) dealloc
{
	[GtNetworkOperation stopNetworkActivityIndicator:self];
    GtRelease(m_cache);
    GtRelease(m_reachability);
	GtRelease(m_request);
	[super dealloc];
}

- (void) setNetworkRequest:(GtNetworkRequest*) request
{
	if(m_request != request)
	{
		[m_request release];
		m_request = [request retain];
	}
	
	if(m_request && self.delegate)
	{
		m_request.delegate = self;
	}
}

- (void) networkRequest:(GtNetworkRequest *) request 
	didSendBodyData:(NSInteger)bytesWritten 
	totalBytesWritten:(NSInteger)totalBytesWritten 
	totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
	if(self.delegate)
	{
		[self.delegate operation:self
			operationDidSendBytes:bytesWritten
			totalBytesWritten:totalBytesWritten
			totalBytesExpectedToWrite:totalBytesExpectedToWrite];
	}
}

- (BOOL) onPrepareOperationInMainThread
{
	return [GtNetworkOperation sharedPrepareOperationInMainThread:self];
}

- (BOOL) onWillPerformOperation
{
	return [GtNetworkOperation sharedWillPerformOperation:self];
}

- (void) onConvertOperationInputToCacheInput:(id*) outCacheInput;
{
}

- (void) onSetOperationOutputWithCacheOutput:(id) cacheOutput;
{
	self.output = cacheOutput;
}

- (void) onConvertOperationOutputToCachedObject:(id*) outCachedObject
{
}

- (BOOL) preLoadOperationOutputFromCache:(id<GtDatabaseCacheProtocol>) cache
{
	return [GtNetworkOperation sharedLoadOperationOutputFromCache:cache
		operation:self
		isPreLoad:YES];
}

- (BOOL) loadOperationOutputFromCache:(id<GtDatabaseCacheProtocol>) cache
{
	return [GtNetworkOperation sharedLoadOperationOutputFromCache:cache
		operation:self
		isPreLoad:NO];
}

- (void) saveOperationOutputToCache:(id<GtDatabaseCacheProtocol>) cache
{
	[GtNetworkOperation sharedSaveOperationOutputToCache:cache
		operation:self];
}

- (void) resetPerformState
{
    [super resetPerformState];
    
    self.didLoadFromCache = NO;
}

- (void) onOperationWasPerformed
{
	[GtNetworkOperation sharedFinalizeOperation:self];
}

- (BOOL) canRetryOnFailure
{
    return [super canRetryOnFailure] ||
        self.error.isOsNetworkingErrorBug;
}


@end

@implementation GtNetworkOperation (SharedCode)


+ (BOOL) sharedPrepareOperationInMainThread:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation
{
	if(operation.canLoadFromCache && operation.cache)
	{
		id output = nil;
	
		operation.wasPerformed = [operation preLoadOperationOutputFromCache:operation.cache];
		if(output)
		{
			[GtNetworkOperation stopNetworkActivityIndicator:operation];
			operation.didLoadFromCache = YES;
			operation.output = output;
			GtRelease(output);
			return NO;
		}
				
	}

	return YES;
}

+ (BOOL) sharedWillPerformOperation:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation
{
    if(operation.canLoadFromCache && operation.cache)
	{
		operation.wasPerformed = [operation loadOperationOutputFromCache:operation.cache];
		if(operation.wasPerformed)
		{
			[GtNetworkOperation stopNetworkActivityIndicator:operation];
			operation.didLoadFromCache = YES;
			return NO;
		}
	}
	
	if(operation.showNetworkActivityIndicator)
	{
		operation.isShowingNetworkActivityIndicator = YES;

		[[GtApplication instance] showNetworkActivityIndicator];

//		if(OSAtomicIncrement32(&s_activityMonitorCount) == 1)
//		{
//			[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//		}
	}
	
	return YES;
}

+ (void) stopNetworkActivityIndicator:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation
{
	if(operation.isShowingNetworkActivityIndicator)
	{
		operation.isShowingNetworkActivityIndicator = NO;
		
		[[GtApplication instance] hideNetworkActivityIndicator];
	}
}

+ (void) sharedFinalizeOperation:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation
{
	@try
	{
		if(	operation.didSucceed &&
			operation.canSaveToCache && 
			operation.cache && 
			!operation.didLoadFromCache)
		{
			[operation saveOperationOutputToCache:operation.cache];
		}
	}
	@finally
	{
		[GtNetworkOperation stopNetworkActivityIndicator:operation];
	}
}

+ (BOOL) sharedLoadOperationOutputFromCache:(id<GtDatabaseCacheProtocol>) cache 
	operation:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation
	isPreLoad:(BOOL) isPreLoad
{
	id cacheInput = nil;
	id cacheOutput = nil;
	@try
	{
		[operation onConvertOperationInputToCacheInput:&cacheInput];
		if(cacheInput)
		{
			if(	(isPreLoad ? 
				[cache preLoadObjectFromCache:cacheInput outputObject:&cacheOutput]:
				[cache loadObjectFromCache:cacheInput outputObject:&cacheOutput]) && 
				cacheOutput)
			{
				[operation onSetOperationOutputWithCacheOutput:cacheOutput];
				operation.didLoadFromCache = YES;
				return YES;
			}
		}
	}
	@catch(NSException* ex)
	{
		NSError* error = [GtAlloc(NSError) initWithException:ex];
		operation.error = error;
		GtRelease(error);
	}
	@finally
	{
		GtRelease(cacheInput);
		GtRelease(cacheOutput);
	}
	
	return NO;
}
	
+ (void) sharedSaveOperationOutputToCache:(id<GtDatabaseCacheProtocol>) cache 
	operation:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation
{
	if(!operation.didLoadFromCache)
	{
		id cacheableObject = nil;
		@try
		{
			[operation onConvertOperationOutputToCachedObject:&cacheableObject];
			if(cacheableObject)
			{
				[cache saveObjectToCache:cacheableObject];
			}
		}
		@catch(NSException* ex)
		{
			NSError* error = [GtAlloc(NSError) initWithException:ex];
			operation.error = error;
			GtRelease(error);
		}
		@finally
		{
			GtRelease(cacheableObject);
		}
	}
}

@end
