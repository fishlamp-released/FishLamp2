//
//	GtAssetsLibraryPhotoBrowserController.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetsLibraryPhotoBrowserController.h"
#import "GtImageAssetCellWidget.h"
#import "GtAssetsLibraryImageAsset.h"
#import "GtGradientButton.h"
#import "GtThemeManager.h"
#import "GtAssetsLibrary.h"
#import "GtTableViewBatchSelectorView.h"
#import "GtMenuInHoverViewController.h"
#import "GtNavigationControllerViewController.h"
#import "GtHoverViewController.h"

#import "GtNotificationView.h"

#import "UIImage+GtColorize.h"

#import "UIColor+GtMoreColors.h"

@implementation GtAssetsLibraryPhotoBrowserController

@synthesize assets = m_assets;
@synthesize group = m_group;

- (id) initWithAssetQueue:(GtAssetQueue*) queue  withGroup:(ALAssetsGroup*) group
{
	if((self = [self initWithAssetQueue:queue]))
	{
		self.group = group;
		self.title = [group valueForProperty:ALAssetsGroupPropertyName];
	}
	
	return self;
}

- (id) initWithAssetQueue:(GtAssetQueue*) queue
{
	if((self = [super initWithAssetQueue:queue]))
	{
		if(DeviceIsPad())
		{
			self.maxPortaitColumns = 6;
			self.maxLandscapeColumns = 10;
		}
		else
		{
			self.maxPortaitColumns = 4;
			self.maxLandscapeColumns = 6;
		}
	}
	
	return self;
}

- (void) dealloc
{
    GtRelease(m_notificationView);
	GtRelease(m_assets);
	GtRelease(m_group);
	GtSuperDealloc();
}

- (void) _hideNotification
{
    if(m_notificationView)
    {
        [m_notificationView removeFromSuperviewWithAnimationType:GtViewAnimationTypeSlideFromTop duration:0.3 finishedBlock:nil];
        GtReleaseWithNil(m_notificationView);
    }
}


- (void) _showNotification:(NSString*) title
{
    [self _hideNotification];
    
    m_notificationView = [[UIView alloc] initWithFrame:
        CGRectMake(0,GtRectGetBottom(self.navigationController.navigationBar.frame),self.view.bounds.size.width, 30)];
    m_notificationView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    m_notificationView.autoresizesSubviews = YES;
    m_notificationView.backgroundColor = [UIColor blackColor];
    m_notificationView.alpha = 0.7;
    m_notificationView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    m_notificationView.layer.borderWidth = 1.0f;
    
    UILabel* label = GtReturnAutoreleased([[UILabel alloc] initWithFrame:m_notificationView.bounds]);
    label.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    label.textColor = [UIColor amberColor ];
    label.shadowColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = title;
    [m_notificationView addSubview:label];
    [self.view addSubview:m_notificationView];
    [m_notificationView animateOntoScreen:GtViewAnimationTypeSlideFromTop duration:0.3 finishedBlock:nil];
}

- (void) _cancelRangeSelect
{
    m_rangedSelectedCount = 0;
    m_rangeSelectMode = NO;
    m_rangeStartIndex = 0;
    [self _hideNotification];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.locationManager cancelPermissionsCheck];
    [self _cancelRangeSelect];
}

- (BOOL) imageAssetCellWidgetIsDisabled:(GtImageAssetCellWidget*) widget
{
	return [self.disabledAssets containsObject:widget.asset.assetURL.absoluteString];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return DeviceIsPad() ? 128 : 76;
}

+ (GtAssetsLibraryPhotoBrowserController*) assetsLibraryPhotoBrowserController:(GtAssetQueue*) assetsQueue  withGroup:(ALAssetsGroup*) group
{
	return GtReturnAutoreleased([[GtAssetsLibraryPhotoBrowserController alloc] initWithAssetQueue:assetsQueue withGroup:group]);
}

- (NSUInteger) numberOfDataItems
{
	return m_assets.count;
}

- (void) updateWidget:(GtImageAssetCellWidget*) widget forDataItemIndex:(NSUInteger) itemIndex
{
	widget.asset = [m_assets objectAtIndex:itemIndex];
	GtAssertNotNil(widget.asset);
	
	[widget setAssetIndex:itemIndex + 1]; // display indexes are 1 based
}

