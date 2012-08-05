//
//	FLPhotoViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/19/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLPhotoViewController.h"


#import "FLGeometry.h"
#import "FLOldUserNotificationView.h"

#import "FLAction.h"
#import "FLImageUtilities.h"
#import "FLSlideShowOptionsViewController.h"
#import "FLZoomingScrollView.h"
#import "UIImage+FLColorize.h"

#import "FLPhotoMapViewController.h"
#import "FLButtonbarToolbar.h"
#import "FLNavigationControllerViewController.h"

#import "FLRandom.h"

#import "FLFloatingViewController.h"


@implementation FLPhotoViewLoadingState 

@synthesize image = m_image;
@synthesize photoView = m_photoView;
@synthesize photo = m_photo;
@synthesize imageSize = m_imageSize;
@synthesize lastKnownPhotoIndex = m_lastKnownPhotoIndex;
FLSynthesizeStructProperty(isRefreshing, setRefreshing, BOOL, m_flags);
FLSynthesizeStructProperty(isLoading, setLoading, BOOL, m_flags);

- (void) dealloc
{
	FLRelease(m_image);
	FLRelease(m_photo);
	FLRelease(m_photoView);
	FLSuperDealloc();
}

@end

#ifdef DEBUG
#define LOG 0
#endif

#if LOG
#warning LOG enabled
#endif

@interface FLPhotoViewController ()
- (void) _downloadPhotosIfNeeded:(BOOL) resetErrorsFirst;
@end

#define NO_AUTOROTATE 1

#define DefaultSlideShowSpeed 5
#define DefaultFullScreenTimerSpeed 7


@implementation FLPhotoViewController

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

FLSynthesizeStructProperty(isNetworkAware, setNetworkAware, BOOL, m_photoViewControllerFlags);
FLSynthesizeStructProperty(shouldRefreshWhenAppearing, setShouldRefreshWhenAppearing, BOOL, m_photoViewControllerFlags);
FLSynthesizeStructProperty(autoZoomPhotos, setAutoZoomPhotos, BOOL, m_photoViewControllerFlags);
FLSynthesizeStructProperty(inSlideShow, setInSlideShow, BOOL, m_photoViewControllerFlags);
FLSynthesizeStructProperty(isFullScreenTapDisabled, setFullScreenTapDisabled, BOOL, m_photoViewControllerFlags);

