//
//  GtPhotoViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtPhotoViewController.h"

#import "GtColors.h"
#import "GtGeometry.h"
#import "GtViewUtilities.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"

#import "GtViewFader.h"
#import "GtLowMemoryHandler.h"
#import "GtAction.h"
#import "GtImageUtilities.h"

typedef enum
{
	gtSlideLeft = 0,
	gtSlideRight = 1
} GtSlideDirection;

#if IPHONE

#define DefaultSlideShowSpeed 5
#define DefaultFullScreenTimerSpeed 7

@interface GtPhotoViewController (Private)

- (void) stopSlideShowTimer;

@end

@implementation GtPhotoViewController

@synthesize currentIndex = m_currentIndex;
@synthesize delegate = m_delegate;
@synthesize photoCount = m_photoCount;
@synthesize slideShowSpeed = m_slideShowSpeed;
@synthesize autoRotate = m_autoRotate;
@synthesize fullScreenTimerSpeed = m_fullScreenTimerSpeed;
@synthesize topToolbar = m_topToolbar;
@synthesize bottomToolbar = m_bottomToolbar;
@synthesize autoRotateOrientation = m_autoRotateOrientation;
@synthesize inSlideShow = m_inSlideShow;

@synthesize organizeButton = m_organizeButton;
@synthesize actionButton = m_actionButton;

GtSynthesize(arrangement, setArrangement, GtPhotoViewControllerViewArrangement, m_arrangement);

- (id) initWithPhotoCount:(NSUInteger) photoCount currentIndex:(NSUInteger) currentIndex
{
	return [self initWithNibNameAndPhotoCount:@"PhotoView" photoCount:photoCount currentIndex:currentIndex];
}

- (id) initWithNibNameAndPhotoCount:(NSString*) nibName 
                         photoCount:(NSUInteger) photoCount 
					   currentIndex:(NSUInteger) currentIndex
{
	if(self = [self initWithNibName:nibName bundle:nil])
	{
		m_photoCount = photoCount;
		m_currentIndex = currentIndex;
		m_slideShowSpeed = DefaultSlideShowSpeed;
		m_fullScreenTimerSpeed = DefaultFullScreenTimerSpeed;
		m_orientation = UIDeviceOrientationPortrait; 
		m_previousOrientation = UIDeviceOrientationUnknown;
		m_autoRotateOrientation = UIDeviceOrientationLandscapeLeft;
		
		m_arrangement = [GtAlloc(GtPhotoViewControllerViewArrangement) init];
	}
	
	return self;
}

- (void) timedSetToFullScreen:(id) sender
{
	m_fullScreenTimer = nil;
	[self enterFullScreen:YES];
}

- (BOOL) cancelFullScreenTimer
{
	if(m_fullScreenTimer)
	{
		[m_fullScreenTimer invalidate];
		m_fullScreenTimer = nil; 
		return YES;
	}
	return NO;
}

- (void) startFullScreenTimer
{
	[self cancelFullScreenTimer];
	
	m_fullScreenTimer = [NSTimer timerWithTimeInterval:m_fullScreenTimerSpeed 
			target:self 
			selector:@selector(timedSetToFullScreen:) 
			userInfo:nil 
			repeats:NO];
		
	[[NSRunLoop mainRunLoop] addTimer:m_fullScreenTimer forMode:NSRunLoopCommonModes];

}

- (void) clearPhotos
{
	[m_arrangement clearPhotos];
}

- (void) cleanupPhotoViewController
{
	[self cancelFullScreenTimer];
	[self stopSlideShowTimer];

	GtReleaseWithNil(m_arrangement);

	GtReleaseWithNil(m_rotatingSubview);
	GtReleaseWithNil(m_scrollView);
	GtReleaseWithNil(m_topToolbar);
	GtReleaseWithNil(m_bottomToolbar);
	GtReleaseWithNil(m_editButton);
	GtReleaseWithNil(m_playButton);
	GtReleaseWithNil(m_prevButton);
	GtReleaseWithNil(m_nextButton);
	GtReleaseWithNil(m_topLabel);
    GtReleaseWithNil(m_titleView);
    GtReleaseWithNil(m_counterItem);
    
  	GtReleaseWithNil(m_organizeButton);
    GtReleaseWithNil(m_actionButton);

}

- (void)dealloc 
{
	[self cleanupPhotoViewController];
	[super dealloc];
}

- (void) viewDidUnload
{
	[self cleanupPhotoViewController];
	[super viewDidUnload];
}

- (void) onRemovePhotoAtIndex:(NSUInteger) index
{
}