- (void) imageAssetCellWidgetWasSelected:(GtImageAssetCellWidget*) widget
{
	if(m_rangeSelectMode)
    {
        if(m_rangedSelectedCount == 0)
        {
            ++m_rangedSelectedCount;
            m_rangeStartIndex = widget.assetIndex - 1; // display indexes are 1 based
    
        	[self.chosenAssets setObject:widget.asset forKey:widget.asset.assetURL];
            [widget updateState];
        
            [self _showNotification:NSLocalizedString(@"Select last photo in range", nil)];
        }
        else 
        {
            NSUInteger rangeStopIndex = widget.assetIndex - 1;
        
            NSUInteger low = MIN(rangeStopIndex, m_rangeStartIndex);
            NSUInteger high = MAX(rangeStopIndex, m_rangeStartIndex);
            
            for(NSUInteger i = low; i <= high; i++)
            {
                id<GtAsset> asset = [m_assets objectAtIndex:i];
                
                if([self canAddAsset:[asset assetURL].absoluteString])
                {
                    [self.chosenAssets setObject:asset forKey:[asset assetURL]];
                }
#if DEBUG
                else
                {
                    GtLog(@"Asset %d not added", i);
                }
#endif                
            }
            [self.tableView reloadData];
            [self _cancelRangeSelect];
        }
    
        [self updateSubtitle];
        return;
    }
    
    if([self.chosenAssets objectForKey:widget.asset.assetURL] != nil)
	{
		[self.chosenAssets removeObjectForKey:widget.asset.assetURL];
	}
	else
	{
		[self.chosenAssets setObject:widget.asset forKey:widget.asset.assetURL];
	}
	
	[widget updateState];
	
	[self updateSubtitle];
}

// TODO: need to be able to set these images from client code

- (GtWidget*) createWidgetForColumn:(NSUInteger) columnNumber
{
	GtImageAssetCellWidget* widget = [GtImageAssetCellWidget widgetWithFrame:CGRectZero];
	widget.imageAssetCellDelegate = self;
	[widget setSelectedImage:[UIImage imageNamed:@"zen_check.png"]];
	[widget setProcessedImage:[UIImage whiteImageNamed:@"upload_to_cloud.png"]];
	return widget;
}

- (BOOL) imageAssetCellWidgetIsSelected:(GtImageAssetCellWidget*) widget
{
	return [self.chosenAssets objectForKey:widget.asset.assetURL] != nil;
}

- (BOOL) imageAssetCellWidgetWasProcessed:(GtImageAssetCellWidget*) widget
{
	NSString* assetStr = widget.asset.assetURL.absoluteString;
	
	NSNumber* uploaded = [self.processedAssets objectForKey:assetStr];
	if(!uploaded)
	{
		uploaded = [NSNumber numberWithBool:[self.assetQueue assetWasUploaded:assetStr]];
		if(!uploaded)
		{
			uploaded = [NSNumber numberWithBool:NO];
		}
		[self.processedAssets setObject:uploaded forKey:assetStr];
	}
	return [uploaded boolValue];
}

- (void) didLoadAssets
{
	[self stopSpinner];
	
	if(self.assets.count == 0)
	{
		[self showEmptyMessage:NSLocalizedString(@"Your Album is empty.", nil)];
	}	

	[self.tableView reloadData];
}

- (void) assetsLibraryDidChange:(NSNotification*) notification
{
//	[self didLoadGroup];
}

- (void) selectAll:(id) sender
{
    for(id<GtAsset> asset in self.assets)
    {
        if([self canAddAsset:[asset assetURL].absoluteString])
        {
            [self.chosenAssets setObject:asset forKey:[asset assetURL]];
        }
    }
    [self updateSubtitle];
    [self.tableView reloadData];
}

- (void) clearSelection:(id) sender
{
    [self.chosenAssets removeAllObjects];
    [self updateSubtitle];
    [self.tableView reloadData];
}

- (void) selectVisible:(id) sender
{
}

- (void) hideShowUploadedPhotos:(id) sender
{
}

- (void) hideShowQueuedPhotos:(id) sender
{
}

- (void) _scrollToTop:(id) sender
{
    [self.tableView scrollToTop:YES];
}

