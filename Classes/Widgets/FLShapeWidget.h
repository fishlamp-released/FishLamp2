//
//	FLShapeWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"

#import "FLGradientWidget.h"

@interface FLShapeWidget : FLWidget {
@private
	CGFloat _cornerRadius;
	UIColor* _innerBorderColor;
	CGFloat _lineWidth;
	FLGradientWidget* _borderGradient;
}
@property (readonly, strong, nonatomic) FLGradientWidget* borderGradient;
@property (readwrite, assign, nonatomic) CGFloat borderLineWidth;
@property (readwrite, assign, nonatomic) CGFloat cornerRadius;
@property (readwrite, strong, nonatomic) UIColor* innerBorderColor;

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(FLRect) rect;


@end
