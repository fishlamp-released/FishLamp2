//
//  FLAssetsLibraryBrowser.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAssetsLibraryBrowserBase.h"
#import "FLGradientButton.h"
#import "FLAssetsLibrary.h"
#import "FLAssetsLibraryImageAsset.h"

#import "NSFileManager+FLExtras.h"
#import "UIDevice+FLExtras.h"

@implementation FLAssetsLibraryBrowserBase

@synthesize emptyCellImage = _emptyCellImage;
@synthesize doneCallback = _doneCallback;
@synthesize cancelCallback = _cancelCallback;
@synthesize chosenAssets = _chosenAssets;
@synthesize disabledAssets = _disabledAssets;
@synthesize processedAssets = _processedAssets;
@synthesize assetQueue = _assetQueue;
@synthesize groups = _groups;
@synthesize locationManager = _locationManager;

- (void) assetsLibraryDidChange:(NSNotification*) notification
{
}

- (id) initWithAssetQueue:(FLAssetQueue*) queue {
	if((self = [super initWithNibName:nil bundle:nil])) {
        self.wantsFullScreenLayout = YES;
		
		[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(assetsLibraryDidChange:)
			name:ALAssetsLibraryChangedNotification
			object:nil];
		
		_assetQueue = FLRetain(queue);
        
        self.viewContentsDescriptor = [FLViewContentsDescriptor descriptorWithTopStatusAndToolbar];
    }
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	FLRelease(_locationManager);
	FLRelease(_processedAssets);
	FLRelease(_chosenAssets);
	FLRelease(_disabledAssets);
	FLRelease(_assetQueue);
	FLRelease(_emptyCellImage);
	FLRelease(_groups);
	FLSuperDealloc();
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
        FLAssetsLibraryImageAsset* gt_asset = [[FLAssetsLibraryImageAsset alloc] initWithALAsset:asset];
        [self.chosenAssets setObject:gt_asset forKey:gt_asset.assetURL];
        FLRelease(gt_asset); 
    }
}

- (void) addAllFromGroup:(ALAssetsGroup*) group assetFilter:(FLAssetsLibraryFilter) filter
{
    [[FLAssetsLibrary instance] beginLoadingAssetsForGroup:group 
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
	FLInvokeCallback(_doneCallback, self);
}
- (void) _cancel:(id) sender
{
	FLInvokeCallback(_cancelCallback, self);
}

- (void) viewDidLoad
{
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor blackColor];
	self.view.alpha = 1.0;
	self.view.opaque = YES;

	self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.buttonbar addViewToRightSide:[FLToolbarButtonDeprecated toolbarButton:FLGradientButtonColorBrightBlue title:NSLocalizedString(@"Done", nil) target:self action:@selector(_done:)] forKey:@"done" animated:NO];
	
	[self updateSubtitle];
}

- (void) updateSubtitle
{
	self.buttonbar.subtitle = [NSString stringWithFormat:(NSLocalizedString(@"%d Photos Selected", nil)), _chosenAssets.count]; 
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (void) startSpinner
{
	if(!_spinner)
	{
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_spinner.autoresizingMask = UIViewAutoresizingPositioned;
		[self.view addSubview:_spinner];
	}
	
	_spinner.frame = FLRectCenterRectInRect(self.view.bounds, _spinner.frame);
	_spinner.hidden = NO;
	[_spinner startAnimating];
}

- (void) stopSpinner
{
	if(_spinner)
	{
		[_spinner removeFromSuperview];
		FLReleaseWithNil(_spinner);
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

- (void) applyTheme:(FLTheme*) theme {
}


- (void) showEmptyMessage:(NSString*) message
{
	if(!_emptyMessage)
	{
		_emptyMessage = [[FLLabel alloc] initWithFrame:CGRectMake(0,0, 280, 400)];
		_emptyMessage.autoresizingMask = UIViewAutoresizingPositioned;
		_emptyMessage.autoresizesSubviews = NO;
		[self.view addSubview:_emptyMessage];
        _emptyMessage.lineBreakMode = UILineBreakModeWordWrap;
		_emptyMessage.textAlignment = UITextAlignmentCenter;
		_emptyMessage.numberOfLines = 0; // wrap
	}
	
	_emptyMessage.hidden = NO;
	_emptyMessage.frameOptimizedForSize = FLRectCenterRectInRect(self.view.bounds, _emptyMessage.frame);
	_emptyMessage.text = message;
}

- (void) hideEmptyMessage
{
	if(_emptyMessage)
	{
		[_emptyMessage removeFromSuperview];
		FLReleaseWithNil(_emptyMessage);
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
