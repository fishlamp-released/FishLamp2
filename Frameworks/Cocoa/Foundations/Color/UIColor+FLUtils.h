//
//  UIColor+Utils.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface UIColor (FLUtils)

+ (UIColor*) colorWithRGBRed:(CGFloat) rgbRed
                       green:(CGFloat) rgbGreen
                        blue:(CGFloat) rgbBlue
                       alpha:(CGFloat) alpha;


- (BOOL) isLightColor;

- (UIColor*) colorWithDarkening:(CGFloat) byPercentageAmount;

- (UIColor*) colorWithLightening:(CGFloat) byPercentageAmount;

@end

