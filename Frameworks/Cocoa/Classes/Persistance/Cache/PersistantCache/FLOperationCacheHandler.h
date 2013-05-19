//
//  FLOperationCacheHandler.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/9/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if 0
#import "FishLampCore.h"
#import "FLDatabase.h"
#import "FLSynchronousOperation.h"

@class FLOperationCacheHandler;

typedef id (^FLOperationCacheHandlerLoadFromCacheBlock)(FLOperationCacheHandler* cacheHandler);
typedef void (^FLOperationCacheHandlerBlock)(FLOperationCacheHandler* cacheHandler, id operation);

typedef enum {
	FLHttpOperationCacheBehaviorNone					= 0,
	FLHttpOperationCacheBehaviorLoad 				= (1 << 1),
	FLHttpOperationCacheBehaviorSave 				= (1 << 2),
	FLHttpOperationCacheBehaviorContinueAfterLoad 	= (1 << 3),
	FLHttpOperationCacheBehaviorLoadAndSave			= FLHttpOperationCacheBehaviorLoad | FLHttpOperationCacheBehaviorSave,
	FLHttpOperationCacheBehaviorAll					= FLHttpOperationCacheBehaviorLoad | FLHttpOperationCacheBehaviorSave | FLHttpOperationCacheBehaviorContinueAfterLoad
} FLHttpOperationCacheBehavior;



@interface FLOperationCacheHandler : NSObject<FLOperationObserver> {
@private
	FLDatabase* _database;
	FLOperationCacheHandlerLoadFromCacheBlock _loadFromCacheCallback;
	FLOperationCacheHandlerBlock _saveToCacheCallback;
	FLOperationCacheHandlerBlock _wasLoadedFromCacheCallback;
	FLOperationCacheHandlerBlock _wasLoadedFromCacheMainThreadCallback;
    
	struct networkFlags {
		unsigned int wasLoadedFromCache: 1;
		FLHttpOperationCacheBehavior cacheBehavior: 4;
	} _networkFlags;
}

- (id) initWithDatabase:(FLDatabase*) database
    behavior:(FLHttpOperationCacheBehavior) behavior;

+ (FLOperationCacheHandler*) operationCacheHandler:(FLDatabase*) database
    behavior:(FLHttpOperationCacheBehavior) behavior;

@property (readwrite, assign, nonatomic) BOOL wasLoadedFromCache;
@property (readwrite, retain, nonatomic) FLDatabase* database;
@property (readwrite, assign, nonatomic) FLHttpOperationCacheBehavior cacheBehavior;

@property (readwrite, copy, nonatomic) FLOperationCacheHandlerLoadFromCacheBlock onLoadFromCache;
@property (readwrite, copy, nonatomic) FLOperationCacheHandlerBlock onSaveToCache;
@property (readwrite, copy, nonatomic) FLOperationCacheHandlerBlock onLoadedFromCache;
@property (readwrite, copy, nonatomic) FLOperationCacheHandlerBlock onLoadedFromCacheInMainThread;

- (void) saveOperationOutputToCache:(FLSynchronousOperation*) operation;
- (id) loadObjectFromCacheWithOperation:(FLSynchronousOperation*) operation;

@end

#endif
