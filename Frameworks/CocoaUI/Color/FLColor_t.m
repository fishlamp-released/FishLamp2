//
//  FLColorUtils.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLColor_t.h"
#import "FLColor.h"

@implementation FLColor (FLColorUtils)

- (FLColor_t) color_t
{
   FLColor_t color;
   [self rgbValues:&color.red green:&color.green blue:&color.blue alpha:&color.alpha];
   return color;
}

+ (FLColor*) colorWithColor_t:(FLColor_t) color
{
#if IOS
	return [FLColor colorWithRed:color.red 
								green:color.green 
								blue:color.blue 
								alpha:color.alpha ];
#else
	return [FLColor colorWithDeviceRed:color.red 
								green:color.green 
								blue:color.blue 
								alpha:color.alpha ];

#endif                                
}

@end