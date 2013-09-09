//
//	FLImageFrameLayout.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLImageWidget.h"

#define FLImageFrameWidgetDefaultFrameWidth_iPhone 2.0f
#define FLImageFrameWidgetDefaultFrameWidth_iPad 4.0f

@interface FLImageFrameWidget : FLWidget {
@private
	struct {	
		unsigned int showFrame: 1;
		unsigned int showStack:1;
	    FLWidgetImageContentMode imageContentMode: 4;
    } _imageFrameFlags;
	CGFloat _frameWidth;
	FLImageWidget* _imageWidget;
	UIColor* _frameColor;
}

@property (readwrite, assign, nonatomic) FLWidgetImageContentMode imageContentMode;

@property (readwrite, retain, nonatomic) UIColor* frameColor;

@property (readwrite, assign, nonatomic) CGFloat frameWidth;
@property (readwrite, assign, nonatomic) BOOL showFrame;
@property (readwrite, assign, nonatomic) BOOL showStack; // only if showFrame is YES

@property (readwrite, retain, nonatomic) UIImage* image;

@property (readwrite, retain, nonatomic) FLImageWidget* imageWidget;

+ (FLImageFrameWidget*) imageFrameWidget:(CGRect) frame;

@end