//
//  UIColor.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX

#import "UIColor+OSX.h"

@implementation NSColor (FLCompatibility)
+ (NSColor*) colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
}

@end

#endif