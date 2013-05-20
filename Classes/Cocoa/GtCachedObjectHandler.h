//
//	GtCachedObjectHandler.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtInMemoryDataCache.h"

@protocol GtCachedObjectHandler <NSObject>
- (BOOL) willSaveObjectToDatabaseCache:(id) object;
- (BOOL) didSaveObjectToDatabaseCache:(id) object;
- (id) loadObjectFromMemoryCache:(id) inputObject;
- (void) didRemoveObjectFromCache:(id) object;
- (BOOL) didLoadObjectFromDatabaseCache:(id) object; // returns true if should stay in dbCache
- (id) createNewObjectForOutput:(id) inputObject;

- (void) clearMemoryCache;

#if DEBUG
@property (readwrite, assign, nonatomic) BOOL warnOnMainThreadLoad;
@property (readwrite, assign, nonatomic) BOOL warnOnMainThreadWrite;
@property (readwrite, assign, nonatomic) BOOL warnOnMainThreadDelete;
#endif

@end

@interface GtCachedObjectHandler : NSObject<GtCachedObjectHandler> {
@private
	GtInMemoryDataCache* m_cache;

#if DEBUG
	BOOL m_warnOnMainThreadLoad;
	BOOL m_warnOnMainThreadWrite;
	BOOL m_warnOnMainThreadDelete;
#endif
	
}

- (id) initWithCapacity:(NSUInteger) capacity;
+ (GtCachedObjectHandler*) cachedObjectHandler:(NSUInteger) capacity;

- (id) cacheKeyForObject:(id) object;
@end

@interface NSObject (GtCaching)
+ (void) setCachedObjectHandler:(id<GtCachedObjectHandler>) behavior;
+ (id<GtCachedObjectHandler>) cachedObjectHandler;
@end

#define __memberName(__class__) s_##__class__##CacheHandler

#define GtSynthesizeCachedObjectHandlerProperty(__class__) \
	static id<GtCachedObjectHandler> __memberName(__class__) = nil;\
	+ (void) setCachedObjectHandler:(id<GtCachedObjectHandler>) behavior {\
		GtAssignObject(__memberName(__class__), behavior); \
	} \
	+ (id<GtCachedObjectHandler>) cachedObjectHandler { \
		return __memberName(__class__); \
	}
	
