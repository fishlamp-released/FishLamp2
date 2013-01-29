//
//	FLZfSyncUpdateGroupSyncStatus.m
//	MyZen
//
//	Created by Mike Fullerton on 8/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#if REFACTOR

#import "FLZfSyncUpdateGroupSyncStatus.h"
#import "FLZfUtils.h"

#if DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@interface FLZfSyncUpdateGroupSyncStatus (Private)
- (void) _syncNextRootGroup;
- (void) _beginCheckGroupSyncStatus:(int) groupId ;
@end

@implementation FLZfSyncUpdateGroupSyncStatus

- (id) delegate
{
	return _delegate.object;
}

- (void) setDelegate:(id<FLZfSyncUpdateGroupSyncStatusDelegate>) delegate
{
	_delegate.object = delegate;
}

- (id) init
{
	if((self = [super init]))
	{
		_delegate = [[FLWeakReference alloc] init];
	}
	
	return self;
}
- (void) dealloc
{
	FLRelease(_delegate);
	FLRelease(_groupList);
	FLRelease(_groupStack);
	FLSuperDealloc();
}

- (BOOL) _walkTreeAndCheckStatusForGroup:(FLZfGroup*) group operation:(FLOperation*) operation
{
	
#if LOG
	FLLog(@"Syncing Status for group: %@", group.Title);
#endif
	
	BOOL didFindUnsyncedChild = NO;
	   
	NSMutableArray* array = group.Elements;
	for(FLZfGroupElement* elementInGroupList in array)
	{
		FLThrowIfCancelled(self);;
		
		BOOL takeSubElementToGo = [[FLZfSyncService instance] doTakeElementToGo:elementInGroupList parentId:group.Id];
		
		FLThrowIfCancelled(self);;
		
		if(elementInGroupList.isGroupElement)
		{ 
			FLZfGroup* cachedGroup = [FLZfGroup loadFromCacheWithId:elementInGroupList.IdValue];
			if(cachedGroup)
			{				 
				if( takeSubElementToGo &&
					(![cachedGroup.ModifiedOn isEqual:elementInGroupList.ModifiedOn] ||
					cachedGroup.TextCnValue != ((FLZfGroup*)elementInGroupList).TextCnValue))
				{
					FLZfSyncState* state = [[FLZfSyncService instance] syncStateForGroupElementId:cachedGroup.Id];
					state.isSyncedValue = NO;
				   [[FLZfSyncService instance] saveSyncState:state];
				   
				   didFindUnsyncedChild = YES;
				}
				
				if(_checkGroups)
				{
					if([self _walkTreeAndCheckStatusForGroup:cachedGroup operation:operation])
					{
						didFindUnsyncedChild = YES;
					}
				}
			}
			else if(takeSubElementToGo)
			{
				FLZfSyncState* state = [[FLZfSyncService instance] syncStateForGroupElementId:elementInGroupList.Id];
				state.isSyncedValue = NO;
				[[FLZfSyncService instance] saveSyncState:state];

				didFindUnsyncedChild = YES;
			}
		}
		else if(takeSubElementToGo)
		{
			FLZfPhotoSet* photoSet = [[[self.context photoSetStorage] loadPhotoSetWithID:elementInGroupList.IdValue];
			if(photoSet)
			{
				if( photoSet.PhotoListCnValue != ((FLZfPhotoSet*) elementInGroupList).PhotoListCnValue ||
					photoSet.TextCnValue != ((FLZfPhotoSet*) elementInGroupList).TextCnValue )
				{
					FLZfSyncState* state = [[FLZfSyncService instance] syncStateForGroupElementId:photoSet.Id];
					state.isSyncedValue = NO;
					[[FLZfSyncService instance] saveSyncState:state];
					didFindUnsyncedChild = YES;
				}
			}
			else
			{
				FLZfSyncState* state = [[FLZfSyncService instance] syncStateForGroupElementId:elementInGroupList.Id];
				state.isSyncedValue = NO;
				[[FLZfSyncService instance] saveSyncState:state];
				didFindUnsyncedChild = YES;
			}
		}

		if(didFindUnsyncedChild)
		{
			FLZfSyncState* state = [[FLZfSyncService instance] syncStateForGroupElementId:group.Id];
			state.isSyncedValue = NO;
			[[FLZfSyncService instance] saveSyncState:state];
			didFindUnsyncedChild = YES;
		}
		
	}
	
	return didFindUnsyncedChild;
}

- (void) _notifyDone:(NSError*) error
{
	[self hideProgress];
	
    [self.delegate syncUpdateGroupSyncStatus:self finishedUpdatingGroupList:error];
	self.delegate = nil;
	
	FLAutorelease(self);
}

- (void) _didFinishUpdating:(FLAction*) action
{
	if(action.didSucceed)
	{
		FLZfGroup* group = [[action lastOperation] operationOutput];
		if(group.IdValue == _rootGroupId)
		{
			[self.delegate syncUpdateGroupSyncStatus:self didUpdateGroup:group error:nil];
		}
		
		[self _syncNextRootGroup];
	}
	else
	{
		[self _notifyDone:[action error]];
	}
}

- (void) _updateToGoStatus:(FLOperation*) operation
{
#if FL_MRC
	FLPerformBlockInAutoreleasePool(^{
#endif    
		FLZfGroup* rootGroup = [FLZfGroup loadFromCacheWithId:_rootGroupId];
		if(rootGroup)
		{	
			FLThrowIfCancelled(self);;
			operation.output = rootGroup;
			[self _walkTreeAndCheckStatusForGroup:rootGroup operation:operation];
		}
#if FL_MRC
	});
#endif    
}

- (BOOL) _beginDownloadingNextGroupInGroupStack
{
	if(_groupStack.count)
	{
		self.progressController.title = NSLocalizedString(@"Checking Sub-Groups…", nil);
		
		int groupId = [[_groupStack lastObject] intValue];
		[_groupStack removeLastObject];
			
		[self _beginCheckGroupSyncStatus:groupId];
		return YES;
	}
	
	self.progressController.title = NSLocalizedString(@"Updating To-Go Status…", nil);

	if(self.actionContext)
	{
		FLReleaseWithNil(_groupStack);

        FLAction* action = [FLAction action];
        self.action = action;

        [action addOperationWithBlock:^(id operation) {
            [self _updateToGoStatus:operation];
        }];

        [self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
            [self _didFinishUpdating:action];
        }];
	}
	return NO;
}

