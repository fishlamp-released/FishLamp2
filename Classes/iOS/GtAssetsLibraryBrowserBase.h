//
//  GtAssetsLibraryBrowser.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>

#import "GtMultiColumnTableViewController.h"
#import "GtAssetQueue.h"
#import "GtLabel.h"
#import "GtAssetsLibrary.h"

#import "GtCallback.h"
#import "GtAssetsLibraryLocationManager.h"

//@protocol GtAssetsLibraryBrowserDelegate;

@interface GtAssetsLibraryBrowserBase : GtMultiColumnTableViewController {
@private
	GtCallback m_doneCallback;
	GtCallback m_cancelCallback;
	
	UIImage* m_emptyCellImage;
	GtAssetQueue* m_assetQueue;

	NSMutableSet* m_disabledAssets;
	NSMutableDictionary* m_chosenAssets;
	NSMutableDictionary* m_processedAssets;
	NSArray* m_groups;
	GtAssetsLibraryLocationManager* m_locationManager;
    
	UIActivityIndicatorView* m_spinner;
	GtLabel* m_emptyMessage;
}

@property (readwrite, retain, nonatomic) GtAssetsLibraryLocationManager* locationManager;

@property (readwrite, retain, nonatomic) NSArray* groups;

@property (readonly, retain, nonatomic) GtAssetQueue* assetQueue;

@property (readwrite, assign, nonatomic) GtCallback doneCallback;
@property (readwrite, assign, nonatomic) GtCallback cancelCallback;

@property (readwrite, retain, nonatomic) NSMutableDictionary* chosenAssets; // keys are URLs.

@property (readwrite, retain, nonatomic) NSMutableSet* disabledAssets;

@property (readwrite, retain, nonatomic) NSMutableDictionary* processedAssets;

@property (readwrite, retain, nonatomic) UIImage* emptyCellImage;

- (id) initWithAssetQueue:(GtAssetQueue*) queue;

- (void) assetsLibraryDidChange:(NSNotification*) notification;

- (void) startSpinner;
- (void) stopSpinner;

- (void) showPermissionDeniedMessage;
- (void) showEmptyMessage:(NSString*) message;
- (void) hideEmptyMessage;

- (void) updateSubtitle;

- (BOOL) canAddAsset:(NSString *) assetURL;

- (void) addAllFromGroup:(ALAssetsGroup*) group assetFilter:(GtAssetsLibraryFilter) filter;
- (void) addAssetIfNotInQueueOrUploaded:(ALAsset*) asset;

- (void) beginCheckingLocationPermissions;
- (void) didCheckLocationPermissions; // override point

@end
//
//@protocol GtAssetsLibraryBrowserDelegate <NSObject> 
//
//- (void) assetsLibraryController:(GtAssetsLibraryBrowser*) controller didAddAssets:(NSArray*) newAssets;
//
//- (void) assetsLibraryControllerWasCancelled:(GtAssetsLibraryBrowser*) controller;
//	
//@end