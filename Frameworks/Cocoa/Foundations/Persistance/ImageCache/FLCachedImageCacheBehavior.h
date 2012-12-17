//
//	FLCacheableImageBehavior.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

#if REFACTOR

#import "FLCacheBehavior.h"
#import "FLCachedImage.h"
#import "FLInMemoryDataCache.h"
#import "FLCore.h"

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