//
//	FLPhotoView.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTilingScrollView.h"
#import "FLZoomingScrollView.h"
#import "FLOldUserNotificationView.h"
#import "FLWeakReference.h"

#define FLCaptionOpacity 0.60

@protocol FLPhotoViewDelegate;

typedef enum {
	FLPhotoViewImageSizeNone,
	FLPhotoViewImageSizeThumbnail,
	FLPhotoViewImageSizeFullScreen,
	FLPhotoViewImageSizeHighResolution
} FLPhotoViewImageSize;

@class FLPhotoImageView;

@interface FLPhotoView : UIView {
@private
	FLWeakReference* _detailsView;
	FLWeakReference* _errorView;
	UIActivityIndicatorView* _spinner;
	FLZoomingScrollView* _scrollView;
	FLPhotoImageView* _imageView;
	
	struct {
		unsigned int autoShowSpinner:1;
		FLPhotoViewImageSize imageSize: 4;
		unsigned int autoZoom:1;
		unsigned int didShowError:1;
		unsigned int loadingDidFail:1;
	} _photoViewFlags;
}

- (id)initWithFrame:(CGRect)frame;
- (id)initWithImage:(UIImage *)image forImageSize:(FLPhotoViewImageSize) imageSize;


@property (readwrite, assign, nonatomic) BOOL autoZoom;
@property (readonly, retain, nonatomic) UIImageView* imageView;
@property (readonly, retain, nonatomic) FLZoomingScrollView* imageScrollView;

@property (readwrite, assign, nonatomic) FLOldNotificationView* detailsView; // weakly referenced
- (void) hideDetailsView;

@property (readonly, assign, nonatomic) BOOL didShowError;
@property (readwrite, assign, nonatomic) UIView* errorView; // weakly referenced
- (void) hideErrorView;

@property (readwrite, assign, nonatomic) BOOL autoShowSpinner;

// image loading state
@property (readonly, assign, nonatomic) BOOL loadingDidFail;
@property (readonly, assign, nonatomic) FLPhotoViewImageSize imageSize;
@property (readonly, retain, nonatomic) UIImage *image;
- (void) setImage:(UIImage*) image forImageSize:(FLPhotoViewImageSize) imageSize;
- (void) removeImage;
- (void) setLoadingDidFail;
- (void) clearError;

//- (void) setNothingLoaded;
	   
- (void) resetState;

- (void) stopSpinner;
- (void) startSpinner;

@end



