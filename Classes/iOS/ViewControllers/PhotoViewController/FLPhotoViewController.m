//
//	FLPhotoViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/19/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPhotoViewController.h"


#import "FLGeometry.h"
#import "FLOldUserNotificationView.h"

#import "FLAction.h"
#import "FLImageUtilities.h"
#import "FLSlideShowOptionsViewController.h"
#import "FLZoomingScrollView.h"
#import "UIImage+Colorize.h"

#import "FLPhotoMapViewController.h"
#import "FLDeprecatedButtonbarToolbar.h"
#import "FLNavigationControllerViewController.h"

#import "FLRandom.h"

#import "FLFloatingViewController.h"


@implementation FLPhotoViewLoadingState 

@synthesize image = _image;
@synthesize photoView = _photoView;
@synthesize photo = _photo;
@synthesize imageSize = _imageSize;
@synthesize lastKnownPhotoIndex = _lastKnownPhotoIndex;
FLSynthesizeStructProperty(isRefreshing, setRefreshing, BOOL, _flags);
FLSynthesizeStructProperty(isLoading, setLoading, BOOL, _flags);

- (void) dealloc
{
	FLRelease(_image);
	FLRelease(_photo);
	FLRelease(_photoView);
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

@synthesize currentPhotoIndex = _currentPhotoIndex;
@synthesize photoViewControllerDelegate = _photoViewControllerDelegate;
@synthesize bottomToolbar = _bottomToolbar;
@synthesize topToolbar = _topToolbar;
@synthesize thumbnailBar = _thumbnailBar;
@synthesize organizeButton = _organizeButton;
@synthesize actionButton = _actionButton;
@synthesize uiElementMask = _uiElementMask;
@synthesize slideshowOptions = _slideshowOptions;
@synthesize slideShowPlayButton = _playButton;

FLSynthesizeStructProperty(isNetworkAware, setNetworkAware, BOOL, _photoViewControllerFlags);
FLSynthesizeStructProperty(shouldRefreshWhenAppearing, setShouldRefreshWhenAppearing, BOOL, _photoViewControllerFlags);
FLSynthesizeStructProperty(autoZoomPhotos, setAutoZoomPhotos, BOOL, _photoViewControllerFlags);
FLSynthesizeStructProperty(inSlideShow, setInSlideShow, BOOL, _photoViewControllerFlags);
FLSynthesizeStructProperty(isFullScreenTapDisabled, setFullScreenTapDisabled, BOOL, _photoViewControllerFlags);

- (id) init {
    self = [super init];
    if(self) {
        self.wantsApplyTheme = YES;

		self.title = @"";// NSLocalizedString(@"Photo", nil);

		self.shouldRefreshWhenAppearing = YES;

//		_action = [[FLActionReference alloc] init];
//		_thumbnailAction = [[FLActionReference alloc] init];
		self.wantsFullScreenLayout = YES;
    }
    
    return self;
}

- (NSUInteger) photoCount {
    return [self.photoViewControllerDelegate photoViewControllerGetPhotoCount:self];
}

- (BOOL) isLoadingPhoto {
	return _busyCount > 0; // _action.action != nil && ![_action.action isFinished] && !_action.action.wasCancelled;
}

- (CGFloat) zoomScale
{
	return self.centerView.imageScrollView.zoomingScrollViewZoomScale;
}

- (NSUInteger) relativePhotoIndex:(NSInteger) fromCurrent
{
	NSInteger idx = _currentPhotoIndex + fromCurrent;
	
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
	return FLTestBits(_uiElementMask, element);
}

//- (FLPhotoViewLoadingState*) loadingState
//{
//	return _action.action != nil ? _action.action.userObject : nil;
//}

- (void) cleanupPhotoViewController
{
	_scrollView.delegate = nil;
	_scrollView.tilingScrollViewDelegate = nil;

	FLReleaseWithNil(_scrollView);
    FLReleaseWithNil(_topToolbar);
	FLReleaseWithNil(_bottomToolbar);
	FLReleaseWithNil(_thumbnailBar);
	FLReleaseWithNil(_editButton);
	FLReleaseWithNil(_playButton);
	FLReleaseWithNil(_prevButton);
	FLReleaseWithNil(_nextButton);
	
	FLReleaseWithNil(_organizeButton);
	FLReleaseWithNil(_actionButton);
	FLReleaseWithNil(_thumbnailCountView);

	FLReleaseWithNil(_photoMapController);

}

- (void)dealloc 
{   
	[self stopSlideShowTimer];
    [self cleanupPhotoViewController];
	FLRelease(_randomSlideshowIndexes);
	FLRelease(_slideshowOptions);
	self.photoViewControllerDelegate = nil;
	FLRelease(_action);
	FLRelease(_thumbnailAction);
	FLSuperDealloc();
}

- (void) photoCountDidChange
{
	NSUInteger photoCount = self.photoCount;
    
	if(_thumbnailBar)
	{
		_thumbnailBar.nextButton.enabled = photoCount > 1;
		_thumbnailBar.backButton.enabled = photoCount > 1;
	}
	
	if(DeviceIsPad())
	{
		[self.buttonbar setViewEnabled:photoCount > 1 forKey:@"slideshow"];
	}
	else
	{
		[_playButton setEnabled: photoCount > 1];
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
		
		_scrollView = [[FLTilingScrollView alloc] initWithFrame:view.bounds];
		_scrollView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		_scrollView.autoresizesSubviews = YES;
		_scrollView.backgroundColor = [UIColor blackColor];
		[view addSubview:_scrollView];
		
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
	_scrollView.canScrollTiles = self.photoCount > 1;
	[self updateSlideShowButtons];
}

- (void) setCurrentPhotoIndex:(NSUInteger) index animated:(BOOL) animated
{
    _currentPhotoIndex = index;
    if(self.isViewLoaded)
    {
        [self updateVisibleViewElements];
        [self _downloadPhotosIfNeeded:YES];
        
        [self updateCanScrollTiles];
        
        if(_thumbnailBar)
        {
            self.thumbnailBar.thumbnailBarView.selectedThumbnailIndex = _currentPhotoIndex;
            [_thumbnailBar setNeedsLayout];
            [_thumbnailBar layoutIfNeeded];
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
		[_scrollView removeTiledView:self.centerView];
	
		if(_currentPhotoIndex >= self.photoCount)
		{
            [self setCurrentPhotoIndex:MAX(self.photoCount - 1, 0) animated:YES];
		}
        else	
        {
            [self setCurrentPhotoIndex:_currentPhotoIndex animated:YES];
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
        [NSString stringWithFormat:(NSLocalizedString(@"%d of %d", nil)), _currentPhotoIndex + 1, self.photoCount];
}

- (void) _updateTitle
{
	NSString* title = [_photoViewControllerDelegate photoViewController:self titleForPhotoAtIndex:self.currentPhotoIndex];
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
		[self _updateBalloon:FLStringIsNotEmpty([_photoViewControllerDelegate photoViewController:self detailsForPhotoAtIndex:self.currentPhotoIndex])];
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
	NSString* details = [_photoViewControllerDelegate photoViewController:self detailsForPhotoAtIndex:photoIndex];
	if( FLStringIsNotEmpty(details) && !photoView.detailsView)
	{
		FLOldNotificationView* view = [[FLOldNotificationView alloc] init];
#if VIEW_AUTOLAYOUT
		view.viewDelegate = self;
		view.autoLayoutMode = FLRectLayoutMake(FLRectLayoutHorizontalFill, FLRectLayoutVerticalTop);
#endif        
		// TODO: make isHtml and maxTextHeight configurable
		
		view.roundRectView.fillAlpha = FLCaptionOpacity;
		view.roundRectView.borderAlpha = FLCaptionOpacity;

		view.notificationViewDelegate = self;
		view.isHtml	 = YES;
		view.maxTextHeight = 180;
		view.animationType = FLAnimatedViewTypeFade;
		view.dismissStyle = FLOldNotificationViewDismissStyleCloseBox;
		view.text = details;
		photoView.detailsView = view;
		FLReleaseWithNil(view);
	}
}

- (void) _didLoadCenterView
{
	[self updateVisibleViewElements];

	if([_photoViewControllerDelegate respondsToSelector:@selector(photoViewController:didLoadCenterView:)])
	{
		[_photoViewControllerDelegate photoViewController:self didLoadCenterView:self.centerView];
	}
}

- (void) cancelCurrentLoadingAction {
    [self.operationContext cancelAllOperations];
}

- (FLPhotoViewImageSize) imageSizeForZoomScale:(CGFloat) zoomScale
{
	return zoomScale > 1.0 ? FLPhotoViewImageSizeHighResolution : FLPhotoViewImageSizeFullScreen;
}

- (void) _actionDidComplete:(FLAction*) action 	loadingState:(FLPhotoViewLoadingState*) loadingState
{
	if(!action.wasCancelled)
	{
		if([_scrollView indexForTiledView:loadingState.photoView] != NSNotFound)
		{
			[loadingState.photoView stopSpinner];
			if([action error])
			{
				[loadingState.photoView setLoadingDidFail];
			}
			[_photoViewControllerDelegate photoViewController:self actionDidComplete:action loadingState:loadingState];
			
			if(_photoViewControllerFlags.showingDetailsView)
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
					if(_photoViewControllerFlags.inSlideShow)
					{
						[self startSlideShowTimer];
					}
					[self _didLoadCenterView];
				}
				else
				{
					if(_photoViewControllerFlags.inSlideShow)
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
	
	[self _downloadPhotosIfNeeded:NO];
	
}

- (void) onWillShowNotification:(FLAction*) action {

// FIXME

//	BOOL isCenter = (self.loadingState.photoView == self.centerView);
//	action.disableWarningNotifications = !isCenter;
//	action.disableErrorNotifications = !isCenter;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

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

#pragma GCC diagnostic pop


- (id) currentPhoto
{
	return [_photoViewControllerDelegate photoViewController:self photoAtIndex:self.currentPhotoIndex];
}

- (void) reloadCurrentPhoto:(id) sender
{
//	  [_scrollView cancelLoadingForAllTiledViewsExceptViewAtIndex:_scrollView.centerViewIndex];
	
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
	
	FLPhotoViewLoadingState* state = FLAutorelease([[FLPhotoViewLoadingState alloc] init]);
	state.photoView = photoView;
	state.photo = [self currentPhoto];
	state.lastKnownPhotoIndex = self.currentPhotoIndex;
	state.imageSize = FLPhotoViewImageSizeFullScreen;
	state.refreshing = YES;
	
	[self stopZooming:NO target:nil action:nil];
	[photoView resetState];
	
	FLAction* action = [_photoViewControllerDelegate photoViewController:self createLoadAction:state];		 
	if(action)
	{

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

        ++_busyCount;
		[self startAction:action completion: ^(id result) {
            [self _actionDidComplete:action loadingState:state];
            --_busyCount;
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
	NSInteger idx = [_scrollView indexForTiledView:photoView];
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
	_scrollView.centerView.alpha = 0;

	[CATransaction begin];
	CATransition *animation = [CATransition animation];
	animation.type = kCATransitionFade;
	animation.duration = 0.3;
	
	CALayer* layer = _scrollView.layer;
	[layer addAnimation:animation forKey:@"FadeIn"];

	_scrollView.centerView.alpha = 1.0;
	
	[CATransaction commit];
	
	[layer removeAnimationForKey:@"FadeIn"];
}

- (void) onTappedToolbar:(id) sender
{
//	  [self cancelFullScreenTimer];
	_photoViewControllerFlags.showingDetailsView = !_photoViewControllerFlags.showingDetailsView;
	[self showHideAllDetailViews:_photoViewControllerFlags.showingDetailsView];
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
				*outNewItem = FLRetain(customItem);
			}
   
			FLReleaseWithNil(customItem);
			
			break;
		}
	}

	toolbar.items = items;
	
	FLAssertWithComment(foundIt, @"didn't find item");
	
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
		if(!_photoMapController)
		{
			_photoMapController = [[FLWeakReference alloc] init];
		}
	
		FLPhotoMapViewController* controller = FLAutorelease([[FLPhotoMapViewController alloc] init]);
		_photoMapController.object = controller;
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
            FLAssertFailedWithComment(@"How do I show the gps map?");
        }
        
		[controller addPin:NSLocalizedString(@"Taken Here:", nil) coordinate:exif.coordinate];
		controller.title = [self.photoViewControllerDelegate photoViewController:self titleForPhotoAtIndex:self.currentPhotoIndex];
	}
}

- (void) createTopToolbar
{
	if(DeviceIsPad() && [self wantsUIElement:FLPhotoViewControllerUIElementGpsPinButton])
	{
		UIView* mapButton = [FLDeprecatedButtonbarView createImageButtonByName:@"globe.png" imageColor:FLImageColorBlack target:self action:@selector(_showGpsMap:)];
	//	  mapButton.hidden = YES;
		[self.buttonbar addViewToLeftSide:mapButton forKey:@"map" animated:NO];
	}

	if([self wantsUIElement:FLPhotoViewControllerUIElementTopBalloon])
	{
		[self.buttonbar addViewToRightSide:[FLDeprecatedButtonbarView createImageButtonByName:@"balloon.png" imageColor:FLImageColorBlack target:self action:@selector(onTappedToolbar:)] forKey:@"balloon" animated:NO];
		
		[self.buttonbar setViewHidden:YES forKey:@"balloon.png" animated:NO];
	}

	if(DeviceIsPad())
	{
		if([self wantsUIElement:FLPhotoViewControllerUIElementTopPlaySlideshowButton] )
		{
			_playButton = [FLDeprecatedButtonbarView createImageButtonByName:@"playicon.png"
																imageColor:FLImageColorBlack 
                                                                target:self action:@selector(handleSlideShowPress:)] ;

			[self.buttonbar addViewToRightSide:_playButton forKey:@"slideshow" animated:NO];
		}
		
		if([self wantsUIElement:FLPhotoViewControllerUIElementTopToolsButton] )
		{
			[self.buttonbar addViewToRightSide:
					[FLDeprecatedButtonbarView createImageButtonByName:@"tools_small.png"
                                                  imageColor:FLImageColorBlack 
                                                      target:self action:@selector(handleTools:)] forKey:@"tools" animated:NO];
		}
	}

	if([self wantsUIElement:FLPhotoViewControllerUIElementTopComposeButton])
	{
		[self.buttonbar addViewToRightSide:
				[FLDeprecatedButtonbarView createImageButtonByName:@"composeicon.png"
                                              imageColor:FLImageColorBlack 
														target:self action:@selector(handleInfoPress:)] forKey:@"compose" animated:NO];
	}
}

- (void) viewDidDisappear:(BOOL)animated
{
	for(NSUInteger i = 0; i < _scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*)[_scrollView tiledViewAtIndex:i];
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
    else if(_topToolbar)
    {
        contents.topItem = FLViewContentItemToolbar;
    }

	if(_bottomToolbar)
	{
		contents.bottomItem = FLViewContentItemToolbar;
	}
	if(_thumbnailBar)
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
//	  if(_thumbnailAction.action)
//	  {
//		  [_thumbnailAction.action requestCancel];
//	  }
	[_photoViewControllerDelegate photoViewController:self beginLoadingThumbnailAtIndex:self.thumbnailBar.thumbnailBarView.nextThumbnailIndex];
}

- (void) _startLoading
{
	if(self.thumbnailBar && !self.thumbnailBar.thumbnailBarView.hasAllThumbnails)
	{
		[self _beginLoadingNextThumbnail];
	}

	[_scrollView resetAllViews];
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
	_photoViewControllerFlags.wantsThumbnailLoad = NO;
}

- (void) thumbnailBarViewTouchesStopped:(FLImageThumbnailBarView*) thumbnailBar
{
	if(_photoViewControllerFlags.wantsThumbnailLoad)
	{
		[self _startLoading];
	}
	
	[_thumbnailCountView removeFromSuperviewWithAnimationType:FLAnimatedViewTypeFade duration:0.3 finishedBlock:nil];
	FLReleaseWithNil(_thumbnailCountView);
}

- (void) thumbnailBarView:(FLImageThumbnailBarView*) thumbnailBar didChangeSelectedThumbnail:(NSUInteger) newIndex
{
	if(newIndex != self.currentPhotoIndex)
	{
		_photoViewControllerFlags.wantsThumbnailLoad = YES;
       	[self setCurrentPhotoIndex:newIndex animated:NO]; // ANIMATED?

		if(!_thumbnailCountView)
		{
			_thumbnailCountView = [[FLThumbnailBarCountView alloc] initWithFrame:CGRectMake(0,0, 140, 40)];
			_thumbnailCountView.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(self.view.bounds, FLRectSetTop(_thumbnailCountView.frame, self.view.bounds.size.height * 0.80));
			_thumbnailCountView.autoresizesSubviews = NO;
			_thumbnailCountView.autoresizingMask = UIViewAutoresizingPositioned;
			
			[self.view addSubview:_thumbnailCountView];
			[_thumbnailCountView animateOntoScreen:FLAnimatedViewTypeFade duration:0.3 finishedBlock:nil];
		}
		
		[_thumbnailCountView updateCount:newIndex+1 total:self.photoCount];
	}
}

- (NSUInteger) thumbnailBarViewGetThumbnailCount:(FLImageThumbnailBarView*) thumbnailBar
{
	return self.photoCount;
}

- (NSUInteger) thumbnailBarViewGetSelectedThumbnailIndex:(FLImageThumbnailBarView*) thumbnailBar
{
	return _currentPhotoIndex;
}

- (void) createBottomToolbar
{
    if(DeviceIsPad())
	{
		if(!_thumbnailBar)
		{
			_thumbnailBar = [[FLPhotoThumbnailToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 44)];
			_thumbnailBar.autoresizingMask = UIViewAutoresizingPositioned | UIViewAutoresizingFlexibleWidth;
			_thumbnailBar.frame = FLRectJustifyRectInRectBottom(self.view.bounds, _thumbnailBar.frame);
			_thumbnailBar.barStyle = UIBarStyleBlack;
			_thumbnailBar.translucent = YES;
			[self.view addSubview:_thumbnailBar];
		}
	
		self.thumbnailBar.thumbnailBarView.delegate = self;
		[self.thumbnailBar.thumbnailBarView resetThumbnails];
	}
	else
	{
        UIToolbar* bottomToolbar = FLAutorelease([[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 44)]);
        bottomToolbar.barStyle = UIBarStyleBlack;
        bottomToolbar.translucent = YES;
        bottomToolbar.frame = FLRectJustifyRectInRectBottom(self.view.bounds, _bottomToolbar.frame);
        bottomToolbar.autoresizingMask = UIViewAutoresizingPositioned | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:bottomToolbar];

        _prevButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"rewind.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handlePrevPress:)];
        _playButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"playicon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handlePlayPress:)];
        _nextButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fast_forward.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleNextPress:)];
        _organizeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(handleMovePress:)];
        _actionButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"at_symbol.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleActionPress:)];

        bottomToolbar.items = [NSArray arrayWithObjects:
            _prevButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            _playButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            _nextButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            _organizeButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            _actionButton,
            nil];
            
        self.bottomToolbar = bottomToolbar;
	}
}

- (void) viewDidLoad
{
	[super viewDidLoad];

	_scrollView.tilingScrollViewDelegate = self;
	
//	  if(self.photoCount >= 5 && [UIDevice currentDevice].isAtLeastIPhone4)
//	  {
//		  [_scrollView createTiles:5];
//	  }
//	  else
	{
		[_scrollView createTiles:3];
	}
	
	[self updateCanScrollTiles];

    [self createTopToolbar];
	[self createBottomToolbar];
	
    [self photoCountDidChange];
}

- (void) beginLoadingPhotosIfNeeded
{
	for(NSUInteger i = 0; i < _scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*) [_scrollView tiledViewAtIndex:i];
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
	_photoViewControllerFlags.showingDetailsView = NO;
	
	for(NSUInteger i = 0; i < _scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*) [_scrollView tiledViewAtIndex:i];
		if(photoView && photoView.detailsView != nil && closingView != photoView.detailsView)
		{
			[photoView hideDetailsView];
		}
	}
}

- (void) resetErrors
{
	for(NSUInteger i = 0; i < _scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*)[_scrollView tiledViewAtIndex:i];
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
	FLPhotoView* photoView = (FLPhotoView*) [_scrollView tiledViewAtIndex:viewIndex];	  
	if(photoView.loadingDidFail)
	{
		return NO;
	}
	
	if(photoView.imageSize != imageSize)
	{
#if LOG
		FLLog(@"beginning to load photo view at idx: %d", viewIndex);
#endif
		FLPhotoViewLoadingState* state = FLAutorelease([[FLPhotoViewLoadingState alloc] init]);
		state.photoView = photoView;
		state.photo = [_photoViewControllerDelegate photoViewController:self photoAtIndex:photoIndex];
		state.lastKnownPhotoIndex = photoIndex;
		state.imageSize = imageSize;
		FLAction* action = [_photoViewControllerDelegate photoViewController:self createLoadAction:state];		 
		
		if(action)
		{

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

            ++_busyCount;
            [self startAction:action completion: ^(id result) { 
                [self _actionDidComplete:action loadingState:state];
                --_busyCount;
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
		for(NSUInteger i = 0; i < _scrollView.tiledViewCount; i++)
		{
			FLPhotoView* photoView = (FLPhotoView*)[_scrollView tiledViewAtIndex:i];
			[photoView clearError];
		}
	}
			
	if(![self _pingViewAtIndex:_scrollView.centerViewIndex 
		photoIndex:self.currentPhotoIndex 
		wantedSize:[self imageSizeForZoomScale:self.zoomScale]] &&
		_photoViewControllerFlags.inSlideShow)
	{
		[self startSlideShowTimer];
	}
	   
	if(!self.isLoadingPhoto && self.photoCount > 1)
	{
		NSInteger nextIndex = _scrollView.firstNextViewIndex;
		NSInteger prevIndex = _scrollView.lastPreviousViewIndex;
		
		for(NSUInteger i = 0; i < _scrollView.nextTiledViewCount + _scrollView.previousTiledViewCount; i++)
		{
			if(_scrollView.lastScrollDirection == FLTilingScrollViewSlideDirectionLeft)
			{
				if(nextIndex <= (NSInteger) _scrollView.lastNextViewIndex)
				{
					[self _pingViewAtIndex:nextIndex++ photoIndex:[self relativePhotoIndex:i+1] wantedSize:FLPhotoViewImageSizeFullScreen];
					if(self.isLoadingPhoto)
					{
						break;
					}
				}
				
				if(prevIndex >= (NSInteger) _scrollView.firstPreviousViewIndex)
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
				if(prevIndex >= (NSInteger) _scrollView.firstPreviousViewIndex)
				{
					[self _pingViewAtIndex:prevIndex-- photoIndex:[self relativePhotoIndex:-(i+1)] wantedSize:FLPhotoViewImageSizeFullScreen];
					if(self.isLoadingPhoto)
					{
						break;
					}
				}
			  
				if(nextIndex <= (NSInteger) _scrollView.lastNextViewIndex)
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
	if(!_photoViewControllerFlags.shutDown)
	{
		_photoViewControllerFlags.shutDown = YES;
		
		[self stopSlideShow:YES];
		
		[self hideViewController:YES];
	}
}

- (NSUInteger) photoIndexFromViewIndex:(NSInteger) viewIndex
{
	return [self relativePhotoIndex:viewIndex - _scrollView.centerViewIndex];
}

- (void) showHideAllDetailViews:(BOOL) show
{
	for(NSUInteger i = 0; i < _scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*)[_scrollView tiledViewAtIndex:i];
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
	return _photoViewControllerFlags.fullScreen; // [UIApplication sharedApplication].statusBarHidden;
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

    if(_topToolbar)
    {
		[views addObject:_topToolbar];
    }
	if(_bottomToolbar)
	{
		[views addObject:_bottomToolbar];
	}
	if(_thumbnailBar)
	{
		[views addObject:_thumbnailBar];
	}

	for(NSUInteger i = 0; i < _scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*)[_scrollView tiledViewAtIndex:i];
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
                { _photoViewControllerFlags.fullScreen = hideViews;}
                ];
	}
	else
	{
		for(UIView* view in views)
		{
			view.hidden = hideViews;
		}
			
		_photoViewControllerFlags.fullScreen = hideViews;;
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

	if(_photoViewControllerFlags.inSlideShow)
	{	
		if(_slideShowStartIndex == _currentPhotoIndex)
		{
			[self stopSlideShow:YES];
		}
		
		[self _downloadPhotosIfNeeded:YES];
	}
}

- (void) handlePrevPress:(id) sender
{
	[_scrollView shiftArrangementToRight];
	[self _didPressNextOrPrevButton];
}

- (void) handleNextPress:(id) sender
{
	[_scrollView shiftArrangementToLeft];
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
	if(_photoViewControllerFlags.inSlideShow)
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
	return _scrollView;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation
	duration:(NSTimeInterval)duration
{
	[_scrollView willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[_scrollView didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (FLPhotoView*) centerView
{
	return (FLPhotoView*)_scrollView.centerView;
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

//			FLOldUserNotificationView* view = FLAutorelease([[FLOldUserNotificationView alloc] initAsInfoNotification]);
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
			UIView* view = FLAutorelease([[UIView alloc] initWithFrame:photoView.bounds]);
			view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
			view.autoresizesSubviews = YES;
			view.backgroundColor = [UIColor clearColor];
			view.userInteractionEnabled = YES;
			
			UILabel* label = FLAutorelease([[UILabel alloc] initWithFrame:DeviceIsPad() ? CGRectMake(0,0, 400, 400): CGRectMake(0,0, 300, 300)]);
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
			_currentPhotoIndex = [self relativePhotoIndex:1];
		}
		break;
		
		case FLTilingScrollViewSlideDirectionRight:
		{
			_currentPhotoIndex = [self relativePhotoIndex:-1];
		}
		break;
		
		default:
			FLAssertFailedWithComment(@"wtf?");
			break;
	}

	
	if(self.thumbnailBar)
	{
		 self.thumbnailBar.thumbnailBarView.selectedThumbnailIndex = _currentPhotoIndex;
	}
	[self updateVisibleViewElements];
	
	[self cancelCurrentLoadingAction];
	
	[self _downloadPhotosIfNeeded:YES];
}

- (void) tilingScrollViewDidFinishDragAnimation:(FLTilingScrollView*) tilingScrollView
{
//	  _photoViewControllerFlags.wantsFullScreenAfterDrag = YES;
//	  if(action.didSucceed && _photoViewControllerFlags.wantsFullScreenAfterDrag)
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

- (void) tilingScrollViewWillRotate:(FLTilingScrollView*) tilingScrollView {
}

- (void) tilingScrollViewDidRotate:(FLTilingScrollView*) tilingScrollView
{
	[self _downloadPhotosIfNeeded:NO];
}

- (void) updateSlideShowButtons
{
	[_playButton setEnabled:self.photoCount > 1];
	[_prevButton setEnabled:self.photoCount > 1];
	[_nextButton setEnabled:self.photoCount > 1];
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
	
	_photoViewControllerFlags.inSlideShow = YES;
	
	_slideShowStartIndex = _currentPhotoIndex;
	
	[self _setButtonImage:_playButton image:[UIImage imageNamed:@"pauseicon.png"]];
	
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
		
	_photoViewControllerFlags.inSlideShow = NO;

	[self _setButtonImage:_playButton image:[UIImage imageNamed:@"playicon.png"]];

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
	FLRelease(_randomSlideshowIndexes);
	_randomSlideshowIndexes = [[NSMutableArray alloc] initWithCapacity:self.photoCount];

	for(NSUInteger i = 0; i < self.photoCount; i++)
	{
		[_randomSlideshowIndexes addObject:[NSNumber numberWithUnsignedInt:i]];
	}
}

- (void) handleSlideShowNext:(NSTimer*)theTimer
{
	_slideShowTimer = nil;

	if(_photoViewControllerFlags.inSlideShow)
	{	
		if(_slideshowOptions.randomValue)
		{
			if(!_randomSlideshowIndexes)
			{
				[self populateRandomSlideshowArray];
			}
		
			if(!_slideshowOptions.repeatValue && _randomSlideshowIndexes.count == 0)
			{
			// stop
				[self stopSlideShow:YES];
			}
			else
			{
				if(_randomSlideshowIndexes.count == 0)
				{
				// in case we're repeating
					[self populateRandomSlideshowArray];
				}
			
				NSUInteger randomIndex = FLRandomInt(0, _randomSlideshowIndexes.count - 1);
				NSNumber* whichIndex = [_randomSlideshowIndexes objectAtIndex:randomIndex];
				
				[self showPhotoAtIndex:whichIndex.intValue];
				
				[_randomSlideshowIndexes removeObjectAtIndex:randomIndex];
			}
		}
		else
		{
			[_scrollView shiftArrangementToLeft];
			
			if(!_slideshowOptions.repeatValue && _slideShowStartIndex == _currentPhotoIndex)
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
	[_slideShowTimer invalidate];
	_slideShowTimer = nil;
}

- (void) startSlideShowTimer
{
	_photoViewControllerFlags.inSlideShow = YES;
//	[self cancelFullScreenTimer];
	[self stopSlideShowTimer];

	if(self.centerView.imageSize >= FLPhotoViewImageSizeFullScreen)
	{
		_slideShowTimer = [NSTimer timerWithTimeInterval:_slideshowOptions.speedValue 
				target:self 
				selector:@selector(handleSlideShowNext:) 
				userInfo:nil 
				repeats:NO];
			
		[[NSRunLoop mainRunLoop] addTimer:_slideShowTimer forMode:NSRunLoopCommonModes];
	}
}

- (FLPhotoView*) photoViewForImageView:(UIImageView*) imageView
{
	for(NSUInteger i = 0; i < _scrollView.tiledViewCount; i++)
	{
		FLPhotoView* photoView = (FLPhotoView*) [_scrollView tiledViewAtIndex:i];
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




