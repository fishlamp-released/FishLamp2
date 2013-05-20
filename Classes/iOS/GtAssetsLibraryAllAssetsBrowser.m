//
//  GtAssetsLibraryAllAssetsBrowser.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetsLibraryAllAssetsBrowser.h"
#import "GtAssetsLibrary.h"
#import "UIDevice+GtExtras.h"

@implementation GtAssetsLibraryAllAssetsBrowser

- (id) initWithAssetQueue:(GtAssetQueue*) queue
{
	if((self = [super initWithAssetQueue:queue]))
	{
		self.title = NSLocalizedString(@"All Photos", nil);
	}
	
	return self;
}

- (GtViewContentsDescriptor) describeViewContents
{
	GtViewContentsDescriptor desc = [super describeViewContents];
	desc.bottom = GtViewContentItemTabBar;
	return desc;
}

- (void) _showEmptyMessage
{
    [self showEmptyMessage:[NSString stringWithFormat:(NSLocalizedString(@"Your %@ has no photos on it.", nil)), [UIDevice currentDevice].deviceDisplayName]];
}

- (void) _beginLoadingAssets
{
	[self startSpinner];

	[[GtAssetsLibrary instance] beginLoadingAssetsForGroups:self.groups assetFilter:GtAssetsLibraryFilterPhotosOnly doneBlock:^(NSArray* assets, NSError* error){
		
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
			[[GtAssetsLibrary instance] beginLoadingGroups:^(NSArray* groups, NSError* error) {
				
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
