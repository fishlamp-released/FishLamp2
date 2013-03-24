//
//	ZFSyncService.h
//	MyZen
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "ZFGroupElementSyncInfo.h"
#import "ZFSyncState.h"
#import "ZFGroupElement.h"
#import "FLService.h"
#import "FLOrderedCollection.h"
#import "FLObjectStorage.h"

typedef enum { 
	ZFSyncStateIconDefault,
	ZFSyncStateIconNeedsSync,
	ZFSyncStateIconSynced
} ZFSyncStateIcon;

@protocol ZFSyncServiceDelegate;

@interface ZFSyncService : FLService<FLObjectStorage>  {
@private
	NSMutableDictionary* _groups;
    id<FLObjectStorageExtended> _syncStateDatabase;
    id<FLObjectStorageExtended> _syncedObjectDatabase;
    int _rootGroupID;
    __unsafe_unretained id<ZFSyncServiceDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<ZFSyncServiceDelegate> delegate;

@property (readonly, assign) NSUInteger toGoElementCount;

@property (readonly, assign, nonatomic) int rootGroupID;
@property (readonly, strong) id<FLObjectStorageExtended> syncStateDataStore;
@property (readonly, strong) id<FLObjectStorageExtended> syncedObjectsDataStore;

+ (id) syncService;

// UI entry points, e.g. these are called almost directly from user
- (void) removeAllGroupElements;
- (void) removeGroupElement:(ZFGroupElement*) inGroupElement;
- (void) addGroupElement:(ZFGroupElement*) groupElement;

- (NSArray*) loadAllSyncInfoObjectsFromDatabase;

// manage list directly

- (ZFGroupElementSyncInfo*) syncInfoFromGroupElementId:(NSNumber*) elementId; // doesn't mark dirty
- (ZFGroupElementSyncInfo*) syncInfoFromGroupElement:(ZFGroupElement*) element;

- (ZFSyncState*) syncStateForGroupElementId:(NSNumber*) elementId;
- (void) saveSyncState:(ZFSyncState*) state;
- (void) removeSyncStateForElement:(ZFGroupElement*) element;

- (void) updateElement:(ZFGroupElementSyncInfo*) element;
- (void) removeElement:(ZFGroupElementSyncInfo*) element;
- (void) removeElementById:(NSNumber*) elementId;
- (void) batchRemoveElementById:(NSArray*) idArray;

- (void) updateGroupIsToGo:(ZFGroup*) group;
- (BOOL) groupIsToGo:(NSNumber*) groupId;
- (BOOL) doTakeElementToGo:(ZFGroupElement*) element parentId:(NSNumber*) parentId;

//- (void) unload;
- (void) removeAllSyncStates;

- (FLOrderedCollection*) syncableItemsForElement:(ZFGroupElement*) element;

- (ZFSyncStateIcon) syncStateIconForGroupElement:(ZFGroupElement*) element;

@end

@protocol ZFSyncServiceDelegate <NSObject>
- (int) syncServiceGetRootGroupID:(ZFSyncService*) service;
- (id<FLObjectStorageExtended>) syncServiceSyncStateDataStore:(ZFSyncService*) service;
- (id<FLObjectStorageExtended>) syncServiceGroupElementDataStore:(ZFSyncService*) service;
@end
 