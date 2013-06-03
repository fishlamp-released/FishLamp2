//
//  FLAssetsLibraryAllAssetsBrowser.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAssetsLibraryAllAssetsBrowser.h"
#import "FLAssetsLibrary.h"
#import "UIDevice+FLExtras.h"

@implementation FLAssetsLibraryAllAssetsBrowser

- (id) initWithAssetQueue:(FLAssetQueue*) queue
{
	if((self = [super initWithAssetQueue:queue]))
	{
		self.title = NSLocalizedString(@"All Photos", nil);
	
        self.viewContentsDescriptor = [FLViewContentsDescriptor descriptorWithTopStatusAndToolbarAndBottomTabBar];
    }
	
	return self;
}

- (void) _showEmptyMessage
{
    [self showEmptyMessage:[NSString stringWithFormat:(NSLocalizedString(@"Your %@ has no photos on it.", nil)), [UIDevice currentDevice].deviceDisplayName]];
}

- (void) _beginLoadingAssets
{
	[self startSpinner];

	[[FLAssetsLibrary instance] beginLoadingAssetsForGroups:self.groups assetFilter:FLAssetsLibraryFilterPhotosOnly doneBlock:^(NSArray* assets, NSError* error){
		
		self.assets = assets;
	
		[self stopSpinner];
		[self.tableView reloadData];
		
		if(self.assets.count == 0)
		{
			[self _showEmptyMessage];
		}
		
		self.title = [NSString stringWithFormat:(NSLocalizedString(@"All Photos (%d)", nil)), self.assets.count];

	}
	shouldCancel:^{ return NO; }];
}

- (void) beginLoadingAssets
{
	if(!self.assets || self.assets.count == 0)
	{
		if(self.groups.count == 0)
		{
			[self startSpinner];
			[[FLAssetsLibrary instance] beginLoadingGroups:^(NSArray* groups, NSError* error) {
				
				self.groups = groups;
			
                if(self.groups.count == 0)
                {
                    [self _showEmptyMessage];
                }
            
				[self stopSpinner];
				if(!error && self.groups.count > 0)
				{
					[self _beginLoadingAssets];
				}
			}
			shouldCancel:^{ return NO; }];
		}
		else
		{
			[self _beginLoadingAssets];
		}
	
	}
}

@end
