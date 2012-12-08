//
//  FLAssetQueue.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLQueuedAsset.h"
#import "FLDatabase.h"
#import "FLPerformSelectorOperation.h"
#import "FLAssetQueueState.h"

#import "FLImageAsset.h"
#import "FLService.h"

@class FLAssetQueueLoadLock;

typedef enum
{
	FLAssetQueueSortOrderOldestFirst,
	FLAssetQueueSortOrderNewestFirst
} FLAssetQueueSortOrder;

typedef void (^FLQueuedAssetVisitor)(FLQueuedAsset* asset);
typedef void (^FLAssetQueueLoadAssetBlock)(id loadedAsset, NSError* error);

@interface FLAssetQueue : FLService<NSFastEnumeration> {
@private
	NSString* _queueUID;
	NSMutableArray* _assets;
	FLAssetQueueState* _state;
    NSInteger _lockCount;
}

@property (readonly, strong) NSArray* assets;

@property (readonly, strong) FLDatabase* database;
@property (readonly, strong) NSString* queueUID;

@property (readonly, assign) unsigned long totalAssetsAdded; // lifetime tally
@property (readonly, assign) NSUInteger count; 
 
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
//- (void) unload;
- (BOOL) isLoaded;
- (id) loadLock; //delete the lock to release it.

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
typedef void (^FLAssetQueueLoaderBlock)(FLAssetQueueLoadLock* loadLock);

@interface FLAssetQueueLoader : FLOperation {
@private
    FLAssetQueue* _assetQueue;
}

- (id) initWithAssetQueue:(FLAssetQueue*) queue;

+ (FLAssetQueueLoader*) assetQueueLoader:(FLAssetQueue*) queue;


@end

