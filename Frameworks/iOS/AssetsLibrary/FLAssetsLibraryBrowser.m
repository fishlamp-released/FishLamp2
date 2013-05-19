//
//  FLAssetLibraryBrowser.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
		_queue = FLRetain(queue);
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
    FLRelease(_locationManager);
	FLRelease(_groups);
	FLRelease(_processedAssets);
	FLRelease(_chosenAssets);
	FLRelease(_disabledAssets);
	FLRelease(_queue);
	FLSuperDealloc();
}

+ (FLAssetsLibraryBrowser*) assetsLibraryBrowser:(FLAssetQueue*) queue
{
	return FLAutorelease([[FLAssetsLibraryBrowser alloc] initWithAssetQueue:queue]);
}



- (void) didLoadTabBar:(UITabBar*) tabBar
{
	FLAssertIsNotNilWithComment(tabBar, nil);

	tabBar.items = [NSArray arrayWithObjects:
			FLAutorelease([[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"All Photos", nil) image:[UIImage imageNamed:@"image.png"] tag: 0]),
			FLAutorelease([[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Albums", nil) image:[UIImage imageNamed:@"images.png"] tag: 1]),
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
			controller = FLAutorelease([[FLAssetsLibraryAllAssetsBrowser alloc] initWithAssetQueue:_queue]);
			[self _setupViewController:controller];
		break;

		case 1:
			controller = FLAutorelease([[FLAssetsLibraryGroupBrowser alloc] initWithAssetQueue:_queue]);
			[self _setupViewController:controller];
		break;
	}
	
	controller.navigationItem.hidesBackButton = YES;
	controller.buttonbar.backButtonHidden = YES;
	
	return controller;
}

@end

