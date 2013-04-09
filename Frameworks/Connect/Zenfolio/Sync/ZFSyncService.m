//
//	ZFSyncService.m
//	MyZen
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "ZFSyncService.h"

#import "ZFGroupElementSyncInfo.h"
#import "ZFSyncPerformSync.h"
#import "ZFSyncUpdateGroupSyncStatus.h"
#import "ZFSyncState.h"
#import "FLCacheBehavior.h"
#import "FLLengthyTask.h"
#import "FLCacheManager.h"
#import "FLDatabase.h"
#import "FLCacheManager.h"
#import "FLService.h"
#import "FLWeakReference.h"
#import "ZFSyncPerformSync.h"
#import "FLLengthyTask.h"
#import "FLUserDataStorageService.h"
#import "ZFWebApi.h"

@interface ZFSyncService ()
@property (readwrite, strong) NSMutableDictionary* groups;
- (void) _userEmptiedCache:(id) sender;
- (ZFSyncStateIcon) syncStateIconForPhotoSet:(ZFPhotoSet*) photoSet;
- (ZFSyncStateIcon) syncStateIconForGroup:(ZFGroup*) element;
@property (readwrite, assign, nonatomic) int rootGroupID;
@property (readwrite, strong) id<FLObjectStorageExtended> syncStateDataStore;
@property (readwrite, strong) id<FLObjectStorageExtended> syncedObjectsDataStore;

@end

@implementation ZFGroup (Sync)
// for groups!!!
- (void) wasSavedToDatabase:(FLDatabase *)database
{
FIXME(@"this is removed from fishlamp");

//	[[ZFSyncService instance] updateGroupIsToGo:self];
}

@end

@implementation ZFSyncService

@synthesize syncedObjectsDataStore = _syncedObjectDatabase;
@synthesize syncStateDataStore = _syncStateDatabase;
@synthesize rootGroupID = _rootGroupID;
@synthesize groups = _groups;

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
#if FL_MRC
    [_syncStateDatabase release];
    [_syncedObjectDatabase release];
    [_groups release];
    [super dealloc];
#endif
}

- (id) init {
	if((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(_userEmptiedCache:) 
                name:FLCacheManagerEmptyCacheNotification
                object:[FLCacheManager instance]];	
    }
	return self;
}

+ (id) syncService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) _userEmptiedCache:(id) sender {
    [self removeAllSyncStates];
}

- (void) updateGroupIsToGo:(ZFGroup*) group
{
	FLAssertIsNotNil(group);
	ZFGroupElementSyncInfo* info = [self syncInfoFromGroupElementId:group.Id];
	BOOL toGo = (info || [self groupIsToGo:group.parentGroupId]);
	[_groups setObject:[NSNumber numberWithBool:toGo] forKey:group.Id];
}

- (BOOL) groupIsToGo:(NSNumber*) groupId {
	if(!groupId) {
		return NO;
	}
	
	ZFGroupElementSyncInfo* info = [self syncInfoFromGroupElementId:groupId];
	if(info) {
		return YES;
	}

	return [[_groups objectForKey:groupId] boolValue];
}

- (BOOL) doTakeElementToGo:(ZFGroupElement*) element parentId:(NSNumber*) parentId
{
	FLAssertIsNotNil(element);

	ZFGroupElementSyncInfo* info = [self syncInfoFromGroupElementId:element.Id];
	if(info)
	{
		return YES;
	}
	
	if(parentId)
	{
		return [self groupIsToGo:parentId];
	}
	
	return NO;
}

- (NSUInteger) toGoElementCount
{
	@synchronized(self) {
//		FLDatabaseTable* table = [[ZFGroupElementSyncInfo class] sharedDatabaseTable];
//		return [self.syncStateDataStore rowCountForTable: table];
        
        return [self.syncStateDataStore objectCountForClass:[ZFGroupElementSyncInfo class]];
	}
	
	return 0;
}