- (void) reloadCurrentPhoto
{
	[self centerView].image = nil;
	[[self centerView] reset];
    [self beginLoadingPhotos];
}

- (GtPhotoView*) centerView
{
	return m_arrangement.centerView;
}

- (GtPhotoView*) nextView
{
	return m_arrangement.nextView;
}

- (GtPhotoView*) previousView
{
	return m_arrangement.previousView;
}

- (void) handleUserDeletedPhoto
{
	m_photoCount--;
	if(m_photoCount == 0)
	{
		[self handleDonePress:self];
	}
	else
	{
		NSUInteger deletedIndex = m_currentIndex;
	
		m_currentIndex = [self prevIndex];
		[self handleNextPress:self];
		
		[self onRemovePhotoAtIndex:deletedIndex];
		
		[m_arrangement removeView:kPrevPhoto];
		
		[self insertNewPrevPhoto];
		
		[self beginLoadingPhotos];
	}
}

- (NSUInteger) nextIndex
{
	int newIndex = m_currentIndex + 1;
	if(newIndex >= m_photoCount)
	{
		newIndex = 0;
	}
	return newIndex;
}

- (NSUInteger) prevIndex
{
	int newIndex = m_currentIndex - 1;
	if(newIndex < 0)
	{
		newIndex = m_photoCount - 1;
	}
	return newIndex;
}

- (NSString*) getDetailsForPhoto:(id) photo
{
	GtFail(@"required override");

	return nil;
}
- (NSString*) emptyDetailsViewString
{
    GtFail(@"required override");
    
    return nil;
}
- (void) createPlaceHolderView:(id) photo outView:(GtPhotoView**) outView
{
	GtPhotoView* imgView = [GtAlloc(GtPhotoView) initWithFrame:CGRectZero];
	imgView.autoRotateImage = m_autoRotate;
	imgView.photo = photo;
    
  	*outView = imgView;
}

- (void) updateVisibleViewElements
{

    m_topLabel.text = [self onGetPhotoTitle:self.centerView.photo];
	m_countLabel.text = [NSString stringWithFormat:@"%d of %d", self.currentIndex + 1, m_photoCount];
	
	for(int i = 0; i < m_arrangement.viewCount; i++)
	{
        GtPhotoView* view = [m_arrangement viewAtIndex:i];
        
        view.title = [self onGetPhotoTitle:view.photo];
        view.details = [self getDetailsForPhoto:view.photo];
        
        if([self isFullScreen] || self.centerView != view)
        {
            [view hideDetailsView];
        }
        else 
        {
            [view showDetailsView:NO withMessage:nil];
        }
	}
}

#if DEBUG
- (void) testViewHierarchy
{
	NSArray* subViews = [m_scrollView subviews];

	int lastIndex = -1;
	for(int i = 0; i < m_arrangement.viewCount; i++)
	{
		if([m_arrangement viewAtIndex:i])
		{
			BOOL foundIt = NO;
			for(UIView* view in subViews)
			{
				if(view == [m_arrangement viewAtIndex:i])
				{
					GtAssert(i > lastIndex, @"views are out of order");
					foundIt = YES;
					lastIndex = i;
					break;
				}
			}
			GtAssert(foundIt, @"didn't find an GtPhotoView in scroller view");
		}
	}
	for(UIView* view in subViews)
	{
        if([view isKindOfClass:[GtPhotoView class]])
        {
            BOOL foundIt = NO;
            for(int i = 0; i < m_arrangement.viewCount; i++)
            {
                if(view == [m_arrangement viewAtIndex:i])
                {
                    foundIt = YES;
                    break;
                }
            }
            GtAssert(foundIt, @"didn't find an GtPhotoView in arrangement");
        }
	}
	
}
#endif

- (void) arrangeScrollerSubviews
{
#if DEBUG
	[self testViewHierarchy];
#endif
	
	CGRect pageFrame = m_scrollView.bounds; // [GtViewUtilities rotatedFrameForView: self.view];
	pageFrame.origin = CGPointZero;

	for(int i = 0; i < m_arrangement.viewCount; i++)
	{
		if([m_arrangement viewAtIndex:i])
		{
			[m_arrangement viewAtIndex:i].frame = pageFrame;
			pageFrame.origin.x += pageFrame.size.width;
		}
	}

	CGSize size = CGSizeMake(	pageFrame.origin.x, 
								pageFrame.size.height);
	[m_scrollView setContentSize:size];
	
	[m_scrollView scrollRectToVisible:[m_arrangement viewAtIndex:kCurrentPhoto].frame 
		animated:NO]; // scroll to middle one

	m_lastOffset = m_scrollView.contentOffset;
	
	[self updateVisibleViewElements];
}

