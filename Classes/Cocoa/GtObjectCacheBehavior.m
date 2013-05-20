//
//	GtObjectCacheBehavior.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/25/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtObjectCacheBehavior.h"

@implementation GtObjectCacheBehavior

- (id) initWithCapacity:(NSUInteger) capacity cacheKey:(NSString*) cacheKey
{
	if((self = [super initWithCapacity:capacity]))
	{
		m_cacheKey = GtRetain(cacheKey);
	}
	
	return self;
}

+ (GtObjectCacheBehavior*) objectCacheBehavior:(NSUInteger) capacity cacheKey:(NSString*) cacheKey
{
	return GtReturnAutoreleased([[GtObjectCacheBehavior alloc] initWithCapacity:capacity cacheKey:cacheKey]);
}


- (void) dealloc
{
	GtRelease(m_cacheKey);
	GtSuperDealloc();
}

- (id) cacheKeyForObject:(id) object
{
	return [object valueForKey:m_cacheKey];
}

@end