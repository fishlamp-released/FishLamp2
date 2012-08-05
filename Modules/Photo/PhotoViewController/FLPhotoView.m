//
//	FLPhotoView.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLPhotoView.h"

#import "FLGeometry.h"
#import "FLOldUserNotificationView.h"
#import "FLAction.h"
#import "FLPhotoViewController.h"
#import "FLZoomingScrollView.h"


@interface FLPhotoImageView : UIImageView {
	CGSize m_imageSize;
	FLPhotoViewImageSize m_imageSizeEnum;
	BOOL m_autoZoom;
}
- (void) setImage:(UIImage*) image forSize:(FLPhotoViewImageSize) size autoZoom:(BOOL) autoZoom;

@end

@implementation FLPhotoImageView


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
				frame = FLRectCenterRectInRect(superbounds, frame);
			}
		
			frame = FLRectOptimizedForViewSize(frame);
		}
		else
		{
			frame = [super frameSizedToFitInSuperview:centerInSuperview];
		}
	}

//	  FLLog(@"image size: %@, frame size: %@", NSStringFromCGSize(size), NSStringFromCGSize(frame.size));

	return frame;
}

- (void) setImage:(UIImage*) image forSize:(FLPhotoViewImageSize) size autoZoom:(BOOL) autoZoom
{
	m_imageSizeEnum = size;
	m_autoZoom = autoZoom;
	if(m_imageSizeEnum == FLPhotoViewImageSizeFullScreen)
	{
		m_imageSize = image.size;
	}
	[super setImage:image];
}

@end

@implementation FLPhotoView

FLSynthesizeStructProperty(autoShowSpinner, setAutoShowSpinner, BOOL, m_photoViewFlags);
FLSynthesizeStructProperty(imageSize, setImageSize, FLPhotoViewImageSize, m_photoViewFlags);
FLSynthesizeStructProperty(loadingDidFail, setLoadingDidFail, BOOL, m_photoViewFlags);
FLSynthesizeStructProperty(autoZoom, setAutoZoom,BOOL, m_photoViewFlags);
FLSynthesizeStructProperty(didShowError, setDidShowError, BOOL, m_photoViewFlags);

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
		
		m_scrollView = [[FLZoomingScrollView alloc] initWithFrame:self.bounds];
		[self addSubview:m_scrollView];
		
		m_imageView = [[FLPhotoImageView alloc] initWithFrame:CGRectZero];
		m_scrollView.zoomedView = m_imageView;
		
		self.backgroundColor = [UIColor blackColor];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image forImageSize:(FLPhotoViewImageSize) imageSize
{
	if((self = [self initWithFrame:CGRectZero]))
	{
		[self setImage:image forImageSize:imageSize];
	}
	return self;
}

//- (FLPhotoViewImageLoadState) loadStateForImageSize:(FLPhotoViewImageSize) size
//{
//	  return m_imageSizeLoadStates[size];
//}
//
//- (BOOL) imageSizeIsLoaded:(FLPhotoViewImageSize) size
//{
//	  return m_imageSizeLoadStates[size] == FLPhotoViewImageLoadStateLoaded;
//}

- (void) startSpinner
{
	if(!m_spinner)
	{
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		m_spinner.frame = FLRectCenterRectInRect(self.bounds, m_spinner.frame);
		[m_spinner startAnimating];
		[self addSubview:m_spinner];
	}
}

- (void) stopSpinner
{
	if(m_spinner)
	{
		[m_spinner removeFromSuperview];
		FLReleaseWithNil(m_spinner);
	}
}

- (void) dealloc
{
	if(self.detailsView)
	{
		[self.detailsView setNotificationViewDelegate:nil];
	}
   
	[self hideDetailsView];
	[self hideErrorView];
 
	[self stopSpinner];
 
	FLRelease(m_scrollView);
	FLRelease(m_imageView);
	FLRelease(m_spinner);
	FLRelease(m_detailsView);
	FLRelease(m_errorView);
	FLSuperDealloc();
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
	[m_imageView setImage:nil forSize:FLPhotoViewImageSizeNone autoZoom:self.autoZoom];
	self.imageSize = FLPhotoViewImageSizeNone;
 }

- (void) setImage:(UIImage*) image forImageSize:(FLPhotoViewImageSize) imageSize
{
	FLAssertIsNotNil(image);
	FLAssert(imageSize != FLPhotoViewImageSizeNone, @"can't set to FLPhotoViewImageSizeNone");
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
		m_spinner.frameOptimizedForSize = FLRectCenterRectInRect(self.bounds, m_spinner.frame);
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

- (FLOldNotificationView*) detailsView
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

- (void) setDetailsView:(FLOldNotificationView*) view
{
	if(!m_detailsView)
	{
		m_detailsView = [[FLWeakReference alloc] init];
	}
	else if(m_detailsView.object)
	{
		[m_detailsView.object hideNotification];
	}
	if(view)
	{
		[self addSubview:view];
	}
	m_detailsView.object = view;
}

- (void) setErrorView:(UIView*) view
{
	if(!m_photoViewFlags.didShowError)
	{
		m_photoViewFlags.didShowError = YES;
		if(!m_errorView)
		{
			m_errorView = [[FLWeakReference alloc] init];
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

@end /* FLPhotoView */