- (void) fadeInImages
{
	[m_arrangement viewAtIndex:kCurrentPhoto].alpha = 0;
	
	[CATransaction begin];
	CATransition *animation = [CATransition animation];
	animation.type = kCATransitionFade;
	animation.duration = 0.3;
	
	CALayer* layer = m_scrollView.layer;
	[layer addAnimation:animation forKey:@"FadeIn"];
	[m_arrangement viewAtIndex:kCurrentPhoto].alpha = 1.0;
 	[CATransaction commit];
	
	[layer removeAnimationForKey:@"FadeIn"];
}

- (NSString*) onGetPhotoTitle:(id) photo
{
	GtFail(@"required override");
	return nil;
}

- (void) onCancelLoadPhoto:(GtPhotoView*) photoView
{
	[photoView cancel];
}

#define TOOLBAR_LABEL_LEFT 60
#define EDIT_BUTTON_WIDTH 34
#define ANIMATE 1

- (void) prepareScrollViewForRotation
{
	[[m_arrangement viewAtIndex:kPrevPhoto] removeFromSuperview];
	[[m_arrangement viewAtIndex:kNextPhoto] removeFromSuperview];

	CGRect curFrame = [m_arrangement viewAtIndex:kCurrentPhoto].frame;
	curFrame.origin = CGPointZero;
	[m_arrangement viewAtIndex:kCurrentPhoto].frame = curFrame;
	
	[m_scrollView setContentSize:curFrame.size];
	[m_scrollView scrollRectToVisible:curFrame animated:NO]; 
}

- (void) rotateScrollViewToOrientation:(CGAffineTransform) transform
{		
	CGRect selfBounds = self.view.bounds;

	m_scrollView.transform = transform;
	CGRect scrollFrame = CGRectZero;
	
	switch(m_orientation)
	{
		case UIDeviceOrientationLandscapeLeft: 
			scrollFrame.size.height = selfBounds.size.height;
			scrollFrame.size.width = selfBounds.size.width;
			scrollFrame.origin.x = selfBounds.size.width - scrollFrame.size.width;
			scrollFrame.origin.y = 0;
			break;

		case UIDeviceOrientationLandscapeRight: 
			scrollFrame.origin.x = 0;
			scrollFrame.origin.y = 0;
			scrollFrame.size.height = selfBounds.size.height;
			scrollFrame.size.width = selfBounds.size.width;
			break;
		
		case UIDeviceOrientationPortrait: 
			scrollFrame = selfBounds;
			break;
	}

	m_scrollView.frame = scrollFrame;
	
	[m_arrangement viewAtIndex:kCurrentPhoto].frame = m_scrollView.bounds;
}

- (void) rotateToolbars:(CGAffineTransform) rotateTransform
{
	m_topToolbar.transform = rotateTransform;
	m_bottomToolbar.transform = rotateTransform;
	CGRect selfBounds = self.view.bounds;
	
	CGRect topFrame = m_topToolbar.frame;
	CGRect bottomFrame = m_topToolbar.frame;

	switch(m_orientation)
	{
		case UIDeviceOrientationLandscapeLeft: 
			topFrame.origin.x = selfBounds.size.width - 20 - topFrame.size.width;
			topFrame.origin.y = 0;
			topFrame.size.height = selfBounds.size.height;
			
			bottomFrame.origin.x = 0;
			bottomFrame.origin.y = 0;
			bottomFrame.size.height = selfBounds.size.height;
			break;

		case UIDeviceOrientationLandscapeRight: 
			topFrame.origin.x = 20;
			topFrame.origin.y = 0;
			topFrame.size.height = selfBounds.size.height;
			
			bottomFrame.origin.y = 0; // selfBounds.size.width;
			bottomFrame.origin.x = selfBounds.size.width - bottomFrame.size.width;
			bottomFrame.size.height = selfBounds.size.height;
			break;
		
		case UIDeviceOrientationPortrait: 
			topFrame.origin.x = 0;
			topFrame.origin.y = 20;
			topFrame.size.width = selfBounds.size.width;
			
			bottomFrame.origin.x = 0;
			bottomFrame.origin.y = selfBounds.size.height - bottomFrame.size.height;
			bottomFrame.size.width = selfBounds.size.width;
			break;
	}

	m_topToolbar.frame = topFrame;
	m_bottomToolbar.frame = bottomFrame;
}

