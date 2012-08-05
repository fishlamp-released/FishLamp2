//
//  FLOperationCacheHandler.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/9/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLObjectDatabase.h"
#import "FLOperation.h"

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
	FLObjectDatabase* _database;
	FLOperationCacheHandlerLoadFromCacheBlock _loadFromCacheCallback;
	FLOperationCacheHandlerBlock _saveToCacheCallback;
	FLOperationCacheHandlerBlock _wasLoadedFromCacheCallback;
	FLOperationCacheHandlerBlock _wasLoadedFromCacheMainThreadCallback;
    
	struct networkFlags {
		unsigned int wasLoadedFromCache: 1;
		FLHttpOperationCacheBehavior cacheBehavior: 4;
	} _networkFlags;
}

- (id) initWithDatabase:(FLObjectDatabase*) database
    behavior:(FLHttpOperationCacheBehavior) behavior;

+ (FLOperationCacheHandler*) operationCacheHandler:(FLObjectDatabase*) database
    behavior:(FLHttpOperationCacheBehavior) behavior;

@property (readwrite, assign, nonatomic) BOOL wasLoadedFromCache;
@property (readwrite, retain, nonatomic) FLObjectDatabase* database;
@property (readwrite, assign, nonatomic) FLHttpOperationCacheBehavior cacheBehavior;

@property (readwrite, copy, nonatomic) FLOperationCacheHandlerLoadFromCacheBlock onLoadFromCache;
@property (readwrite, copy, nonatomic) FLOperationCacheHandlerBlock onSaveToCache;
@property (readwrite, copy, nonatomic) FLOperationCacheHandlerBlock onLoadedFromCache;
@property (readwrite, copy, nonatomic) FLOperationCacheHandlerBlock onLoadedFromCacheInMainThread;

- (void) saveOperationOutputToCache:(FLOperation*) operation;
- (id) loadObjectFromCacheWithOperation:(FLOperation*) operation;

@end

