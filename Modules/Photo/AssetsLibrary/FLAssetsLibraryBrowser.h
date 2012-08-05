//
//  FLAssetLibraryBrowser.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
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
	FLAssetQueue* m_queue;
	NSMutableSet* m_disabledAssets;
	NSMutableDictionary* m_chosenAssets;
	NSMutableDictionary* m_processedAssets;
	NSMutableArray* m_groups;
	
	id<FLAssetsLibraryBrowserDelegate> m_delegate;
    
    FLAssetsLibraryLocationManager* m_locationManager;
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

