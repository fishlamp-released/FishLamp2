//
//  FLColorUtils.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCocoaUICompatibility.h"

typedef struct {
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
} FLColor_t;

typedef struct {
	FLColor_t startColor;
	FLColor_t endColor;
} FLColorRange_t;

NS_INLINE
FLColor_t FLColorMake(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
{
	FLColor_t color = { red, green, blue, alpha };
	return	color;
}

NS_INLINE
FLColor_t FLColorDarken(FLColor_t color, CGFloat amount)
{
	color.red = MIN(1.0f, (color.red * amount));
	color.green = MIN(1.0f, (color.green * amount));
	color.blue = MIN(1.0f, (color.blue * amount));
	return color;
}

NS_INLINE
FLColor_t FLColorLighten(FLColor_t color, CGFloat amount)
{
	color.red = MAX(0.0f, color.red / amount);
	color.green = MAX(0.0f, color.green / amount);
	color.blue = MAX(0.0f, color.blue / amount);
	return color;
}

NS_INLINE 
FLColorRange_t FLColorRangeMake(FLColor_t start, FLColor_t end) {
    FLColorRange_t range = { start, end };
    return range;
}

@interface FLColor (FLColorUtils) 
- (FLColor_t) color_t;
+ (FLColor*) colorWithColor_t:(FLColor_t) color;
@end