//
//	FLPopoverView.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLGradientWidget.h"

typedef enum {
	FLFloatingViewArrowDirectionNone,
	FLFloatingViewArrowDirectionUp,
	FLFloatingViewArrowDirectionDown,
	FLFloatingViewArrowDirectionLeft,
	FLFloatingViewArrowDirectionRight,
} FLFloatingViewArrowDirection;

#define FLFloatingViewDefaultFrameWidth     8.0f
#define FLFloatingViewDefaultArrowWidth     14.0f
#define FLFloatingViewDefaultCornerRadius   8.0f

@interface FLFloatingView : UIView {
@private
	UIView* _containerView;
	UIView* _contentView;
	FLFloatingViewArrowDirection _arrowDirection;
	CGRect _targetRect;
	FLGradientWidget* _topGradient;
	FLGradientWidget* _lineGradient;
    
    CGFloat _cornerRadius;
    CGFloat _arrowWidth;
    CGFloat _frameWidth;
}

@property (readwrite, assign, nonatomic) CGFloat arrowWidth;
@property (readwrite, assign, nonatomic) CGFloat frameWidth;
@property (readwrite, assign, nonatomic) CGFloat cornerRadius;
@property (readwrite, assign, nonatomic) FLFloatingViewArrowDirection arrowDirection;
@property (readwrite, assign, nonatomic) CGRect targetRect;

@property (readonly, retain, nonatomic) UIView* containerView;
@property (readwrite, retain, nonatomic) UIView* contentView;

@end
