//
//  FLColorUtils.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLColor_t.h"

@implementation UIColor (FLColorUtils)

- (FLColor_t) color_t
{
   FLColor_t color;
   [self rgbValues:&color.red green:&color.green blue:&color.blue alpha:&color.alpha];
   return color;
}

+ (UIColor*) colorWithColor_t:(FLColor_t) color
{
#if IOS
	return [UIColor colorWithRed:color.red 
								green:color.green 
								blue:color.blue 
								alpha:color.alpha ];
#else
	return [UIColor colorWithDeviceRed:color.red 
								green:color.green 
								blue:color.blue 
								alpha:color.alpha ];

#endif                                
}

@end