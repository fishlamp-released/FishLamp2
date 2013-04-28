//
//	ZFSyncUpdateGroupSyncStatus.m
//	MyZen
//
//	Created by Mike Fullerton on 8/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#if REFACTOR

#import "ZFSyncUpdateGroupSyncStatus.h"


#if DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@interface ZFSyncUpdateGroupSyncStatus (Private)
- (void) _syncNextRootGroup;
- (void) _beginCheckGroupSyncStatus:(int) groupId ;
@end

@implementation ZFSyncUpdateGroupSyncStatus

- (id) delegate
{
	return _delegate.object;
}

- (void) setDelegate:(id<ZFSyncUpdateGroupSyncStatusDelegate>) delegate
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

- (BOOL) _walkTreeAndCheckStatusForGroup:(ZFGroup*) group operation:(FLSynchronousOperation*) operation
{
	
#if LOG
	FLLog(@"Syncing Status for group: %@", group.Title);
#endif
	
	BOOL didFindUnsyncedChild = NO;
	   
	NSMutableArray* array = group.Elements;
	for(ZFGroupElement* elementInGroupList in array)
	{
		FLThrowIfCancelled(self);;
		
		BOOL takeSubElementToGo = [[ZFSyncService instance] doTakeElementToGo:elementInGroupList parentId:group.Id];
		
		FLThrowIfCancelled(self);;
		
		if(elementInGroupList.isGroupElement)
		{ 
			ZFGroup* cachedGroup = [ZFGroup loadFromCacheWithId:elementInGroupList.IdValue];
			if(cachedGroup)
			{				 
				if( takeSubElementToGo &&
					(![cachedGroup.ModifiedOn isEqual:elementInGroupList.ModifiedOn] ||
					cachedGroup.TextCnValue != ((ZFGroup*)elementInGroupList).TextCnValue))
				{
					ZFSyncState* state = [[ZFSyncService instance] syncStateForGroupElementId:cachedGroup.Id];
					state.isSyncedValue = NO;
				   [[ZFSyncService instance] saveSyncState:state];
				   
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
				ZFSyncState* state = [[ZFSyncService instance] syncStateForGroupElementId:elementInGroupList.Id];
				state.isSyncedValue = NO;
				[[ZFSyncService instance] saveSyncState:state];

				didFindUnsyncedChild = YES;
			}
		}
		else if(takeSubElementToGo)
		{
			ZFPhotoSet* photoSet = [[[self.context photoSetStorage] loadPhotoSetWithID:elementInGroupList.IdValue];
			if(photoSet)
			{
				if( photoSet.PhotoListCnValue != ((ZFPhotoSet*) elementInGroupList).PhotoListCnValue ||
					photoSet.TextCnValue != ((ZFPhotoSet*) elementInGroupList).TextCnValue )
				{
					ZFSyncState* state = [[ZFSyncService instance] syncStateForGroupElementId:photoSet.Id];
					state.isSyncedValue = NO;
					[[ZFSyncService instance] saveSyncState:state];
					didFindUnsyncedChild = YES;
				}
			}
			else
			{
				ZFSyncState* state = [[ZFSyncService instance] syncStateForGroupElementId:elementInGroupList.Id];
				state.isSyncedValue = NO;
				[[ZFSyncService instance] saveSyncState:state];
				didFindUnsyncedChild = YES;
			}
		}

		if(didFindUnsyncedChild)
		{
			ZFSyncState* state = [[ZFSyncService instance] syncStateForGroupElementId:group.Id];
			state.isSyncedValue = NO;
			[[ZFSyncService instance] saveSyncState:state];
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
		ZFGroup* group = [[action lastOperation] operationOutput];
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

- (void) _updateToGoStatus:(FLSynchronousOperation*) operation
{
#if FL_MRC
	FLPerformBlockInAutoreleasePool(^{
#endif    
		ZFGroup* rootGroup = [ZFGroup loadFromCacheWithId:_rootGroupId];
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

        [self.actionContext startAction:action completion: ^(FLPromisedResult result) {
            [self _didFinishUpdating:action];
        }];
	}
	return NO;
}

- (void) _addToGroupStackIfInCache:(ZFGroup*) group 
{
	ZFGroup* cachedGroup = [ZFGroup loadFromCacheWithId:group.IdValue];
	if(cachedGroup)
	{
		[_groupStack addObject:group.Id];
	}
}

- (void) _gotGroup:(ZFGroup*) newGroup
{
	[self.delegate syncUpdateGroupSyncStatus:self didUpdateGroup:newGroup error:nil];
}

- (void) _onGroupLoadedForSyncStatus:(FLAction*) action groupId:(int) groupId
{
	if(action.didSucceed)
	{
		ZFGroup* newGroup = [[action lastOperation] operationOutput];
		
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
		
		[[ZFSyncService instance] removeElementById:groupElement];
		[self.delegate syncUpdateGroupSyncStatus:self didRemoveGroup:groupElement error:nil];
		[self _beginDownloadingNextGroupInGroupStack];
	}
	else
	{
		[self _notifyDone:[action error]];
	}
}

- (void) _didLoadGroupFromCache:(ZFLoadGroupFromCacheOperation*) operation {
	if(operation.didSucceed && _checkGroups) {
		ZFGroup* newGroup = operation.output;
		
		NSMutableArray* array = newGroup.Elements;
		for(ZFGroupElement* element in array)
		{
			if(element.isGroupElement)
			{
				[self _addToGroupStackIfInCache:(ZFGroup*)element];
			}
		}
	}
}

- (void) _beginCheckGroupSyncStatus:(int) groupId {
	FLAction* action = [self createAction];
	
	action.actionDescription.actionType = FLActionTypeSync;
	action.actionDescription.actionItemName = FLActionDescriptionItemNameGroup;
		
	ZFLoadGroupFromCacheOperation* operation = 
		[[ZFLoadGroupFromCacheOperation alloc] initWithGroupId:groupId];
//			level:kZenfolioInformatonLevelFull
//			includeChildren:YES];
	operation.cache = [[self.context userStorageService].cacheDatabase;
	operation.canLoadFromCache = YES;
	operation.canSaveToCache = YES;
	operation.alwaysRunSubOperations = YES;	 
    operation.willStartBlock = ^(id theOperation) { [self _didLoadGroupFromCache:theOperation]; };  
//	[operation setDidPerformCallback:self action:@selector(_didLoadGroupFromCache:)];
	[action addOperation:operation];
	FLRelease(operation);

	[self.actionContext startAction:action completion: ^(FLPromisedResult result) {
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
		for(ZFGroup* group in outputList)
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
		
		ZFGroup* group = [ZFGroup loadFromCacheWithId:idObject.intValue];
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

    [self.actionContext startAction:action completion: ^(FLPromisedResult result) { 
        [self _didLoadFromCacheForDisplay:action outputList:outputList]; 
    }];
}

@end
#endif