- (void) removeElementById:(NSNumber*) elementId
{
	FLAssertIsNotNil(elementId);

	ZFGroupElementSyncInfo* info = [ZFGroupElementSyncInfo groupElementSyncInfo];
	info.syncObjectId = elementId;

	[self.syncStateDataStore deleteObject:info];
}

- (void) removeAllSyncStates {
//	[self.syncStateDataStore dropTable:[[ZFSyncState class] sharedDatabaseTable]];
    [self.syncStateDataStore removeAllObjectsWithClass:[ZFGroupElementSyncInfo class]];
	[[ZFSyncState sharedCacheBehavior] clearMemoryCache];
}

- (void) updateElement:(ZFGroupElementSyncInfo*) element
{
	FLAssertIsNotNil(element);
	
	[self.syncStateDataStore writeObject:element];
}

- (ZFGroupElementSyncInfo*) syncInfoFromGroupElementId:(NSNumber*) elementId
{
	FLAssertIsNotNil(elementId);
	ZFGroupElementSyncInfo* info = [ZFGroupElementSyncInfo groupElementSyncInfo];
	info.syncObjectId = elementId;
	return [self.syncStateDataStore readObject:info];
}

- (ZFGroupElementSyncInfo*) syncInfoFromGroupElement:(ZFGroupElement*) element 
{
	return [self syncInfoFromGroupElementId:element.Id];
}

- (void) addGroupElement:(ZFGroupElement*) groupElement
{
	FLAssertIsNotNil(groupElement);
	if(groupElement)
	{
		ZFGroupElementSyncInfo* element = [self syncInfoFromGroupElement:groupElement];
		if(!element)
		{
			element = FLAutorelease([[ZFGroupElementSyncInfo alloc] init]);
			element.syncObjectId = groupElement.Id;
			element.isGroupValue = groupElement.isGroupElement;
		}
		element.name = groupElement.Title;
		[self updateElement:element];
	}
}

//- (void) loadAllGroupElementSyncInfoObjects:(NSArray**) outObjects {
//	[[[self.context userStorageService] database]loadAllObjectsForTypeWithClass:[ZFGroupElementSyncInfo class]
//		outObjects:outObjects];
//}

- (NSArray*) loadAllSyncInfoObjectsFromDatabase {
    return [self.syncStateDataStore readObjectsForClass:[ZFGroupElementSyncInfo class]];
}

- (void) removeGroupElement:(ZFGroupElement*) groupElement
{
	FLAssertIsNotNil(groupElement);
	[self removeElementById:groupElement.Id];
}

- (void) removeElement:(ZFGroupElementSyncInfo*) element
{
	FLAssertIsNotNil(element);
	[self removeElementById:element.syncObjectId];
}

- (void) removeAllGroupElements {
    [self removeAllSyncStates];
	[_groups removeAllObjects];
}

- (void) batchRemoveElementById:(NSArray*) idArray
{
	FLAssertIsNotNil(idArray);
	
	for(NSNumber* idObj in idArray)
	{
		[self removeElementById:idObj];
	}
}

- (void) saveSyncState:(ZFSyncState*) state
{
	FLAssertIsNotNil(state);
	[self.syncStateDataStore writeObject:state];
}

- (void) removeSyncStateForElement:(ZFGroupElement*) element
{
	FLAssertIsNotNil(element);
	ZFSyncState* state = [ZFSyncState syncState];
	state.syncObjectId = element.Id;
	[self.syncStateDataStore deleteObject:state];
}

- (ZFSyncState*) syncStateForGroupElementId:(NSNumber*) elementId
{
	FLAssertIsNotNil(elementId);
	
	ZFSyncState* input = [ZFSyncState syncState];
	input.syncObjectId = elementId;
	ZFSyncState* output = [self.syncStateDataStore readObject:input];

	if(!output)
	{
		output = FLRetain(FLAutorelease(input));
	}

	return output;
}

