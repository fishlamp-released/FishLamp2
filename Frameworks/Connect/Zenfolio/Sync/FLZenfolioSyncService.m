//
//	FLZenfolioSyncService.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioSyncService.h"
#import "FLZenfolioUtils.h"
#import "FLZenfolioGroupElementSyncInfo.h"
#import "FLZenfolioSyncPerformSync.h"
#import "FLZenfolioSyncUpdateGroupSyncStatus.h"
#import "FLZenfolioSyncState.h"
#import "FLDatabase.h"
#import "FLCacheBehavior.h"
#import "FLLengthyTask.h"
#import "FLCacheManager.h"
#import "FLDatabase.h"
#import "FLCacheManager.h"
#import "FLService.h"
#import "FLWeakReference.h"
#import "FLZenfolioSyncPerformSync.h"
#import "FLLengthyTask.h"

#import "FLZenfolioUserContext.h"
#import "FLUserDataStorageService.h"

@interface FLZenfolioSyncService ()
@property (readwrite, strong) NSMutableDictionary* groups;
- (void) _userEmptiedCache:(id) sender;
- (FLZenfolioSyncStateIcon) syncStateIconForPhotoSet:(FLZenfolioPhotoSet*) photoSet;
- (FLZenfolioSyncStateIcon) syncStateIconForGroup:(FLZenfolioGroup*) element;
@end

@implementation FLZenfolioGroup (Sync)
// for groups!!!
- (void) wasSavedToDatabase:(FLDatabase *)database
{
FIXME(@"this is removed from fishlamp");

//	[[FLZenfolioSyncService instance] updateGroupIsToGo:self];
}

@end

@implementation FLZenfolioSyncService

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

- (void) updateGroupIsToGo:(FLZenfolioGroup*) group
{
	FLAssertIsNotNil_(group);
	FLZenfolioGroupElementSyncInfo* info = [self syncInfoFromGroupElementId:group.Id];
	BOOL toGo = (info || [self groupIsToGo:group.parentGroupId]);
	[_groups setObject:[NSNumber numberWithBool:toGo] forKey:group.Id];
}

- (BOOL) groupIsToGo:(NSNumber*) groupId {
	if(!groupId) {
		return NO;
	}
	
	FLZenfolioGroupElementSyncInfo* info = [self syncInfoFromGroupElementId:groupId];
	if(info) {
		return YES;
	}

	return [[_groups objectForKey:groupId] boolValue];
}

- (BOOL) doTakeElementToGo:(FLZenfolioGroupElement*) element parentId:(NSNumber*) parentId
{
	FLAssertIsNotNil_(element);

	FLZenfolioGroupElementSyncInfo* info = [self syncInfoFromGroupElementId:element.Id];
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
		FLDatabaseTable* table = [[FLZenfolioGroupElementSyncInfo class] sharedDatabaseTable];
		return [self.syncStateDatabase rowCountForTable: table];
	}
	
	return 0;
}

- (void) removeElementById:(NSNumber*) elementId
{
	FLAssertIsNotNil_(elementId);

	FLZenfolioGroupElementSyncInfo* info = [FLZenfolioGroupElementSyncInfo groupElementSyncInfo];
	info.syncObjectId = elementId;

	[self.syncStateDatabase deleteObject:info];
}

- (void) removeAllSyncStates
{
	[self.syncStateDatabase dropTable:[[FLZenfolioSyncState class] sharedDatabaseTable]];
	[[FLZenfolioSyncState sharedCacheBehavior] clearMemoryCache];
}

- (void) updateElement:(FLZenfolioGroupElementSyncInfo*) element
{
	FLAssertIsNotNil_(element);
	
	[self.syncStateDatabase saveObject:element];
}

- (FLZenfolioGroupElementSyncInfo*) syncInfoFromGroupElementId:(NSNumber*) elementId
{
	FLAssertIsNotNil_(elementId);
	FLZenfolioGroupElementSyncInfo* info = [FLZenfolioGroupElementSyncInfo groupElementSyncInfo];
	info.syncObjectId = elementId;
	return [self.syncStateDatabase loadObject:info];
}

- (FLZenfolioGroupElementSyncInfo*) syncInfoFromGroupElement:(FLZenfolioGroupElement*) element 
{
	return [self syncInfoFromGroupElementId:element.Id];
}



- (void) addGroupElement:(FLZenfolioGroupElement*) groupElement
{
	FLAssertIsNotNil_(groupElement);
	if(groupElement)
	{
		FLZenfolioGroupElementSyncInfo* element = [self syncInfoFromGroupElement:groupElement];
		if(!element)
		{
			element = FLAutorelease([[FLZenfolioGroupElementSyncInfo alloc] init]);
			element.syncObjectId = groupElement.Id;
			element.isGroupValue = groupElement.isGroupElement;
		}
		element.name = groupElement.Title;
		[self updateElement:element];
	}
}

