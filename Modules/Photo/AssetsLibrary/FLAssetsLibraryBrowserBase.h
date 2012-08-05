//
//  FLAssetsLibraryBrowser.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>

#import "FLMultiColumnTableViewController.h"
#import "FLAssetQueue.h"
#import "FLLabel.h"
#import "FLAssetsLibrary.h"

#import "FLCallback.h"
#import "FLAssetsLibraryLocationManager.h"

//@protocol FLAssetsLibraryBrowserDelegate;

@interface FLAssetsLibraryBrowserBase : FLMultiColumnTableViewController {
@private
	FLCallback m_doneCallback;
	FLCallback m_cancelCallback;
	
	UIImage* m_emptyCellImage;
	FLAssetQueue* m_assetQueue;

	NSMutableSet* m_disabledAssets;
	NSMutableDictionary* m_chosenAssets;
	NSMutableDictionary* m_processedAssets;
	NSArray* m_groups;
	FLAssetsLibraryLocationManager* m_locationManager;
    
	UIActivityIndicatorView* m_spinner;
	FLLabel* m_emptyMessage;
}

@property (readwrite, retain, nonatomic) FLAssetsLibraryLocationManager* locationManager;

@property (readwrite, retain, nonatomic) NSArray* groups;

@property (readonly, retain, nonatomic) FLAssetQueue* assetQueue;

@property (readwrite, assign, nonatomic) FLCallback doneCallback;
@property (readwrite, assign, nonatomic) FLCallback cancelCallback;

@property (readwrite, retain, nonatomic) NSMutableDictionary* chosenAssets; // keys are URLs.

@property (readwrite, retain, nonatomic) NSMutableSet* disabledAssets;

@property (readwrite, retain, nonatomic) NSMutableDictionary* processedAssets;

@property (readwrite, retain, nonatomic) UIImage* emptyCellImage;

- (id) initWithAssetQueue:(FLAssetQueue*) queue;

- (void) assetsLibraryDidChange:(NSNotification*) notification;

- (void) startSpinner;
- (void) stopSpinner;

- (void) showPermissionDeniedMessage;
- (void) showEmptyMessage:(NSString*) message;
- (void) hideEmptyMessage;

- (void) updateSubtitle;

- (BOOL) canAddAsset:(NSString *) assetURL;

- (void) addAllFromGroup:(ALAssetsGroup*) group assetFilter:(FLAssetsLibraryFilter) filter;
- (void) addAssetIfNotInQueueOrUploaded:(ALAsset*) asset;

- (void) beginCheckingLocationPermissions;
- (void) didCheckLocationPermissions; // override point

@end
//
//@protocol FLAssetsLibraryBrowserDelegate <NSObject> 
//
//- (void) assetsLibraryController:(FLAssetsLibraryBrowser*) controller didAddAssets:(NSArray*) newAssets;
//
//- (void) assetsLibraryControllerWasCancelled:(FLAssetsLibraryBrowser*) controller;
//	
//@end