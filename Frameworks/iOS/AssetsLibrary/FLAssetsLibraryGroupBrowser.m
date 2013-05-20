//
//  FLAssetsLibraryGroupBrowser.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAssetsLibraryGroupBrowser.h"
#import "FLThumbnailWithTitleWidget.h"
#import "FLAssetsLibrary.h"
#import "FLGradientWidget.h"
#import "FLAssetsLibraryPhotoBrowserController.h"
#import "UIDevice+FLExtras.h"
#import "FLMenuViewController.h"
#import "FLAssetsLibraryImageAsset.h"

@implementation FLAssetsLibraryGroupBrowser

#define CellWidth DeviceIsPad() ? 128.0f : 160.0f
#define CellHeight DeviceIsPad() ? 128.0f : 80.0f

- (id) initWithAssetQueue:(FLAssetQueue*) queue
{
	if((self = [super initWithAssetQueue:queue]))
	{
		self.title = [NSString stringWithFormat:(NSLocalizedString(@"%@ Albums", nil)), [[UIDevice currentDevice] deviceDisplayName]];
		self.backButtonTitle = NSLocalizedString(@"Albums", nil);
		
		if(DeviceIsPad())
		{
			self.maxPortaitColumns = 4;
			self.maxLandscapeColumns = 6;
		}
		else
		{
			self.maxPortaitColumns = 2;
			self.maxLandscapeColumns = 4;
		}
	}
	
	return self;
}

+ (FLAssetsLibraryGroupBrowser*) assetsLibraryGroupBrowser:(FLAssetQueue*) queue
{
	return FLAutorelease([[FLAssetsLibraryGroupBrowser alloc] initWithAssetQueue:queue]);
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CellHeight;
}

- (NSUInteger) numberOfDataItems
{
	return self.groups.count;
}

- (void) updateWidget:(FLThumbnailWithTitleWidget*) widget forDataItemIndex:(NSUInteger) itemIndex
{
	ALAssetsGroup* group = [self.groups objectAtIndex:itemIndex];

	widget.imageFrameWidget.userData = group;
	
	[widget setTitle:[group valueForProperty:ALAssetsGroupPropertyName]]; 
	
	CGImageRef imageRef = group.posterImage;
	
	[widget setThumbnail:[UIImage imageWithCGImage:imageRef]];
	
}

- (void) touchableObjectTouchUpInside:(FLWidget*) widget
{
	FLAssetsLibraryPhotoBrowserController* controller = [FLAssetsLibraryPhotoBrowserController assetsLibraryPhotoBrowserController:self.assetQueue 
		withGroup:widget.userData];
		
	controller.processedAssets = self.processedAssets;
	controller.disabledAssets = self.disabledAssets;
	controller.chosenAssets = self.chosenAssets;
	controller.doneCallback = self.doneCallback;
	controller.cancelCallback = self.cancelCallback;
    controller.locationManager = self.locationManager;

	[self.navigationController pushViewController:controller animated:YES];
}

- (FLWidget*) createWidgetForColumn:(NSUInteger) columnNumber
{
	FLThumbnailWithTitleWidget* widget = [FLThumbnailWithTitleWidget widgetWithFrame:CGRectMake(0,0,CellWidth, CellHeight)];
    FLSelectOnTouchUpHandler* touchHandler = [FLSelectOnTouchUpHandler selectOnTouchUpHandler];
	touchHandler.touchUpInsideCallback = FLCallbackMake(self, @selector(touchableObjectTouchUpInside:));
	widget.imageFrameWidget.touchHandler = touchHandler;
    
//	[widget setSelectedImage:[UIImage imageNamed:@"zen_check.png"]];
//	[widget setProcessedImage:[UIImage imageNamed:@"upload_to_cloud.png"]];
	return widget;
}

- (void) didCreateNewTableCell:(FLMultiColumnTableViewCell*) cell
{
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) _didLoadGroups
{
	[self.tableView reloadData];
	
	if(self.groups.count == 0)
	{
		[self showEmptyMessage:NSLocalizedString(@"You have no albums.", nil)];
	}

	self.title = [NSString stringWithFormat:(NSLocalizedString(@"%@ Albums (%d)", nil)), [[UIDevice currentDevice] deviceDisplayName], self.groups.count];
}

- (void) _beginLoadingGroups
{
    if(!self.groups || self.groups.count == 0)
	{
		[self startSpinner];
		[[FLAssetsLibrary instance] beginLoadingGroups:^(NSArray* groups, NSError* error) {
			
			self.groups = groups;
			
			[self stopSpinner];
			[self _didLoadGroups];          
		}
		shouldCancel:^{ return NO; }];
	}
	else
	{
		[self _didLoadGroups];
	}
}

- (void) didCheckLocationPermissions
{
    self.groups = nil;
    [self.tableView reloadData];
    [self hideEmptyMessage];
		
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)
    {
        [self.buttonbar setViewEnabled:YES forKey:@"tools"];
        [self _beginLoadingGroups];
    }
    else
    {   
        [self.buttonbar setViewEnabled:NO forKey:@"tools"];
        [self showPermissionDeniedMessage];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

- (void) doneCallback:(id) sender
{
	[self.navigationController popViewControllerAnimated:NO];
	
	FLInvokeCallback(self.doneCallback, self);
}

- (void) cancelCallback:(id) sender
{
	[self.navigationController popViewControllerAnimated:NO];
	
	FLInvokeCallback(self.cancelCallback, self);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}



@end
