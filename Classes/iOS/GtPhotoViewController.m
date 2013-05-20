//
//	GtPhotoViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/19/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoViewController.h"


#import "GtGeometry.h"
#import "GtUserNotificationView.h"

#import "GtViewFader.h"
#import "GtAction.h"
#import "GtImageUtilities.h"
#import "GtSlideShowOptionsViewController.h"
#import "GtZoomingScrollView.h"
#import "UIImage+GtColorize.h"

#import "GtPhotoMapViewController.h"
#import "GtProgressViewOwner.h"
#import "GtProgressProtocol.h"
#import "GtButtonbarToolbar.h"
#import "GtNavigationControllerViewController.h"

#import "GtRandom.h"

#import "GtHoverViewController.h"


@implementation GtPhotoViewLoadingState 

@synthesize image = m_image;
@synthesize photoView = m_photoView;
@synthesize photo = m_photo;
@synthesize imageSize = m_imageSize;
@synthesize lastKnownPhotoIndex = m_lastKnownPhotoIndex;
GtSynthesizeStructProperty(isRefreshing, setRefreshing, BOOL, m_flags);
GtSynthesizeStructProperty(isLoading, setLoading, BOOL, m_flags);

- (void) dealloc
{
	GtRelease(m_image);
	GtRelease(m_photo);
	GtRelease(m_photoView);
	GtSuperDealloc();
}

@end

#ifdef DEBUG
#define LOG 0
#endif

#if LOG
#warning LOG enabled
#endif

@interface GtPhotoViewController ()
- (void) _downloadPhotosIfNeeded:(BOOL) resetErrorsFirst;
@end

#define NO_AUTOROTATE 1

#define DefaultSlideShowSpeed 5
#define DefaultFullScreenTimerSpeed 7


@implementation GtPhotoViewController

@synthesize currentPhotoIndex = m_currentPhotoIndex;
@synthesize photoViewControllerDelegate = m_photoViewControllerDelegate;
@synthesize bottomToolbar = m_bottomToolbar;
@synthesize topToolbar = m_topToolbar;
@synthesize thumbnailBar = m_thumbnailBar;
@synthesize organizeButton = m_organizeButton;
@synthesize actionButton = m_actionButton;
@synthesize uiElementMask = m_uiElementMask;
@synthesize slideshowOptions = m_slideshowOptions;
@synthesize slideShowPlayButton = m_playButton;

GtSynthesizeStructProperty(isNetworkAware, setNetworkAware, BOOL, m_photoViewControllerFlags);
GtSynthesizeStructProperty(shouldRefreshWhenAppearing, setShouldRefreshWhenAppearing, BOOL, m_photoViewControllerFlags);
GtSynthesizeStructProperty(autoZoomPhotos, setAutoZoomPhotos, BOOL, m_photoViewControllerFlags);
GtSynthesizeStructProperty(inSlideShow, setInSlideShow, BOOL, m_photoViewControllerFlags);
GtSynthesizeStructProperty(isFullScreenTapDisabled, setFullScreenTapDisabled, BOOL, m_photoViewControllerFlags);

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        [self createActionContext];
    
		self.title = @"";// NSLocalizedString(@"Photo", nil);

		self.shouldRefreshWhenAppearing = YES;

		m_action = [[GtActionReference alloc] init];
		m_thumbnailAction = [[GtActionReference alloc] init];
		self.wantsFullScreenLayout = YES;
    }
    
    return self;
}

- (NSUInteger) photoCount
{
    return [self.photoViewControllerDelegate photoViewControllerGetPhotoCount:self];
}

- (BOOL) isLoadingPhoto
{
	return m_action.action != nil && ![m_action.action wasPerformed] && !m_action.action.wasCancelled;
}

- (CGFloat) zoomScale
{
	return self.centerView.imageScrollView.zoomingScrollViewZoomScale;
}

- (NSUInteger) relativePhotoIndex:(NSInteger) fromCurrent
{
	NSInteger idx = m_currentPhotoIndex + fromCurrent;
	
	// wrap around if needed
	
    NSUInteger photoCount = self.photoCount;
    
	if(idx < 0)
	{
		idx = photoCount + idx; // note idx is negative, hence the addition.
	}
	else if(idx >= ((NSInteger)photoCount)) // weird, it seems to be convert idx to unsigned.
	{
		idx = idx - photoCount; 
	}
	
	return idx;
}

- (BOOL) wantsUIElement:(GtPhotoViewControllerUIElement) element
{
	return GtBitMaskTest(m_uiElementMask, element);
}

- (GtPhotoViewLoadingState*) loadingState
{
	return m_action.action != nil ? m_action.action.state : nil;
}

- (void) cleanupPhotoViewController
{
	m_scrollView.delegate = nil;
	m_scrollView.tilingScrollViewDelegate = nil;

	GtReleaseWithNil(m_scrollView);
    GtReleaseWithNil(m_topToolbar);
	GtReleaseWithNil(m_bottomToolbar);
	GtReleaseWithNil(m_thumbnailBar);
	GtReleaseWithNil(m_editButton);
	GtReleaseWithNil(m_playButton);
	GtReleaseWithNil(m_prevButton);
	GtReleaseWithNil(m_nextButton);
	
	GtReleaseWithNil(m_organizeButton);
	GtReleaseWithNil(m_actionButton);
	GtReleaseWithNil(m_thumbnailCountView);

	GtReleaseWithNil(m_photoMapController);

}

- (void)dealloc 
{   
	[self stopSlideShowTimer];
    [self cleanupPhotoViewController];
	GtRelease(m_randomSlideshowIndexes);
	GtRelease(m_slideshowOptions);
	self.photoViewControllerDelegate = nil;
	GtRelease(m_action);
	GtRelease(m_thumbnailAction);
	GtSuperDealloc();
}

- (void) photoCountDidChange
{
	NSUInteger photoCount = self.photoCount;
    
	if(m_thumbnailBar)
	{
		m_thumbnailBar.nextButton.enabled = photoCount > 1;
		m_thumbnailBar.previousButton.enabled = photoCount > 1;
	}
	
	if(DeviceIsPad())
	{
		[self.buttonbar setViewEnabled:photoCount > 1 forKey:@"slideshow"];
	}
	else
	{
		[m_playButton setEnabled: photoCount > 1];
	}
}

- (void) viewDidUnload
{
	[self cleanupPhotoViewController];
	[super viewDidUnload];
}

- (void) loadView
{
	if(GtStringIsEmpty(self.nibName))
	{
		UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)];
		view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		view.autoresizesSubviews = YES;
		
		m_scrollView = [[GtTilingScrollView alloc] initWithFrame:view.bounds];
		m_scrollView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		m_scrollView.autoresizesSubviews = YES;
		m_scrollView.backgroundColor = [UIColor blackColor];
		[view addSubview:m_scrollView];
		
		self.view = view;
		GtRelease(view);
	
	}
	else
	{
		[super loadView];
	}	
}

