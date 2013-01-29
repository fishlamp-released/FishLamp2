//
//	ZFSyncUpdateGroupSyncStatus.h
//	MyZen
//
//	Created by Mike Fullerton on 8/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "ZFSyncTask.h"

@protocol ZFSyncUpdateGroupSyncStatusDelegate;

@interface ZFSyncUpdateGroupSyncStatus : ZFSyncTask {
	NSMutableArray* _groupStack;
	NSMutableArray* _groupList;
	FLWeakReference* _delegate;

	int _rootGroupId;
	BOOL _checkGroups;
}

@property (readwrite, assign, nonatomic) id<ZFSyncUpdateGroupSyncStatusDelegate> delegate;

- (void) configure:(NSArray*) groupIds checkGroups:(BOOL) checkGroups;

@end

@protocol ZFSyncUpdateGroupSyncStatusDelegate <NSObject>

- (void) syncUpdateGroupSyncStatus:(ZFSyncUpdateGroupSyncStatus*) syncTask 
	didUpdateGroup:(ZFGroup*) group
	error:(NSError*) error;

- (void) syncUpdateGroupSyncStatus:(ZFSyncUpdateGroupSyncStatus*) syncTask 
	didRemoveGroup:(NSNumber*) groupId
	error:(NSError*) error;

- (void) syncUpdateGroupSyncStatus:(ZFSyncUpdateGroupSyncStatus*) syncTask 
	finishedUpdatingGroupList:(NSError*) error;

@end
#endif