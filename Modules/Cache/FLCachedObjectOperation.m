//
//	FLCachedObjectOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/27/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCachedObjectOperation.h"
#import "FLPerformSelectorOperation.h"

@implementation FLCachedObjectOperation

//@synthesize cache = _cache;

@synthesize cache = _cache;
@synthesize subOperation = _subOperation;

FLSynthesizeStructProperty(canSaveToCache, setCanSaveToCache, BOOL, _cacheOperationFlags);
FLSynthesizeStructProperty(canLoadFromCache, setCanLoadFromCache, BOOL, _cacheOperationFlags);
FLSynthesizeStructProperty(wasLoadedFromCache, setWasLoadedFromCache, BOOL, _cacheOperationFlags);
FLSynthesizeStructProperty(wasLoadedFromMemoryCache, setWasLoadedFromMemoryCache, BOOL, _cacheOperationFlags);
FLSynthesizeStructProperty(shouldPerformIfLoadedFromCache, setShouldPerformIfLoadedFromCache, BOOL, _cacheOperationFlags);
@synthesize wasLoadedFromCacheCallback = _wasLoadedFromCacheCallback;

- (id) init
{
	if((self = [super init]))
	{
	}

	return self;
}

- (id) initWithSubOperation:(FLOperation*) operation
{
	if((self = [super init]))
	{
		self.subOperation = operation;
	}
	return self;
}

- (void) dealloc
{
	FLRelease(_cache);
	FLRelease(_loadOperation);
	FLRelease(_saveOperation);
	FLRelease(_subOperation);
	FLSuperDealloc();
}

- (void) setWasLoadedFromCacheCallback:(id) target action:(SEL) action
{
	_wasLoadedFromCacheCallback = FLCallbackMake(target, action);
}

- (void) setInputObjectForCacheLoading
{
}

- (id) loadOutputFromMemoryCache {
    FLAssertIsNotNil(self.cache);

	if(!self.input) {
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

- (BOOL) loadFromMemoryCache {

    FLAssertIsNotNil(self.cache);

	id cachedObject = [self loadOutputFromMemoryCache];

	if(cachedObject)
	{
		[self setOutputFromCache:cachedObject];
//		FLReleaseWithNil(cachedObject);

		self.wasLoadedFromMemoryCache = YES;
		self.wasLoadedFromCache = YES;
		
		[self didLoadFromCache];
	}
	
	return self.wasLoadedFromMemoryCache;
}

- (void) didLoadFromCache
{
	FLInvokeCallback(_wasLoadedFromCacheCallback, self);
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
	[self queueOperation:_subOperation];
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
