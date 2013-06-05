//
//	FLObjectCacheBehavior.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/25/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR
#import "FLCocoaRequired.h"
#import "FishLamp.h"
#import "FLCacheBehavior.h"

@interface FLObjectCacheBehavior : FLCacheBehavior {
@private
	NSString* _cacheKey;
}

- (id) initWithCapacity:(NSUInteger) capacity cacheKey:(NSString*) cacheKey;

+ (FLObjectCacheBehavior*) objectCacheBehavior:(NSUInteger) capacity cacheKey:(NSString*) cacheKey;

@end
#endif