//
//	FLObjectCacheBehavior.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/25/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import "FLObjectCacheBehavior.h"

@implementation FLObjectCacheBehavior

- (id) initWithCapacity:(NSUInteger) capacity cacheKey:(NSString*) cacheKey
{
	if((self = [super initWithCapacity:capacity]))
	{
		_cacheKey = FLRetain(cacheKey);
	}
	
	return self;
}

+ (FLObjectCacheBehavior*) objectCacheBehavior:(NSUInteger) capacity cacheKey:(NSString*) cacheKey
{
	return FLAutorelease([[FLObjectCacheBehavior alloc] initWithCapacity:capacity cacheKey:cacheKey]);
}


- (void) dealloc
{
	FLRelease(_cacheKey);
	FLSuperDealloc();
}

- (id) cacheKeyForObject:(id) object
{
	return [object valueForKey:_cacheKey];
}

@end

#endif