- (id) init
{
    self = [super init];
    if(self)
    {
        [self createActionContext];
        self.wantsApplyTheme = YES;


		self.title = @"";// NSLocalizedString(@"Photo", nil);

		self.shouldRefreshWhenAppearing = YES;

		m_action = [[FLActionReference alloc] init];
		m_thumbnailAction = [[FLActionReference alloc] init];
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

- (BOOL) wantsUIElement:(FLPhotoViewControllerUIElement) element
{
	return FLBitTest(m_uiElementMask, element);
}

- (FLPhotoViewLoadingState*) loadingState
{
	return m_action.action != nil ? m_action.action.state : nil;
}

- (void) cleanupPhotoViewController
{
	m_scrollView.delegate = nil;
	m_scrollView.tilingScrollViewDelegate = nil;

	FLReleaseWithNil(m_scrollView);
    FLReleaseWithNil(m_topToolbar);
	FLReleaseWithNil(m_bottomToolbar);
	FLReleaseWithNil(m_thumbnailBar);
	FLReleaseWithNil(m_editButton);
	FLReleaseWithNil(m_playButton);
	FLReleaseWithNil(m_prevButton);
	FLReleaseWithNil(m_nextButton);
	
	FLReleaseWithNil(m_organizeButton);
	FLReleaseWithNil(m_actionButton);
	FLReleaseWithNil(m_thumbnailCountView);

	FLReleaseWithNil(m_photoMapController);

}

- (void)dealloc 
{   
	[self stopSlideShowTimer];
    [self cleanupPhotoViewController];
	FLRelease(m_randomSlideshowIndexes);
	FLRelease(m_slideshowOptions);
	self.photoViewControllerDelegate = nil;
	FLRelease(m_action);
	FLRelease(m_thumbnailAction);
	FLSuperDealloc();
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
	if(FLStringIsEmpty(self.nibName))
	{
		UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)];
		view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		view.autoresizesSubviews = YES;
		
		m_scrollView = [[FLTilingScrollView alloc] initWithFrame:view.bounds];
		m_scrollView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		m_scrollView.autoresizesSubviews = YES;
		m_scrollView.backgroundColor = [UIColor blackColor];
		[view addSubview:m_scrollView];
		
		self.view = view;
		FLRelease(view);
	
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
        FLLog(@"Showing photo at index: %d", newIndex);
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
            [self setCurrentPhotoIndex:MAX(self.photoCount - 1, 0) animated:YES];
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
	if([self wantsUIElement:FLPhotoViewControllerUIElementTopBalloon])
	{
		[self.buttonbar viewForKey:@"balloon"].hidden = !hasCaption;
		[self.buttonbar setNeedsLayout];
	}
}

- (void) updateVisibleViewElements
{
	[self _updateTitle];
	
	if([self wantsUIElement:FLPhotoViewControllerUIElementTopBalloon])
	{
		[self _updateBalloon:FLStringIsNotEmpty([m_photoViewControllerDelegate photoViewController:self detailsForPhotoAtIndex:self.currentPhotoIndex])];
	}
	
	if(DeviceIsPad() && [self wantsUIElement:FLPhotoViewControllerUIElementGpsPinButton])
	{
		FLGpsExif* exif = [self.photoViewControllerDelegate photoViewController:self gpsExifForPhotoAtIndex:self.currentPhotoIndex];
		[self.buttonbar setViewHidden:(exif == nil) forKey:@"map" animated:YES];
	}
}

- (void) applyTheme:(FLTheme*) theme {
// 	[self applyThemeToNotificationView:view];

}


- (void) showDetailsView:(FLPhotoView*) photoView photoIndex:(NSUInteger) photoIndex
{
	NSString* details = [m_photoViewControllerDelegate photoViewController:self detailsForPhotoAtIndex:photoIndex];
	if( FLStringIsNotEmpty(details) && !photoView.detailsView)
	{
		FLOldNotificationView* view = [[FLOldNotificationView alloc] init];
#if VIEW_AUTOLAYOUT
		view.viewDelegate = self;
		view.autoLayoutMode = FLContentModeMake(FLContentModeHorizontalFill, FLContentModeVerticalTop);
#endif        
		// TODO: make isHtml and maxTextHeight configurable
		
		view.roundRectView.fillAlpha = FLCaptionOpacity;
		view.roundRectView.borderAlpha = FLCaptionOpacity;

		view.notificationViewDelegate = self;
		view.isHtml	 = YES;
		view.maxTextHeight = 180;
		view.animationType = FLViewAnimationTypeFade;
		view.dismissStyle = FLOldNotificationViewDismissStyleCloseBox;
		view.text = details;
		photoView.detailsView = view;
		FLReleaseWithNil(view);
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

- (FLPhotoViewImageSize) imageSizeForZoomScale:(CGFloat) zoomScale
{
	return zoomScale > 1.0 ? FLPhotoViewImageSizeHighResolution : FLPhotoViewImageSizeFullScreen;
}

- (void) _actionDidComplete:(FLAction*) action
{
	FLPhotoViewLoadingState* loadingState = action.state;

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
		FLLog(@"Got cancelled action, will try again");
	}
#endif	  
	
	if(m_action.action == action)
	{
		m_action.action = nil;
	}
	
	[self _downloadPhotosIfNeeded:NO];
	
}

- (void) onWillShowNotification:(FLAction*) action
{
	BOOL isCenter = (self.loadingState.photoView == self.centerView);
	action.disableWarningNotifications = !isCenter;
	action.disableErrorNotifications = !isCenter;
}

- (void) stopZooming:(BOOL) animated
	target:(id) target
	action:(SEL) action
{
	FLPhotoView* photoView = self.centerView;
	
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
	FLLog(@"beginning to load photo view at idx: %d", self.currentPhotoIndex);
#endif
	
	FLPhotoView* photoView = self.centerView;
	
	if(photoView.imageScrollView.isZoomingScrollViewZooming)
	{
		[photoView.imageScrollView stopZooming:YES target:self action:@selector(reloadCurrentPhoto:)];
		return;
	} 
	
	FLPhotoViewLoadingState* state = FLReturnAutoreleased([[FLPhotoViewLoadingState alloc] init]);
	state.photoView = photoView;
	state.photo = [self currentPhoto];
	state.lastKnownPhotoIndex = self.currentPhotoIndex;
	state.imageSize = FLPhotoViewImageSizeFullScreen;
	state.refreshing = YES;
	
	[self stopZooming:NO target:nil action:nil];
	[photoView resetState];
	
	FLAction* action = [m_photoViewControllerDelegate photoViewController:self createLoadAction:state];		 
	if(action)
	{
		m_action.action = action;
		action.state = state;


// FIXME: progress commented out here.

//        action.progressController.onShowProgress = ^(id theAction) {
//
//#if VIEW_AUTOLAYOUT
////				((FLWidgetView*)action.progressView).viewDelegate = self;
//            [theAction.progressView showProgressInSuperview:state.photoView];
//#endif
//
////TODO no progress here
//
//        };
        
        action.onShowNotification = ^(id theAction){
            [self onWillShowNotification:theAction];
        };

        action.onFinished = ^(id theAction) { 
            [self _actionDidComplete:action]; 
            };

		[self.actionContext beginAction:action];

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

- (void) _setImageForView:(FLPhotoView*) photoView img:(UIImage*) img forImageSize:(FLPhotoViewImageSize) imageSize
{
	[photoView setImage:img forImageSize:imageSize];
	
	if(self.inSlideShow)
	{
		[self startPlayingMusicIfNeeded];
	}
}

- (void) updatePhotoView:(FLPhotoView*) photoView withImage:(UIImage*) image forImageSize:(FLPhotoViewImageSize) imageSize
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
	FLAssertIsNotNil(toolbar);
	FLAssertIsNotNil(oldItem);
	FLAssertIsNotNil(newView);

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
				*outNewItem = FLReturnRetained(customItem);
			}
   
			FLReleaseWithNil(customItem);
			
			break;
		}
	}

	toolbar.items = items;
	
	FLAssert(foundIt, @"didn't find item");
	
	return foundIt;
}