- (void) _addToGroupStackIfInCache:(FLZfGroup*) group 
{
	FLZfGroup* cachedGroup = [FLZfGroup loadFromCacheWithId:group.IdValue];
	if(cachedGroup)
	{
		[_groupStack addObject:group.Id];
	}
}

- (void) _gotGroup:(FLZfGroup*) newGroup
{
	[self.delegate syncUpdateGroupSyncStatus:self didUpdateGroup:newGroup error:nil];
}

- (void) _onGroupLoadedForSyncStatus:(FLAction*) action groupId:(int) groupId
{
	if(action.didSucceed)
	{
		FLZfGroup* newGroup = [[action lastOperation] operationOutput];
		
		if(newGroup.IdValue == _rootGroupId)
		{
			[self.delegate syncUpdateGroupSyncStatus:self didUpdateGroup:newGroup error:nil];
		}
	
		[self _beginDownloadingNextGroupInGroupStack];
	}
	else if([action error].zenfolioFaultCode == errNoSuchObject)
	{		
		action.handledError = YES;
		NSNumber* groupElement = [NSNumber numberWithInt:groupId];
		
		[[FLZfSyncService instance] removeElementById:groupElement];
		[self.delegate syncUpdateGroupSyncStatus:self didRemoveGroup:groupElement error:nil];
		[self _beginDownloadingNextGroupInGroupStack];
	}
	else
	{
		[self _notifyDone:[action error]];
	}
}

