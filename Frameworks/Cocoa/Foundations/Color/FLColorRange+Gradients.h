//
//  FLColorRange+Gradients.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLColorRange.h"

@interface FLColorRange (FLGradientColors)
// utils
// premade gradients

- (id) initWithStartColor:(UIColor*) color 
                rangeSeperationPercentage:(CGFloat) percentage;

+ (id) gradientColorsFromColor:(UIColor*) color 
                rangeSeperationPercentage:(CGFloat) percentage; // .3 is typical

+ (FLColorRange*) iPhoneBlueGradientColorRange;

+ (FLColorRange*) redGradientColorRange;
+ (FLColorRange*) paleBlueGradientColorRange;
+ (FLColorRange*) brightBlueGradientColorRange;
+ (FLColorRange*) darkGrayGradientColorRange;
+ (FLColorRange*) darkGrayWithBlueTintGradientColorRange;
+ (FLColorRange*) blackGradientColorRange;
+ (FLColorRange*) grayGradientColorRange;
+ (FLColorRange*) lightGrayGradientColorRange;
+ (FLColorRange*) lightLightGrayGradientColorRange;

+ (FLColorRange*) silverGradientColorRange;
@end