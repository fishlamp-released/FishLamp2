//
//	GtCachedObjectOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/27/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCachedObjectOperation.h"
#import "GtPerformSelectorOperation.h"

@implementation GtCachedObjectOperation

//@synthesize cache = m_cache;

@synthesize cache = m_cache;
@synthesize subOperation = m_subOperation;

GtSynthesizeStructProperty(canSaveToCache, setCanSaveToCache, BOOL, m_cacheOperationFlags);
GtSynthesizeStructProperty(canLoadFromCache, setCanLoadFromCache, BOOL, m_cacheOperationFlags);
GtSynthesizeStructProperty(wasLoadedFromCache, setWasLoadedFromCache, BOOL, m_cacheOperationFlags);
GtSynthesizeStructProperty(wasLoadedFromMemoryCache, setWasLoadedFromMemoryCache, BOOL, m_cacheOperationFlags);
GtSynthesizeStructProperty(shouldPerformIfLoadedFromCache, setShouldPerformIfLoadedFromCache, BOOL, m_cacheOperationFlags);
@synthesize wasLoadedFromCacheCallback = m_wasLoadedFromCacheCallback;

- (id) init
{
	if((self = [super init]))
	{
	}

	return self;
}

- (id) initWithSubOperation:(GtOperation*) operation
{
	if((self = [super init]))
	{
		self.subOperation = operation;
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_cache);
	GtRelease(m_loadOperation);
	GtRelease(m_saveOperation);
	GtRelease(m_subOperation);
	GtSuperDealloc();
}

- (void) setWasLoadedFromCacheCallback:(id) target action:(SEL) action
{
	m_wasLoadedFromCacheCallback.target = target;
	m_wasLoadedFromCacheCallback.action = action;
}

- (void) setInputObjectForCacheLoading
{
}

- (id) loadOutputFromMemoryCache
{
#if DEBUG
	if(self.cache == nil)
	{
		GtLog(@"Cache is nil, can't load from cache");
	}
#endif

	if(!self.input)
	{
		[self setInputObjectForCacheLoading];
	}
	return [self.cache loadObjectFromMemoryCache:self.input];
}

- (id) loadOutputFromCache
{
	if(!self.input)
	{	
		[self setInputObjectForCacheLoading];
	}
	return [self.cache loadObject:self.input];
}

- (void) setOutputFromCache:(id) object
{
	self.output = object;
}

- (BOOL) loadFromMemoryCache
{
#if DEBUG
	if(self.cache == nil)
	{
		GtLog(@"Cache is nil, can't load from cache");
	}
#endif

	id cachedObject = [self loadOutputFromMemoryCache];

	if(cachedObject)
	{
		[self setOutputFromCache:cachedObject];
//		GtReleaseWithNil(cachedObject);

		self.wasLoadedFromMemoryCache = YES;
		self.wasLoadedFromCache = YES;
		
		[self didLoadFromCache];
	}
	
	return self.wasLoadedFromMemoryCache;
}

- (void) didLoadFromCache
{
	GtInvokeCallback(m_wasLoadedFromCacheCallback, self);
}

- (void) loadFromCache
{
	id cachedObject = [self loadOutputFromCache];

	if(cachedObject)
	{
		[self setOutputFromCache:cachedObject];
	
		self.wasLoadedFromCache = YES;
		[self didLoadFromCache];
	}
}

- (void) saveOutputToCache
{
	[self.cache saveObject:self.output];
}

- (void) setOutputFromSubOperation
{
	self.output = self.subOperation.output;
}

- (void) addSubOperationToQueue
{
	[self queueOperation:m_subOperation];
}

- (void) performSelf
{
	if(self.canLoadFromCache && (!self.wasLoadedFromCache || self.shouldPerformIfLoadedFromCache))
	{
		[self loadFromCache];
	}
	if(!self.wasLoadedFromCache || self.shouldPerformIfLoadedFromCache)
	{
		self.wasLoadedFromCache = NO;
	
		[self addSubOperationToQueue];
	
		[super performSelf];
		
		if(!self.error)
		{
			[self setOutputFromSubOperation];
		
			if(self.canSaveToCache && !self.wasLoadedFromCache)
			{
				[self saveOutputToCache];
			}
		}
		
	}
}

@end
