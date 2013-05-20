//
//	GtCachedObjectOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/27/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOperationQueue.h"
#import "GtPerformSelectorOperation.h"
#import "GtObjectDatabase.h"

@interface GtCachedObjectOperation : GtOperationQueue {
@private
	GtObjectDatabase* m_cache;
	struct {
		unsigned int canLoadFromCache:1;
		unsigned int canSaveToCache:1;
		unsigned int wasLoadedFromCache:1;
		unsigned int wasLoadedFromMemoryCache:1;
		unsigned int shouldPerformIfLoadedFromCache:1;
	} m_cacheOperationFlags;
	
	GtPerformSelectorOperation* m_loadOperation;
	GtPerformSelectorOperation* m_saveOperation;
	GtOperation* m_subOperation;
	GtCallback m_wasLoadedFromCacheCallback;
}
@property (readwrite, retain, nonatomic) GtObjectDatabase* cache;

@property (readwrite, assign, nonatomic) BOOL canSaveToCache;
@property (readwrite, assign, nonatomic) BOOL canLoadFromCache;
@property (readwrite, assign, nonatomic) BOOL wasLoadedFromCache;
@property (readwrite, assign, nonatomic) BOOL wasLoadedFromMemoryCache;

@property (readwrite, assign, nonatomic) BOOL shouldPerformIfLoadedFromCache; // NO by default

@property (readwrite, assign, nonatomic) GtCallback wasLoadedFromCacheCallback; 
- (void) setWasLoadedFromCacheCallback:(id) target action:(SEL) action;

@property (readwrite, retain, nonatomic) GtOperation* subOperation;

- (id) initWithSubOperation:(GtOperation*) operation;
- (id) loadOutputFromCache;

- (BOOL) loadFromMemoryCache; // will not execute subOperations unless shouldPerformIfLoadedFromCache is YES

// override points
- (void) setInputObjectForCacheLoading; // optional, or set input in your init. This is called before attempting to load from cache. If it's loaded, subOperation is not performed (unless shouldPerformIfLoadedFromCache is YES)
- (void) didLoadFromCache; // does nothing by default
- (void) setOutputFromSubOperation; // set self.output from your suboperation, default is self.output = self.suboperation.output
- (void) saveOutputToCache; // saves self.output to cache by default
- (void) addSubOperationToQueue; // by default add self.subOperation
@end
