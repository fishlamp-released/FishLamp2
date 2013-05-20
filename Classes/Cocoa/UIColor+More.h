//
//  NSColor+More.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/10/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishlampCocoaCompatibility.h"

#define TO_RGB(VAL) (VAL*255.0)
#define GtRgbColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

typedef struct {
	CGFloat red;
	CGFloat green;
	CGFloat blue;
	CGFloat alpha;
} GtColorStruct;

NS_INLINE
GtColorStruct GtRgbStructMake(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
{
	GtColorStruct color = { red, green, blue, alpha };
	return	color;
}

NS_INLINE
GtColorStruct GtColorStructDarken(GtColorStruct color, CGFloat amount)
{
	color.red = MIN(1.0, color.red * amount);
	color.green = MIN(1.0, color.green * amount);
	color.blue = MIN(1.0, color.blue * amount);
	return color;
}

NS_INLINE
GtColorStruct GtColorStructLighten(GtColorStruct color, CGFloat amount)
{
	color.red = MAX(0.0, color.red / amount);
	color.green = MAX(0.0, color.green / amount);
	color.blue = MAX(0.0, color.blue / amount);
	return color;
}

@interface UIColor (More)

+ (UIColor*) colorWithRgbValues:(CGFloat) red /* 0-255 */
	green:(CGFloat) green /* 0-255 */
	blue:(CGFloat) blue /* 0-255 */
	alpha:(CGFloat) alpha;

- (void) rgbValues:(CGFloat*) red 
			 green:(CGFloat*) green 
			  blue:(CGFloat*) blue 
			 alpha:(CGFloat*) alpha;

- (NSString*) toHexString:(BOOL) forCss;

+ (UIColor*) colorWithRgbValues:(GtColorStruct) colorStruct;

- (BOOL) isLightColor;

// #112233
// rgb(10,11,12)
// rgb(10,11,12, 0.5);
+ (UIColor*) colorWithRgbString:(NSString*) string;

- (NSString*) toRgbString; // rgb(11,11,11,0.5)

- (GtColorStruct) colorStruct;

@end
