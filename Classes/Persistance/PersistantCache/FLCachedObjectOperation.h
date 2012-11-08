//
//	FLCachedObjectOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/27/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLOperationQueue.h"
#import "FLPerformSelectorOperation.h"
#import "FLDatabase.h"

@interface FLCachedObjectOperation : FLOperation {
@private
	FLDatabase* _cache;
	struct {
		unsigned int canLoadFromCache:1;
		unsigned int canSaveToCache:1;
		unsigned int wasLoadedFromCache:1;
		unsigned int wasLoadedFromMemoryCache:1;
		unsigned int shouldRunIfLoadedFromCache:1;
	} _cacheOperationFlags;
	
	FLOperation* _subOperation;
	__unsafe_unretained id _target;
    SEL _action;
}
@property (readwrite, retain, nonatomic) FLDatabase* cache;

@property (readwrite, assign, nonatomic) BOOL canSaveToCache;
@property (readwrite, assign, nonatomic) BOOL canLoadFromCache;
@property (readwrite, assign, nonatomic) BOOL wasLoadedFromCache;
@property (readwrite, assign, nonatomic) BOOL wasLoadedFromMemoryCache;

@property (readwrite, assign, nonatomic) BOOL shouldRunIfLoadedFromCache; // NO by default

- (void) setWasLoadedFromCacheCallback:(id) target action:(SEL) action;

@property (readwrite, retain, nonatomic) FLOperation* subOperation;

- (id) initWithSubOperation:(FLOperation*) operation;
+ (id) cachedObjectOperation:(FLOperation*) subOperation;

- (id) loadOutputFromCache;

- (BOOL) loadFromMemoryCache; // will not execute subOperations unless shouldRunIfLoadedFromCache is YES

// override points
- (void) setInputObjectForCacheLoading; // optional, or set input in your init. This is called before attempting to load from cache. If it's loaded, subOperation is not performed (unless shouldRunIfLoadedFromCache is YES)
- (void) didLoadFromCache; // does nothing by default
- (void) setOutputFromSubOperation; // set self.output from your suboperation, default is self.output = self.suboperation.output
- (void) saveOutputToCache; // saves self.output to cache by default

- (void) runSubOperations;

@end


