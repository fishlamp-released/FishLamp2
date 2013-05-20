//
//	GtPhotoView.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoView.h"

#import "GtGeometry.h"
#import "GtUserNotificationView.h"
#import "GtViewFader.h"
#import "GtAction.h"
#import "GtPhotoViewController.h"
#import "GtZoomingScrollView.h"


@interface GtPhotoImageView : UIImageView {
	CGSize m_imageSize;
	GtPhotoViewImageSize m_imageSizeEnum;
	BOOL m_autoZoom;
}
- (void) setImage:(UIImage*) image forSize:(GtPhotoViewImageSize) size autoZoom:(BOOL) autoZoom;

@end

@implementation GtPhotoImageView


- (CGRect) frameSizedToFitInSuperview:(BOOL) centerInSuperview
{
	CGRect frame = CGRectZero;
	if(self.superview)
	{
		CGSize size = m_imageSize;
			
		CGRect superbounds = self.superview.bounds;
		if( !m_autoZoom && 
			!CGSizeEqualToSize(size, CGSizeZero) &&
			size.width < superbounds.size.width &&
			size.height < superbounds.size.height )
		{	
			frame.size = size; 
			if(centerInSuperview)
			{
				frame = GtRectCenterRectInRect(superbounds, frame);
			}
		
			frame = GtRectGrowRectToOptimizedSizeIfNeeded(frame);
		}
		else
		{
			frame = [super frameSizedToFitInSuperview:centerInSuperview];
		}
	}

//	  GtLog(@"image size: %@, frame size: %@", NSStringFromCGSize(size), NSStringFromCGSize(frame.size));

	return frame;
}

- (void) setImage:(UIImage*) image forSize:(GtPhotoViewImageSize) size autoZoom:(BOOL) autoZoom
{
	m_imageSizeEnum = size;
	m_autoZoom = autoZoom;
	if(m_imageSizeEnum == GtPhotoViewImageSizeFullScreen)
	{
		m_imageSize = image.size;
	}
	[super setImage:image];
}

@end

@implementation GtPhotoView

GtSynthesizeStructProperty(autoShowSpinner, setAutoShowSpinner, BOOL, m_photoViewFlags);
GtSynthesizeStructProperty(imageSize, setImageSize, GtPhotoViewImageSize, m_photoViewFlags);
GtSynthesizeStructProperty(loadingDidFail, setLoadingDidFail, BOOL, m_photoViewFlags);
GtSynthesizeStructProperty(autoZoom, setAutoZoom,BOOL, m_photoViewFlags);
GtSynthesizeStructProperty(didShowError, setDidShowError, BOOL, m_photoViewFlags);

@synthesize imageView = m_imageView;
@synthesize imageScrollView = m_scrollView;

- (id)initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = NO;
		self.multipleTouchEnabled = YES;
		self.userInteractionEnabled = YES;
					   
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything; 
		
		self.autoresizesSubviews = YES; 
		self.contentMode = UIViewContentModeScaleAspectFit;
		
		m_scrollView = [[GtZoomingScrollView alloc] initWithFrame:self.bounds];
		[self addSubview:m_scrollView];
		
		m_imageView = [[GtPhotoImageView alloc] initWithFrame:CGRectZero];
		m_scrollView.zoomedView = m_imageView;
		
		self.backgroundColor = [UIColor blackColor];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image forImageSize:(GtPhotoViewImageSize) imageSize
{
	if((self = [self initWithFrame:CGRectZero]))
	{
		[self setImage:image forImageSize:imageSize];
	}
	return self;
}

//- (GtPhotoViewImageLoadState) loadStateForImageSize:(GtPhotoViewImageSize) size
//{
//	  return m_imageSizeLoadStates[size];
//}
//
//- (BOOL) imageSizeIsLoaded:(GtPhotoViewImageSize) size
//{
//	  return m_imageSizeLoadStates[size] == GtPhotoViewImageLoadStateLoaded;
//}

- (void) startSpinner
{
	if(!m_spinner)
	{
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		m_spinner.frame = GtRectCenterRectInRect(self.bounds, m_spinner.frame);
		[m_spinner startAnimating];
		[self addSubview:m_spinner];
	}
}

- (void) stopSpinner
{
	if(m_spinner)
	{
		[m_spinner removeFromSuperview];
		GtReleaseWithNil(m_spinner);
	}
}

