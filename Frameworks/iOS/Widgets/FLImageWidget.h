//
//	FLImageLayout.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"

typedef enum {
	FLWidgetImageContentModeScaleToFill,
	FLWidgetImageContentModeScaleAspectFit,
	FLWidgetImageContentModeScaleAspectFill,
	FLWidgetImageContentModeScaleAspectFitOptimalSize
} FLWidgetImageContentMode;

@interface FLImageWidget : FLWidget {
@private
	UIImage* _image;
    FLWidgetImageContentMode _imageContentMode;
}
@property (readwrite, retain, nonatomic) UIImage* image;

@property (readwrite, assign, nonatomic) FLWidgetImageContentMode imageContentMode;

- (void) resizeToImageSize;
- (void) resizeToImageSizeWithMaxSize:(CGSize) maxSize;
- (void) resizeProportionallyWithMaxSize:(CGSize) maxSize;

- (void) clear; // release image.

+ (FLImageWidget*) imageWidgetWithFrame:(CGRect) frame;

@end

extern void FLWidgetBlueTintImageHighlighter(id widget, CGRect rect);
