//
//	FLObjectCacheBehavior.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/25/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLCachedObjectHandler.h"

@interface FLObjectCacheBehavior : FLCachedObjectHandler {
@private
	NSString* _cacheKey;
}

- (id) initWithCapacity:(NSUInteger) capacity cacheKey:(NSString*) cacheKey;

+ (FLObjectCacheBehavior*) objectCacheBehavior:(NSUInteger) capacity cacheKey:(NSString*) cacheKey;

@end