- (void) _didLoadGroupFromCache:(FLZfLoadGroupFromCacheOperation*) operation {
	if(operation.didSucceed && _checkGroups) {
		FLZfGroup* newGroup = operation.output;
		
		NSMutableArray* array = newGroup.Elements;
		for(FLZfGroupElement* element in array)
		{
			if(element.isGroupElement)
			{
				[self _addToGroupStackIfInCache:(FLZfGroup*)element];
			}
		}
	}
}

- (void) _beginCheckGroupSyncStatus:(int) groupId {
	FLAction* action = [self createAction];
	
	action.actionDescription.actionType = FLActionTypeSync;
	action.actionDescription.actionItemName = FLActionDescriptionItemNameGroup;
		
	FLZfLoadGroupFromCacheOperation* operation = 
		[[FLZfLoadGroupFromCacheOperation alloc] initWithGroupId:groupId];
//			level:kZfInformatonLevelFull
//			includeChildren:YES];
	operation.cache = [[self.context userStorageService].cacheDatabase;
	operation.canLoadFromCache = YES;
	operation.canSaveToCache = YES;
	operation.alwaysRunSubOperations = YES;	 
    operation.willStartBlock = ^(id theOperation) { [self _didLoadGroupFromCache:theOperation]; };  
//	[operation setDidPerformCallback:self action:@selector(_didLoadGroupFromCache:)];
	[action addOperation:operation];
	FLRelease(operation);

	[self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
        [self _onGroupLoadedForSyncStatus:action groupId:groupId];
    }];

}

- (void) _syncNextRootGroup
{
	FLReleaseWithNil(_groupStack);

	if(_groupList.count)
	{
		_groupStack = [[NSMutableArray alloc] init];
		
		_rootGroupId = [[_groupList lastObject] intValue];
		[_groupList removeLastObject];
		
		self.progressController.title = NSLocalizedString(@"Updating Group…", nil);
		[self _beginCheckGroupSyncStatus:_rootGroupId];
	}
	else
	{
		[self _notifyDone:nil];
	}
}

- (void) _didLoadFromCacheForDisplay:(FLAction*) action 
                          outputList:(NSMutableArray*) outputList
{
	if(action.didSucceed)
	{
		for(FLZfGroup* group in outputList)
		{
			[self.delegate syncUpdateGroupSyncStatus:self didUpdateGroup:group error:nil];
		}
		[self _syncNextRootGroup];
	}
	else
	{
		[self _notifyDone:[action error]];
	}
}

- (void) _loadRootGroupsFromCacheForDisplay:(FLPerformSelectorOperation*) operation
                                 outputList:(NSMutableArray*) outputList
{
	for(NSNumber* idObject in _groupList)
	{
		FLThrowIfCancelled(self);;
		
		FLZfGroup* group = [FLZfGroup loadFromCacheWithId:idObject.intValue];
		if(group) 
		{	
			[outputList addObject:group];
		}
	}
}

- (void) configure:(NSArray*) groupIds checkGroups:(BOOL) checkGroups
{
	FLReleaseWithNil(_groupList);
	_groupList = [groupIds mutableCopy];
	_checkGroups = checkGroups;
}

- (void) beginActionInContext:(FLOperationContext *)context
{
	FLRetain(self);
	[super beginActionInContext:context];

    [self hideProgress];

    NSMutableArray* outputList = [NSMutableArray array];

    FLAction* action = [self createAction];
    [action actionDescription].actionType = FLActionTypeLoad;
    [action actionDescription].actionItemName = FLActionDescriptionItemNameGroup;
     
    [action addOperationWithBlock: ^(id operation){
        [self _loadRootGroupsFromCacheForDisplay:operation outputList:outputList];
        }];

    [self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) { 
        [self _didLoadFromCacheForDisplay:action outputList:outputList]; 
    }];
}

@end
#endif