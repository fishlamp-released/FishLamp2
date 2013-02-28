//
//  UIColor+ZenfolioAdditions.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "UIColor+ZenfolioAdditions.h"

@implementation UIColor (ZenfolioAdditions)

//#define ZenfolioOrange FLColorCreateWithRGBColorValues(203, 102, 10,1.0)

+ (UIColor*) zenfolioOrange {
    FLReturnColorWithRGBRed(203, 102, 10,1.0);
}

@end