- (void) slideshowOptionsViewController:(FLSlideshowOptionsViewController*) viewController
	beginSlideshowWithOptions:(FLSlideshowOptions*) options
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
		FLSlideshowOptionsViewController* controller = [FLSlideshowOptionsViewController slideshowOptionsViewController:self.slideshowOptions showStartNowButton:YES];
		controller.slideshowOptionsDelegate = self;
		controller.autoResizeFloatingView = YES;
		controller.buttonStrategy = FLEditObjectViewControllerShowCancelButtonOnly;

        [self presentFloatingViewController:[FLNavigationControllerViewController navigationControllerViewController:controller] 
            permittedArrowDirection:FLFloatingViewControllerArrowDirectionUp
            fromPositionProvider:[self.buttonbar viewForKey:@"slideshow"]
            withBehavior:nil
            withAnimation:nil];
	}
}

- (void) handleTools:(id) sender
{
}

- (void) _showGpsMap:(id) sender
{
	FLGpsExif* exif = [self.photoViewControllerDelegate photoViewController:self gpsExifForPhotoAtIndex:self.currentPhotoIndex];
	if(exif)
	{
		if(!m_photoMapController)
		{
			m_photoMapController = [[FLWeakReference alloc] init];
		}
	
		FLPhotoMapViewController* controller = FLReturnAutoreleased([[FLPhotoMapViewController alloc] init]);
		m_photoMapController.object = controller;
		if(DeviceIsPad())
		{
            [self presentFloatingViewController:[FLNavigationControllerViewController navigationControllerViewController:controller] 
                permittedArrowDirection:FLFloatingViewControllerArrowDirectionUp
                fromPositionProvider:[self.buttonbar viewForKey:@"map"]
                withBehavior:nil
                withAnimation:nil];
		}
		else if(self.navigationController)
		{
			[self.navigationController pushViewController:controller animated:YES];
		}
        else
        {
            FLAssertFailed(@"How do I show the gps map?");
        }
        
		[controller addPin:NSLocalizedString(@"Taken Here:", nil) coordinate:exif.coordinate];
		controller.title = [self.photoViewControllerDelegate photoViewController:self titleForPhotoAtIndex:self.currentPhotoIndex];
	}
}

