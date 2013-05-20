//
//	GtPhotoView.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTilingScrollView.h"
#import "GtZoomingScrollView.h"
#import "GtUserNotificationView.h"
#import "GtWeakReference.h"

#define GtCaptionOpacity 0.60

@protocol GtPhotoViewDelegate;

typedef enum {
	GtPhotoViewImageSizeNone,
	GtPhotoViewImageSizeThumbnail,
	GtPhotoViewImageSizeFullScreen,
	GtPhotoViewImageSizeHighResolution
} GtPhotoViewImageSize;

@class GtPhotoImageView;

@interface GtPhotoView : UIView {
@private
	GtWeakReference* m_detailsView;
	GtWeakReference* m_errorView;
	UIActivityIndicatorView* m_spinner;
	GtZoomingScrollView* m_scrollView;
	GtPhotoImageView* m_imageView;
	
	struct {
		unsigned int autoShowSpinner:1;
		GtPhotoViewImageSize imageSize: 4;
		unsigned int autoZoom:1;
		unsigned int didShowError:1;
		unsigned int loadingDidFail:1;
	} m_photoViewFlags;
}

- (id)initWithFrame:(CGRect)frame;
- (id)initWithImage:(UIImage *)image forImageSize:(GtPhotoViewImageSize) imageSize;


@property (readwrite, assign, nonatomic) BOOL autoZoom;
@property (readonly, retain, nonatomic) UIImageView* imageView;
@property (readonly, retain, nonatomic) GtZoomingScrollView* imageScrollView;

@property (readwrite, assign, nonatomic) GtNotificationViewController* detailsViewController; // weakly referenced
- (void) hideDetailsView;

@property (readonly, assign, nonatomic) BOOL didShowError;
@property (readwrite, assign, nonatomic) UIViewController* errorViewController; 
- (void) hideErrorView;

@property (readwrite, assign, nonatomic) BOOL autoShowSpinner;

// image loading state
@property (readonly, assign, nonatomic) BOOL loadingDidFail;
@property (readonly, assign, nonatomic) GtPhotoViewImageSize imageSize;
@property (readonly, retain, nonatomic) UIImage *image;
- (void) setImage:(UIImage*) image forImageSize:(GtPhotoViewImageSize) imageSize;
- (void) removeImage;
- (void) setLoadingDidFail;
- (void) clearError;

//- (void) setNothingLoaded;
	   
- (void) resetState;

- (void) stopSpinner;
- (void) startSpinner;

@end