- (void) updateCanScrollTiles
{
	m_scrollView.canScrollTiles = self.photoCount > 1;
	[self updateSlideShowButtons];
}

- (void) setCurrentPhotoIndex:(NSUInteger) index animated:(BOOL) animated
{
    m_currentPhotoIndex = index;
    if(self.isViewLoaded)
    {
        [self updateVisibleViewElements];
        [self _downloadPhotosIfNeeded:YES];
        
        [self updateCanScrollTiles];
        
        if(m_thumbnailBar)
        {
            self.thumbnailBar.thumbnailBarView.selectedThumbnailIndex = m_currentPhotoIndex;
            [m_thumbnailBar setNeedsLayout];
            [m_thumbnailBar layoutIfNeeded];
        }

    #if LOG
        GtLog(@"Showing photo at index: %d", newIndex);
    #endif
        
        [self photoCountDidChange];
    }
}

- (void) handleUserDeletedPhotoAtCurrentPhotoIndex
{
	[self photoCountDidChange];
    if(self.photoCount == 0)
	{
		[self performSelectorOnMainThread:@selector(handleDonePress:) withObject:nil waitUntilDone:NO];
	}
	else
	{
		[m_scrollView removeTiledView:self.centerView];
	
		if(m_currentPhotoIndex >= self.photoCount)
		{
            [self setCurrentPhotoIndex:MAX((int)self.photoCount - 1, 0) animated:YES];
		}
        else	
        {
            [self setCurrentPhotoIndex:m_currentPhotoIndex animated:YES];
        }
	}
}

- (void) updateTitleBar:(NSString*) title
{
	if(self.centerView)
	{
		self.title = title;
		self.backButtonTitle = NSLocalizedString(@"Back", nil);
	}
	
	self.buttonbar.subtitle = 
        [NSString stringWithFormat:(NSLocalizedString(@"%d of %d", nil)), m_currentPhotoIndex + 1, self.photoCount];
}

- (void) _updateTitle
{
	NSString* title = [m_photoViewControllerDelegate photoViewController:self titleForPhotoAtIndex:self.currentPhotoIndex];
	[self updateTitleBar:title];
}


- (void) networkDidBecomeAvailable
{
	if(self.isNetworkAware)
	{
		[self beginLoadingPhotosIfNeeded];
	}
}
- (void) _updateBalloon:(BOOL) hasCaption
{
	if([self wantsUIElement:GtPhotoViewControllerUIElementTopBalloon])
	{
		[self.buttonbar viewForKey:@"balloon"].hidden = !hasCaption;
		[self.buttonbar setNeedsLayout];
	}
}

- (void) updateVisibleViewElements
{
	[self _updateTitle];
	
	if([self wantsUIElement:GtPhotoViewControllerUIElementTopBalloon])
	{
		[self _updateBalloon:GtStringIsNotEmpty([m_photoViewControllerDelegate photoViewController:self detailsForPhotoAtIndex:self.currentPhotoIndex])];
	}
	
	if(DeviceIsPad() && [self wantsUIElement:GtPhotoViewControllerUIElementGpsPinButton])
	{
		GtGpsExif* exif = [self.photoViewControllerDelegate photoViewController:self gpsExifForPhotoAtIndex:self.currentPhotoIndex];
		[self.buttonbar setViewHidden:(exif == nil) forKey:@"map" animated:YES];
	}
}

- (void) showDetailsView:(GtPhotoView*) photoView photoIndex:(NSUInteger) photoIndex
{
	NSString* details = [m_photoViewControllerDelegate photoViewController:self detailsForPhotoAtIndex:photoIndex];
	if( GtStringIsNotEmpty(details) && !photoView.detailsViewController)
	{
		GtNotificationViewController* view = [GtNotificationViewController notificationViewController:[[[GtNotificationView alloc] init] autorelease]];
        
		view.autoLayoutMode = GtRectLayoutMake(GtRectLayoutHorizontalFill, GtRectLayoutVerticalTop);

		// TODO: make isHtml and maxTextHeight configurable
		
		view.notificationView.roundRectView.fillAlpha = GtCaptionOpacity;
		view.notificationView.roundRectView.borderAlpha = GtCaptionOpacity;

		view.notificationView.notificationViewDelegate = self;
		view.notificationView.isHtml	 = YES;
		view.notificationView.maxTextHeight = 180;
		view.notificationView.animationType = GtViewAnimationTypeFade;
		view.notificationView.dismissStyle = GtNotificationViewDismissStyleCloseBox;
		view.notificationView.text = details;
		view.themeAction = @selector(applyThemeToPhotoDetailsViewController:);
		photoView.detailsViewController = view;
	}
}

- (void) _didLoadCenterView
{
	[self updateVisibleViewElements];

	if([m_photoViewControllerDelegate respondsToSelector:@selector(photoViewController:didLoadCenterView:)])
	{
		[m_photoViewControllerDelegate photoViewController:self didLoadCenterView:self.centerView];
	}
}

- (void) cancelCurrentLoadingAction
{
	[m_thumbnailAction.action requestCancel];
	[m_action.action requestCancel];
}

- (GtPhotoViewImageSize) imageSizeForZoomScale:(CGFloat) zoomScale
{
	return zoomScale > 1.0 ? GtPhotoViewImageSizeHighResolution : GtPhotoViewImageSizeFullScreen;
}

- (void) _actionDidComplete:(GtAction*) action
{
	GtPhotoViewLoadingState* loadingState = action.state;

	if(!action.wasCancelled)
	{
		if([m_scrollView indexForTiledView:loadingState.photoView] != NSNotFound)
		{
			[loadingState.photoView stopSpinner];
			if([action error])
			{
				[loadingState.photoView setLoadingDidFail];
			}
			[m_photoViewControllerDelegate photoViewController:self actionDidComplete:action loadingState:loadingState];
			
			if(m_photoViewControllerFlags.showingDetailsView)
			{
				[self showDetailsView:loadingState.photoView photoIndex:loadingState.lastKnownPhotoIndex];
			}
			
//			  if([loadingState.photoView.imageZiloadingState.imageSize])
//			  {
//				  [loadingState.photoView hideErrorView];
//			  }

			if(loadingState.photoView == self.centerView)
			{
				if(!loadingState.photoView.loadingDidFail) //[loadingState.photoView imageSizeIsLoaded:loadingState.imageSize])
				{
					if(m_photoViewControllerFlags.inSlideShow)
					{
						[self startSlideShowTimer];
					}
					[self _didLoadCenterView];
				}
				else
				{
					if(m_photoViewControllerFlags.inSlideShow)
					{
						[self stopSlideShow:YES];
					}
				}
			}
		}
	}
#if DEBUG
	else
	{
		GtLog(@"Got cancelled action, will try again");
	}
#endif	  
	
	if(m_action.action == action)
	{
		m_action.action = nil;
	}
	
	[self _downloadPhotosIfNeeded:NO];
	
}

