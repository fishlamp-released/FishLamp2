//
//  SDKColor+Utils.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface SDKColor (FLUtils)

+ (SDKColor*) colorWithRGBRed:(CGFloat) rgbRed
                       green:(CGFloat) rgbGreen
                        blue:(CGFloat) rgbBlue
                       alpha:(CGFloat) alpha;


- (BOOL) isLightColor;

- (SDKColor*) colorWithDarkening:(CGFloat) byPercentageAmount;

- (SDKColor*) colorWithLightening:(CGFloat) byPercentageAmount;

@end

