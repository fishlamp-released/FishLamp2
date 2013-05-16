//
//  UIColor.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/20/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//
#if IPHONE
#import "GtColors.h"

#define TO_RGB(VAL) (VAL*255.0)

#define RETURN_RGB_COLOR(RED,GREEN,BLUE) \
		GtReturnSyncronizedStatic(s_color, UIColor, [[UIColor	colorWithRed:RED/255.0f \
								green:GREEN/255.0f \
								blue:BLUE/255.0f \
								alpha:1.0f ] retain])

#define RETURN_COLOR(RED,GREEN,BLUE) \
		GtReturnSyncronizedStatic(s_color, UIColor, [[UIColor	colorWithRed:RED \
								green:GREEN \
								blue:BLUE \
								alpha:1.0f ] retain])

@implementation UIColor (GtExtras)

- (NSString*) toHexString:(BOOL) forCss
{
    CGFloat red = 0, green = 0, blue = 0;
    
    [self rgbValues:&red green:&green blue:&blue alpha:nil];
    
    return [NSString stringWithFormat:@"%@%X%X%X", forCss ? @"#" : @"",  
        (unsigned int) TO_RGB(red), 
        (unsigned int) TO_RGB(green), 
        (unsigned int) TO_RGB(blue)];
}

+ (UIColor*) colorWithRgbValues:(CGFloat) red 
	green:(CGFloat) green 
	blue:(CGFloat) blue 
	alpha:(CGFloat) alpha
{
	return [UIColor	colorWithRed:red/255.0f \
								green:green/255.0f \
								blue:blue/255.0f \
								alpha:alpha ];
}

+ (UIColor*) blueLabelColor
{
/*
	static UIColor* s_color = nil;
	if(!s_color)
	{
		s_color = [[UIColor	colorWithRed:50.0f/255.0f 
								green:79.0f/255.0f 
								blue:133.0f/255.0f 
								alpha:1.0f ] retain];
	}
	return s_color;
*/	
	RETURN_RGB_COLOR(50.0,79.0,133.0);
}

+ (UIColor*) almostBlackGrayColor
{
	static UIColor* s_color = nil;
	if(!s_color)
	{
		s_color = [[UIColor	colorWithWhite:0.1 alpha:1.0f ] retain];
	}
	return s_color;
}

+ (UIColor*) iPhoneBlueColor
{
//	return [UIColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];

	RETURN_RGB_COLOR(36,99,222);
}

+ (UIColor*) standardLabelColor
{
	return [UIColor blackColor];
}

+ (UIColor*) standardTextFieldColor
{
	return [UIColor blueLabelColor];
}	

+ (UIColor*) disabledControlColor
{
	return [UIColor lightGrayColor];
}

+ (UIColor*)indigoColor
{
	RETURN_COLOR(.294f, 0.0f, .509f);
}

+ (UIColor*)lightLightGrayColor
{
	RETURN_COLOR(0.85f, 0.85f, 0.85f);
}

+ (UIColor*) almostWhiteGrayColor
{
	RETURN_COLOR(0.95f, 0.95f, 0.95f);
}

+ (UIColor*)tealColor
{
	RETURN_COLOR(0.0f, 0.5f, 0.5f);
}

+ (UIColor*)violetColor
{
	RETURN_COLOR (.498f, 0.0f, 1.0f); 
}

+ (UIColor*)electricVioletColor
{
	RETURN_COLOR(.506f, 0.0f, 1.0f);
}

+ (UIColor*)vividVioletColor
{
	RETURN_COLOR(.506f, 0.0f, 1.0f);
}

+ (UIColor*)darkVioletColor
{
	RETURN_COLOR(.58f, 0.0f, .827f);
}

+ (UIColor*)amberColor
{
	RETURN_COLOR(1.0f, .75f, 0.0f);
}

+ (UIColor*)darkAmberColor
{
	RETURN_COLOR(1.0f, .494f, 0.0f);
}

+ (UIColor*)lemonColor
{
	RETURN_COLOR(1.0f, .914f, .0627f);
}

+ (UIColor*) paleYellowColor
{
	RETURN_COLOR(1.0f, .914f, .0627f);
}

+ (UIColor*)roseColor
{
	RETURN_COLOR(1.0f, 0.0f, 0.5f);
}

+ (UIColor*)rubyColor
{
	RETURN_COLOR(0.8784f, .06667f, .3725f);
}

+ (UIColor*)fireEngineRed
{
	RETURN_COLOR(0.8078f, 0.0863f, 0.1255f);
}

+ (UIColor*)darkBlueColor
{
	RETURN_COLOR(0.0f, 0.0f, 0.25f);
}

- (void) rgbValues:(CGFloat*) red green:(CGFloat*) green blue:(CGFloat*) blue
{
	[self rgbValues:red green:green blue:blue alpha:nil];
}

- (void) rgbValues:(CGFloat*) red 
             green:(CGFloat*) green 
              blue:(CGFloat*) blue 
             alpha:(CGFloat*) alphaOrNil
{
	CGColorRef color = self.CGColor;
	int numComponents = CGColorGetNumberOfComponents(color);
	 
	if (numComponents == 2)
	{
		const CGFloat *components = CGColorGetComponents(color);
		CGFloat all = components[0];
		*red = all;
		*green = all;
		*blue = all;
		if(alphaOrNil)
		{
			*alphaOrNil = components[1];
		}
	}
	else
	{
		GtAssert(numComponents == 4, @"didn't get 4 componants");
	
		const CGFloat *components = CGColorGetComponents(color);
		*red = components[0];
		*green = components[1];
		*blue = components[2];
		if(alphaOrNil)
		{
			*alphaOrNil = components[3];
		}
	}
}

@end

@implementation UIFont (GtExtras)

+ (UIFont*) standardLabelFont
{
	GtReturnSyncronizedStatic(s_color, UIFont, [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]);

//	return [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
}

+ (UIFont*) standardTextFieldFont
{
	GtReturnSyncronizedStatic(s_color, UIFont, [UIFont systemFontOfSize:[UIFont systemFontSize]]);
//	return [UIFont systemFontOfSize:[UIFont systemFontSize]];
}

+ (UIFont*) standardNavigationBarLabelFont
{
	return [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
}
@end

#endif