- (void) createTopToolbar
{
	if(DeviceIsPad() && [self wantsUIElement:FLPhotoViewControllerUIElementGpsPinButton])
	{
		UIView* mapButton = [FLButtonbarView createImageButtonByName:@"globe.png" imageColor:FLImageColorBlack target:self action:@selector(_showGpsMap:)];
	//	  mapButton.hidden = YES;
		[self.buttonbar addViewToLeftSide:mapButton forKey:@"map" animated:NO];
	}

	if([self wantsUIElement:FLPhotoViewControllerUIElementTopBalloon])
	{
		[self.buttonbar addViewToRightSide:[FLButtonbarView createImageButtonByName:@"balloon.png" imageColor:FLImageColorBlack target:self action:@selector(onTappedToolbar:)] forKey:@"balloon" animated:NO];
		
		[self.buttonbar setViewHidden:YES forKey:@"balloon.png" animated:NO];
	}

	if(DeviceIsPad())
	{
		if([self wantsUIElement:FLPhotoViewControllerUIElementTopPlaySlideshowButton] )
		{
			m_playButton = [[FLButtonbarView createImageButtonByName:@"playicon.png"
																imageColor:FLImageColorBlack 
                                                                target:self action:@selector(handleSlideShowPress:)] retain];

			[self.buttonbar addViewToRightSide:m_playButton forKey:@"slideshow" animated:NO];
		}
		
		if([self wantsUIElement:FLPhotoViewControllerUIElementTopToolsButton] )
		{
			[self.buttonbar addViewToRightSide:
					[FLButtonbarView createImageButtonByName:@"tools_small.png"
                                                  imageColor:FLImageColorBlack 
                                                      target:self action:@selector(handleTools:)] forKey:@"tools" animated:NO];
		}
	}

	if([self wantsUIElement:FLPhotoViewControllerUIElementTopComposeButton])
	{
		[self.buttonbar addViewToRightSide:
				[FLButtonbarView createImageButtonByName:@"composeicon.png"
                                              imageColor:FLImageColorBlack 
														target:self action:@selector(handleInfoPress:)] forKey:@"compose" animated:NO];
	}
}

- (void) viewDidDisappear:(BOOL)animated
{
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*)[m_scrollView tiledViewAtIndex:i];
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

- (void) updateViewContentsDescriptor
{
    FLMutableViewContentsDescriptor* contents = [FLMutableViewContentsDescriptor mutableViewContentsDescriptor];

    contents.hasStatusBar = YES;
    
    if(self.navigationController)
	{
		contents.topItem = FLViewContentItemNavigationBar;
	}
    else if(m_topToolbar)
    {
        contents.topItem = FLViewContentItemToolbar;
    }

	if(m_bottomToolbar)
	{
		contents.bottomItem = FLViewContentItemToolbar;
	}
	if(m_thumbnailBar)
	{
		contents.bottomItem = FLViewContentItemToolbar;
	}
    
    self.viewContentsDescriptor = contents;
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

- (void) thumbnailBarViewTouchesStarted:(FLImageThumbnailBarView*) thumbnailBar
{
	m_photoViewControllerFlags.wantsThumbnailLoad = NO;
}

- (void) thumbnailBarViewTouchesStopped:(FLImageThumbnailBarView*) thumbnailBar
{
	if(m_photoViewControllerFlags.wantsThumbnailLoad)
	{
		[self _startLoading];
	}
	
	[m_thumbnailCountView removeFromSuperviewWithAnimationType:FLViewAnimationTypeFade duration:0.3 finishedBlock:nil];
	FLReleaseWithNil(m_thumbnailCountView);
}

- (void) thumbnailBarView:(FLImageThumbnailBarView*) thumbnailBar didChangeSelectedThumbnail:(NSUInteger) newIndex
{
	if(newIndex != self.currentPhotoIndex)
	{
		m_photoViewControllerFlags.wantsThumbnailLoad = YES;
       	[self setCurrentPhotoIndex:newIndex animated:NO]; // ANIMATED?

		if(!m_thumbnailCountView)
		{
			m_thumbnailCountView = [[FLThumbnailBarCountView alloc] initWithFrame:CGRectMake(0,0, 140, 40)];
			m_thumbnailCountView.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(self.view.bounds, FLRectSetTop(m_thumbnailCountView.frame, self.view.bounds.size.height * 0.80));
			m_thumbnailCountView.autoresizesSubviews = NO;
			m_thumbnailCountView.autoresizingMask = UIViewAutoresizingPositioned;
			
			[self.view addSubview:m_thumbnailCountView];
			[m_thumbnailCountView animateOntoScreen:FLViewAnimationTypeFade duration:0.3 finishedBlock:nil];
		}
		
		[m_thumbnailCountView updateCount:newIndex+1 total:self.photoCount];
	}
}

- (NSUInteger) thumbnailBarViewGetThumbnailCount:(FLImageThumbnailBarView*) thumbnailBar
{
	return self.photoCount;
}

- (NSUInteger) thumbnailBarViewGetSelectedThumbnailIndex:(FLImageThumbnailBarView*) thumbnailBar
{
	return m_currentPhotoIndex;
}

- (void) createBottomToolbar
{
    if(DeviceIsPad())
	{
		if(!m_thumbnailBar)
		{
			m_thumbnailBar = [[FLPhotoThumbnailToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 44)];
			m_thumbnailBar.autoresizingMask = UIViewAutoresizingPositioned | UIViewAutoresizingFlexibleWidth;
			m_thumbnailBar.frame = FLRectJustifyRectInRectBottom(self.view.bounds, m_thumbnailBar.frame);
			m_thumbnailBar.barStyle = UIBarStyleBlack;
			m_thumbnailBar.translucent = YES;
			[self.view addSubview:m_thumbnailBar];
		}
	
		self.thumbnailBar.thumbnailBarView.delegate = self;
		[self.thumbnailBar.thumbnailBarView resetThumbnails];
	}
	else
	{
        UIToolbar* bottomToolbar = FLReturnAutoreleased([[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 44)]);
        bottomToolbar.barStyle = UIBarStyleBlack;
        bottomToolbar.translucent = YES;
        bottomToolbar.frame = FLRectJustifyRectInRectBottom(self.view.bounds, m_bottomToolbar.frame);
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
		FLPhotoView* photoView = (FLPhotoView*) [m_scrollView tiledViewAtIndex:i];
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

- (void) notificationViewWasTouched:(FLOldNotificationView*) view
{
//	  [self cancelFullScreenTimer];
}

- (void) notificationViewDidShow:(FLOldNotificationView*) view
{
}

- (void) notificationViewDidHide:(FLOldNotificationView*) view
{
}

- (void) notificationViewUserClosed:(FLOldNotificationView*) closingView
{
	m_photoViewControllerFlags.showingDetailsView = NO;
	
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*) [m_scrollView tiledViewAtIndex:i];
		if(photoView && photoView.detailsView != nil && closingView != photoView.detailsView)
		{
			[photoView hideDetailsView];
		}
	}
}

- (void) resetErrors
{
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*)[m_scrollView tiledViewAtIndex:i];
		if(photoView.loadingDidFail)
		{
			[photoView clearError];
		}
	}
}

