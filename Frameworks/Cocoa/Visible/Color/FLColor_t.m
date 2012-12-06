//
//  FLColorUtils.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLColor_t.h"
#import "FLColor.h"

@implementation SDKColor (FLColorUtils)

- (FLColor_t) color_t
{
   FLColor_t color;
   [self rgbValues:&color.red green:&color.green blue:&color.blue alpha:&color.alpha];
   return color;
}

+ (SDKColor*) colorWithColor_t:(FLColor_t) color
{
#if IOS
	return [SDKColor colorWithRed:color.red 
								green:color.green 
								blue:color.blue 
								alpha:color.alpha ];
#else
	return [SDKColor colorWithDeviceRed:color.red 
								green:color.green 
								blue:color.blue 
								alpha:color.alpha ];

#endif                                
}

@end