- (BOOL) setNewOrientation:(UIDeviceOrientation) newOrientation
{
	if(newOrientation == m_orientation)
	{
		return NO;
	}
	
	switch(newOrientation)
	{
		case UIDeviceOrientationLandscapeLeft: 
			m_rotateAngle = 90.0; 
			break;

		case UIDeviceOrientationLandscapeRight: 
			m_rotateAngle = -90.0; 
			break;

		case UIDeviceOrientationPortrait: 
			m_rotateAngle = 0.0; 
			break;
			
		default:
			return NO;
	}

	m_previousOrientation = m_orientation;
	m_orientation = newOrientation;
	
	return YES;
} 

#define ANIMATION_DURATION 0.25

- (void) completedRotation
{
	if(m_autoRotate)
	{
		CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(GtDegreesToRadian(m_rotateAngle));
		[self rotateScrollViewToOrientation:rotateTransform];
	}

	[m_scrollView insertSubview:[m_arrangement viewAtIndex:kPrevPhoto] atIndex:0];
	[m_scrollView addSubview:[m_arrangement viewAtIndex:kNextPhoto]];
	
	for(int i = 0; i < m_arrangement.viewCount; i++)
	{		
		[m_arrangement viewAtIndex:i].orientation = m_orientation;
	}
	
	[self arrangeScrollerSubviews];

	[self startFullScreenTimer];

}
 
- (void) rotateToOrientation:(UIDeviceOrientation) newOrientation
	                 animate:(BOOL) animate
{
	if([self setNewOrientation:newOrientation])
	{
		[self cancelFullScreenTimer];
		[self prepareScrollViewForRotation];
		
		CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(GtDegreesToRadian(m_rotateAngle));
		
		if(animate)
		{
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDuration:[UIApplication sharedApplication].statusBarOrientationAnimationDuration];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(doneRotating:finished:context:)];
		}
		
		if(!m_autoRotate)
		{
			[self rotateScrollViewToOrientation:rotateTransform];
		}
		
		[[UIApplication sharedApplication] setStatusBarOrientation:m_orientation animated:animate];
		[self rotateToolbars:rotateTransform];
		
		if(animate)
		{
			[UIView commitAnimations];
		}
		else
		{
			[self completedRotation];
		}
	}

}

- (void)doneRotating:(NSString *)animationID 
	        finished:(NSNumber *)finished 
	         context:(void *)context
{
	[self completedRotation];
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void) didRotate:(id) sender
{
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];

	[self rotateToOrientation:orientation animate:YES];
	
	if(orientation != UIDeviceOrientationPortrait)
	{
		m_autoRotateOrientation = orientation;
	}
}

- (void) onTappedToolbar:(id) sender
{
    [self cancelFullScreenTimer];

    GtPhotoView* view = self.centerView;
    if(view.hasDetailsView)
    {
        [view hideDetailsView];
    }
    else
    {
        [view showDetailsView:YES withMessage:self.emptyDetailsViewString];
    }
}

- (UIBarButtonItem*) setCustomViewInToolbar:(UIToolbar*) toolbar
    oldItem:(UIBarButtonItem*) oldItem
    newView:(UIView*) newView
{
    GtAssertNotNil(toolbar);
    GtAssertNotNil(oldItem);
    GtAssertNotNil(newView);

    UIBarButtonItem* customItem = nil;
    
#if DEBUG
    BOOL foundIt = NO;
#endif    
    
   // Gawd, this is lame
    NSMutableArray* items = [NSMutableArray arrayWithArray:toolbar.items];
    for(int i = 0; i < items.count; i++)
    {
        if([items objectAtIndex:i] == oldItem)
        {
#if DEBUG
            foundIt = YES;
#endif
            customItem = [GtAlloc(UIBarButtonItem) initWithCustomView:newView];
        //    customItem.enabled = NO;
            [items replaceObjectAtIndex:i withObject:customItem];
            break;
        }
    }

    toolbar.items = items;
    
    GtAssert(foundIt, @"didn't find item");
    
    return customItem;
}