- (void) dealloc
{
	if(self.detailsViewController)
	{
		[self.detailsViewController.notificationView setNotificationViewDelegate:nil];
	}
   
	[self hideDetailsView];
	[self hideErrorView];
 
	[self stopSpinner];
 
	GtRelease(m_scrollView);
	GtRelease(m_imageView);
	GtRelease(m_spinner);
	GtRelease(m_detailsView);
	GtRelease(m_errorView);
	GtSuperDealloc();
}

- (UIImage*) image
{
	return m_imageView.image;
}

- (void) setBackgroundColor:(UIColor*) color
{
	[super setBackgroundColor:color];
	m_scrollView.backgroundColor = color;
	m_imageView.backgroundColor = color;
}

- (void) removeImage
{
	[m_imageView setImage:nil forSize:GtPhotoViewImageSizeNone autoZoom:self.autoZoom];
	self.imageSize = GtPhotoViewImageSizeNone;
 }

- (void) setImage:(UIImage*) image forImageSize:(GtPhotoViewImageSize) imageSize
{
	GtAssertNotNil(image);
	GtAssert(imageSize != GtPhotoViewImageSizeNone, @"can't set to GtPhotoViewImageSizeNone");
	if(image)
	{
		[self clearError];
		self.imageSize = imageSize;
		
		BOOL hasImage = m_imageView.image != nil;
			
		if(self.autoShowSpinner)
		{
			if(image)
			{
				[self stopSpinner];
			}
			else
			{
				[self startSpinner];
			}
		}
		
		[m_imageView setImage:image forSize:imageSize autoZoom:self.autoZoom];
		if(!hasImage || m_scrollView.zoomingScrollViewZoomScale == 1.0) 
		{
			// only set frame if it's a new image. 
			// this is to prevent problems setting image during zoom
	   
			m_scrollView.newFrame = self.bounds;
			[m_imageView setViewSizeToFitInSuperview:YES];
		}
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(m_spinner)
	{
		m_spinner.frameOptimizedForSize = GtRectCenterRectInRect(self.bounds, m_spinner.frame);
	}
	
	m_scrollView.newFrame = self.bounds;
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	
	if(self.superview)
	{
		m_scrollView.newFrame = self.bounds;
		
		if(self.image)
		{
			[m_imageView setViewSizeToFitInSuperview:YES];
		}
	}
}

- (GtNotificationViewController*) detailsViewController
{
	return m_detailsView.object;
}

- (UIView*) errorView
{
	return m_errorView ? m_errorView.object : nil;
}

- (void) resetState
{
	[self removeImage];
	[self hideErrorView];
	
	if(self.autoShowSpinner)
	{
		[m_spinner startAnimating];
	}
	
}

- (void) clearError
{
	self.loadingDidFail = NO;
	[self hideErrorView];
}

- (void) hideErrorView
{
	if(m_errorView && m_errorView.object)
	{
		if([m_errorView.object respondsToSelector:@selector(hideNotification)])
		{
			[m_errorView.object hideNotification];
		}
		else
		{
			[m_errorView.object removeFromSuperview];
		}
	}
	
	m_photoViewFlags.didShowError = NO;
}

- (void) hideDetailsView
{
	if(m_detailsView && m_detailsView.object)
	{
		[m_detailsView.object hideNotification];
	}
}

- (void) setDetailsViewController:(GtNotificationViewController*) notificationViewController
{
	if(!m_detailsView)
	{
		m_detailsView = [[GtWeakReference alloc] init];
	}
	else if(m_detailsView.object)
	{
		[m_detailsView.object hideNotification];
	}
    
    if(notificationViewController)
	{
		[self addSubview:notificationViewController.view];
	}
	m_detailsView.object = notificationViewController;
}

- (void) setErrorView:(UIView*) view
{
	if(!m_photoViewFlags.didShowError)
	{
		m_photoViewFlags.didShowError = YES;
		if(!m_errorView)
		{
			m_errorView = [[GtWeakReference alloc] init];
		}
		else if(m_errorView.object)
		{
			[self hideErrorView];
		}
		m_errorView.object = view;
	}
}

- (void) setLoadingDidFail
{
	self.loadingDidFail = YES;
}

@end /* GtPhotoView */
