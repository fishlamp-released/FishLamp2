//
//	GtObjectCacheBehavior.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/25/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtCachedObjectHandler.h"

@interface GtObjectCacheBehavior : GtCachedObjectHandler {
@private
	NSString* m_cacheKey;
}

- (id) initWithCapacity:(NSUInteger) capacity cacheKey:(NSString*) cacheKey;

+ (GtObjectCacheBehavior*) objectCacheBehavior:(NSUInteger) capacity cacheKey:(NSString*) cacheKey;

@end