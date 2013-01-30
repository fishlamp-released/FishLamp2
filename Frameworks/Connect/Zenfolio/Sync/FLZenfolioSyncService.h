//
//	FLZenfolioSyncService.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLZenfolioGroupElementSyncInfo.h"
#import "FLZenfolioSyncState.h"
#import "FLZenfolioGroupElement.h"
#import "FLService.h"
#import "FLOrderedCollection.h"

typedef enum { 
	FLZenfolioSyncStateIconDefault,
	FLZenfolioSyncStateIconNeedsSync,
	FLZenfolioSyncStateIconSynced
} FLZenfolioSyncStateIcon;

@interface FLZenfolioSyncService : FLService  {
@private
	NSMutableDictionary* _groups;
}

//@property (readwrite, assign) BOOL isDirty; 
@property (readonly, assign) NSUInteger toGoElementCount;

+ (id) syncService;

// UI entry points, e.g. these are called almost directly from user
- (void) removeAllGroupElements;
- (void) removeGroupElement:(FLZenfolioGroupElement*) inGroupElement;
- (void) addGroupElement:(FLZenfolioGroupElement*) groupElement;

- (NSArray*) loadAllSyncInfoObjectsFromDatabase;

// manage list directly

- (FLZenfolioGroupElementSyncInfo*) syncInfoFromGroupElementId:(NSNumber*) elementId; // doesn't mark dirty
- (FLZenfolioGroupElementSyncInfo*) syncInfoFromGroupElement:(FLZenfolioGroupElement*) element;

- (FLZenfolioSyncState*) syncStateForGroupElementId:(NSNumber*) elementId;
- (void) saveSyncState:(FLZenfolioSyncState*) state;
- (void) removeSyncStateForElement:(FLZenfolioGroupElement*) element;

- (void) updateElement:(FLZenfolioGroupElementSyncInfo*) element;
- (void) removeElement:(FLZenfolioGroupElementSyncInfo*) element;
- (void) removeElementById:(NSNumber*) elementId;
- (void) batchRemoveElementById:(NSArray*) idArray;

- (void) updateGroupIsToGo:(FLZenfolioGroup*) group;
- (BOOL) groupIsToGo:(NSNumber*) groupId;
- (BOOL) doTakeElementToGo:(FLZenfolioGroupElement*) element parentId:(NSNumber*) parentId;

//- (void) unload;
- (void) removeAllSyncStates;

- (NSInteger) loadRootGroupId;

- (FLOrderedCollection*) syncableItemsForElement:(FLZenfolioGroupElement*) element;

- (FLZenfolioSyncStateIcon) syncStateIconForGroupElement:(FLZenfolioGroupElement*) element;

- (void) elementWasUpdated:(FLZenfolioGroupElement*) element;
@end

FLPublishService(syncService, FLZenfolioSyncService*);
