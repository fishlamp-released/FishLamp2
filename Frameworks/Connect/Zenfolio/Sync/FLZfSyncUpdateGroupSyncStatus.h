//
//	FLZfSyncUpdateGroupSyncStatus.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "FLZfSyncTask.h"

@protocol FLZfSyncUpdateGroupSyncStatusDelegate;

@interface FLZfSyncUpdateGroupSyncStatus : FLZfSyncTask {
	NSMutableArray* _groupStack;
	NSMutableArray* _groupList;
	FLWeakReference* _delegate;

	int _rootGroupId;
	BOOL _checkGroups;
}

@property (readwrite, assign, nonatomic) id<FLZfSyncUpdateGroupSyncStatusDelegate> delegate;

- (void) configure:(NSArray*) groupIds checkGroups:(BOOL) checkGroups;

@end

@protocol FLZfSyncUpdateGroupSyncStatusDelegate <NSObject>

- (void) syncUpdateGroupSyncStatus:(FLZfSyncUpdateGroupSyncStatus*) syncTask 
	didUpdateGroup:(FLZfGroup*) group
	error:(NSError*) error;

- (void) syncUpdateGroupSyncStatus:(FLZfSyncUpdateGroupSyncStatus*) syncTask 
	didRemoveGroup:(NSNumber*) groupId
	error:(NSError*) error;

- (void) syncUpdateGroupSyncStatus:(FLZfSyncUpdateGroupSyncStatus*) syncTask 
	finishedUpdatingGroupList:(NSError*) error;

@end
#endif