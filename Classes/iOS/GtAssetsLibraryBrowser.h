//
//  GtAssetLibraryBrowser.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTabBarController.h"
#import "GtAssetQueue.h"
#import "GtAssetsLibraryLocationManager.h"

#if DEBUG

#ifdef ASSETS_LIBRARY_ERROR_ALERT 
#undef ASSETS_LIBRARY_ERROR_ALERT
#endif

#define ASSETS_LIBRARY_ERROR_ALERT 1
#endif

@protocol GtAssetsLibraryBrowserDelegate;


@interface GtAssetsLibraryBrowser : GtTabBarController<CLLocationManagerDelegate> {
@private
	GtAssetQueue* m_queue;
	NSMutableSet* m_disabledAssets;
	NSMutableDictionary* m_chosenAssets;
	NSMutableDictionary* m_processedAssets;
	NSMutableArray* m_groups;
	
	id<GtAssetsLibraryBrowserDelegate> m_delegate;
    
    GtAssetsLibraryLocationManager* m_locationManager;
}

@property (readonly, retain, nonatomic) GtAssetQueue* assetQueue;

@property (readwrite, assign, nonatomic) id<GtAssetsLibraryBrowserDelegate> delegate; 

- (id) initWithAssetQueue:(GtAssetQueue*) queue;

+ (GtAssetsLibraryBrowser*) assetsLibraryBrowser:(GtAssetQueue*) queue;

@end

@protocol GtAssetsLibraryBrowserDelegate <NSObject>
- (void) assetsLibraryBrowser:(GtAssetsLibraryBrowser*) browser didChooseAssets:(NSArray*) assets;
- (void) assetsLibraryBrowserWasCancelled:(GtAssetsLibraryBrowser*) browser;
@end