- (void) onWillShowNotification:(GtAction*) action
{
	BOOL isCenter = (self.loadingState.photoView == self.centerView);
	action.disableWarningNotifications = !isCenter;
	action.disableErrorNotifications = !isCenter;
}

- (void) stopZooming:(BOOL) animated
	target:(id) target
	action:(SEL) action
{
	GtPhotoView* photoView = self.centerView;
	
	if(photoView.imageScrollView.isZoomingScrollViewZooming)
	{
		[photoView.imageScrollView stopZooming:animated target:target action:action];
	}
	else
	{
		[target performSelector:action withObject:photoView.imageScrollView];
	}
}

- (id) currentPhoto
{
	return [m_photoViewControllerDelegate photoViewController:self photoAtIndex:self.currentPhotoIndex];
}

- (void) reloadCurrentPhoto:(id) sender
{
//	  [m_scrollView cancelLoadingForAllTiledViewsExceptViewAtIndex:m_scrollView.centerViewIndex];
	
	[self cancelCurrentLoadingAction];
	
#if LOG
	GtLog(@"beginning to load photo view at idx: %d", self.currentPhotoIndex);
#endif
	
	GtPhotoView* photoView = self.centerView;
	
	if(photoView.imageScrollView.isZoomingScrollViewZooming)
	{
		[photoView.imageScrollView stopZooming:YES target:self action:@selector(reloadCurrentPhoto:)];
		return;
	} 
	
	GtPhotoViewLoadingState* state = GtReturnAutoreleased([[GtPhotoViewLoadingState alloc] init]);
	state.photoView = photoView;
	state.photo = [self currentPhoto];
	state.lastKnownPhotoIndex = self.currentPhotoIndex;
	state.imageSize = GtPhotoViewImageSizeFullScreen;
	state.refreshing = YES;
	
	[self stopZooming:NO target:nil action:nil];
	[photoView resetState];
	
	GtAction* action = [m_photoViewControllerDelegate photoViewController:self createLoadAction:state];		 
	if(action)
	{
		action.state = state;
		m_action.action = action;
		[self.actionContext beginAction:action configureAction:^(id inAction) {
			action.willShowProgressCallback = ^{
#if VIEW_AUTOLAYOUT
//				((GtWidgetView*)action.progressView).viewDelegate = self;
#endif
				[action.progressView showProgressInSuperview:state.photoView];
			};
			
			action.willShowNotificationCallback = ^{
				[self onWillShowNotification:action];
			};

			action.didCompleteCallback = ^{ [self _actionDidComplete:action]; };
		}];	

	}
}

- (void) startPlayingMusicIfNeeded
{
	if(DeviceIsPad() && self.slideshowOptions.playMusicValue)
	{
#if !TARGET_IPHONE_SIMULATOR
		if([[MPMusicPlayerController applicationMusicPlayer] playbackState] != MPMusicPlaybackStatePlaying)
		{
			if(self.slideshowOptions.mediaItemList.count > 0)
			{
				MPMediaItemCollection* collection = [MPMediaItemCollection collectionWithItems:self.slideshowOptions.mediaItemList];
				if(collection)
				{
					[[MPMusicPlayerController applicationMusicPlayer] setQueueWithItemCollection:collection];
					[MPMusicPlayerController applicationMusicPlayer].repeatMode = MPMusicRepeatModeAll;
					[[MPMusicPlayerController applicationMusicPlayer] play];
				}
			}
		}
#endif
	}
}

- (void) _setImageForView:(GtPhotoView*) photoView img:(UIImage*) img forImageSize:(GtPhotoViewImageSize) imageSize
{
	[photoView setImage:img forImageSize:imageSize];
	
	if(self.inSlideShow)
	{
		[self startPlayingMusicIfNeeded];
	}
}

- (void) updatePhotoView:(GtPhotoView*) photoView withImage:(UIImage*) image forImageSize:(GtPhotoViewImageSize) imageSize
{
	NSInteger idx = [m_scrollView indexForTiledView:photoView];
	if(idx != NSNotFound)	 
	{
		if(image)
		{
			[self _setImageForView:photoView img:image forImageSize:imageSize];
		}
	}
}

- (void) _fadeInImages
{
	m_scrollView.centerView.alpha = 0;

	[CATransaction begin];
	CATransition *animation = [CATransition animation];
	animation.type = kCATransitionFade;
	animation.duration = 0.3;
	
	CALayer* layer = m_scrollView.layer;
	[layer addAnimation:animation forKey:@"FadeIn"];

	m_scrollView.centerView.alpha = 1.0;
	
	[CATransaction commit];
	
	[layer removeAnimationForKey:@"FadeIn"];
}

- (void) onTappedToolbar:(id) sender
{
//	  [self cancelFullScreenTimer];
	m_photoViewControllerFlags.showingDetailsView = !m_photoViewControllerFlags.showingDetailsView;
	[self showHideAllDetailViews:m_photoViewControllerFlags.showingDetailsView];
}

- (BOOL) _setCustomViewInToolbar:(UIToolbar*) toolbar
	outNewItem:(UIBarButtonItem**) outNewItem
	oldItem:(UIBarButtonItem*) oldItem
	newView:(UIView*) newView
{
	GtAssertNotNil(toolbar);
	GtAssertNotNil(oldItem);
	GtAssertNotNil(newView);

	BOOL foundIt = NO;
	
   // Gawd, this is lame
	NSMutableArray* items = [NSMutableArray arrayWithArray:toolbar.items];
	for(NSUInteger i = 0; i < items.count; i++)
	{
		if([items objectAtIndex:i] == oldItem)
		{
			foundIt = YES;
			UIBarButtonItem* customItem = [[UIBarButtonItem alloc] initWithCustomView:newView];
			[items replaceObjectAtIndex:i withObject:customItem];
			if(outNewItem)
			{
				*outNewItem = GtRetain(customItem);
			}
   
			GtReleaseWithNil(customItem);
			
			break;
		}
	}

	toolbar.items = items;
	
	GtAssert(foundIt, @"didn't find item");
	
	return foundIt;
}

- (void) slideshowOptionsViewController:(GtSlideshowOptionsViewController*) viewController
	beginSlideshowWithOptions:(GtSlideshowOptions*) options
{
	self.slideshowOptions = options;
	[self startSlideShow];
}

