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

@synthesize delegate = _delegate;
@synthesize assetQueue = _queue;

- (id) initWithAssetQueue:(FLAssetQueue*) queue
{
	if((self = [super initWithNibName:nil bundle:nil]))
	{
		_queue = retain_(queue);
		_disabledAssets = [[NSMutableSet alloc] init];	
		_chosenAssets = [[NSMutableDictionary alloc] init];
		_processedAssets = [[NSMutableDictionary alloc] init];
		_groups = [[NSMutableArray alloc] init];
		 
        _locationManager = [[FLAssetsLibraryLocationManager alloc] init];
         
		for(FLQueuedAsset* asset in _queue)
		{
			[_disabledAssets addObject:asset.assetURL];
		}
	}
	
	return self;
}

- (void) dealloc
{
    release_(_locationManager);
	release_(_groups);
	release_(_processedAssets);
	release_(_chosenAssets);
	release_(_disabledAssets);
	release_(_queue);
	super_dealloc_();
}

+ (FLAssetsLibraryBrowser*) assetsLibraryBrowser:(FLAssetQueue*) queue
{
	return autorelease_([[FLAssetsLibraryBrowser alloc] initWithAssetQueue:queue]);
}



- (void) didLoadTabBar:(UITabBar*) tabBar
{
	FLAssertIsNotNil_v(tabBar, nil);

	tabBar.items = [NSArray arrayWithObjects:
			autorelease_([[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"All Photos", nil) image:[UIImage imageNamed:@"image.png"] tag: 0]),
			autorelease_([[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Albums", nil) image:[UIImage imageNamed:@"images.png"] tag: 1]),
			nil];	
}

- (void) doneCallback:(id) sender
{
	[_delegate assetsLibraryBrowser:self didChooseAssets:[_chosenAssets allValues]]; 
}

- (void) _setupViewController:(FLAssetsLibraryBrowserBase*) controller
{
	controller.disabledAssets = _disabledAssets;
	controller.chosenAssets = _chosenAssets;
	controller.processedAssets = _processedAssets;
	controller.groups = _groups;
	controller.locationManager = _locationManager;
    
	controller.doneCallback = FLCallbackMake(self, @selector(doneCallback:));
}

- (UIViewController*) createViewControllerForIndex:(NSUInteger) idx
{
	FLAssetsLibraryBrowserBase* controller = nil;
	switch(idx)
	{
		case 0:
			controller = autorelease_([[FLAssetsLibraryAllAssetsBrowser alloc] initWithAssetQueue:_queue]);
			[self _setupViewController:controller];
		break;

		case 1:
			controller = autorelease_([[FLAssetsLibraryGroupBrowser alloc] initWithAssetQueue:_queue]);
			[self _setupViewController:controller];
		break;
	}
	
	controller.navigationItem.hidesBackButton = YES;
	controller.buttonbar.backButtonHidden = YES;
	
	return controller;
}

@end

