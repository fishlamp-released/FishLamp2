//
//	FLObjectCacheBehavior.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/25/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if REFACTOR
#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLCacheBehavior.h"

@interface FLObjectCacheBehavior : FLCacheBehavior {
@private
	NSString* _cacheKey;
}

- (id) initWithCapacity:(NSUInteger) capacity cacheKey:(NSString*) cacheKey;

+ (FLObjectCacheBehavior*) objectCacheBehavior:(NSUInteger) capacity cacheKey:(NSString*) cacheKey;

@end
#endif