- (IBAction) handleSlideShowPress:(id) sender
{
	if(!self.slideshowOptions)
	{
		self.slideshowOptions = [self.photoViewControllerDelegate photoViewControllerGetDefaultSlideshowOptions:self];
	}

	if(self.inSlideShow)
	{
		[self stopSlideShow:YES];
	}
	else
	{
		GtSlideshowOptionsViewController* controller = [GtSlideshowOptionsViewController slideshowOptionsViewController:self.slideshowOptions showStartNowButton:YES];
		controller.slideshowOptionsDelegate = self;
		controller.autoResizeHoverView = YES;
		controller.buttonStrategy = GtEditObjectViewControllerShowCancelButtonOnly;

        GtHoverViewController* hoverView = [GtHoverViewController hoverViewController:[GtNavigationControllerViewController navigationControllerViewController:controller]];
        [hoverView presentInViewController:self
            permittedArrowDirection:GtHoverViewControllerArrowDirectionUp
            fromPositionProvider:[self.buttonbar viewForKey:@"slideshow"]
            style:GtHoverViewStyleNormal
            animated:YES];
	}
}

- (void) handleTools:(id) sender
{
}

- (void) _showGpsMap:(id) sender
{
	GtGpsExif* exif = [self.photoViewControllerDelegate photoViewController:self gpsExifForPhotoAtIndex:self.currentPhotoIndex];
	if(exif)
	{
		if(!m_photoMapController)
		{
			m_photoMapController = [[GtWeakReference alloc] init];
		}
	
		GtPhotoMapViewController* controller = GtReturnAutoreleased([[GtPhotoMapViewController alloc] init]);
		m_photoMapController.object = controller;
		if(DeviceIsPad())
		{
            GtHoverViewController* hoverView = [GtHoverViewController hoverViewController:[GtNavigationControllerViewController navigationControllerViewController:controller]];
            [hoverView presentInViewController:self
                permittedArrowDirection:GtHoverViewControllerArrowDirectionUp
                fromPositionProvider:[self.buttonbar viewForKey:@"map"]
                style:GtHoverViewStyleNormal
                animated:YES];
		}
		else if(self.navigationController)
		{
			[self.navigationController pushViewController:controller animated:YES];
		}
        else
        {
        }
        
		[controller addPin:NSLocalizedString(@"Taken Here:", nil) coordinate:exif.coordinate];
		controller.title = [self.photoViewControllerDelegate photoViewController:self titleForPhotoAtIndex:self.currentPhotoIndex];
	}
}

- (void) createTopToolbar
{
	if(DeviceIsPad() && [self wantsUIElement:GtPhotoViewControllerUIElementGpsPinButton])
	{
		UIView* mapButton = [GtButtonbarView createImageButtonByName:@"globe.png" target:self action:@selector(_showGpsMap:)];
	//	  mapButton.hidden = YES;
		[self.buttonbar addViewToLeftSide:mapButton forKey:@"map" animated:NO];
	}

	if([self wantsUIElement:GtPhotoViewControllerUIElementTopBalloon])
	{
		[self.buttonbar addViewToRightSide:[GtButtonbarView createImageButtonByName:@"balloon.png" target:self action:@selector(onTappedToolbar:)] forKey:@"balloon" animated:NO];
		
		[self.buttonbar setViewHidden:YES forKey:@"balloon.png" animated:NO];
	}

	if(DeviceIsPad())
	{
		if([self wantsUIElement:GtPhotoViewControllerUIElementTopPlaySlideshowButton] )
		{
			m_playButton = [[GtButtonbarView createImageButtonByName:@"playicon.png"
																target:self action:@selector(handleSlideShowPress:)] retain];

			[self.buttonbar addViewToRightSide:m_playButton forKey:@"slideshow" animated:NO];
		}
		
		if([self wantsUIElement:GtPhotoViewControllerUIElementTopToolsButton] )
		{
			[self.buttonbar addViewToRightSide:
					[GtButtonbarView createImageButtonByName:@"tools_small.png"
																target:self action:@selector(handleTools:)] forKey:@"tools" animated:NO];
		}
	}

	if([self wantsUIElement:GtPhotoViewControllerUIElementTopComposeButton])
	{
		[self.buttonbar addViewToRightSide:
				[GtButtonbarView createImageButtonByName:@"composeicon.png"
														target:self action:@selector(handleInfoPress:)] forKey:@"compose" animated:NO];
	}
}

- (void) viewDidDisappear:(BOOL)animated
{
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		GtPhotoView* photoView = (GtPhotoView*)[m_scrollView tiledViewAtIndex:i];
		[photoView hideDetailsView];
	}
//	  [self stopSlideShow:NO];
	[super viewDidDisappear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[self stopSlideShow:YES];
	[super viewWillDisappear:animated];
}

- (GtViewContentsDescriptor) describeViewContents
{
	GtViewContentsDescriptor contents = GtViewContentsDescriptorNone;
	
    if(self.navigationController)
	{
		contents.top = GtViewContentItemNavigationBarAndStatusBar;
	}
    else if(m_topToolbar)
    {
        contents.top = GtViewContentItemToolbarAndStatusBar;
    }

	if(m_bottomToolbar)
	{
		contents.bottom = GtViewContentItemToolbar;
	}
	if(m_thumbnailBar)
	{
		contents.bottom = GtViewContentItemToolbar;
	}

	return contents;
}

- (void) setThumbnailBarImage:(UIImage*) image atIndex:(NSUInteger) atIndex
{
	[self.thumbnailBar.thumbnailBarView setThumbnail:image atIndex:atIndex];
	[self _downloadPhotosIfNeeded:NO];
}

- (void) _beginLoadingNextThumbnail
{
//	  if(m_thumbnailAction.action)
//	  {
//		  [m_thumbnailAction.action requestCancel];
//	  }
	m_thumbnailAction.action =	
		[m_photoViewControllerDelegate photoViewController:self beginLoadingThumbnailAtIndex:self.thumbnailBar.thumbnailBarView.nextThumbnailIndex];
}

- (void) _startLoading
{
	if(self.thumbnailBar && !self.thumbnailBar.thumbnailBarView.hasAllThumbnails)
	{
		[self _beginLoadingNextThumbnail];
	}

	[m_scrollView resetAllViews];
	[self _downloadPhotosIfNeeded:YES];
	[self _fadeInImages];
}

- (void) showPhotoAtIndex:(NSUInteger) newIndex
{
	[self setCurrentPhotoIndex:newIndex animated:NO]; // ANIMATED?
	[self _startLoading];
}

- (void) thumbnailBarViewTouchesStarted:(GtImageThumbnailBarView*) thumbnailBar
{
	m_photoViewControllerFlags.wantsThumbnailLoad = NO;
}

- (void) thumbnailBarViewTouchesStopped:(GtImageThumbnailBarView*) thumbnailBar
{
	if(m_photoViewControllerFlags.wantsThumbnailLoad)
	{
		[self _startLoading];
	}
	
	[m_thumbnailCountView removeFromSuperviewWithAnimationType:GtViewAnimationTypeFade duration:0.3 finishedBlock:nil];
	GtReleaseWithNil(m_thumbnailCountView);
}

