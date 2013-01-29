//
//	ZFSyncService.m
//	MyZen
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "ZFSyncService.h"
#import "ZFUtils.h"
#import "ZFGroupElementSyncInfo.h"
#import "ZFSyncPerformSync.h"
#import "ZFSyncUpdateGroupSyncStatus.h"
#import "ZFSyncState.h"
#import "FLDatabase.h"
#import "FLCacheBehavior.h"
#import "FLLengthyTask.h"
#import "FLCacheManager.h"
#import "FLDatabase.h"
#import "FLCacheManager.h"
#import "FLService.h"
#import "FLWeakReference.h"
#import "ZFSyncPerformSync.h"
#import "FLLengthyTask.h"

#import "ZFUserContext.h"

@interface ZFSyncService ()
@property (readwrite, strong) NSMutableDictionary* groups;
- (void) _userEmptiedCache:(id) sender;
- (ZFSyncStateIcon) syncStateIconForPhotoSet:(ZFPhotoSet*) photoSet;
- (ZFSyncStateIcon) syncStateIconForGroup:(ZFGroup*) element;
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

- (void) updateGroupIsToGo:(ZFGroup*) group
{
	FLAssertIsNotNil_(group);
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
	FLAssertIsNotNil_(element);

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
		FLDatabaseTable* table = [[ZFGroupElementSyncInfo class] sharedDatabaseTable];
		return [self.syncStateDatabase rowCountForTable: table];
	}
	
	return 0;
}

- (void) removeElementById:(NSNumber*) elementId
{
	FLAssertIsNotNil_(elementId);

	ZFGroupElementSyncInfo* info = [ZFGroupElementSyncInfo groupElementSyncInfo];
	info.syncObjectId = elementId;

	[self.syncStateDatabase deleteObject:info];
}

- (void) removeAllSyncStates
{
	[self.syncStateDatabase dropTable:[[ZFSyncState class] sharedDatabaseTable]];
	[[ZFSyncState sharedCacheBehavior] clearMemoryCache];
}

- (void) updateElement:(ZFGroupElementSyncInfo*) element
{
	FLAssertIsNotNil_(element);
	
	[self.syncStateDatabase saveObject:element];
}

- (ZFGroupElementSyncInfo*) syncInfoFromGroupElementId:(NSNumber*) elementId
{
	FLAssertIsNotNil_(elementId);
	ZFGroupElementSyncInfo* info = [ZFGroupElementSyncInfo groupElementSyncInfo];
	info.syncObjectId = elementId;
	return [self.syncStateDatabase loadObject:info];
}

- (ZFGroupElementSyncInfo*) syncInfoFromGroupElement:(ZFGroupElement*) element 
{
	return [self syncInfoFromGroupElementId:element.Id];
}



- (void) addGroupElement:(ZFGroupElement*) groupElement
{
	FLAssertIsNotNil_(groupElement);
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
    NSArray* list = nil;
	[self.syncStateDatabase loadAllObjectsForTypeWithClass:[ZFGroupElementSyncInfo class]
		outObjects:&list];
    
    return FLAutorelease(list);
}

- (void) removeGroupElement:(ZFGroupElement*) groupElement
{
	FLAssertIsNotNil_(groupElement);
	[self removeElementById:groupElement.Id];
}

- (void) removeElement:(ZFGroupElementSyncInfo*) element
{
	FLAssertIsNotNil_(element);
	[self removeElementById:element.syncObjectId];
}

- (void) removeAllGroupElements
{
	FLDatabaseTable* table = [[ZFGroupElementSyncInfo class] sharedDatabaseTable];
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

- (void) saveSyncState:(ZFSyncState*) state
{
	FLAssertIsNotNil_(state);
	[self.syncStateDatabase saveObject:state];
}

- (void) removeSyncStateForElement:(ZFGroupElement*) element
{
	FLAssertIsNotNil_(element);
	ZFSyncState* state = [ZFSyncState syncState];
	state.syncObjectId = element.Id;
	[self.syncStateDatabase deleteObject:state];
}

- (ZFSyncState*) syncStateForGroupElementId:(NSNumber*) elementId
{
	FLAssertIsNotNil_(elementId);
	
	ZFSyncState* input = [ZFSyncState syncState];
	input.syncObjectId = elementId;
	ZFSyncState* output = [self.syncStateDatabase loadObject:input];

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
		[items addOrReplaceObject:element forKey:element.Id];
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
    
    ZFPhotoSet* elementInCache = [[self.context cacheService] loadPhotoSetWithID:newPhotoSet.IdValue];
    if( !elementInCache ||   
        [elementInCache isStaleComparedToPhotoSet:newPhotoSet]) {

        ZFSyncState* state = [self syncStateForGroupElementId:newPhotoSet.Id];
        state.isSyncedValue = NO;
        [self saveSyncState:state];
    }
    
    [[self.context cacheService] updateObject:newPhotoSet];
}

- (void) groupWasUpdated:(ZFGroup*) group {
    [[self.context cacheService] updateObject:group];
}

- (void) elementWasUpdated:(ZFGroupElement*) element {
    if(element.isGalleryElement) {
        [self photoSetWasUpdated:(ZFPhotoSet*) element];
    }
    else {
        [self groupWasUpdated:(ZFGroup*) element];
    }
}



@end



