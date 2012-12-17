//
//  UIColor+Utils.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "UIColor+FLUtils.h"
#import "FLColorUtilities.h"
#import "FLColorValues.h"

@implementation UIColor (FLUtils)

+ (UIColor*) colorWithRGBRed:(CGFloat) red
                       green:(CGFloat) green
                        blue:(CGFloat) blue
                       alpha:(CGFloat) alpha {
    
	return [UIColor colorWithRed:FLRgbColorToDecimalColor(red)
                           green:FLRgbColorToDecimalColor(green)
                            blue:FLRgbColorToDecimalColor(blue)
                           alpha:alpha ];
}


- (BOOL) isLightColor
{
#if IOS
	const CGFloat *componentColors = CGColorGetComponents(self.CGColor);

	CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
	return (colorBrightness > 0.5);
#endif 

    return NO;
}

- (UIColor*) colorWithDarkening:(CGFloat) byPercentageAmount {
    return [UIColor colorWithColorValues:FLColorValuesDarken(self.rgbColorValues, byPercentageAmount)];
}

- (UIColor*) colorWithLightening:(CGFloat) byPercentageAmount {
    return [UIColor colorWithColorValues:FLColorValuesLighten(self.rgbColorValues, byPercentageAmount)];
}




@end

