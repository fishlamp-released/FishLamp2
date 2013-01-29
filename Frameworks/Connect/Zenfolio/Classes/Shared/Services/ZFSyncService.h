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

typedef enum { 
	ZFSyncStateIconDefault,
	ZFSyncStateIconNeedsSync,
	ZFSyncStateIconSynced
} ZFSyncStateIcon;

@interface ZFSyncService : FLService  {
@private
	NSMutableDictionary* _groups;
}

//@property (readwrite, assign) BOOL isDirty; 
@property (readonly, assign) NSUInteger toGoElementCount;

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

- (NSInteger) loadRootGroupId;

- (FLOrderedCollection*) syncableItemsForElement:(ZFGroupElement*) element;

- (ZFSyncStateIcon) syncStateIconForGroupElement:(ZFGroupElement*) element;

- (void) elementWasUpdated:(ZFGroupElement*) element;
@end

FLPublishService(syncService, ZFSyncService*);
