//
//	FLZfSyncService.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLZfGroupElementSyncInfo.h"
#import "FLZfSyncState.h"
#import "FLZfGroupElement.h"
#import "FLService.h"
#import "FLOrderedCollection.h"

typedef enum { 
	FLZfSyncStateIconDefault,
	FLZfSyncStateIconNeedsSync,
	FLZfSyncStateIconSynced
} FLZfSyncStateIcon;

@interface FLZfSyncService : FLService  {
@private
	NSMutableDictionary* _groups;
}

//@property (readwrite, assign) BOOL isDirty; 
@property (readonly, assign) NSUInteger toGoElementCount;

+ (id) syncService;

// UI entry points, e.g. these are called almost directly from user
- (void) removeAllGroupElements;
- (void) removeGroupElement:(FLZfGroupElement*) inGroupElement;
- (void) addGroupElement:(FLZfGroupElement*) groupElement;

- (NSArray*) loadAllSyncInfoObjectsFromDatabase;

// manage list directly

- (FLZfGroupElementSyncInfo*) syncInfoFromGroupElementId:(NSNumber*) elementId; // doesn't mark dirty
- (FLZfGroupElementSyncInfo*) syncInfoFromGroupElement:(FLZfGroupElement*) element;

- (FLZfSyncState*) syncStateForGroupElementId:(NSNumber*) elementId;
- (void) saveSyncState:(FLZfSyncState*) state;
- (void) removeSyncStateForElement:(FLZfGroupElement*) element;

- (void) updateElement:(FLZfGroupElementSyncInfo*) element;
- (void) removeElement:(FLZfGroupElementSyncInfo*) element;
- (void) removeElementById:(NSNumber*) elementId;
- (void) batchRemoveElementById:(NSArray*) idArray;

- (void) updateGroupIsToGo:(FLZfGroup*) group;
- (BOOL) groupIsToGo:(NSNumber*) groupId;
- (BOOL) doTakeElementToGo:(FLZfGroupElement*) element parentId:(NSNumber*) parentId;

//- (void) unload;
- (void) removeAllSyncStates;

- (NSInteger) loadRootGroupId;

- (FLOrderedCollection*) syncableItemsForElement:(FLZfGroupElement*) element;

- (FLZfSyncStateIcon) syncStateIconForGroupElement:(FLZfGroupElement*) element;

- (void) elementWasUpdated:(FLZfGroupElement*) element;
@end

FLPublishService(syncService, FLZfSyncService*);