- (void) thumbnailBarView:(GtImageThumbnailBarView*) thumbnailBar didChangeSelectedThumbnail:(NSUInteger) newIndex
{
	if(newIndex != self.currentPhotoIndex)
	{
		m_photoViewControllerFlags.wantsThumbnailLoad = YES;
       	[self setCurrentPhotoIndex:newIndex animated:NO]; // ANIMATED?

		if(!m_thumbnailCountView)
		{
			m_thumbnailCountView = [[GtThumbnailBarCountView alloc] initWithFrame:CGRectMake(0,0, 140, 40)];
			m_thumbnailCountView.frameOptimizedForSize = GtRectCenterRectInRectHorizontally(self.view.bounds, GtRectSetTop(m_thumbnailCountView.frame, self.view.bounds.size.height * 0.80));
			m_thumbnailCountView.autoresizesSubviews = NO;
			m_thumbnailCountView.autoresizingMask = UIViewAutoresizingPositioned;
			
			[self.view addSubview:m_thumbnailCountView];
			[m_thumbnailCountView animateOntoScreen:GtViewAnimationTypeFade duration:0.3 finishedBlock:nil];
		}
		
		[m_thumbnailCountView updateCount:newIndex+1 total:self.photoCount];
	}
}

- (NSUInteger) thumbnailBarViewGetThumbnailCount:(GtImageThumbnailBarView*) thumbnailBar
{
	return self.photoCount;
}

- (NSUInteger) thumbnailBarViewGetSelectedThumbnailIndex:(GtImageThumbnailBarView*) thumbnailBar
{
	return m_currentPhotoIndex;
}

- (void) createBottomToolbar
{
    if(DeviceIsPad())
	{
		if(!m_thumbnailBar)
		{
			m_thumbnailBar = [[GtPhotoThumbnailToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 44)];
			m_thumbnailBar.autoresizingMask = UIViewAutoresizingPositioned | UIViewAutoresizingFlexibleWidth;
			m_thumbnailBar.frame = GtRectJustifyRectInRectBottom(self.view.bounds, m_thumbnailBar.frame);
			m_thumbnailBar.barStyle = UIBarStyleBlack;
			m_thumbnailBar.translucent = YES;
			[self.view addSubview:m_thumbnailBar];
		}
	
		self.thumbnailBar.thumbnailBarView.delegate = self;
		[self.thumbnailBar.thumbnailBarView resetThumbnails];
	}
	else
	{
        UIToolbar* bottomToolbar = GtReturnAutoreleased([[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 44)]);
        bottomToolbar.barStyle = UIBarStyleBlack;
        bottomToolbar.translucent = YES;
        bottomToolbar.frame = GtRectJustifyRectInRectBottom(self.view.bounds, m_bottomToolbar.frame);
        bottomToolbar.autoresizingMask = UIViewAutoresizingPositioned | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:bottomToolbar];

        m_prevButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"rewind.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handlePrevPress:)];
        m_playButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"playicon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handlePlayPress:)];
        m_nextButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fast_forward.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleNextPress:)];
        m_organizeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(handleMovePress:)];
        m_actionButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"at_symbol.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleActionPress:)];

        bottomToolbar.items = [NSArray arrayWithObjects:
            m_prevButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            m_playButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            m_nextButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            m_organizeButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            m_actionButton,
            nil];
            
        self.bottomToolbar = bottomToolbar;
	}
}

- (void) viewDidLoad
{
	[super viewDidLoad];

	m_scrollView.tilingScrollViewDelegate = self;
	
//	  if(self.photoCount >= 5 && [UIDevice currentDevice].isAtLeastIPhone4)
//	  {
//		  [m_scrollView createTiles:5];
//	  }
//	  else
	{
		[m_scrollView createTiles:3];
	}
	
	[self updateCanScrollTiles];

    [self createTopToolbar];
	[self createBottomToolbar];
	
    [self photoCountDidChange];
}

- (void) beginLoadingPhotosIfNeeded
{
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		GtPhotoView* photoView = (GtPhotoView*) [m_scrollView tiledViewAtIndex:i];
		[photoView clearError];
	}
	[self _downloadPhotosIfNeeded:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

// these only do anything the first time.

	if(self.shouldRefreshWhenAppearing)
	{
		[self beginLoadingPhotosIfNeeded];
		[self updateVisibleViewElements];
	}
}

- (void) appDidEnterForeground
{
	[super appDidEnterForeground];
	[self beginLoadingPhotosIfNeeded];
}

- (void) notificationViewWasTouched:(GtNotificationView*) view
{
//	  [self cancelFullScreenTimer];
}

- (void) notificationViewDidShow:(GtNotificationView*) view
{
}

- (void) notificationViewDidHide:(GtNotificationView*) view
{
}

- (void) notificationViewUserClosed:(GtNotificationView*) closingView
{
	m_photoViewControllerFlags.showingDetailsView = NO;
	
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		GtPhotoView* photoView = (GtPhotoView*) [m_scrollView tiledViewAtIndex:i];
		if(photoView && photoView.detailsViewController != nil && closingView != photoView.detailsViewController.view)
		{
			[photoView hideDetailsView];
		}
	}
}

- (void) resetErrors
{
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		GtPhotoView* photoView = (GtPhotoView*)[m_scrollView tiledViewAtIndex:i];
		if(photoView.loadingDidFail)
		{
			[photoView clearError];
		}
	}
}

- (BOOL) _pingViewAtIndex:(NSUInteger) viewIndex 
	photoIndex:(NSUInteger) photoIndex
	wantedSize:(GtPhotoViewImageSize) imageSize
{
	GtPhotoView* photoView = (GtPhotoView*) [m_scrollView tiledViewAtIndex:viewIndex];	  
	if(photoView.loadingDidFail)
	{
		return NO;
	}
	
	if(photoView.imageSize != imageSize)
	{
#if LOG
		GtLog(@"beginning to load photo view at idx: %d", viewIndex);
#endif
		GtPhotoViewLoadingState* state = GtReturnAutoreleased([[GtPhotoViewLoadingState alloc] init]);
		state.photoView = photoView;
		state.photo = [m_photoViewControllerDelegate photoViewController:self photoAtIndex:photoIndex];
		state.lastKnownPhotoIndex = photoIndex;
		state.imageSize = imageSize;
		GtAction* action = [m_photoViewControllerDelegate photoViewController:self createLoadAction:state];		 
		
		if(action)
		{
			action.state = state;
			m_action.action = action;
			
			[self.actionContext beginAction:action configureAction:^(id inAction) {
				action.willShowProgressCallback = ^{
#if VIEW_AUTOLAYOUT
//					((GtWidgetView*)action.progressView).viewDelegate = self;
#endif                    
					[action.progressView showProgressInSuperview:state.photoView];
				};
				
				action.willShowNotificationCallback = ^{
					[self onWillShowNotification:action];
				};

				action.didCompleteCallback = ^{ [self _actionDidComplete:action]; };

			}];	

			return YES;
		}
	}
	
	return NO;
}

