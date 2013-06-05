//
//	FLCacheableImageBehavior.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

#if REFACTOR

#import "FLCacheBehavior.h"
#import "FLCachedImage.h"
#import "FLInMemoryDataCache.h"
#import "FishLamp.h"

@interface FLCachedImageCacheBehavior : NSObject<FLCacheBehavior> {
@private
	FLInMemoryDataCache* _memoryCache;
	CGFloat _maxLongSideForInMemoryCache;

#if DEBUG
	BOOL _warnOnMainThreadLoad;
	BOOL _warnOnMainThreadDelete;
	BOOL _warnOnMainThreadWrite;
#endif
}

- (id) initWithCapacity:(NSUInteger) capacity;
+ (FLCachedImageCacheBehavior*) cachedImageCacheBehavior:(NSUInteger) capacity;

@property (readwrite, assign, nonatomic) CGFloat maxLongSideForInMemoryCache;

// TODO: generalize this
//+ (void) clearImageCache:(id<FLCancellable>) operation;

@end

#endif