//
//	FLPhotoView.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPhotoView.h"

#import "FLGeometry.h"
#import "FLOldUserNotificationView.h"
#import "FLAction.h"
#import "FLPhotoViewController.h"
#import "FLZoomingScrollView.h"


@interface FLPhotoImageView : UIImageView {
	CGSize _imageSize;
	FLPhotoViewImageSize _imageSizeEnum;
	BOOL _autoZoom;
}
- (void) setImage:(UIImage*) image forSize:(FLPhotoViewImageSize) size autoZoom:(BOOL) autoZoom;

@end

@implementation FLPhotoImageView


- (CGRect) frameSizedToFitInSuperview:(BOOL) centerInSuperview
{
	CGRect frame = CGRectZero;
	if(self.superview)
	{
		CGSize size = _imageSize;
			
		CGRect superbounds = self.superview.bounds;
		if( !_autoZoom && 
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
	_imageSizeEnum = size;
	_autoZoom = autoZoom;
	if(_imageSizeEnum == FLPhotoViewImageSizeFullScreen)
	{
		_imageSize = image.size;
	}
	[super setImage:image];
}

@end

@implementation FLPhotoView

FLSynthesizeStructProperty(autoShowSpinner, setAutoShowSpinner, BOOL, _photoViewFlags);
FLSynthesizeStructProperty(imageSize, setImageSize, FLPhotoViewImageSize, _photoViewFlags);
FLSynthesizeStructProperty(loadingDidFail, setLoadingDidFail, BOOL, _photoViewFlags);
FLSynthesizeStructProperty(autoZoom, setAutoZoom,BOOL, _photoViewFlags);
FLSynthesizeStructProperty(didShowError, setDidShowError, BOOL, _photoViewFlags);

@synthesize imageView = _imageView;
@synthesize imageScrollView = _scrollView;

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
		
		_scrollView = [[FLZoomingScrollView alloc] initWithFrame:self.bounds];
		[self addSubview:_scrollView];
		
		_imageView = [[FLPhotoImageView alloc] initWithFrame:CGRectZero];
		_scrollView.zoomedView = _imageView;
		
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
//	  return _imageSizeLoadStates[size];
//}
//
//- (BOOL) imageSizeIsLoaded:(FLPhotoViewImageSize) size
//{
//	  return _imageSizeLoadStates[size] == FLPhotoViewImageLoadStateLoaded;
//}

- (void) startSpinner
{
	if(!_spinner)
	{
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_spinner.frame = FLRectCenterRectInRect(self.bounds, _spinner.frame);
		[_spinner startAnimating];
		[self addSubview:_spinner];
	}
}

- (void) stopSpinner
{
	if(_spinner)
	{
		[_spinner removeFromSuperview];
		FLReleaseWithNil(_spinner);
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
 
	FLRelease(_scrollView);
	FLRelease(_imageView);
	FLRelease(_spinner);
	FLRelease(_detailsView);
	FLRelease(_errorView);
	FLSuperDealloc();
}

- (UIImage*) image
{
	return _imageView.image;
}

- (void) setBackgroundColor:(UIColor*) color
{
	[super setBackgroundColor:color];
	_scrollView.backgroundColor = color;
	_imageView.backgroundColor = color;
}

- (void) removeImage
{
	[_imageView setImage:nil forSize:FLPhotoViewImageSizeNone autoZoom:self.autoZoom];
	self.imageSize = FLPhotoViewImageSizeNone;
 }

- (void) setImage:(UIImage*) image forImageSize:(FLPhotoViewImageSize) imageSize
{
	FLAssertIsNotNil(image);
	FLAssertWithComment(imageSize != FLPhotoViewImageSizeNone, @"can't set to FLPhotoViewImageSizeNone");
	if(image)
	{
		[self clearError];
		self.imageSize = imageSize;
		
		BOOL hasImage = _imageView.image != nil;
			
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
		
		[_imageView setImage:image forSize:imageSize autoZoom:self.autoZoom];
		if(!hasImage || _scrollView.zoomingScrollViewZoomScale == 1.0) 
		{
			// only set frame if it's a new image. 
			// this is to prevent problems setting image during zoom
	   
			_scrollView.newFrame = self.bounds;
			[_imageView setViewSizeToFitInSuperview:YES];
		}
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(_spinner)
	{
		_spinner.frameOptimizedForSize = FLRectCenterRectInRect(self.bounds, _spinner.frame);
	}
	
	_scrollView.newFrame = self.bounds;
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	
	if(self.superview)
	{
		_scrollView.newFrame = self.bounds;
		
		if(self.image)
		{
			[_imageView setViewSizeToFitInSuperview:YES];
		}
	}
}

- (FLOldNotificationView*) detailsView
{
	return _detailsView.object;
}

- (UIView*) errorView
{
	return _errorView ? _errorView.object : nil;
}

- (void) resetState
{
	[self removeImage];
	[self hideErrorView];
	
	if(self.autoShowSpinner)
	{
		[_spinner startAnimating];
	}
	
}

- (void) clearError
{
	self.loadingDidFail = NO;
	[self hideErrorView];
}

- (void) hideErrorView
{
	if(_errorView && _errorView.object)
	{
		if([_errorView.object respondsToSelector:@selector(hideNotification)])
		{
			[_errorView.object hideNotification];
		}
		else
		{
			[_errorView.object removeFromSuperview];
		}
	}
	
	_photoViewFlags.didShowError = NO;
}

- (void) hideDetailsView
{
	if(_detailsView && _detailsView.object)
	{
		[_detailsView.object hideNotification];
	}
}

- (void) setDetailsView:(FLOldNotificationView*) view
{
	if(!_detailsView)
	{
		_detailsView = [[FLWeakReference alloc] init];
	}
	else if(_detailsView.object)
	{
		[_detailsView.object hideNotification];
	}
	if(view)
	{
		[self addSubview:view];
	}
	_detailsView.object = view;
}

- (void) setErrorView:(UIView*) view
{
	if(!_photoViewFlags.didShowError)
	{
		_photoViewFlags.didShowError = YES;
		if(!_errorView)
		{
			_errorView = [[FLWeakReference alloc] init];
		}
		else if(_errorView.object)
		{
			[self hideErrorView];
		}
		_errorView.object = view;
	}
}

- (void) setLoadingDidFail
{
	self.loadingDidFail = YES;
}

@end /* FLPhotoView */