- (void) _downloadPhotosIfNeeded:(BOOL) resetErrorsFirst
{
	if(self.photoCount == 0 || self.isLoadingPhoto)
	{
		return;
	}
		
	if(resetErrorsFirst)
	{
		for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
		{
			GtPhotoView* photoView = (GtPhotoView*)[m_scrollView tiledViewAtIndex:i];
			[photoView clearError];
		}
	}
			
	if(![self _pingViewAtIndex:m_scrollView.centerViewIndex 
		photoIndex:self.currentPhotoIndex 
		wantedSize:[self imageSizeForZoomScale:self.zoomScale]] &&
		m_photoViewControllerFlags.inSlideShow)
	{
		[self startSlideShowTimer];
	}
	   
	if(!self.isLoadingPhoto && self.photoCount > 1)
	{
		NSInteger nextIndex = m_scrollView.firstNextViewIndex;
		NSInteger prevIndex = m_scrollView.lastPreviousViewIndex;
		
		for(NSUInteger i = 0; i < m_scrollView.nextTiledViewCount + m_scrollView.previousTiledViewCount; i++)
		{
			if(m_scrollView.lastScrollDirection == GtTilingScrollViewSlideDirectionLeft)
			{
				if(nextIndex <= (NSInteger) m_scrollView.lastNextViewIndex)
				{
					[self _pingViewAtIndex:nextIndex++ photoIndex:[self relativePhotoIndex:i+1] wantedSize:GtPhotoViewImageSizeFullScreen];
					if(self.isLoadingPhoto)
					{
						break;
					}
				}
				
				if(prevIndex >= (NSInteger) m_scrollView.firstPreviousViewIndex)
				{
					[self _pingViewAtIndex:prevIndex-- photoIndex:[self relativePhotoIndex:-(i+1)] wantedSize:GtPhotoViewImageSizeFullScreen];
					if(self.isLoadingPhoto)
					{
						break;
					}
				}
			
			}
			else
			{
				if(prevIndex >= (NSInteger) m_scrollView.firstPreviousViewIndex)
				{
					[self _pingViewAtIndex:prevIndex-- photoIndex:[self relativePhotoIndex:-(i+1)] wantedSize:GtPhotoViewImageSizeFullScreen];
					if(self.isLoadingPhoto)
					{
						break;
					}
				}
			  
				if(nextIndex <= (NSInteger) m_scrollView.lastNextViewIndex)
				{
					[self _pingViewAtIndex:nextIndex++ photoIndex:[self relativePhotoIndex:i+1] wantedSize:GtPhotoViewImageSizeFullScreen];
					if(self.isLoadingPhoto)
					{
						break;
					}
				}
			}
		}
	}
	
	if(!self.isLoadingPhoto && self.thumbnailBar && !self.thumbnailBar.thumbnailBarView.hasAllThumbnails)
	{
		[self _beginLoadingNextThumbnail];
	}
}

- (void) handleDonePress:(id)sender
{
	if(!m_photoViewControllerFlags.shutDown)
	{
		m_photoViewControllerFlags.shutDown = YES;
		
		[self stopSlideShow:YES];
		
		[self dismissViewControllerAnimated:YES];
	}
}

- (NSUInteger) photoIndexFromViewIndex:(NSInteger) viewIndex
{
	return [self relativePhotoIndex:viewIndex - m_scrollView.centerViewIndex];
}

- (void) showHideAllDetailViews:(BOOL) show
{
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		GtPhotoView* photoView = (GtPhotoView*)[m_scrollView tiledViewAtIndex:i];
		if(photoView)
		{
			if(show)
			{
				[self showDetailsView:photoView photoIndex:[self photoIndexFromViewIndex:i]];
			}
			else
			{
				[photoView.detailsViewController hideNotification];
			}
		}
	}
}

- (BOOL) isFullScreen
{
	return m_photoViewControllerFlags.fullScreen; // [UIApplication sharedApplication].statusBarHidden;
}

- (void) enterFullScreen:(BOOL) animate
{
	if(![self isFullScreen])
	{
		[self toggleFullScreen:animate];
	}
}

- (void) leaveFullScreen:(BOOL) animate
{
	if([self isFullScreen])
	{
		[self toggleFullScreen:animate];
	}
}

- (void) toggleFullScreen:(BOOL) animate
{
//	[self cancelFullScreenTimer];

	BOOL hideViews = !self.isFullScreen;
	
	[[UIApplication sharedApplication] setStatusBarHidden:hideViews withAnimation:animate ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];

	NSMutableArray* views = [NSMutableArray array];

	if(self.navigationController)
	{
		if(animate)
		{
			[views addObject:self.navigationController.navigationBar];
		}
		else
		{
			[self.navigationController setNavigationBarHidden:hideViews animated:NO];
		}
		
		if(!hideViews)
		{
			 // make sure the nav bar is at the correct y coordinate
				self.navigationController.navigationBar.frame = 
					GtRectSetHeight(
						GtRectSetTop(self.navigationController.navigationBar.frame, [[UIDevice currentDevice] statusBarHeight]),
						[UIDevice currentDevice].navigationBarHeight);
			
		}
	}

    if(m_topToolbar)
    {
		[views addObject:m_topToolbar];
    }
	if(m_bottomToolbar)
	{
		[views addObject:m_bottomToolbar];
	}
	if(m_thumbnailBar)
	{
		[views addObject:m_thumbnailBar];
	}

	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		GtPhotoView* photoView = (GtPhotoView*)[m_scrollView tiledViewAtIndex:i];
		if(photoView)
		{
			if(photoView.detailsViewController)
			{
				[views addObject:photoView.detailsViewController];
			}
		
			if(photoView.errorViewController && [photoView.errorViewController isKindOfClass:[GtNotificationViewController class]])
			{
				[views addObject:photoView.errorViewController.view];
			}
		}
	}
	
	if(animate)
	{
		[UIView setViewsHiddenWithFade:views hidden:hideViews duration:0.3 
            finishedBlock:^(NSArray* animatedViews) 
                { m_photoViewControllerFlags.fullScreen = hideViews;}
                ];
	}
	else
	{
		for(UIView* view in views)
		{
			view.hidden = hideViews;
		}
			
		m_photoViewControllerFlags.fullScreen = hideViews;;
	}
}

- (IBAction) handleToolPress:(id) sender
{
	[self stopSlideShow:YES];
}

- (void) handleReloadPress:(id) sender
{
	[self stopSlideShow:YES];
}

- (void) handleMovePress:(id) sender
{
	[self stopSlideShow:YES];
}

- (void) handleDeletePress:(id) sender
{
	[self stopSlideShow:YES];
}

