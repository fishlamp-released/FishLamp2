//
//	ZFSyncPerformSync.h
//	MyZen
//
//	Created by Mike Fullerton on 8/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOrderedCollection.h"

#if 0
@protocol ZFSyncPerformSyncDelegate;

@interface ZFSyncPerformSync : ZFSyncTask {
// for prep
	NSMutableArray* _prepareSyncList;
	NSMutableDictionary* _prepareSyncDictionary;

// for sync
	NSMutableArray* _photoSetSyncList;
	NSMutableArray* _groupSyncList;
	
	ZFPhotoSet* _downloadingPhotoSet;
	
	NSUInteger _totalPhotoCount;
	NSUInteger _photoCount;

	NSInteger _currentPhotoIndex;
	
	BOOL _downloadLargeImages;

	FLOrderedCollection* _elementsToSync;
}

@property (readwrite, retain, nonatomic) FLOrderedCollection* elementsToSync;

@property (readwrite, assign, nonatomic) id<ZFSyncPerformSyncDelegate> delegate;

@end

@protocol ZFSyncPerformSyncDelegate <NSObject>

- (void) syncPerformSync:(ZFSyncPerformSync*) syncTask	  
		  didDownloadPhoto:(ZFPhoto*) photo
					 error:(NSError*) error;
					 
- (void) syncPerformSync:(ZFSyncPerformSync*) syncTask 
	didFinishSync:(NSError*) error;

- (void) syncPerformSync:(ZFSyncPerformSync*) syncTask 
	didUpdateGroupElement:(ZFGroupElement*) group 
	error:(NSError*) error;
	
- (void) syncPerformSync:(ZFSyncPerformSync*) syncTask 
	didAddGroupElement:(ZFGroupElement*) element 
	error:(NSError*) error;
	
- (void) syncPerformSync:(ZFSyncPerformSync*) syncTask 
	didRemoveGroupElement:(ZFGroupElement*) element 
	error:(NSError*) error;

	
@end

#endif