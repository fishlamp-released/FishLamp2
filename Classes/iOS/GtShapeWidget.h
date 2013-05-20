//
//	GtShapeWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"

#import "GtGradientWidget.h"

@interface GtShapeWidget : GtWidget {
@private
	CGFloat m_cornerRadius;
	UIColor* m_borderColor;
	CGFloat m_lineWidth;
	GtGradientWidget* m_gradientWidget;
}
@property (readonly, assign, nonatomic) GtGradientWidget* borderGradient;
@property (readwrite, assign, nonatomic) CGFloat borderLineWidth;
@property (readwrite, assign, nonatomic) CGFloat cornerRadius;
@property (readwrite, retain, nonatomic) UIColor* borderColor;

-(void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect;


@end
