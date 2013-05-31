//
//  FLAssetsLibraryBrowser.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>

#import "FLMultiColumnTableViewController.h"
#import "FLAssetQueue.h"
#import "FLLabel.h"
#import "FLAssetsLibrary.h"

#import "FLCallback_t.h"
#import "FLAssetsLibraryLocationManager.h"

//@protocol FLAssetsLibraryBrowserDelegate;

@interface FLAssetsLibraryBrowserBase : FLMultiColumnTableViewController {
@private
	FLCallback_t _doneCallback;
	FLCallback_t _cancelCallback;
	
	UIImage* _emptyCellImage;
	FLAssetQueue* _assetQueue;

	NSMutableSet* _disabledAssets;
	NSMutableDictionary* _chosenAssets;
	NSMutableDictionary* _processedAssets;
	NSArray* _groups;
	FLAssetsLibraryLocationManager* _locationManager;
    
	UIActivityIndicatorView* _spinner;
	FLLabel* _emptyMessage;
}

@property (readwrite, retain, nonatomic) FLAssetsLibraryLocationManager* locationManager;

@property (readwrite, retain, nonatomic) NSArray* groups;

@property (readonly, retain, nonatomic) FLAssetQueue* assetQueue;

@property (readwrite, assign, nonatomic) FLCallback_t doneCallback;
@property (readwrite, assign, nonatomic) FLCallback_t cancelCallback;

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