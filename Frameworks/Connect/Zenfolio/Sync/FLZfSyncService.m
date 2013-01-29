//
//	FLZfSyncService.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLZfSyncService.h"
#import "FLZfUtils.h"
#import "FLZfGroupElementSyncInfo.h"
#import "FLZfSyncPerformSync.h"
#import "FLZfSyncUpdateGroupSyncStatus.h"
#import "FLZfSyncState.h"
#import "FLDatabase.h"
#import "FLCacheBehavior.h"
#import "FLLengthyTask.h"
#import "FLCacheManager.h"
#import "FLDatabase.h"
#import "FLCacheManager.h"
#import "FLService.h"
#import "FLWeakReference.h"
#import "FLZfSyncPerformSync.h"
#import "FLLengthyTask.h"

#import "FLZfUserContext.h"

@interface FLZfSyncService ()
@property (readwrite, strong) NSMutableDictionary* groups;
- (void) _userEmptiedCache:(id) sender;
- (FLZfSyncStateIcon) syncStateIconForPhotoSet:(FLZfPhotoSet*) photoSet;
- (FLZfSyncStateIcon) syncStateIconForGroup:(FLZfGroup*) element;
@end

@implementation FLZfGroup (Sync)
// for groups!!!
- (void) wasSavedToDatabase:(FLDatabase *)database
{
FIXME(@"this is removed from fishlamp");

//	[[FLZfSyncService instance] updateGroupIsToGo:self];
}

@end

@implementation FLZfSyncService

@synthesize groups = _groups;

- (FLDatabase*) syncStateDatabase {
    return [self.context userStorageService].documentsDatabase;
}

- (FLDatabase*) groupElementDatabase {
    return [self.context userStorageService].cacheDatabase;
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

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
	FLRelease(_groups);
	FLSuperDealloc();
}

- (void) _userEmptiedCache:(id) sender {
    [self removeAllSyncStates];
}

- (void) openService:(FLServiceManager*) context {
    self.groups = [NSMutableDictionary dictionary];
    [super openService:context];
}

- (void) closeService:(FLServiceManager*) context {
    self.groups = nil;
    [super closeService:context];
}

- (void) updateGroupIsToGo:(FLZfGroup*) group
{
	FLAssertIsNotNil_(group);
	FLZfGroupElementSyncInfo* info = [self syncInfoFromGroupElementId:group.Id];
	BOOL toGo = (info || [self groupIsToGo:group.parentGroupId]);
	[_groups setObject:[NSNumber numberWithBool:toGo] forKey:group.Id];
}

- (BOOL) groupIsToGo:(NSNumber*) groupId {
	if(!groupId) {
		return NO;
	}
	
	FLZfGroupElementSyncInfo* info = [self syncInfoFromGroupElementId:groupId];
	if(info) {
		return YES;
	}

	return [[_groups objectForKey:groupId] boolValue];
}

- (BOOL) doTakeElementToGo:(FLZfGroupElement*) element parentId:(NSNumber*) parentId
{
	FLAssertIsNotNil_(element);

	FLZfGroupElementSyncInfo* info = [self syncInfoFromGroupElementId:element.Id];
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
		FLDatabaseTable* table = [[FLZfGroupElementSyncInfo class] sharedDatabaseTable];
		return [self.syncStateDatabase rowCountForTable: table];
	}
	
	return 0;
}

- (void) removeElementById:(NSNumber*) elementId
{
	FLAssertIsNotNil_(elementId);

	FLZfGroupElementSyncInfo* info = [FLZfGroupElementSyncInfo groupElementSyncInfo];
	info.syncObjectId = elementId;

	[self.syncStateDatabase deleteObject:info];
}

- (void) removeAllSyncStates
{
	[self.syncStateDatabase dropTable:[[FLZfSyncState class] sharedDatabaseTable]];
	[[FLZfSyncState sharedCacheBehavior] clearMemoryCache];
}

- (void) updateElement:(FLZfGroupElementSyncInfo*) element
{
	FLAssertIsNotNil_(element);
	
	[self.syncStateDatabase saveObject:element];
}

- (FLZfGroupElementSyncInfo*) syncInfoFromGroupElementId:(NSNumber*) elementId
{
	FLAssertIsNotNil_(elementId);
	FLZfGroupElementSyncInfo* info = [FLZfGroupElementSyncInfo groupElementSyncInfo];
	info.syncObjectId = elementId;
	return [self.syncStateDatabase loadObject:info];
}

- (FLZfGroupElementSyncInfo*) syncInfoFromGroupElement:(FLZfGroupElement*) element 
{
	return [self syncInfoFromGroupElementId:element.Id];
}



- (void) addGroupElement:(FLZfGroupElement*) groupElement
{
	FLAssertIsNotNil_(groupElement);
	if(groupElement)
	{
		FLZfGroupElementSyncInfo* element = [self syncInfoFromGroupElement:groupElement];
		if(!element)
		{
			element = FLAutorelease([[FLZfGroupElementSyncInfo alloc] init]);
			element.syncObjectId = groupElement.Id;
			element.isGroupValue = groupElement.isGroupElement;
		}
		element.name = groupElement.Title;
		[self updateElement:element];
	}
}

