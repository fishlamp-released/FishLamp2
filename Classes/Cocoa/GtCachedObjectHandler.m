//
//	GtCachedObjectHandler.m
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCachedObjectHandler.h"

@implementation GtCachedObjectHandler

#if DEBUG
@synthesize warnOnMainThreadLoad = m_warnOnMainThreadLoad;
@synthesize warnOnMainThreadWrite = m_warnOnMainThreadWrite;
@synthesize warnOnMainThreadDelete = m_warnOnMainThreadDelete;
#endif

//@synthesize cache = m_cache;

- (id) cacheKeyForObject:(id) object
{
	return nil;
}

- (id) initWithCapacity:(NSUInteger) capacity
{
	if((self = [super init]))
	{
	   m_cache = [[GtInMemoryDataCache alloc] initWithCapacity:capacity];
	   
#if DEBUG
		m_warnOnMainThreadLoad = YES;
		m_warnOnMainThreadWrite = YES;
		m_warnOnMainThreadDelete = YES;
#endif		 
	}
	return self;
}

+ (GtCachedObjectHandler*) cachedObjectHandler:(NSUInteger) capacity
{
	return GtReturnAutoreleased([[GtCachedObjectHandler alloc] initWithCapacity:capacity]);
}

- (void) dealloc
{
	GtRelease(m_cache);
	GtSuperDealloc();
}

- (BOOL) willSaveObjectToDatabaseCache:(id) object
{
	return YES;
}

- (BOOL) didSaveObjectToDatabaseCache:(id) object
{
	id key = [self cacheKeyForObject:object];
	if(m_cache && key)
	{ 
		[m_cache updateOrAddObject:object forKey:key];
		return YES;
	}
	
	return NO;
}
- (void) didRemoveObjectFromCache:(id) object 
{
	id key = [self cacheKeyForObject:object];
	if(m_cache && key)
	{
		[m_cache removeObjectForKey:key];
	}
}

- (BOOL) didLoadObjectFromDatabaseCache:(id) object
{
	id key = [self cacheKeyForObject:object];
	if(m_cache && key)
	{
		[m_cache updateOrAddObject:object forKey:key];
	}
	
	return YES;
}

- (id) loadObjectFromMemoryCache:(id) inputObject
{
	id key = [self cacheKeyForObject:inputObject];
	return (m_cache && key) ? [m_cache objectForKey:key] : nil;
}

- (id) createNewObjectForOutput:(id) inputObject
{
	return GtReturnAutoreleased([[[inputObject class] alloc] init]);
}

- (void) clearMemoryCache
{
	[m_cache removeAllObjects];
}

@end

@implementation NSObject (GtCaching)

//GtSynthesizeCachedObjectHandlerProperty(NSObject)

+ (void) setCachedObjectHandler:(id<GtCachedObjectHandler>) behavior
{
	GtAssertFailed(@"Can't set cache behavior on NSObject. Subclass '%@' needs to define GtSynthesizeCachedObjectHandlerProperty in its .m file. See GtCachedObjectHandler.h", NSStringFromClass([self class]));
}

+ (id<GtCachedObjectHandler>) cachedObjectHandler
{
	return nil;
}

@end
