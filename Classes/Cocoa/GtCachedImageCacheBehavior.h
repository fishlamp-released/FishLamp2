//
//	GtCacheableImageBehavior.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCachedObjectHandler.h"
#import "GtCachedImage.h"
#import "GtInMemoryDataCache.h"

@interface GtCachedImageCacheBehavior : NSObject<GtCachedObjectHandler> {
@private
	GtInMemoryDataCache* m_memoryCache;
	CGFloat m_maxLongSideForInMemoryCache;

#if DEBUG
	BOOL m_warnOnMainThreadLoad;
	BOOL m_warnOnMainThreadDelete;
	BOOL m_warnOnMainThreadWrite;
#endif

}

- (id) initWithCapacity:(NSUInteger) capacity;
+ (GtCachedImageCacheBehavior*) cachedImageCacheBehavior:(NSUInteger) capacity;

@property (readwrite, assign, nonatomic) CGFloat maxLongSideForInMemoryCache;

// TODO: generalize this
//+ (void) clearImageCache:(id<GtCancellableOperation>) operation;

@end