//- (void) loadAllGroupElementSyncInfoObjects:(NSArray**) outObjects {
//	[[[self.context userStorageService] database]loadAllObjectsForTypeWithClass:[FLZfGroupElementSyncInfo class]
//		outObjects:outObjects];
//}

- (NSArray*) loadAllSyncInfoObjectsFromDatabase {
    NSArray* list = nil;
	[self.syncStateDatabase loadAllObjectsForTypeWithClass:[FLZfGroupElementSyncInfo class]
		outObjects:&list];
    
    return FLAutorelease(list);
}

- (void) removeGroupElement:(FLZfGroupElement*) groupElement
{
	FLAssertIsNotNil_(groupElement);
	[self removeElementById:groupElement.Id];
}

- (void) removeElement:(FLZfGroupElementSyncInfo*) element
{
	FLAssertIsNotNil_(element);
	[self removeElementById:element.syncObjectId];
}

- (void) removeAllGroupElements
{
	FLDatabaseTable* table = [[FLZfGroupElementSyncInfo class] sharedDatabaseTable];
	[self.syncStateDatabase dropTable:table];
	[_groups removeAllObjects];
}

- (void) batchRemoveElementById:(NSArray*) idArray
{
	FLAssertIsNotNil_(idArray);
	
	for(NSNumber* idObj in idArray)
	{
		[self removeElementById:idObj];
	}
}

- (void) saveSyncState:(FLZfSyncState*) state
{
	FLAssertIsNotNil_(state);
	[self.syncStateDatabase saveObject:state];
}

- (void) removeSyncStateForElement:(FLZfGroupElement*) element
{
	FLAssertIsNotNil_(element);
	FLZfSyncState* state = [FLZfSyncState syncState];
	state.syncObjectId = element.Id;
	[self.syncStateDatabase deleteObject:state];
}

- (FLZfSyncState*) syncStateForGroupElementId:(NSNumber*) elementId
{
	FLAssertIsNotNil_(elementId);
	
	FLZfSyncState* input = [FLZfSyncState syncState];
	input.syncObjectId = elementId;
	FLZfSyncState* output = [self.syncStateDatabase loadObject:input];

	if(!output)
	{
		output = FLRetain(FLAutorelease(input));
	}

	return output;
}

- (FLOrderedCollection*) syncableItemsForElement:(FLZfGroupElement*) element
{
	FLOrderedCollection* items = [FLOrderedCollection orderedCollection];
	if( [self doTakeElementToGo:element parentId:element.parentGroupId]) 
	{
		[items addOrReplaceObject:element forKey:element.Id];
	}
	else
	{
		if(element.isGroupElement)
		{
			NSArray* elements = ((FLZfGroup*) element).Elements;
			for(FLZfGroupElement* subElement in elements)
			{
				if([self doTakeElementToGo:subElement parentId:element.Id])
				{
					[items addOrReplaceObject:subElement	 forKey:element.Id];
				}
			}
		}
	}
	
	return items;
}

- (NSInteger) loadRootGroupId
{
	return [[self context] userLogin].userValueValue;
}

- (FLZfSyncStateIcon) syncStateIconForPhotoSet:(FLZfPhotoSet*) photoSet {
	if([self doTakeElementToGo:photoSet parentId:photoSet.parentGroupId]) {

		if([self syncStateForGroupElementId:photoSet.Id].isSyncedValue) {
			return FLZfSyncStateIconSynced;
		}
		else {
			return FLZfSyncStateIconNeedsSync;
		}
	}

	return FLZfSyncStateIconDefault;
}


- (FLZfSyncStateIcon) syncStateIconForGroup:(FLZfGroup*) element {
    return 0;
}

- (FLZfSyncStateIcon) syncStateIconForGroupElement:(FLZfGroupElement*) element {
    return [element isGroupElement] ? [self syncStateIconForPhotoSet:(FLZfPhotoSet*)element] : [self syncStateIconForGroup:(FLZfGroup*)element];
}

- (void) photoSetWasUpdated:(FLZfPhotoSet*) newPhotoSet {
    
    FLZfPhotoSet* elementInCache = [[self.context cacheService] loadPhotoSetWithID:newPhotoSet.IdValue];
    if( !elementInCache ||   
        [elementInCache isStaleComparedToPhotoSet:newPhotoSet]) {

        FLZfSyncState* state = [self syncStateForGroupElementId:newPhotoSet.Id];
        state.isSyncedValue = NO;
        [self saveSyncState:state];
    }
    
    [[self.context cacheService] updateObject:newPhotoSet];
}

- (void) groupWasUpdated:(FLZfGroup*) group {
    [[self.context cacheService] updateObject:group];
}

- (void) elementWasUpdated:(FLZfGroupElement*) element {
    if(element.isGalleryElement) {
        [self photoSetWasUpdated:(FLZfPhotoSet*) element];
    }
    else {
        [self groupWasUpdated:(FLZfGroup*) element];
    }
}



@end



