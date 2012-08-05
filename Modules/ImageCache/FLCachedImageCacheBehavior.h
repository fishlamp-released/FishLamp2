//
//	FLCacheableImageBehavior.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCachedObjectHandler.h"
#import "FLCachedImage.h"
#import "FLInMemoryDataCache.h"
#import "FishLampCore.h"

@interface FLCachedImageCacheBehavior : NSObject<FLCachedObjectHandler> {
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
//+ (void) clearImageCache:(id<FLCancellableOperation>) operation;

@end