- (void) _scrollToBottom:(id) sender
{
    [self.tableView scrollToBottom:YES];
}

- (void) _beginSelectingRange:(id) sender
{
    m_rangeSelectMode = YES;
    m_rangedSelectedCount = 0;
    m_rangeStartIndex = 0;
    [self updateSubtitle];
    [self _showNotification:NSLocalizedString(@"Select first photo in range", nil)];
}

- (void) handleTools:(id) sender
{
    [self _cancelRangeSelect];

	GtMenuInHoverViewController* menu = [GtMenuInHoverViewController menuViewController:@""];
	
	[menu.menuView addMenuItem:[GtMenuItemView menuItemView:NSLocalizedString(@"Select All", nil)
		target:self
		action:@selector(selectAll:)]];

	[menu.menuView addMenuItem:[GtMenuItemView menuItemView:NSLocalizedString(@"Clear Selection", nil)
		target:self
		action:@selector(clearSelection:)]];

    [menu.menuView addDivider];

	[menu.menuView addMenuItem:[GtMenuItemView menuItemView:NSLocalizedString(@"Select Range", nil)
		target:self
		action:@selector(_beginSelectingRange:)]];

    [menu.menuView addDivider];

	[menu.menuView addMenuItem:[GtMenuItemView menuItemView:NSLocalizedString(@"Scroll To Top", nil)
		target:self
		action:@selector(_scrollToTop:)]];

	[menu.menuView addMenuItem:[GtMenuItemView menuItemView:NSLocalizedString(@"Scroll To Bottom", nil)
		target:self
		action:@selector(_scrollToBottom:)]];

    GtHoverViewController* hoverView = [GtHoverViewController hoverViewController:menu];
    [hoverView presentInViewController:self
        permittedArrowDirection:GtHoverViewControllerArrowDirectionUp
        fromPositionProvider:[self.buttonbar viewForKey:@"tools"]
        style:GtHoverViewStyleNormal
        animated:YES];

	
//	[GtHoverViewController presentViewController:menu
//			inViewController:self
//			permittedArrowDirection:GtHoverViewControllerArrowDirectionUp 
//			fromObject:[self.buttonbar viewForKey:@"tools"]
//			animated:YES
//			isModal:NO];

}

- (void) unselect:(id) sender
{
}

- (void) filter:(id) sender
{
}

- (void) viewDidLoad
{
	[self.buttonbar addViewToRightSide:
			[GtButtonbarView createImageButtonByName:@"tools_small.png" target:self action:@selector(handleTools:)] forKey:@"tools" animated:NO];

	[super viewDidLoad];
	
	
	[GtThemeManager applyThemeToObject:self  themeAction:@selector(applyThemeToAssetsLibraryPhotoBrowserController:)];
}

- (void) beginLoadingAssets
{
    if(!m_assets)
	{
        [self startSpinner];
		
		[[GtAssetsLibrary instance] beginLoadingAssetsForGroup:m_group 
                                                   assetFilter:GtAssetsLibraryFilterPhotosOnly 
                                                     doneBlock:^(NSArray* assets, NSError* error) {
			self.assets = assets;
			
			[self stopSpinner];
			[self.tableView reloadData];
			
			if(m_assets.count == 0)
			{
				[self showEmptyMessage:NSLocalizedString(@"Album is empty.", nil)];
			}
			
			self.title = [NSString stringWithFormat:@"%@ (%d)", [m_group valueForProperty:ALAssetsGroupPropertyName], m_assets.count];
		}
		shouldCancel:^{ return NO; }];
	}
}

- (void) didCheckLocationPermissions
{
    self.assets = nil;
    [self.tableView reloadData];
    [self hideEmptyMessage];
		
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)
    {
        [self.buttonbar setViewEnabled:YES forKey:@"tools"];
    
        [self beginLoadingAssets];
    }
    else
    {   
        [self.buttonbar setViewEnabled:NO forKey:@"tools"];
        [self showPermissionDeniedMessage];
    }
}

- (void) viewDidAppear:(BOOL) animated
{	
	[super viewDidAppear:animated];
    [self _cancelRangeSelect];
}

- (void) appDidEnterForeground
{
    [super appDidEnterForeground];
    [self _cancelRangeSelect];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

@end
