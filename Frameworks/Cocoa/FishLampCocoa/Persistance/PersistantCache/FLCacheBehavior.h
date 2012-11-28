//
//	FLCacheBehavior.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/24/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLInMemoryDataCache.h"
#import "FishLampCore.h"

@protocol FLCacheBehavior <NSObject>

- (BOOL) willSaveObjectToDatabaseCache:(id) object;

- (BOOL) didSaveObjectToDatabaseCache:(id) object;

- (id) loadObjectFromMemoryCache:(id) inputObject;

- (void) didRemoveObjectFromCache:(id) object;

- (BOOL) didLoadObjectFromDatabaseCache:(id) object; // returns true if should stay in dbCache

- (void) clearMemoryCache;

#if DEBUG
@property (readwrite, assign, nonatomic) BOOL warnOnMainThreadLoad;
@property (readwrite, assign, nonatomic) BOOL warnOnMainThreadWrite;
@property (readwrite, assign, nonatomic) BOOL warnOnMainThreadDelete;
#endif

@end

@interface FLCacheBehavior : NSObject<FLCacheBehavior> {
@private
	FLInMemoryDataCache* _cache;

#if DEBUG
	BOOL _warnOnMainThreadLoad;
	BOOL _warnOnMainThreadWrite;
	BOOL _warnOnMainThreadDelete;
#endif
	
}

@property (readonly, strong) FLInMemoryDataCache* memoryCache;

- (id) initWithCapacity:(NSUInteger) capacity;
+ (FLCacheBehavior*) sharedCacheBehavior:(NSUInteger) capacity;

- (id) cacheKeyForObject:(id) object;
@end

@interface NSObject (FLCaching)
+ (void) setSharedCacheBehavior:(id<FLCacheBehavior>) behavior;
+ (id<FLCacheBehavior>) sharedCacheBehavior;
- (id<FLCacheBehavior>) cacheBehavior;
@end

#define __memberName(__class__) s_##__class__##CacheHandler

#define FLSynthesizeCachedObjectHandlerProperty(__class__) \
	static id<FLCacheBehavior> __memberName(__class__) = nil;\
	+ (void) setSharedCacheBehavior:(id<FLCacheBehavior>) behavior {\
		FLRetainObject_(__memberName(__class__), behavior); \
	} \
	+ (id<FLCacheBehavior>) sharedCacheBehavior { \
		return __memberName(__class__); \
	}
	
