//
//	FLCacheBehavior.m
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR

#import "FLCacheBehavior.h"

@implementation FLCacheBehavior

#if DEBUG
@synthesize warnOnMainThreadLoad = _warnOnMainThreadLoad;
@synthesize warnOnMainThreadWrite = _warnOnMainThreadWrite;
@synthesize warnOnMainThreadDelete = _warnOnMainThreadDelete;
#endif

@synthesize memoryCache = _cache;

- (id) cacheKeyForObject:(id) object
{
	return nil;
}

- (id) initWithCapacity:(NSUInteger) capacity
{
	if((self = [super init]))
	{
	   _cache = [[FLInMemoryDataCache alloc] initWithCapacity:capacity];
	   
#if DEBUG
		_warnOnMainThreadLoad = YES;
		_warnOnMainThreadWrite = YES;
		_warnOnMainThreadDelete = YES;
#endif		 
	}
	return self;
}

+ (FLCacheBehavior*) sharedCacheBehavior:(NSUInteger) capacity
{
	return FLAutorelease([[FLCacheBehavior alloc] initWithCapacity:capacity]);
}

- (void) dealloc
{
	FLRelease(_cache);
	FLSuperDealloc();
}

- (BOOL) willSaveObjectToDatabaseCache:(id) object
{
	return YES;
}

- (BOOL) didSaveObjectToDatabaseCache:(id) object
{
	id key = [self cacheKeyForObject:object];
	if(_cache && key)
	{ 
		[_cache updateOrAddObject:object forKey:key];
		return YES;
	}
	
	return NO;
}
- (void) didRemoveObjectFromCache:(id) object 
{
	id key = [self cacheKeyForObject:object];
	if(_cache && key)
	{
		[_cache removeObjectForKey:key];
	}
}

- (BOOL) didLoadObjectFromDatabaseCache:(id) object
{
	id key = [self cacheKeyForObject:object];
	if(_cache && key)
	{
		[_cache updateOrAddObject:object forKey:key];
	}
	
	return YES;
}

- (id) loadObjectFromMemoryCache:(id) inputObject
{
	id key = [self cacheKeyForObject:inputObject];
	return (_cache && key) ? [_cache objectForKey:key] : nil;
}


- (void) clearMemoryCache
{
	[_cache removeAllObjects];
}

@end

@implementation NSObject (FLCaching)

//FLSynthesizeCachedObjectHandlerProperty(NSObject)

+ (void) setSharedCacheBehavior:(id<FLCacheBehavior>) behavior
{
	FLAssertFailedWithComment(@"Can't set cache behavior on NSObject. Subclass '%@' needs to define FLSynthesizeCachedObjectHandlerProperty in its .m file. See FLCacheBehavior.h", NSStringFromClass([self class]));
}

+ (id<FLCacheBehavior>) sharedCacheBehavior
{
	return nil;
}

- (id<FLCacheBehavior>) cacheBehavior {
    return [[self class] sharedCacheBehavior];
}

@end

#endif