//
//	FLCachedObjectOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/27/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLOperationQueue.h"
#import "FLPerformSelectorOperation.h"
#import "FLObjectDatabase.h"

@interface FLCachedObjectOperation : FLOperationQueue {
@private
	FLObjectDatabase* _cache;
	struct {
		unsigned int canLoadFromCache:1;
		unsigned int canSaveToCache:1;
		unsigned int wasLoadedFromCache:1;
		unsigned int wasLoadedFromMemoryCache:1;
		unsigned int shouldPerformIfLoadedFromCache:1;
	} _cacheOperationFlags;
	
	FLPerformSelectorOperation* _loadOperation;
	FLPerformSelectorOperation* _saveOperation;
	FLOperation* _subOperation;
	FLCallback _wasLoadedFromCacheCallback;
}
@property (readwrite, retain, nonatomic) FLObjectDatabase* cache;

@property (readwrite, assign, nonatomic) BOOL canSaveToCache;
@property (readwrite, assign, nonatomic) BOOL canLoadFromCache;
@property (readwrite, assign, nonatomic) BOOL wasLoadedFromCache;
@property (readwrite, assign, nonatomic) BOOL wasLoadedFromMemoryCache;

@property (readwrite, assign, nonatomic) BOOL shouldPerformIfLoadedFromCache; // NO by default

@property (readwrite, assign, nonatomic) FLCallback wasLoadedFromCacheCallback; 
- (void) setWasLoadedFromCacheCallback:(id) target action:(SEL) action;

@property (readwrite, retain, nonatomic) FLOperation* subOperation;

- (id) initWithSubOperation:(FLOperation*) operation;
- (id) loadOutputFromCache;

- (BOOL) loadFromMemoryCache; // will not execute subOperations unless shouldPerformIfLoadedFromCache is YES

// override points
- (void) setInputObjectForCacheLoading; // optional, or set input in your init. This is called before attempting to load from cache. If it's loaded, subOperation is not performed (unless shouldPerformIfLoadedFromCache is YES)
- (void) didLoadFromCache; // does nothing by default
- (void) setOutputFromSubOperation; // set self.output from your suboperation, default is self.output = self.suboperation.output
- (void) saveOutputToCache; // saves self.output to cache by default
- (void) addSubOperationToQueue; // by default add self.subOperation
@end
