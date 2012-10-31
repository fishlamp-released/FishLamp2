//
//	FLGradientWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "FLGradientWidget.h"
#import "FLColor+FLMoreColors.h"
#import "FLColor+FLExtras.h"
#import "FLColor_t.h"
#import "FLColorRange.h"
#import "FLViewGradients.h"
#import "FLColorRange.h"

@implementation FLGradientWidget

@synthesize gradientColors = _gradientColors;

//- (void) applyTheme:(FLTheme*) theme {
//      [self setColorRange:[FLColorRange grayGradientColorRange] forControlState:UIControlStateNormal];
//}

- (id) initWithFrame:(FLRect) frame {
	if((self = [super initWithFrame:frame])){
//        self.wantsApplyTheme = YES;
		
        _gradientColors = [[FLViewGradients alloc] init];
    }
	return self;
}

+ (FLGradientWidget*) gradientWidgetWithFrame:(FLRect) frame {
    return FLReturnAutoreleased([[[self class] alloc] initWithFrame:frame]);

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

- (void) drawSelf:(FLRect) rect{

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

	FLColorRange_t colors = [_gradientColors colorRangeForControlState:self.controlState].colorRange_t;
    
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
   
	[super drawSelf:rect];
}

@end


