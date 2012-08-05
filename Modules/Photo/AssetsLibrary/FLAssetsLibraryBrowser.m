//
//  FLAssetLibraryBrowser.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLAssetsLibraryBrowser.h"
#import "FLAssetsLibraryGroupBrowser.h"
#import "FLAssetsLibraryAllAssetsBrowser.h"

@implementation FLAssetsLibraryBrowser

@synthesize delegate = m_delegate;
@synthesize assetQueue = m_queue;

- (id) initWithAssetQueue:(FLAssetQueue*) queue
{
	if((self = [super initWithNibName:nil bundle:nil]))
	{
		m_queue = FLReturnRetained(queue);
		m_disabledAssets = [[NSMutableSet alloc] init];	
		m_chosenAssets = [[NSMutableDictionary alloc] init];
		m_processedAssets = [[NSMutableDictionary alloc] init];
		m_groups = [[NSMutableArray alloc] init];
		 
        m_locationManager = [[FLAssetsLibraryLocationManager alloc] init];
         
		for(FLQueuedAsset* asset in m_queue)
		{
			[m_disabledAssets addObject:asset.assetURL];
		}
	}
	
	return self;
}

- (void) dealloc
{
    FLRelease(m_locationManager);
	FLRelease(m_groups);
	FLRelease(m_processedAssets);
	FLRelease(m_chosenAssets);
	FLRelease(m_disabledAssets);
	FLRelease(m_queue);
	FLSuperDealloc();
}

+ (FLAssetsLibraryBrowser*) assetsLibraryBrowser:(FLAssetQueue*) queue
{
	return FLReturnAutoreleased([[FLAssetsLibraryBrowser alloc] initWithAssetQueue:queue]);
}



- (void) didLoadTabBar:(UITabBar*) tabBar
{
	FLAssertIsNotNil(tabBar);

	tabBar.items = [NSArray arrayWithObjects:
			FLReturnAutoreleased([[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"All Photos", nil) image:[UIImage imageNamed:@"image.png"] tag: 0]),
			FLReturnAutoreleased([[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Albums", nil) image:[UIImage imageNamed:@"images.png"] tag: 1]),
			nil];	
}

- (void) doneCallback:(id) sender
{
	[m_delegate assetsLibraryBrowser:self didChooseAssets:[m_chosenAssets allValues]]; 
}

- (void) _setupViewController:(FLAssetsLibraryBrowserBase*) controller
{
	controller.disabledAssets = m_disabledAssets;
	controller.chosenAssets = m_chosenAssets;
	controller.processedAssets = m_processedAssets;
	controller.groups = m_groups;
	controller.locationManager = m_locationManager;
    
	controller.doneCallback = FLCallbackMake(self, @selector(doneCallback:));
}

- (UIViewController*) createViewControllerForIndex:(NSUInteger) idx
{
	FLAssetsLibraryBrowserBase* controller = nil;
	switch(idx)
	{
		case 0:
			controller = FLReturnAutoreleased([[FLAssetsLibraryAllAssetsBrowser alloc] initWithAssetQueue:m_queue]);
			[self _setupViewController:controller];
		break;

		case 1:
			controller = FLReturnAutoreleased([[FLAssetsLibraryGroupBrowser alloc] initWithAssetQueue:m_queue]);
			[self _setupViewController:controller];
		break;
	}
	
	controller.navigationItem.hidesBackButton = YES;
	controller.buttonbar.backButtonHidden = YES;
	
	return controller;
}

@end

