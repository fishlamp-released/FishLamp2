//
//  ZFLoadGroupOperation.m
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFLoadGroupOperation.h"
#import "ZFLoadGroupsFromCacheOperation.h"

@implementation ZFLoadGroupOperation


- (void) _beginCheckGroupSyncStatus:(NSNumber*) groupID {

//	ZFLoadGroupsFromCacheOperation* operation =
//		[[ZFLoadGroupsFromCacheOperation alloc] initWithGroupId:groupId.intValue];
////			level:kZfInformatonLevelFull
////			includeChildren:YES];
//	operation.cache = [[self.context userStorageService].cacheDatabase;
//	operation.canLoadFromCache = YES;
//	operation.canSaveToCache = YES;
//	operation.alwaysRunSubOperations = YES;	 
//    operation.willStartBlock = ^(id theOperation) { [self _didLoadGroupFromCache:theOperation]; };  
////	[operation setDidPerformCallback:self action:@selector(_didLoadGroupFromCache:)];
//	[action addOperation:operation];
//	FLRelease(operation);
//
//	[self.actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
//        [self _onGroupLoadedForSyncStatus:action groupId:groupId];
//    }];

}

@end