- (void) viewDidLoad
{
	[super viewDidLoad];

	self.view.multipleTouchEnabled = YES;
    
    {
        m_topLabel = [GtAlloc(UILabel) initWithFrame:m_topToolbar.bounds];
        m_topLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        m_topLabel.backgroundColor = [UIColor clearColor];
        m_topLabel.textColor = [UIColor whiteColor];
        m_topLabel.lineBreakMode = UILineBreakModeTailTruncation;
        m_topLabel.textAlignment = UITextAlignmentLeft;
 //       m_topLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | 
 //                                   UIViewAutoresizingFlexibleRightMargin;
                                    
        CGRect frame = m_topLabel.bounds;
        frame.size.width = 180;
        m_topLabel.frame = frame;

        UIBarButtonItem* newItem = [self setCustomViewInToolbar:m_topToolbar oldItem:m_titleItem newView:m_topLabel];
        GtReleaseWithNil(m_titleItem);
        m_titleItem = newItem;
    }
    
    {
        m_countLabel = [GtAlloc(UILabel) initWithFrame:CGRectZero];
        m_countLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    /*
        m_countLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
          m_countLabel.autoresizingMask = 
            UIViewAutoresizingFlexibleLeftMargin   |
            UIViewAutoresizingFlexibleRightMargin  |
            UIViewAutoresizingFlexibleTopMargin    |
            UIViewAutoresizingFlexibleBottomMargin; 
     */  
        m_countLabel.backgroundColor = [UIColor clearColor];
        m_countLabel.textColor = [UIColor whiteColor];
        m_countLabel.lineBreakMode = UILineBreakModeTailTruncation;
        m_countLabel.textAlignment = UITextAlignmentCenter;
        m_countLabel.text = @"999 of 999";

        CGRect myFrame = m_countLabel.frame;
        myFrame.size = [m_countLabel.text sizeWithFont:m_countLabel.font
                        constrainedToSize:m_bottomToolbar.bounds.size
                        lineBreakMode:UILineBreakModeTailTruncation];
        m_countLabel.frame = myFrame;

        UIBarButtonItem* newItem = [self setCustomViewInToolbar:m_bottomToolbar oldItem:m_counterItem newView:m_countLabel];
        GtReleaseWithNil(m_counterItem);
        m_counterItem = newItem;
    }
    
    
    CGRect stupid = m_topToolbar.frame;
	if(stupid.origin.y < 20)
	{
		stupid.origin.y = 20;
	}
	m_topToolbar.frame = stupid;

	BOOL canFlick = m_photoCount > 1;

	GtAssert(m_scrollView != nil, @"scroll view is nil");
	
	m_scrollView.pagingEnabled = canFlick;
	m_scrollView.scrollEnabled = canFlick;
	m_scrollView.directionalLockEnabled = YES;
	
	m_scrollView.showsVerticalScrollIndicator = NO;
	m_scrollView.showsHorizontalScrollIndicator = NO;
	
	m_scrollView.autoresizingMask =	UIViewAutoresizingFlexibleWidth | 
								UIViewAutoresizingFlexibleHeight |
								UIViewAutoresizingFlexibleLeftMargin |
								UIViewAutoresizingFlexibleRightMargin |
								UIViewAutoresizingFlexibleHeight |
								UIViewAutoresizingFlexibleBottomMargin; 
	m_scrollView.autoresizesSubviews = YES;
	
	
	m_scrollView.delegate = self;
	
	[[NSNotificationCenter defaultCenter] addObserver:self
							selector:@selector(didRotate:)
							name:UIDeviceOrientationDidChangeNotification
							object:nil];

	[self performSelectorOnMainThread:@selector(fadeInViewAndBeginLoadingPhotos)
		withObject:nil
		waitUntilDone:NO];
}

- (BOOL) canAutoLoadView:(GtPhotoView*) view
{
    return  !view.isLoaded &&
            !view.failedToLoad;
}

- (void) notificationViewWasTouched:(GtNotificationView*) view
{
    [self cancelFullScreenTimer];
}

- (void) beginLoadingPhotos
{
	GtPhotoView* loadMe = nil;

	if([self canAutoLoadView:[self centerView]])
	{
#if LOG_PHOTO_VIEW	
		GtLog(@"loading center view");
#endif
		loadMe = [self centerView];
        loadMe.detailsView.delegate = self;
		[self onCenterPhotoLoading];
	}
	else if([self canAutoLoadView:[self nextView]])
	{
#if LOG_PHOTO_VIEW	
		GtLog(@"loading next view");
#endif
		loadMe = [self nextView];
	}
	else if([self canAutoLoadView:[self previousView]])
	{
#if LOG_PHOTO_VIEW	
		GtLog(@"loading prev view");
#endif
		loadMe = [self previousView];
	}

	if(loadMe)
	{
        loadMe.isLoading = YES;
        [loadMe startSpinner];
		[self beginLoadPhoto:loadMe];
	}

}


