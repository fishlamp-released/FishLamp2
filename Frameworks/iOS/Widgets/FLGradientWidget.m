//
//	FLGradientWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import <QuartzCore/QuartzCore.h>
#import "FLGradientWidget.h"
#import "UIColor+FLMoreColors.h"
#import "UIColor+FLUtils.h"
#import "FLColorValues.h"
#import "FLColorRange.h"
#import "FLViewGradients.h"
#import "FLColorRange.h"

@implementation FLGradientWidget

@synthesize gradientColors = _gradientColors;

//- (void) applyTheme:(FLTheme*) theme {
//      [self setColorRange:[FLColorRange grayGradientColorRange] forControlState:UIControlStateNormal];
//}

- (id) initWithFrame:(CGRect) frame {
	if((self = [super initWithFrame:frame])){
//        self.wantsApplyTheme = YES;
		
        _gradientColors = [[FLViewGradients alloc] init];
    }
	return self;
}

+ (FLGradientWidget*) gradientWidgetWithFrame:(CGRect) frame {
    return FLAutorelease([[[self class] alloc] initWithFrame:frame]);

}

+ (FLGradientWidget*) gradientWidget {
    return [FLGradientWidget gradientWidgetWithFrame:CGRectZero];
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_gradientColors);
    FLSuperDealloc();
}
#endif

- (void) setColorRange:(FLColorRange*) range forControlState:(FLControlState) state {
    [_gradientColors setColorRange:range forControlState:state];
    [self setNeedsDisplay];
}

- (FLColorRange*) colorRangeForControlState:(FLControlState) state {
    return [_gradientColors colorRangeForControlState:state];
}

- (void) drawRect:(CGRect) rect{

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

	FLColorRangeColorValues colors = [_gradientColors colorRangeForControlState:self.controlState].colorRangeColorValues;
    
    CGFloat alpha = self.alpha;
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat colorArray[] =
	{
		colors.startColor.red, colors.startColor.green, colors.startColor.blue, alpha,
		colors.endColor.red, colors.endColor.green, colors.endColor.blue, alpha,
	};
    
	CGGradientRef	gradient = CGGradientCreateWithColorComponents(rgb, colorArray, NULL, sizeof(colorArray)/(sizeof(colorArray[0])*4));
	CGColorSpaceRelease(rgb);	 
	
    CGContextClipToRect(context, self.frame);
	CGContextDrawLinearGradient(context, gradient, 
		self.frame.origin, 
		CGPointMake(self.frame.origin.x, FLRectGetBottom(self.frame)),
		0);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
   
	[super drawRect:rect];
}

@end


