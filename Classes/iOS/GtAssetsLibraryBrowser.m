//
//  GtAssetLibraryBrowser.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetsLibraryBrowser.h"
#import "GtAssetsLibraryGroupBrowser.h"
#import "GtAssetsLibraryAllAssetsBrowser.h"

@implementation GtAssetsLibraryBrowser

@synthesize delegate = m_delegate;
@synthesize assetQueue = m_queue;

- (id) initWithAssetQueue:(GtAssetQueue*) queue
{
	if((self = [super initWithNibName:nil bundle:nil]))
	{
		m_queue = GtRetain(queue);
		m_disabledAssets = [[NSMutableSet alloc] init];	
		m_chosenAssets = [[NSMutableDictionary alloc] init];
		m_processedAssets = [[NSMutableDictionary alloc] init];
		m_groups = [[NSMutableArray alloc] init];
		 
        m_locationManager = [[GtAssetsLibraryLocationManager alloc] init];
         
		for(GtQueuedAsset* asset in m_queue)
		{
			[m_disabledAssets addObject:asset.assetURL];
		}
	}
	
	return self;
}

- (void) dealloc
{
    GtRelease(m_locationManager);
	GtRelease(m_groups);
	GtRelease(m_processedAssets);
	GtRelease(m_chosenAssets);
	GtRelease(m_disabledAssets);
	GtRelease(m_queue);
	GtSuperDealloc();
}

+ (GtAssetsLibraryBrowser*) assetsLibraryBrowser:(GtAssetQueue*) queue
{
	return GtReturnAutoreleased([[GtAssetsLibraryBrowser alloc] initWithAssetQueue:queue]);
}



- (void) didLoadTabBar:(UITabBar*) tabBar
{
	GtAssertNotNil(tabBar);

	tabBar.items = [NSArray arrayWithObjects:
			GtReturnAutoreleased([[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"All Photos", nil) image:[UIImage imageNamed:@"image.png"] tag: 0]),
			GtReturnAutoreleased([[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Albums", nil) image:[UIImage imageNamed:@"images.png"] tag: 1]),
			nil];	
}

- (void) doneCallback:(id) sender
{
	[m_delegate assetsLibraryBrowser:self didChooseAssets:[m_chosenAssets allValues]]; 
}

- (void) _setupViewController:(GtAssetsLibraryBrowserBase*) controller
{
	controller.disabledAssets = m_disabledAssets;
	controller.chosenAssets = m_chosenAssets;
	controller.processedAssets = m_processedAssets;
	controller.groups = m_groups;
	controller.locationManager = m_locationManager;
    
	controller.doneCallback = GtCallbackMake(self, @selector(doneCallback:));
}

- (UIViewController*) createViewControllerForIndex:(NSUInteger) idx
{
	GtAssetsLibraryBrowserBase* controller = nil;
	switch(idx)
	{
		case 0:
			controller = GtReturnAutoreleased([[GtAssetsLibraryAllAssetsBrowser alloc] initWithAssetQueue:m_queue]);
			[self _setupViewController:controller];
		break;

		case 1:
			controller = GtReturnAutoreleased([[GtAssetsLibraryGroupBrowser alloc] initWithAssetQueue:m_queue]);
			[self _setupViewController:controller];
		break;
	}
	
	controller.navigationItem.hidesBackButton = YES;
	controller.buttonbar.backButtonHidden = YES;
	
	return controller;
}

@end

