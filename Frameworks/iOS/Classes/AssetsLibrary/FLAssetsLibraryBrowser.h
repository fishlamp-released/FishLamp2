//
//  FLAssetLibraryBrowser.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTabBarController.h"
#import "FLAssetQueue.h"
#import "FLAssetsLibraryLocationManager.h"

#if DEBUG

#ifdef ASSETS_LIBRARY_ERROR_ALERT 
#undef ASSETS_LIBRARY_ERROR_ALERT
#endif

#define ASSETS_LIBRARY_ERROR_ALERT 1
#endif

@protocol FLAssetsLibraryBrowserDelegate;


@interface FLAssetsLibraryBrowser : FLTabBarController<CLLocationManagerDelegate> {
@private
	FLAssetQueue* _queue;
	NSMutableSet* _disabledAssets;
	NSMutableDictionary* _chosenAssets;
	NSMutableDictionary* _processedAssets;
	NSMutableArray* _groups;
	
	__unsafe_unretained id<FLAssetsLibraryBrowserDelegate> _delegate;
    
    FLAssetsLibraryLocationManager* _locationManager;
}

@property (readonly, retain, nonatomic) FLAssetQueue* assetQueue;

@property (readwrite, assign, nonatomic) id<FLAssetsLibraryBrowserDelegate> delegate; 

- (id) initWithAssetQueue:(FLAssetQueue*) queue;

+ (FLAssetsLibraryBrowser*) assetsLibraryBrowser:(FLAssetQueue*) queue;

@end

@protocol FLAssetsLibraryBrowserDelegate <NSObject>
- (void) assetsLibraryBrowser:(FLAssetsLibraryBrowser*) browser didChooseAssets:(NSArray*) assets;
- (void) assetsLibraryBrowserWasCancelled:(FLAssetsLibraryBrowser*) browser;
@end