- (void) fadeInViewAndBeginLoadingPhotos
{
	GtPhotoView* prevPhoto = nil;
	GtPhotoView* nextPhoto = nil;
	GtPhotoView* currentPhoto = nil;
	
	if(m_photoCount > 1)
	{
		prevPhoto = nil;
		[self createPlaceHolderView:[self prevPhoto] outView:&prevPhoto];

		[m_scrollView addSubview:prevPhoto];
		GtRelease(prevPhoto);
	}
	else
	{
		m_playButton.enabled = NO;
		m_prevButton.enabled = NO;
		m_nextButton.enabled = NO;
	}
	
	if(m_photoCount >= 1)
	{
		currentPhoto = nil;
		[self createPlaceHolderView:[self currentPhoto] outView:&currentPhoto];
		[m_scrollView addSubview:currentPhoto];
		GtRelease(currentPhoto);
	}
	
	if(m_photoCount > 1)
	{
		nextPhoto = nil;
		[self createPlaceHolderView:[self nextPhoto] outView:&nextPhoto];
		
		[m_scrollView addSubview:nextPhoto];
		GtRelease(nextPhoto);
	}

	[m_arrangement setView:kPrevPhoto view:prevPhoto];
	[m_arrangement setView:kCurrentPhoto view:currentPhoto];
	[m_arrangement setView:kNextPhoto view:nextPhoto];

	[self arrangeScrollerSubviews];
	
	m_firstLoad = YES;
	[self beginLoadingPhotos];
}

