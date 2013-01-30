//
//	FLZenfolioSyncPerformSync.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOrderedCollection.h"

#if 0
@protocol FLZenfolioSyncPerformSyncDelegate;

@interface FLZenfolioSyncPerformSync : FLZenfolioSyncTask {
// for prep
	NSMutableArray* _prepareSyncList;
	NSMutableDictionary* _prepareSyncDictionary;

// for sync
	NSMutableArray* _photoSetSyncList;
	NSMutableArray* _groupSyncList;
	
	FLZenfolioPhotoSet* _downloadingPhotoSet;
	
	NSUInteger _totalPhotoCount;
	NSUInteger _photoCount;

	NSInteger _currentPhotoIndex;
	
	BOOL _downloadLargeImages;

	FLOrderedCollection* _elementsToSync;
}

@property (readwrite, retain, nonatomic) FLOrderedCollection* elementsToSync;

@property (readwrite, assign, nonatomic) id<FLZenfolioSyncPerformSyncDelegate> delegate;

@end

@protocol FLZenfolioSyncPerformSyncDelegate <NSObject>

- (void) syncPerformSync:(FLZenfolioSyncPerformSync*) syncTask	  
		  didDownloadPhoto:(FLZenfolioPhoto*) photo
					 error:(NSError*) error;
					 
- (void) syncPerformSync:(FLZenfolioSyncPerformSync*) syncTask 
	didFinishSync:(NSError*) error;

- (void) syncPerformSync:(FLZenfolioSyncPerformSync*) syncTask 
	didUpdateGroupElement:(FLZenfolioGroupElement*) group 
	error:(NSError*) error;
	
- (void) syncPerformSync:(FLZenfolioSyncPerformSync*) syncTask 
	didAddGroupElement:(FLZenfolioGroupElement*) element 
	error:(NSError*) error;
	
- (void) syncPerformSync:(FLZenfolioSyncPerformSync*) syncTask 
	didRemoveGroupElement:(FLZenfolioGroupElement*) element 
	error:(NSError*) error;

	
@end

#endif