//- (void) loadAllGroupElementSyncInfoObjects:(NSArray**) outObjects {
//	[[[self.context userStorageService] database]loadAllObjectsForTypeWithClass:[FLZenfolioGroupElementSyncInfo class]
//		outObjects:outObjects];
//}

- (NSArray*) loadAllSyncInfoObjectsFromDatabase {
    NSArray* list = nil;
	[self.syncStateDatabase loadAllObjectsForTypeWithClass:[FLZenfolioGroupElementSyncInfo class]
		outObjects:&list];
    
    return FLAutorelease(list);
}

- (void) removeGroupElement:(FLZenfolioGroupElement*) groupElement
{
	FLAssertIsNotNil_(groupElement);
	[self removeElementById:groupElement.Id];
}

- (void) removeElement:(FLZenfolioGroupElementSyncInfo*) element
{
	FLAssertIsNotNil_(element);
	[self removeElementById:element.syncObjectId];
}

- (void) removeAllGroupElements
{
	FLDatabaseTable* table = [[FLZenfolioGroupElementSyncInfo class] sharedDatabaseTable];
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

- (void) saveSyncState:(FLZenfolioSyncState*) state
{
	FLAssertIsNotNil_(state);
	[self.syncStateDatabase saveObject:state];
}

- (void) removeSyncStateForElement:(FLZenfolioGroupElement*) element
{
	FLAssertIsNotNil_(element);
	FLZenfolioSyncState* state = [FLZenfolioSyncState syncState];
	state.syncObjectId = element.Id;
	[self.syncStateDatabase deleteObject:state];
}

- (FLZenfolioSyncState*) syncStateForGroupElementId:(NSNumber*) elementId
{
	FLAssertIsNotNil_(elementId);
	
	FLZenfolioSyncState* input = [FLZenfolioSyncState syncState];
	input.syncObjectId = elementId;
	FLZenfolioSyncState* output = [self.syncStateDatabase loadObject:input];

	if(!output)
	{
		output = FLRetain(FLAutorelease(input));
	}

	return output;
}

- (FLOrderedCollection*) syncableItemsForElement:(FLZenfolioGroupElement*) element
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
			NSArray* elements = ((FLZenfolioGroup*) element).Elements;
			for(FLZenfolioGroupElement* subElement in elements)
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

- (FLZenfolioSyncStateIcon) syncStateIconForPhotoSet:(FLZenfolioPhotoSet*) photoSet {
	if([self doTakeElementToGo:photoSet parentId:photoSet.parentGroupId]) {

		if([self syncStateForGroupElementId:photoSet.Id].isSyncedValue) {
			return FLZenfolioSyncStateIconSynced;
		}
		else {
			return FLZenfolioSyncStateIconNeedsSync;
		}
	}

	return FLZenfolioSyncStateIconDefault;
}


- (FLZenfolioSyncStateIcon) syncStateIconForGroup:(FLZenfolioGroup*) element {
    return 0;
}

- (FLZenfolioSyncStateIcon) syncStateIconForGroupElement:(FLZenfolioGroupElement*) element {
    return [element isGroupElement] ? [self syncStateIconForPhotoSet:(FLZenfolioPhotoSet*)element] : [self syncStateIconForGroup:(FLZenfolioGroup*)element];
}

- (void) photoSetWasUpdated:(FLZenfolioPhotoSet*) newPhotoSet {
    
    FLZenfolioPhotoSet* elementInCache = [[self.context cacheService] loadPhotoSetWithID:newPhotoSet.IdValue];
    if( !elementInCache ||   
        [elementInCache isStaleComparedToPhotoSet:newPhotoSet]) {

        FLZenfolioSyncState* state = [self syncStateForGroupElementId:newPhotoSet.Id];
        state.isSyncedValue = NO;
        [self saveSyncState:state];
    }
    
    [[self.context cacheService] updateObject:newPhotoSet];
}

- (void) groupWasUpdated:(FLZenfolioGroup*) group {
    [[self.context cacheService] updateObject:group];
}

- (void) elementWasUpdated:(FLZenfolioGroupElement*) element {
    if(element.isGalleryElement) {
        [self photoSetWasUpdated:(FLZenfolioPhotoSet*) element];
    }
    else {
        [self groupWasUpdated:(FLZenfolioGroup*) element];
    }
}



@end



