//
//	GtImageLayout.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"

typedef enum {
	GtWidgetContentModeScaleToFill,
	GtWidgetContentModeScaleAspectFit,
	GtWidgetContentModeScaleAspectFill,
	GtWidgetContentModeScaleAspectFitOptimalSize
} GtWidgetContentMode;

@interface GtImageWidget : GtWidget {
@private
	UIImage* m_image;
    GtWidgetContentMode m_contentMode;
}
@property (readwrite, retain, nonatomic) UIImage* image;

@property (readwrite, assign, nonatomic) GtWidgetContentMode contentMode;

- (void) resizeToImageSize;
- (void) resizeToImageSizeWithMaxSize:(CGSize) maxSize;
- (void) resizeProportionallyWithMaxSize:(CGSize) maxSize;

- (void) clear; // release image.

+ (GtImageWidget*) imageWidgetWithFrame:(CGRect) frame;

@end

extern void GtWidgetBlueTintImageHighlighter(id widget, CGRect rect);