- (void) _didPressNextOrPrevButton
{
	[self _fadeInImages];

	if(m_photoViewControllerFlags.inSlideShow)
	{	
		if(m_slideShowStartIndex == m_currentPhotoIndex)
		{
			[self stopSlideShow:YES];
		}
		
		[self _downloadPhotosIfNeeded:YES];
	}
}

- (void) handlePrevPress:(id) sender
{
	[m_scrollView shiftArrangementToRight];
	[self _didPressNextOrPrevButton];
}

- (void) handleNextPress:(id) sender
{
	[m_scrollView shiftArrangementToLeft];
	[self _didPressNextOrPrevButton];
}

- (void) thumbnailBarViewNextButtonPressed:(GtImageThumbnailBarView*) thumbnailBar
{
	[self handleNextPress:thumbnailBar];
}

- (void) thumbnailBarViewPreviousButtonPressed:(GtImageThumbnailBarView*) thumbnailBar
{
	[self handlePrevPress:thumbnailBar];
}

- (void) handlePlayPress:(id) sender
{
	if(m_photoViewControllerFlags.inSlideShow)
	{
		[self stopSlideShow:YES];
	}
	else
	{
		if(!self.slideshowOptions)
		{
			self.slideshowOptions = [self.photoViewControllerDelegate photoViewControllerGetDefaultSlideshowOptions:self];
		}
		
		[self startSlideShow];
	}
}

- (void) handleInfoPress:(id) sender
{
	[self stopSlideShow:YES];
}

- (IBAction) handleActionPress:(id) sender
{
	[self stopSlideShow:YES];
}

