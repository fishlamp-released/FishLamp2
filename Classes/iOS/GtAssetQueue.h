//
//  GtAssetQueue.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtQueuedAsset.h"
#import "GtObjectDatabase.h"
#import "GtPerformSelectorOperation.h"
#import "GtAssetQueueState.h"

#import "GtImageAsset.h"

@class GtAssetQueueLoadLock;

typedef enum
{
	GtAssetQueueSortOrderOldestFirst,
	GtAssetQueueSortOrderNewestFirst
} GtAssetQueueSortOrder;

typedef enum {
    GtAssetTypeNone = 0,

	GtAssetTypeImage = (1 << 1),
	GtAssetTypeVideo = (1 << 2),
	
	GtAssetTypeFromAssetsLibrary = (1 << 3),
	GtAssetTypeFromApp = (1 << 4),
	GtAssetTypeFromCamera = (1 << 5),
	
	GtAssetTypeAutoAdded = (1 << 6),

	GtAssetTypeImageFromApp = GtAssetTypeImage | GtAssetTypeFromApp,
	GtAssetTypeImageFromAssetsLibrary = GtAssetTypeImage | GtAssetTypeFromAssetsLibrary,
	GtAssetTypeImageFromCamera = GtAssetTypeImage | GtAssetTypeFromApp | GtAssetTypeFromCamera,

	GtAssetTypeVideoFromAssetsLibrary = GtAssetTypeVideo | GtAssetTypeFromAssetsLibrary,
	GtAssetTypeVideoFromCamera = GtAssetTypeVideo | GtAssetTypeFromApp,
} GtAssetType;

typedef void (^GtQueuedAssetVisitor)(GtQueuedAsset* asset);
typedef void (^GtAssetQueueLoadAssetBlock)(id loadedAsset, NSError* error);

@interface GtAssetQueue : NSObject<NSFastEnumeration> {
@private
	NSString* m_queueUID;
	NSMutableArray* m_queue;
	GtObjectDatabase* m_database;
	GtAssetQueueState* m_state;
    NSMutableArray* m_locks;
}

@property (readonly, retain, nonatomic) NSArray* assets;

@property (readwrite, retain, nonatomic) GtObjectDatabase* database;
@property (readonly, retain, nonatomic) NSString* queueUID;

@property (readonly, assign, nonatomic) unsigned long totalAssetsAdded; // lifetime tally
@property (readonly, assign, nonatomic) NSUInteger count; 
 
// default init not allowed. 
 
- (id) initWithQueueUID:(NSString*) uid;

- (void) batchAddAssets:(NSArray*) assets;
- (void) addAsset:(GtQueuedAsset*) asset;
- (void) deleteAsset:(GtQueuedAsset*) asset;
- (void) saveAsset:(GtQueuedAsset*) asset;

- (void) didUploadAsset:(GtQueuedAsset*) asset;
- (BOOL) assetWasUploaded:(NSString*) assetURL;
- (BOOL) assetIsInQueue:(NSString*) assetURL;

- (void) removeAssetsByType:(GtAssetType) type;
- (void) removeAllAssets;

// load the queue into memory
//- (void) beginLoadingFromDatabase:(GtErrorCallback) completionBlock;
//- (void) unload;
- (BOOL) isLoaded;
- (GtAssetQueueLoadLock*) loadLock;

// these require queue to be loaded
- (id) assetAtIndex:(NSUInteger) idx;
- (NSUInteger) indexOfAsset:(GtQueuedAsset*) aAsset;
- (void) deleteAssetAtIndex:(NSUInteger) idx;
- (void) replaceAssetAtIndex:(NSUInteger) idx asset:(GtQueuedAsset*) asset;
- (void) saveQueueToDatabase;

// sorting requires queue to be loaded.
@property (readonly, assign, nonatomic) GtAssetQueueSortOrder sortOrder;
- (void) sort:(GtAssetQueueSortOrder) sortOrder assetSortPropertySelector:(SEL) selector;
- (void) exchangeAssetsInSort:(NSUInteger) lhs rhs:(NSUInteger) rhs;

- (void) beginLoadingFirstAsset:(GtAssetQueueLoadAssetBlock) completionBlock;

- (void) didChangeAssetQueue;

- (Class) queueClass;

@end

@interface GtQueuedAsset (GtAssetQueue)

- (id) initWithImageAsset:(id<GtImageAsset>) photo assetType:(GtAssetType) assetType;
- (id) initWithAssetUID:(NSString*) assetUID;

+ (id) queuedAsset:(NSString*) assetUID;

@property (readwrite, retain, nonatomic) id<GtImageAsset> imageAsset;

- (NSString*) displayName;

- (void) createAssetIfNeeded;

@end

@interface GtAssetQueueLoadLock : NSObject {
@private
    GtAssetQueue* m_assetQueue;
}

- (void) releaseLock;
@end

typedef void (^GtAssetQueueLoaderBlock)(GtAssetQueueLoadLock* loadLock);

@interface GtAssetQueueLoader : NSObject {
@private
    GtAssetQueue* m_assetQueue;
    NSError* m_error;
    NSMutableArray* m_queue;
    BOOL m_cancelled;
}

@property (readonly, assign, nonatomic) BOOL wasCancelled;
@property (readonly, retain, nonatomic) GtAssetQueue* assetQueue;
@property (readonly, retain, nonatomic) NSError* error;

- (id) initWithAssetQueue:(GtAssetQueue*) queue;

+ (GtAssetQueueLoader*) assetQueueLoader:(GtAssetQueue*) queue;

- (void) beginLoadingFromDatabase:(GtAssetQueueLoaderBlock) callback;

- (void) cancelLoading; 

@end


