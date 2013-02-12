//
//  FLZenfolioLoadGroupOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioLoadGroupOperation.h"
#import "FLZenfolioLoadGroupsFromCacheOperation.h"

@implementation FLZenfolioLoadGroupOperation


- (void) _beginCheckGroupSyncStatus:(NSNumber*) groupID {

//	FLZenfolioLoadGroupsFromCacheOperation* operation =
//		[[FLZenfolioLoadGroupsFromCacheOperation alloc] initWithGroupId:groupId.intValue];
////			level:kZenfolioInformatonLevelFull
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