- (UIScrollView*) scrollView
{
	return m_scrollView;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation
	duration:(NSTimeInterval)duration
{
	[m_scrollView willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[m_scrollView didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (GtPhotoView*) centerView
{
	return (GtPhotoView*)m_scrollView.centerView;
}

- (void) showErrorMessageInPhotoView:(GtPhotoView*) photoView 
	errorMessage: (NSString*) errorMessage
	userCanDismissErrorView:(BOOL) canDismiss
{
//	  if(photoView.errorView && [[photoView.errorView text] isEqualToString:errorMessage])
//	  {
//		  return;
//	  }
//	   
	if(!photoView.didShowError)
	{
		if(canDismiss)
		{
			GtUserNotificationViewController* view = [GtUserNotificationViewController userNotificationViewController:[[[GtUserNotificationView alloc] initAsInfoNotification] autorelease]];
			view.autoDismiss = NO;
			view.notificationView.shouldAutoCloseAfterDelay = NO;
			view.notificationView.text = errorMessage;
			photoView.errorViewController = view;
			[photoView addSubview:view.view];
		}
		else
		{
        
// FIXME

// just need to make a viewcontroller subclass with this view stuff in it and assign
// it to the errorViewController in the photoView
/*        
			UIView* view = GtReturnAutoreleased([[UIView alloc] initWithFrame:photoView.bounds]);
			view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
			view.autoresizesSubviews = YES;
			view.backgroundColor = [UIColor clearColor];
			view.userInteractionEnabled = YES;
			
			UILabel* label = GtReturnAutoreleased([[UILabel alloc] initWithFrame:DeviceIsPad() ? CGRectMake(0,0, 400, 400): CGRectMake(0,0, 300, 300)]);
			label.userInteractionEnabled = YES;
			label.textAlignment = UITextAlignmentCenter;
			label.numberOfLines = 0;
			label.backgroundColor = [UIColor clearColor];
			label.autoresizingMask = UIViewAutoresizingPositioned;
			label.frameOptimizedForSize = GtRectCenterRectInRect(view.frame, label.frame);
			label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
			label.textColor = [UIColor lightGrayColor];
			label.text = errorMessage;
			[view addSubview:label];
			[photoView.imageScrollView addSubview:view];
			photoView.errorViewController = view;
*/            
		}
	}
}

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView 
	willRemoveView:(GtPhotoView*) view
{
	view.imageScrollView.touchableScrollViewDelegate = nil;
	view.imageScrollView.zoomingScrollViewDelegate = nil; 
}

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView createTiledView:(UIView**) outView
{
	GtPhotoView* imgView = [[GtPhotoView alloc] initWithFrame:self.view.bounds];
	imgView.autoZoom = self.autoZoomPhotos;
	imgView.autoShowSpinner = YES;
	imgView.imageScrollView.touchableScrollViewDelegate = tilingScrollView;
	imgView.imageScrollView.zoomingScrollViewDelegate = self; 
	[imgView startSpinner];
	*outView = imgView;
}

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView 
	releaseMemoryForView:(GtPhotoView*) view
	atIndex:(NSInteger) idx
{
	[view resetState];
}

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView didTileViews:(GtTilingScrollViewSlideDirection) slideDirection
{
	switch(slideDirection)
	{
		case GtTilingScrollViewSlideDirectionLeft:
		{
			m_currentPhotoIndex = [self relativePhotoIndex:1];
		}
		break;
		
		case GtTilingScrollViewSlideDirectionRight:
		{
			m_currentPhotoIndex = [self relativePhotoIndex:-1];
		}
		break;
		
		default:
			GtAssertFailed(@"wtf?");
			break;
	}

	
	if(self.thumbnailBar)
	{
		 self.thumbnailBar.thumbnailBarView.selectedThumbnailIndex = m_currentPhotoIndex;
	}
	[self updateVisibleViewElements];
	
	if(m_thumbnailAction.action)
	{
		[m_thumbnailAction.action requestCancel];
	}
		
	[self cancelCurrentLoadingAction];
	
	[self _downloadPhotosIfNeeded:YES];
}

- (void) tilingScrollViewDidFinishDragAnimation:(GtTilingScrollView*) tilingScrollView
{
//	  m_photoViewControllerFlags.wantsFullScreenAfterDrag = YES;
//	  if(action.didFinishWithoutError && m_photoViewControllerFlags.wantsFullScreenAfterDrag)
//	  {
//		  [self enterFullScreen:YES];
//	  }

	[self enterFullScreen:YES];

}

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView willScrollView:(GtPhotoView*) photoView
{
}

- (void) tilingScrollView:(GtTilingScrollView*) tilingScrollView 
	willTileViews:(GtTilingScrollViewSlideDirection) slideDirection
{
	[self.centerView.imageScrollView setZoomingScrollViewZoomScale:1.0 animated:NO];
}

- (void) tilingScrollViewWillRotate:(GtTilingScrollView*) tilingScrollView;
{
}

- (void) tilingScrollViewDidRotate:(GtTilingScrollView*) tilingScrollView
{
	[self _downloadPhotosIfNeeded:NO];
}

- (void) updateSlideShowButtons
{
	[m_playButton setEnabled:self.photoCount > 1];
	[m_prevButton setEnabled:self.photoCount > 1];
	[m_nextButton setEnabled:self.photoCount > 1];
}

- (void) _setButtonImage:(id) button image:(UIImage*) image
{
	if([button isKindOfClass:[UIButton class]])
	{
		[button setImage:image forState:UIControlStateNormal];
	}
	else if([button isKindOfClass:[UIBarButtonItem class]])
	{
		[button setImage:image];
	}
}

//- (void) _showFullScreen
//{
//	[self enterFullScreen:YES];
//}

- (void) startSlideShow
{
	[UIApplication sharedApplication].idleTimerDisabled = YES; // just in case
	
	m_photoViewControllerFlags.inSlideShow = YES;
	
	m_slideShowStartIndex = m_currentPhotoIndex;
	
	[self _setButtonImage:m_playButton image:[UIImage imageNamed:@"pauseicon.png"]];
	
	[self _downloadPhotosIfNeeded:YES];

	[self enterFullScreen:YES];
	
//	  [self performSelectorOnMainThread:@selector(_showFullScreen) withObject:nil waitUntilDone:NO];
}

- (void) finishFadeOut:(NSNumber*) prevVolume
{
	[MPMusicPlayerController applicationMusicPlayer].volume = prevVolume.floatValue;
}

- (void) fadeOutMusic:(NSNumber*) prevVolume
{
	if([MPMusicPlayerController applicationMusicPlayer].volume < 0.05)
	{
		[[MPMusicPlayerController applicationMusicPlayer] stop];
		[self performSelector:@selector(finishFadeOut:) withObject:prevVolume afterDelay:0.1];
	}
	else
	{
		[MPMusicPlayerController applicationMusicPlayer].volume -= 0.1;
		[self performSelector:@selector(fadeOutMusic:) withObject:prevVolume afterDelay:0.1];
	}
}

- (void) stopSlideShow:(BOOL) animate
{
	[UIApplication sharedApplication].idleTimerDisabled = NO; 
		
	m_photoViewControllerFlags.inSlideShow = NO;

	[self _setButtonImage:m_playButton image:[UIImage imageNamed:@"playicon.png"]];

	[self stopSlideShowTimer];

	[self leaveFullScreen:animate];
	
#if !TARGET_IPHONE_SIMULATOR
	if(DeviceIsPad())
	{
		if([MPMusicPlayerController applicationMusicPlayer].playbackState == MPMusicPlaybackStatePlaying)
		{
			[self fadeOutMusic:[NSNumber numberWithFloat:[MPMusicPlayerController applicationMusicPlayer].volume]];
		}
	}
#endif
}

- (void) populateRandomSlideshowArray
{
	GtRelease(m_randomSlideshowIndexes);
	m_randomSlideshowIndexes = [[NSMutableArray alloc] initWithCapacity:self.photoCount];

	for(NSUInteger i = 0; i < self.photoCount; i++)
	{
		[m_randomSlideshowIndexes addObject:[NSNumber numberWithUnsignedInt:i]];
	}
}

- (void) handleSlideShowNext:(NSTimer*)theTimer
{
	m_slideShowTimer = nil;

	if(m_photoViewControllerFlags.inSlideShow)
	{	
		if(m_slideshowOptions.randomValue)
		{
			if(!m_randomSlideshowIndexes)
			{
				[self populateRandomSlideshowArray];
			}
		
			if(!m_slideshowOptions.repeatValue && m_randomSlideshowIndexes.count == 0)
			{
			// stop
				[self stopSlideShow:YES];
			}
			else
			{
				if(m_randomSlideshowIndexes.count == 0)
				{
				// in case we're repeating
					[self populateRandomSlideshowArray];
				}
			
				NSUInteger randomIndex = GtRandomInt(0, m_randomSlideshowIndexes.count - 1);
				NSNumber* whichIndex = [m_randomSlideshowIndexes objectAtIndex:randomIndex];
				
				[self showPhotoAtIndex:whichIndex.intValue];
				
				[m_randomSlideshowIndexes removeObjectAtIndex:randomIndex];
			}
		}
		else
		{
			[m_scrollView shiftArrangementToLeft];
			
			if(!m_slideshowOptions.repeatValue && m_slideShowStartIndex == m_currentPhotoIndex)
			{
				[self stopSlideShow:YES];
			}
		
			[self _downloadPhotosIfNeeded:YES];
			[self _fadeInImages];
		}
	}
}

- (void) stopSlideShowTimer
{
	[m_slideShowTimer invalidate];
	m_slideShowTimer = nil;
}

- (void) startSlideShowTimer
{
	m_photoViewControllerFlags.inSlideShow = YES;
//	[self cancelFullScreenTimer];
	[self stopSlideShowTimer];

	if(self.centerView.imageSize >= GtPhotoViewImageSizeFullScreen)
	{
		m_slideShowTimer = [NSTimer timerWithTimeInterval:m_slideshowOptions.speedValue 
				target:self 
				selector:@selector(handleSlideShowNext:) 
				userInfo:nil 
				repeats:NO];
			
		[[NSRunLoop mainRunLoop] addTimer:m_slideShowTimer forMode:NSRunLoopCommonModes];
	}
}

- (GtPhotoView*) photoViewForImageView:(UIImageView*) imageView
{
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		GtPhotoView* photoView = (GtPhotoView*) [m_scrollView tiledViewAtIndex:i];
		if(photoView.imageView == imageView)
		{
			return photoView;
		}
	}
	return nil;
}

- (void) zoomingScrollView:(GtZoomingScrollView*) zoomingScrollView isClosePinching:(CGFloat) zoomScale
{
}

- (void) zoomingScrollViewShouldCloseView:(GtZoomingScrollView*) zoomingScrollView
{
}

- (void) zoomingScrollView:(GtZoomingScrollView*) tilingScrollView 
	zoomScaleForViewChanged:(UIImageView*) imageView 
	zoomScale:(CGFloat) zoomScale
{
	[self _downloadPhotosIfNeeded:YES];
}

- (void) zoomingScrollView:(GtZoomingScrollView*) tilingScrollView 
	zoomingDidStopForView:(UIImageView*) imageView
{
	[self _downloadPhotosIfNeeded:YES];
}

- (void) zoomingScrollView:(GtZoomingScrollView*) tilingScrollView 
	userTappedView:(UIImageView*) imageView 
	withTouch:(UITouch*) touch
{
	if(!self.isFullScreenTapDisabled)
	{
		[self toggleFullScreen:YES];
	}
}

- (BOOL) zoomingScrollView:(GtZoomingScrollView*) zoomingScrollView canZoomView:(UIImageView*) imageView
{
	return [self photoViewForImageView:imageView].imageSize >= GtPhotoViewImageSizeFullScreen;
}

- (void) zoomingScrollView:(GtZoomingScrollView*) zoomingScrollView zoomingDidStartForView:(id) view
{
}


@end