- (FLOrderedCollection*) syncableItemsForElement:(ZFGroupElement*) element
{
	FLOrderedCollection* items = [FLOrderedCollection orderedCollection];
	if( [self doTakeElementToGo:element parentId:element.parentGroupId]) 
	{
		[items setObject:element forKey:element.Id];
	}
	else
	{
		if(element.isGroupElement)
		{
			NSArray* elements = ((ZFGroup*) element).Elements;
			for(ZFGroupElement* subElement in elements)
			{
				if([self doTakeElementToGo:subElement parentId:element.Id])
				{
					[items setObject:subElement	 forKey:element.Id];
				}
			}
		}
	}
	
	return items;
}

- (ZFSyncStateIcon) syncStateIconForPhotoSet:(ZFPhotoSet*) photoSet {
	if([self doTakeElementToGo:photoSet parentId:photoSet.parentGroupId]) {

		if([self syncStateForGroupElementId:photoSet.Id].isSyncedValue) {
			return ZFSyncStateIconSynced;
		}
		else {
			return ZFSyncStateIconNeedsSync;
		}
	}

	return ZFSyncStateIconDefault;
}


- (ZFSyncStateIcon) syncStateIconForGroup:(ZFGroup*) element {
    return 0;
}

- (ZFSyncStateIcon) syncStateIconForGroupElement:(ZFGroupElement*) element {
    return [element isGroupElement] ? [self syncStateIconForPhotoSet:(ZFPhotoSet*)element] : [self syncStateIconForGroup:(ZFGroup*)element];
}

- (void) photoSetWasUpdated:(ZFPhotoSet*) newPhotoSet {
    ZFPhotoSet* inputObject = FLAutorelease([[ZFPhotoSet alloc] init]);
    inputObject.Id = [newPhotoSet Id];

    ZFPhotoSet* elementInCache = [self readObject:inputObject];
    if( !elementInCache ||   
        [elementInCache isStaleComparedToPhotoSet:newPhotoSet]) {

        ZFSyncState* state = [self syncStateForGroupElementId:newPhotoSet.Id];
        state.isSyncedValue = NO;
        [self saveSyncState:state];
    }
}

- (void) groupWasUpdated:(ZFGroup*) group {
    [self writeObject:group];
}

- (void) elementWasUpdated:(ZFGroupElement*) element {
    if(element.isGalleryElement) {
        [self photoSetWasUpdated:(ZFPhotoSet*) element];
    }
    else {
        [self groupWasUpdated:(ZFGroup*) element];
    }
}

- (void) writeObject:(id) object {
    if([object isKindOfClass:[ZFGroupElement class]]) {
        [self elementWasUpdated:object];
    }

    [self.syncedObjectsDataStore writeObject:object];
}

- (id) readObject:(id) inputObject {
    return [self.syncedObjectsDataStore readObject:inputObject];
}

- (void) deleteObject:(id) object {

    if([object isKindOfClass:[ZFGroupElement class]]) {
        ZFSyncState* state = [self syncStateForGroupElementId:[object Id]];
        state.isSyncedValue = NO;
        [self saveSyncState:state];
    }

    [self.syncedObjectsDataStore deleteObject:object];
}

- (BOOL) containsObject:(id) object {
    return [self.syncedObjectsDataStore containsObject:object];
}

- (void) openService {
    [super openService];
    self.rootGroupID = [self.delegate syncServiceGetRootGroupID:self];
    self.syncStateDataStore = [self.delegate syncServiceSyncStateDataStore:self];
    self.syncedObjectsDataStore = [self.delegate syncServiceGroupElementDataStore:self];
    self.groups = [NSMutableDictionary dictionary];
    FLAssertNotNil(self.syncedObjectsDataStore);
    FLAssertNotNil(self.syncStateDataStore);
    FLAssert(self.rootGroupID != 0);
}

- (void) closeService {
    [super closeService];
    self.rootGroupID = 0;
    self.syncStateDataStore = nil;
    self.syncedObjectsDataStore = nil;
    self.groups = nil;
}




@end



