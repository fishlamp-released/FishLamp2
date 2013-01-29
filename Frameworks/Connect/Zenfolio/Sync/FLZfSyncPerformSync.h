//
//	FLZfSyncPerformSync.h
//	MyZen
//
//	Created by Mike Fullerton on 8/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOrderedCollection.h"

#if 0
@protocol FLZfSyncPerformSyncDelegate;

@interface FLZfSyncPerformSync : FLZfSyncTask {
// for prep
	NSMutableArray* _prepareSyncList;
	NSMutableDictionary* _prepareSyncDictionary;

// for sync
	NSMutableArray* _photoSetSyncList;
	NSMutableArray* _groupSyncList;
	
	FLZfPhotoSet* _downloadingPhotoSet;
	
	NSUInteger _totalPhotoCount;
	NSUInteger _photoCount;

	NSInteger _currentPhotoIndex;
	
	BOOL _downloadLargeImages;

	FLOrderedCollection* _elementsToSync;
}

@property (readwrite, retain, nonatomic) FLOrderedCollection* elementsToSync;

@property (readwrite, assign, nonatomic) id<FLZfSyncPerformSyncDelegate> delegate;

@end

@protocol FLZfSyncPerformSyncDelegate <NSObject>

- (void) syncPerformSync:(FLZfSyncPerformSync*) syncTask	  
		  didDownloadPhoto:(FLZfPhoto*) photo
					 error:(NSError*) error;
					 
- (void) syncPerformSync:(FLZfSyncPerformSync*) syncTask 
	didFinishSync:(NSError*) error;

- (void) syncPerformSync:(FLZfSyncPerformSync*) syncTask 
	didUpdateGroupElement:(FLZfGroupElement*) group 
	error:(NSError*) error;
	
- (void) syncPerformSync:(FLZfSyncPerformSync*) syncTask 
	didAddGroupElement:(FLZfGroupElement*) element 
	error:(NSError*) error;
	
- (void) syncPerformSync:(FLZfSyncPerformSync*) syncTask 
	didRemoveGroupElement:(FLZfGroupElement*) element 
	error:(NSError*) error;

	
@end

#endif