//
//  FLGradientDrawing.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDrawableGradient.h"

@implementation FLDrawableGradient

@synthesize colorRange = _colorRange;

- (id) initWithColorRange:(FLColorRange*) colorRange {
    self = [super init];
    if(self) {
        self.colorRange = colorRange;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_colorRange release];
    [super dealloc];
}
#endif

- (void) drawRect:(CGRect) drawRect {

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

	FLColorRangeColorValues colors = _colorRange.decimalColorRangeValues;
    
//    CGFloat alpha = self.alpha;

	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat colorArray[] = {
		colors.startColor.red, colors.startColor.green, colors.startColor.blue, colors.startColor.alpha,
		colors.endColor.red, colors.endColor.green, colors.endColor.blue, colors.endColor.alpha,
	};
    
	CGGradientRef	gradient = CGGradientCreateWithColorComponents(rgb, colorArray, NULL, sizeof(colorArray)/(sizeof(colorArray[0])*4));
	CGColorSpaceRelease(rgb);	 
	
    CGContextClipToRect(context, self.frame);
	CGContextDrawLinearGradient(context, gradient, 
		self.frame.origin, 
		CGPointMake(self.frame.origin.x, FLRectGetBottom(self.frame)),
		0);
    
    self.finishDrawingBlock = ^{
        CGGradientRelease(gradient);
        CGContextRestoreGState(context);
    };
        

/*

// some example code from apple.
      
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGFloat locations[2] = {0.0, 1.0};
    NSMutableArray *colors = [NSMutableArray arrayWithObject:(id)[[UIColor darkGrayColor] CGColor]];
    [colors addObject:(id)[[UIColor lightGrayColor] CGColor]];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    CGColorSpaceRelease(colorSpace);  // Release owned Core Foundation object.
    CGPoint startPoint = CGPointMake(0.0, 0.0);
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);  // Release owned Core Foundation object.
*/    
}


@end
