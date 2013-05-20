//
//	GtImageFrameLayout.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"
#import "GtImageWidget.h"

#define GtImageFrameWidgetDefaultFrameWidth_iPhone 2.0f
#define GtImageFrameWidgetDefaultFrameWidth_iPad 4.0f

@interface GtImageFrameWidget : GtWidget {
@private
	struct {	
		unsigned int showFrame: 1;
		unsigned int showStack:1;
	    GtWidgetContentMode contentMode;
    } m_imageFrameFlags;
	CGFloat m_frameWidth;
	GtImageWidget* m_imageWidget;
	UIColor* m_frameColor;
}

@property (readwrite, assign, nonatomic) GtWidgetContentMode contentMode;

@property (readwrite, retain, nonatomic) UIColor* frameColor;

@property (readwrite, assign, nonatomic) CGFloat frameWidth;
@property (readwrite, assign, nonatomic) BOOL showFrame;
@property (readwrite, assign, nonatomic) BOOL showStack; // only if showFrame is YES

@property (readwrite, retain, nonatomic) UIImage* image;

@property (readwrite, retain, nonatomic) GtImageWidget* imageWidget;

+ (GtImageFrameWidget*) imageFrameWidget:(CGRect) frame;

@end