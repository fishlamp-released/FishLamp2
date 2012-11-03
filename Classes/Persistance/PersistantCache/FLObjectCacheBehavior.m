//
//	FLObjectCacheBehavior.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/25/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLObjectCacheBehavior.h"

@implementation FLObjectCacheBehavior

- (id) initWithCapacity:(NSUInteger) capacity cacheKey:(NSString*) cacheKey
{
	if((self = [super initWithCapacity:capacity]))
	{
		_cacheKey = retain_(cacheKey);
	}
	
	return self;
}

+ (FLObjectCacheBehavior*) objectCacheBehavior:(NSUInteger) capacity cacheKey:(NSString*) cacheKey
{
	return autorelease_([[FLObjectCacheBehavior alloc] initWithCapacity:capacity cacheKey:cacheKey]);
}


- (void) dealloc
{
	mrc_release_(_cacheKey);
	super_dealloc_();
}

- (id) cacheKeyForObject:(id) object
{
	return [object valueForKey:_cacheKey];
}

@end