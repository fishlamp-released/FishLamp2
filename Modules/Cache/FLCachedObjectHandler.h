//
//	FLCachedObjectHandler.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLInMemoryDataCache.h"
#import "FishLampCore.h"

@protocol FLCachedObjectHandler <NSObject>
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

@interface FLCachedObjectHandler : NSObject<FLCachedObjectHandler> {
@private
	FLInMemoryDataCache* _cache;

#if DEBUG
	BOOL _warnOnMainThreadLoad;
	BOOL _warnOnMainThreadWrite;
	BOOL _warnOnMainThreadDelete;
#endif
	
}

- (id) initWithCapacity:(NSUInteger) capacity;
+ (FLCachedObjectHandler*) cachedObjectHandler:(NSUInteger) capacity;

- (id) cacheKeyForObject:(id) object;
@end

@interface NSObject (FLCaching)
+ (void) setCachedObjectHandler:(id<FLCachedObjectHandler>) behavior;
+ (id<FLCachedObjectHandler>) cachedObjectHandler;
@end

#define __memberName(__class__) s_##__class__##CacheHandler

#define FLSynthesizeCachedObjectHandlerProperty(__class__) \
	static id<FLCachedObjectHandler> __memberName(__class__) = nil;\
	+ (void) setCachedObjectHandler:(id<FLCachedObjectHandler>) behavior {\
		FLAssignObject(__memberName(__class__), behavior); \
	} \
	+ (id<FLCachedObjectHandler>) cachedObjectHandler { \
		return __memberName(__class__); \
	}
	