- (void) handleDonePress:(id)sender
{
	[[NSNotificationCenter defaultCenter]  removeObserver:self];
	
	[self cancelFullScreenTimer];
	[self stopSlideShowTimer];
	
	[self leaveFullScreen:YES];
	
	[[GtViewFader defaultViewFader] removeFromSuperview:self.view];

	[[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
//	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	[[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationPortrait];
	
	if(m_delegate && [m_delegate respondsToSelector:@selector(onPhotoViewClosed:)])
	{
		[m_delegate onPhotoViewClosed:self];
	}
}

- (void) showHideAllDetailViews:(BOOL) show
{
	for(int i = 0; i < m_arrangement.viewCount; i++)
	{
        GtPhotoView* view = [m_arrangement viewAtIndex:i];
    
        if(show && view == self.centerView)
        {
            [view showDetailsView:NO withMessage:nil];
        }
        else
        {
            [view hideDetailsView];
        }
    }
}

- (BOOL) isFullScreen
{
	return [UIApplication sharedApplication].statusBarHidden;
}

- (void) didToggleFullScreen:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    BOOL hidden = [UIApplication sharedApplication].statusBarHidden;

	m_bottomToolbar.hidden =  hidden;
	m_topToolbar.hidden =  hidden;
	
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void) enterFullScreen:(BOOL) animate
{
	[self cancelFullScreenTimer];
	
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
    
    [self cancelFullScreenTimer];
}

- (void) toggleFullScreen:(BOOL) animate
{
	[self cancelFullScreenTimer];

    BOOL toFullScreen = !self.isFullScreen;
    
    if(animate)
    {
        if(!toFullScreen)
        {
            m_bottomToolbar.alpha = 0;
            m_topToolbar.alpha = 0;
            m_bottomToolbar.hidden = NO;
            m_topToolbar.hidden = NO;
        }

        [self showHideAllDetailViews:!toFullScreen]; 

        [UIView beginAnimations:@"viewin" context:nil];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(didToggleFullScreen:finished:context:)];
        
        if(toFullScreen)
        {
            m_topBarAlpha = m_topToolbar.alpha;
            m_bottomBarAlpha = m_bottomToolbar.alpha;
            m_bottomToolbar.alpha = 0;
            m_topToolbar.alpha = 0;
        }
        else
        {
            m_bottomToolbar.alpha = m_topBarAlpha;
            m_topToolbar.alpha = m_bottomBarAlpha;
        }

        [UIView commitAnimations];
    }
    else
    {
        m_bottomToolbar.hidden = toFullScreen;
        m_topToolbar.hidden = toFullScreen;
        m_bottomToolbar.alpha = toFullScreen ? 0 : m_topBarAlpha;
        m_topToolbar.alpha = toFullScreen ? 0 : m_bottomBarAlpha;
        [self showHideAllDetailViews:!toFullScreen]; 
    }
	
   [[UIApplication sharedApplication] setStatusBarHidden:toFullScreen animated:animate];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (BOOL) cancelLoadIfNeeded:(GtPhotoView*) photoView
{
	if(photoView.isLoading)
	{
		[self onCancelLoadPhoto:photoView];
		return YES;
	}
	
	return NO;
}

- (void) slideViews:(GtSlideDirection) slideDirection
{
	switch(slideDirection)
	{
		case gtSlideLeft:
		{
			if([self cancelLoadIfNeeded:[m_arrangement viewAtIndex:kPrevPhoto]])
			{
#if LOG_PHOTO_VIEW	
				GtLog(@"cancel prev view");
#endif
			}
			
			if([self cancelLoadIfNeeded:[m_arrangement viewAtIndex:kCurrentPhoto]])
			{
#if LOG_PHOTO_VIEW	
				GtLog(@"cancel center view");
#endif
			}

			m_currentIndex = [self nextIndex];
				
			[m_arrangement shiftArrangementToLeft];

#if LOG_PHOTO_VIEW			
			GtLog([self onGetPhotoTitle:[self nextPhoto]]);
#endif
			// now create the new next photo and insert it at the end 
			// of the photo arrangement and subview list

			[self insertNewNextPhoto];
							
#if LOG_PHOTO_VIEW			
			GtLog(@"rotate left replaced last item with placeholder");
#endif	
		}
		break;
		
		case gtSlideRight:
		{
			if([self cancelLoadIfNeeded:[m_arrangement viewAtIndex:kNextPhoto]])
			{
#if LOG_PHOTO_VIEW	
				GtLog(@"cancel next view");
#endif

			}
			if([self cancelLoadIfNeeded:[m_arrangement viewAtIndex:kCurrentPhoto]])
			{
#if LOG_PHOTO_VIEW	
				GtLog(@"cancel current view");
#endif

			}

			m_currentIndex = [self prevIndex];
			
			[m_arrangement shiftArrangementToRight];
			
#if LOG_PHOTO_VIEW			
			GtLog(@"rotate right replaced first item with placeholder");
			GtLog([self onGetPhotoTitle:[self prevPhoto]]);
#endif		
		
			[self insertNewPrevPhoto];
		}
		break;
		
		default:
			GtFail(@"wtf?");
			break;
	}

	[self arrangeScrollerSubviews];
	[self beginLoadingPhotos];
	
	if(m_inSlideShow)
	{
	
	}
}

- (void) insertNewNextPhoto
{
	GtPhotoView* newNextPhoto = nil;
	[self createPlaceHolderView:[self nextPhoto] outView:&newNextPhoto];
	[m_scrollView addSubview:newNextPhoto];
	GtRelease(newNextPhoto);
	
	[m_arrangement setView:kNextPhoto view:newNextPhoto];
}

- (void) insertNewPrevPhoto
{
	// now create the new view and insert it at the beginning of the arrangemnt
	// and the beginning of the view list	
	GtPhotoView* newPrevPhoto = nil;
	[self createPlaceHolderView:[self prevPhoto] outView:&newPrevPhoto];
	[m_scrollView insertSubview:newPrevPhoto atIndex:0];
	GtRelease(newPrevPhoto);

	[m_arrangement setView:kPrevPhoto view:newPrevPhoto];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;                              // called on start of dragging (may require some time and or distance to move)
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	CGPoint loc = m_scrollView.contentOffset;

#if LOG_PHOTO_VIEW	
	GtLog(@"Offset: x: %f, y: %f", loc.x - m_lastOffset.x, loc.y = m_lastOffset.y);
#endif
	
	if(loc.x != m_lastOffset.x)
	{
		if(loc.x > m_lastOffset.x)
		{
			[self slideViews:gtSlideLeft];
		}
		else
		{
			[self slideViews:gtSlideRight];
		}
		
		[self enterFullScreen:YES];
	}
}

- (id) nextPhoto
{
	GtFail(@"required override");
	return nil;
}

- (id) prevPhoto
{
	GtFail(@"required override");
	return nil;
}

- (id) currentPhoto
{
	GtFail(@"required override");
	return nil;
}

- (void) beginLoadPhoto:(GtPhotoView*) photo
{
	GtFail(@"required override");
}

- (void) reloadCallback:(id) sender
{
   [self reloadCurrentPhoto];
}

- (BOOL) areTheSamePhoto:(id) firstPhoto secondPhoto:(id) secondPhoto
{
    GtFail(@"must set onComparePhotoId");
    return NO;
}

- (void) onPhotoLoaded:(GtPhotoView*) photoView 
                   img:(UIImage*) img
{
	GtAssert([photoView isKindOfClass:[GtPhotoView class]], @"wrong class passed in");

	// we need to look through the subviews
	// because they may have been slid into new indexes
	// and we may not even want this img anymore.
	for(int i = 0; i < m_arrangement.viewCount; i++)
	{
		GtPhotoView* pv = [m_arrangement viewAtIndex:i];
	
        if([self areTheSamePhoto:photoView.photo 
                     secondPhoto:pv.photo])
        {
            BOOL didGetPhoto = img != nil;
        
			if(didGetPhoto)
			{
				photoView.image = img;
            }
			else
			{
                [photoView setFailedToLoad:self retryAction:@selector(reloadCallback:)];
            }

			if(i == kCurrentPhoto)
            {
                m_firstLoad = NO;
            
                if(didGetPhoto)
                {
                    if(m_inSlideShow)
                    {
                        [self startSlideShowTimer];
                    }
                    [self onCenterPhotoLoaded];
                }
                else
                {
                    [self stopSlideShow];
                    [self cancelFullScreenTimer];
                    if([self isFullScreen])
                    {
                        [self toggleFullScreen:YES];
                    }
                }
            }
		}
	}
	
	[self beginLoadingPhotos];
}

- (IBAction) handleToolPress:(id) sender
{
	[self stopSlideShow];
}

- (void) handleReloadPress:(id) sender
{
	[self stopSlideShow];
}

- (void) handleMovePress:(id) sender
{
	[self stopSlideShow];
}

- (void) handleDeletePress:(id) sender
{
	[self stopSlideShow];
}

- (void) onNexOrPrevButtonPressed
{
	[self fadeInImages];

	if(m_inSlideShow)
	{	
		if(m_slideShowStartIndex == m_currentIndex)
		{
			[self stopSlideShow];
		}
		else
		{
			[self startSlideShowTimer];
		}
	}
	else
	{
		[self startFullScreenTimer];
	}
}

- (void) startSlideShow
{
	[self cancelFullScreenTimer];

	m_inSlideShow = YES;
	
	[self enterFullScreen:YES];

	m_slideShowStartIndex = m_currentIndex;

	[m_playButton setImage:[UIImage imageNamed:@"pauseicon.png"]];

	[self handleNextPress:self];
}

- (void) stopSlideShow
{
	m_inSlideShow = NO;

	[m_playButton setImage:[UIImage imageNamed:@"rightchevron.png"]];

	[self stopSlideShowTimer];

	[self leaveFullScreen:YES];

	[self cancelFullScreenTimer];
}

- (void) handlePrevPress:(id) sender
{
	[self slideViews:gtSlideRight];
	[self onNexOrPrevButtonPressed];
}

- (void) handleNextPress:(id) sender
{
	[self slideViews:gtSlideLeft];
	[self onNexOrPrevButtonPressed];
}

- (void) handlePlayPress:(id) sender
{
	[self cancelFullScreenTimer];

	if(m_inSlideShow)
	{
		[self stopSlideShow];
		[self startFullScreenTimer];
	}
	else
	{
		[self startSlideShow];
	}
}

- (void) handleInfoPress:(id) sender
{
	[self stopSlideShow];
}

- (void) didBecomeActiveContext
{
	[super didBecomeActiveContext];
	
	[self fadeInViewAndBeginLoadingPhotos];
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

- (BOOL) touchableScrollView:(GtTouchableScrollView*) scrollView 
    touchesEnded:(NSSet *)touches 
    withEvent:(UIEvent *)event;
{
	if([touches count] == 1)
	{
		UITouch* touch = [touches anyObject];
		if (touch.tapCount == 1) 
		{
			[self toggleFullScreen:YES];
            return YES;
		}
	}
    
    return NO;
}

- (void) handleSlideShowNext:(NSTimer*)theTimer
{
	m_slideShowTimer = nil;

	if(m_inSlideShow)
	{	
		[self slideViews:gtSlideLeft];
		[self fadeInImages];
	
		if(m_slideShowStartIndex == m_currentIndex)
		{
			[self handlePlayPress:self];
		}
		else
		{
			[self startSlideShowTimer];
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
	m_inSlideShow = YES;
	[self cancelFullScreenTimer];
	[self stopSlideShowTimer];

	if([self centerView].isLoaded)
	{
		m_slideShowTimer = [NSTimer timerWithTimeInterval:m_slideShowSpeed 
				target:self 
				selector:@selector(handleSlideShowNext:) 
				userInfo:nil 
				repeats:NO];
			
		[[NSRunLoop mainRunLoop] addTimer:m_slideShowTimer forMode:NSRunLoopCommonModes];
	}
}

- (IBAction) handleActionPress:(id) sender
{
	[self stopSlideShow];
}

- (void) onCenterPhotoLoading
{
	m_editButton.enabled = NO;
}

- (void) onCenterPhotoLoaded
{
    [self startFullScreenTimer];
	m_editButton.enabled = YES;
    
    [self updateVisibleViewElements];
}

- (UIScrollView*) scrollView
{
    return m_scrollView;
}

@end

#endif