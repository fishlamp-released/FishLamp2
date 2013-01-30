//
//	FLZenfolioSyncUpdateGroupSyncStatus.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "FLZenfolioSyncTask.h"

@protocol FLZenfolioSyncUpdateGroupSyncStatusDelegate;

@interface FLZenfolioSyncUpdateGroupSyncStatus : FLZenfolioSyncTask {
	NSMutableArray* _groupStack;
	NSMutableArray* _groupList;
	FLWeakReference* _delegate;

	int _rootGroupId;
	BOOL _checkGroups;
}

@property (readwrite, assign, nonatomic) id<FLZenfolioSyncUpdateGroupSyncStatusDelegate> delegate;

- (void) configure:(NSArray*) groupIds checkGroups:(BOOL) checkGroups;

@end

@protocol FLZenfolioSyncUpdateGroupSyncStatusDelegate <NSObject>

- (void) syncUpdateGroupSyncStatus:(FLZenfolioSyncUpdateGroupSyncStatus*) syncTask 
	didUpdateGroup:(FLZenfolioGroup*) group
	error:(NSError*) error;

- (void) syncUpdateGroupSyncStatus:(FLZenfolioSyncUpdateGroupSyncStatus*) syncTask 
	didRemoveGroup:(NSNumber*) groupId
	error:(NSError*) error;

- (void) syncUpdateGroupSyncStatus:(FLZenfolioSyncUpdateGroupSyncStatus*) syncTask 
	finishedUpdatingGroupList:(NSError*) error;

@end
#endif