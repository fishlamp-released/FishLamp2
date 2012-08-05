//
//  FLAssetQueue.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLQueuedAsset.h"
#import "FLObjectDatabase.h"
#import "FLPerformSelectorOperation.h"
#import "FLAssetQueueState.h"

#import "FLImageAsset.h"

@class FLAssetQueueLoadLock;

typedef enum
{
	FLAssetQueueSortOrderOldestFirst,
	FLAssetQueueSortOrderNewestFirst
} FLAssetQueueSortOrder;

typedef enum {
    FLAssetTypeNone = 0,

	FLAssetTypeImage = (1 << 1),
	FLAssetTypeVideo = (1 << 2),
	
	FLAssetTypeFromAssetsLibrary = (1 << 3),
	FLAssetTypeFromApp = (1 << 4),
	FLAssetTypeFromCamera = (1 << 5),
	
	FLAssetTypeAutoAdded = (1 << 6),

	FLAssetTypeImageFromApp = FLAssetTypeImage | FLAssetTypeFromApp,
	FLAssetTypeImageFromAssetsLibrary = FLAssetTypeImage | FLAssetTypeFromAssetsLibrary,
	FLAssetTypeImageFromCamera = FLAssetTypeImage | FLAssetTypeFromApp | FLAssetTypeFromCamera,

	FLAssetTypeVideoFromAssetsLibrary = FLAssetTypeVideo | FLAssetTypeFromAssetsLibrary,
	FLAssetTypeVideoFromCamera = FLAssetTypeVideo | FLAssetTypeFromApp,
} FLAssetType;

typedef void (^FLQueuedAssetVisitor)(FLQueuedAsset* asset);
typedef void (^FLAssetQueueLoadAssetBlock)(id loadedAsset, NSError* error);

@interface FLAssetQueue : NSObject<NSFastEnumeration> {
@private
	NSString* m_queueUID;
	NSMutableArray* m_queue;
	FLObjectDatabase* m_database;
	FLAssetQueueState* m_state;
    NSMutableArray* m_locks;
}

@property (readonly, retain, nonatomic) NSArray* assets;

@property (readwrite, retain, nonatomic) FLObjectDatabase* database;
@property (readonly, retain, nonatomic) NSString* queueUID;

@property (readonly, assign, nonatomic) unsigned long totalAssetsAdded; // lifetime tally
@property (readonly, assign, nonatomic) NSUInteger count; 
 
// default init not allowed. 
 
- (id) initWithQueueUID:(NSString*) uid;

- (void) batchAddAssets:(NSArray*) assets;
- (void) addAsset:(FLQueuedAsset*) asset;
- (void) deleteAsset:(FLQueuedAsset*) asset;
- (void) saveAsset:(FLQueuedAsset*) asset;

- (void) didUploadAsset:(FLQueuedAsset*) asset;
- (BOOL) assetWasUploaded:(NSString*) assetURL;
- (BOOL) assetIsInQueue:(NSString*) assetURL;

- (void) removeAssetsByType:(FLAssetType) type;
- (void) removeAllAssets;

// load the queue into memory
//- (void) beginLoadingFromDatabase:(FLErrorCallback) completionBlock;
//- (void) unload;
- (BOOL) isLoaded;
- (FLAssetQueueLoadLock*) loadLock;

// these require queue to be loaded
- (id) assetAtIndex:(NSUInteger) idx;
- (NSUInteger) indexOfAsset:(FLQueuedAsset*) aAsset;
- (void) deleteAssetAtIndex:(NSUInteger) idx;
- (void) replaceAssetAtIndex:(NSUInteger) idx asset:(FLQueuedAsset*) asset;
- (void) saveQueueToDatabase;

// sorting requires queue to be loaded.
@property (readonly, assign, nonatomic) FLAssetQueueSortOrder sortOrder;
- (void) sort:(FLAssetQueueSortOrder) sortOrder assetSortPropertySelector:(SEL) selector;
- (void) exchangeAssetsInSort:(NSUInteger) lhs rhs:(NSUInteger) rhs;

- (void) beginLoadingFirstAsset:(FLAssetQueueLoadAssetBlock) completionBlock;

- (void) didChangeAssetQueue;

- (Class) queueClass;

@end

@interface FLQueuedAsset (FLAssetQueue)

- (id) initWithImageAsset:(id<FLImageAsset>) photo assetType:(FLAssetType) assetType;
- (id) initWithAssetUID:(NSString*) assetUID;

+ (id) queuedAsset:(NSString*) assetUID;

@property (readwrite, retain, nonatomic) id<FLImageAsset> imageAsset;

- (NSString*) displayName;

- (void) createAssetIfNeeded;

@end

@interface FLAssetQueueLoadLock : NSObject {
@private
    FLAssetQueue* m_assetQueue;
}

- (void) releaseLock;
@end

typedef void (^FLAssetQueueLoaderBlock)(FLAssetQueueLoadLock* loadLock);

@interface FLAssetQueueLoader : NSObject {
@private
    FLAssetQueue* m_assetQueue;
    NSError* m_error;
    NSMutableArray* m_queue;
    BOOL m_cancelled;
}

@property (readonly, assign, nonatomic) BOOL wasCancelled;
@property (readonly, retain, nonatomic) FLAssetQueue* assetQueue;
@property (readonly, retain, nonatomic) NSError* error;

- (id) initWithAssetQueue:(FLAssetQueue*) queue;

+ (FLAssetQueueLoader*) assetQueueLoader:(FLAssetQueue*) queue;

- (void) beginLoadingFromDatabase:(FLAssetQueueLoaderBlock) callback;

- (void) cancelLoading; 

@end


