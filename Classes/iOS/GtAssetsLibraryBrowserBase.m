//
//  GtAssetsLibraryBrowser.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetsLibraryBrowserBase.h"
#import "GtGradientButton.h"
#import "GtAssetsLibrary.h"
#import "GtAssetsLibraryImageAsset.h"

#import "NSFileManager+GtExtras.h"
#import "UIDevice+GtExtras.h"

@implementation GtAssetsLibraryBrowserBase

@synthesize emptyCellImage = m_emptyCellImage;
@synthesize doneCallback = m_doneCallback;
@synthesize cancelCallback = m_cancelCallback;
@synthesize chosenAssets = m_chosenAssets;
@synthesize disabledAssets = m_disabledAssets;
@synthesize processedAssets = m_processedAssets;
@synthesize assetQueue = m_assetQueue;
@synthesize groups = m_groups;
@synthesize locationManager = m_locationManager;

- (void) assetsLibraryDidChange:(NSNotification*) notification
{
}

- (id) initWithAssetQueue:(GtAssetQueue*) queue
{
	if((self = [super initWithNibName:nil bundle:nil]))
	{
        [self createActionContext];
    
		self.wantsFullScreenLayout = YES;
		
		[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(assetsLibraryDidChange:)
			name:ALAssetsLibraryChangedNotification
			object:nil];
		
		m_assetQueue = GtRetain(queue);
	}
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	GtRelease(m_locationManager);
	GtRelease(m_processedAssets);
	GtRelease(m_chosenAssets);
	GtRelease(m_disabledAssets);
	GtRelease(m_assetQueue);
	GtRelease(m_emptyCellImage);
	GtRelease(m_groups);
	GtSuperDealloc();
}

- (BOOL) canAddAsset:(NSString *) url
{
    return  [self.chosenAssets objectForKey:url] == nil &&
            ![self.assetQueue assetIsInQueue:url] &&
            ![self.assetQueue assetWasUploaded:url];
}

- (void) addAssetIfNotInQueueOrUploaded:(ALAsset*) asset
{
    NSString* url = asset.defaultRepresentation.url.absoluteString;
    if([self canAddAsset:url])
    {
        GtAssetsLibraryImageAsset* gt_asset = [[GtAssetsLibraryImageAsset alloc] initWithALAsset:asset];
        [self.chosenAssets setObject:gt_asset forKey:gt_asset.assetURL];
        GtRelease(gt_asset); 
    }
}

- (void) addAllFromGroup:(ALAssetsGroup*) group assetFilter:(GtAssetsLibraryFilter) filter
{
    [[GtAssetsLibrary instance] beginLoadingAssetsForGroup:group 
        assetFilter:filter 
        doneBlock:^(NSError* error)
        {
            [self updateSubtitle];
            [self.tableView reloadData];
        }
        shouldCancel:^{ return NO; } 
        loadedAsset:^(ALAsset* asset) {
           [self addAssetIfNotInQueueOrUploaded:asset];
        }];
}

- (void) _done:(id) sender
{
	GtInvokeCallback(m_doneCallback, self);
}
- (void) _cancel:(id) sender
{
	GtInvokeCallback(m_cancelCallback, self);
}

- (GtViewContentsDescriptor) describeViewContents
{
	return GtViewContentsDescriptorMake(GtViewContentItemNavigationBarAndStatusBar, GtViewContentItemNone);
}

- (void) viewDidLoad
{
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor blackColor];
	self.view.alpha = 1.0;
	self.view.opaque = YES;

	self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.buttonbar addViewToRightSide:[GtToolbarButton toolbarButton:GtButtonColorBrightBlue title:NSLocalizedString(@"Done", nil) target:self action:@selector(_done:)] forKey:@"done" animated:NO];
	
	[self updateSubtitle];
}

- (void) updateSubtitle
{
	self.buttonbar.subtitle = [NSString stringWithFormat:(NSLocalizedString(@"%d Photos Selected", nil)), m_chosenAssets.count]; 
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (void) startSpinner
{
	if(!m_spinner)
	{
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		m_spinner.autoresizingMask = UIViewAutoresizingPositioned;
		[self.view addSubview:m_spinner];
	}
	
	m_spinner.frame = GtRectCenterRectInRect(self.view.bounds, m_spinner.frame);
	m_spinner.hidden = NO;
	[m_spinner startAnimating];
}

- (void) stopSpinner
{
	if(m_spinner)
	{
		[m_spinner removeFromSuperview];
		GtReleaseWithNil(m_spinner);
	}
}

- (void) showPermissionDeniedMessage
{
    NSString* device = [[UIDevice currentDevice] deviceDisplayName];
    NSString* prompt = [NSString stringWithFormat:(NSLocalizedString(@"Unable to display your %@'s photos because Location Services are disabled.\n\nTo fix this, open your %@ Settings app and go to Location Services. Then turn on Location Services for both your %@ and the %@ app.", nil)), 
        device,
        device,
        device,
        [NSFileManager appName]
        ];

    [self showEmptyMessage:prompt];
}

- (void) showEmptyMessage:(NSString*) message
{
	if(!m_emptyMessage)
	{
		m_emptyMessage = [[GtLabel alloc] initWithFrame:CGRectMake(0,0, 280, 400)];
		m_emptyMessage.autoresizingMask = UIViewAutoresizingPositioned;
		m_emptyMessage.autoresizesSubviews = NO;
		m_emptyMessage.themeAction = @selector(applyThemeToBrowserRowTextLabel:);
		[self.view addSubview:m_emptyMessage];
        m_emptyMessage.lineBreakMode = UILineBreakModeWordWrap;
		m_emptyMessage.textAlignment = UITextAlignmentCenter;
		m_emptyMessage.numberOfLines = 0; // wrap
	}
	
	m_emptyMessage.hidden = NO;
	m_emptyMessage.frameOptimizedForSize = GtRectCenterRectInRect(self.view.bounds, m_emptyMessage.frame);
	m_emptyMessage.text = message;
}

- (void) hideEmptyMessage
{
	if(m_emptyMessage)
	{
		[m_emptyMessage removeFromSuperview];
		GtReleaseWithNil(m_emptyMessage);
	}
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self updateSubtitle];
}

- (void) didCheckLocationPermissions
{
}

- (void) beginCheckingLocationPermissions
{
    if(!self.locationManager.isCheckingPermissions)
    {
        [self.locationManager startPermissionsCheck:^{
            [self didCheckLocationPermissions];
            }];
    }
}

- (void) viewDidAppear:(BOOL) animated
{	
	[super viewDidAppear:animated];
    [self beginCheckingLocationPermissions];
}

- (void) appDidEnterForeground
{
    [super appDidEnterForeground];
    [self beginCheckingLocationPermissions];
}




@end