- (BOOL) _pingViewAtIndex:(NSUInteger) viewIndex 
	photoIndex:(NSUInteger) photoIndex
	wantedSize:(FLPhotoViewImageSize) imageSize
{
	FLPhotoView* photoView = (FLPhotoView*) [m_scrollView tiledViewAtIndex:viewIndex];	  
	if(photoView.loadingDidFail)
	{
		return NO;
	}
	
	if(photoView.imageSize != imageSize)
	{
#if LOG
		FLLog(@"beginning to load photo view at idx: %d", viewIndex);
#endif
		FLPhotoViewLoadingState* state = FLReturnAutoreleased([[FLPhotoViewLoadingState alloc] init]);
		state.photoView = photoView;
		state.photo = [m_photoViewControllerDelegate photoViewController:self photoAtIndex:photoIndex];
		state.lastKnownPhotoIndex = photoIndex;
		state.imageSize = imageSize;
		FLAction* action = [m_photoViewControllerDelegate photoViewController:self createLoadAction:state];		 
		
		if(action)
		{
			action.state = state;
			m_action.action = action;


// FIXME: progress commented out

//				action.progressController.onShow = ^(id theAction) {
//#if VIEW_AUTOLAYOUT
////					((FLWidgetView*)action.progressView).viewDelegate = self;
//					[[theAction progressController] showProgressInSuperview:state.photoView];
//#endif                    
////TODO no progress here
//				};
				
				action.onShowNotification = ^(id theAction) {
					[self onWillShowNotification:theAction];
				};

				action.onFinished = ^(id theAction) { 
                    [self _actionDidComplete:theAction]; };
			
                [self.actionContext beginAction:action];

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
			FLPhotoView* photoView = (FLPhotoView*)[m_scrollView tiledViewAtIndex:i];
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
			if(m_scrollView.lastScrollDirection == FLTilingScrollViewSlideDirectionLeft)
			{
				if(nextIndex <= (NSInteger) m_scrollView.lastNextViewIndex)
				{
					[self _pingViewAtIndex:nextIndex++ photoIndex:[self relativePhotoIndex:i+1] wantedSize:FLPhotoViewImageSizeFullScreen];
					if(self.isLoadingPhoto)
					{
						break;
					}
				}
				
				if(prevIndex >= (NSInteger) m_scrollView.firstPreviousViewIndex)
				{
					[self _pingViewAtIndex:prevIndex-- photoIndex:[self relativePhotoIndex:-(i+1)] wantedSize:FLPhotoViewImageSizeFullScreen];
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
					[self _pingViewAtIndex:prevIndex-- photoIndex:[self relativePhotoIndex:-(i+1)] wantedSize:FLPhotoViewImageSizeFullScreen];
					if(self.isLoadingPhoto)
					{
						break;
					}
				}
			  
				if(nextIndex <= (NSInteger) m_scrollView.lastNextViewIndex)
				{
					[self _pingViewAtIndex:nextIndex++ photoIndex:[self relativePhotoIndex:i+1] wantedSize:FLPhotoViewImageSizeFullScreen];
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
		FLPhotoView* photoView = (FLPhotoView*)[m_scrollView tiledViewAtIndex:i];
		if(photoView)
		{
			if(show)
			{
				[self showDetailsView:photoView photoIndex:[self photoIndexFromViewIndex:i]];
			}
			else
			{
				[photoView.detailsView hideNotification];
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
					FLRectSetHeight(
						FLRectSetTop(self.navigationController.navigationBar.frame, [[UIDevice currentDevice] statusBarHeight]),
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
		FLPhotoView* photoView = (FLPhotoView*)[m_scrollView tiledViewAtIndex:i];
		if(photoView)
		{
			if(photoView.detailsView)
			{
				[views addObject:photoView.detailsView];
			}
		
			if(photoView.errorView && [photoView.errorView isKindOfClass:[FLOldNotificationView class]])
			{
				[views addObject:photoView.errorView];
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

- (void) thumbnailBarViewNextButtonPressed:(FLImageThumbnailBarView*) thumbnailBar
{
	[self handleNextPress:thumbnailBar];
}

- (void) thumbnailBarViewPreviousButtonPressed:(FLImageThumbnailBarView*) thumbnailBar
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

- (FLPhotoView*) centerView
{
	return (FLPhotoView*)m_scrollView.centerView;
}

- (void) showErrorMessageInPhotoView:(FLPhotoView*) photoView 
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
// TODO: replace this

//			FLOldUserNotificationView* view = FLReturnAutoreleased([[FLOldUserNotificationView alloc] initAsInfoNotification]);
//			view.autoDismiss = NO;
//			view.shouldAutoCloseAfterDelay = NO;
//#if VIEW_AUTOLAYOUT
//			view.viewDelegate = self;
//#endif
//			view.text = errorMessage;
//			photoView.errorView = view;

//			[photoView addSubview:view];
		}
		else
		{
			UIView* view = FLReturnAutoreleased([[UIView alloc] initWithFrame:photoView.bounds]);
			view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
			view.autoresizesSubviews = YES;
			view.backgroundColor = [UIColor clearColor];
			view.userInteractionEnabled = YES;
			
			UILabel* label = FLReturnAutoreleased([[UILabel alloc] initWithFrame:DeviceIsPad() ? CGRectMake(0,0, 400, 400): CGRectMake(0,0, 300, 300)]);
			label.userInteractionEnabled = YES;
			label.textAlignment = UITextAlignmentCenter;
			label.numberOfLines = 0;
			label.backgroundColor = [UIColor clearColor];
			label.autoresizingMask = UIViewAutoresizingPositioned;
			label.frameOptimizedForSize = FLRectCenterRectInRect(view.frame, label.frame);
			label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
			label.textColor = [UIColor lightGrayColor];
			label.text = errorMessage;
			[view addSubview:label];
			[photoView.imageScrollView addSubview:view];
			photoView.errorView = view;
		}
	}
}

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView 
	willRemoveView:(FLPhotoView*) view
{
	view.imageScrollView.touchableScrollViewDelegate = nil;
	view.imageScrollView.zoomingScrollViewDelegate = nil; 
}

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView createTiledView:(UIView**) outView
{
	FLPhotoView* imgView = [[FLPhotoView alloc] initWithFrame:self.view.bounds];
	imgView.autoZoom = self.autoZoomPhotos;
	imgView.autoShowSpinner = YES;
	imgView.imageScrollView.touchableScrollViewDelegate = tilingScrollView;
	imgView.imageScrollView.zoomingScrollViewDelegate = self; 
	[imgView startSpinner];
	*outView = imgView;
}

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView 
	releaseMemoryForView:(FLPhotoView*) view
	atIndex:(NSInteger) idx
{
	[view resetState];
}

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView didTileViews:(FLTilingScrollViewSlideDirection) slideDirection
{
	switch(slideDirection)
	{
		case FLTilingScrollViewSlideDirectionLeft:
		{
			m_currentPhotoIndex = [self relativePhotoIndex:1];
		}
		break;
		
		case FLTilingScrollViewSlideDirectionRight:
		{
			m_currentPhotoIndex = [self relativePhotoIndex:-1];
		}
		break;
		
		default:
			FLAssertFailed(@"wtf?");
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

- (void) tilingScrollViewDidFinishDragAnimation:(FLTilingScrollView*) tilingScrollView
{
//	  m_photoViewControllerFlags.wantsFullScreenAfterDrag = YES;
//	  if(action.didFinishWithoutError && m_photoViewControllerFlags.wantsFullScreenAfterDrag)
//	  {
//		  [self enterFullScreen:YES];
//	  }

	[self enterFullScreen:YES];

}

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView willScrollView:(FLPhotoView*) photoView
{
}

- (void) tilingScrollView:(FLTilingScrollView*) tilingScrollView 
	willTileViews:(FLTilingScrollViewSlideDirection) slideDirection
{
	[self.centerView.imageScrollView setZoomingScrollViewZoomScale:1.0 animated:NO];
}

- (void) tilingScrollViewWillRotate:(FLTilingScrollView*) tilingScrollView;
{
}

- (void) tilingScrollViewDidRotate:(FLTilingScrollView*) tilingScrollView
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
	FLRelease(m_randomSlideshowIndexes);
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
			
				NSUInteger randomIndex = FLRandomInt(0, m_randomSlideshowIndexes.count - 1);
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

	if(self.centerView.imageSize >= FLPhotoViewImageSizeFullScreen)
	{
		m_slideShowTimer = [NSTimer timerWithTimeInterval:m_slideshowOptions.speedValue 
				target:self 
				selector:@selector(handleSlideShowNext:) 
				userInfo:nil 
				repeats:NO];
			
		[[NSRunLoop mainRunLoop] addTimer:m_slideShowTimer forMode:NSRunLoopCommonModes];
	}
}

- (FLPhotoView*) photoViewForImageView:(UIImageView*) imageView
{
	for(NSUInteger i = 0; i < m_scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*) [m_scrollView tiledViewAtIndex:i];
		if(photoView.imageView == imageView)
		{
			return photoView;
		}
	}
	return nil;
}

- (void) zoomingScrollView:(FLZoomingScrollView*) zoomingScrollView isClosePinching:(CGFloat) zoomScale
{
}

- (void) zoomingScrollViewShouldCloseView:(FLZoomingScrollView*) zoomingScrollView
{
}

- (void) zoomingScrollView:(FLZoomingScrollView*) tilingScrollView 
	zoomScaleForViewChanged:(UIImageView*) imageView 
	zoomScale:(CGFloat) zoomScale
{
	[self _downloadPhotosIfNeeded:YES];
}

- (void) zoomingScrollView:(FLZoomingScrollView*) tilingScrollView 
	zoomingDidStopForView:(UIImageView*) imageView
{
	[self _downloadPhotosIfNeeded:YES];
}

- (void) zoomingScrollView:(FLZoomingScrollView*) tilingScrollView 
	userTappedView:(UIImageView*) imageView 
	withTouch:(UITouch*) touch
{
	if(!self.isFullScreenTapDisabled)
	{
		[self toggleFullScreen:YES];
	}
}

- (BOOL) zoomingScrollView:(FLZoomingScrollView*) zoomingScrollView canZoomView:(UIImageView*) imageView
{
	return [self photoViewForImageView:imageView].imageSize >= FLPhotoViewImageSizeFullScreen;
}

- (void) zoomingScrollView:(FLZoomingScrollView*) zoomingScrollView zoomingDidStartForView:(id) view
{
}


@end




