//
//  NSColor+More.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/10/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "UIColor+FLExtras.h"

@implementation UIColor_ (FLExtras)

+ (UIColor_*) colorWithCSSStyleString:(NSString*) string
{
    if(string.length == 7 && [string characterAtIndex:0] == '#')
    {
        char redStr[3] = { 
            (char)[string characterAtIndex:1], 
            (char)[string characterAtIndex:2], 
            0 
            };
        char blueStr[3] = {
            (char)[string characterAtIndex:3], 
            (char)[string characterAtIndex:4], 
            0 
        };
        char greenStr[3] = {
            (char)[string characterAtIndex:5], 
            (char)[string characterAtIndex:6], 
            0 
        };
        char* endPtr;
        long red = strtol( redStr, &endPtr, 16 );
        long green = strtol( blueStr, &endPtr, 16 );
        long blue = strtol( greenStr, &endPtr, 16 );
        return [UIColor_ colorWithRgbValues:red green:green blue:blue alpha:1.0f];
    }
    
    return nil;
}

+ (UIColor_*) colorWithRgbString:(NSString*) string
{
    UIColor_* color = [UIColor_ colorWithCSSStyleString:string];
    if(!color)
    {
        CGFloat rgb[4] = {
            0,
            0,
            0,
            1.0f 
            };

        int which = 0;
        
        char num[32];
        char *p = num;
        *p = 0;
        
        if([string rangeOfString:@"rgb("].location == 0)
        {
            for(int i = 4; i < string.length; i++)
            {
                char c = (char) [string characterAtIndex:i];
                
                switch(c)
                {
                    case ')':
                    case ',':
                    case ' ':
                    if(p > num)
                    {
                        rgb[which++] = (CGFloat) atof(num);
                        p = num;
                        *p = 0;
                    }
                    break;
                    
                    case '.':
                    default:
                        *p++ = c;
                        *p = 0;
                    break;
                }
            }
        
            color = [UIColor_ colorWithRgbValues:rgb[0] green:rgb[1] blue:rgb[2] alpha:rgb[3]];
        } 
    }
    
    return color;
}

- (NSString*) toRgbString
{
	CGFloat red = 0, green = 0, blue = 0, alpha = 0;
	
	[self rgbValues:&red green:&green blue:&blue alpha:&alpha];
	
	return [NSString stringWithFormat:@"rgb(%d,%d,%d,%f)", 
		(unsigned int) FLToRgb(red), 
		(unsigned int) FLToRgb(green), 
		(unsigned int) FLToRgb(blue),
        alpha];
}

- (NSString*) toHexString:(BOOL) forCss
{
	CGFloat red = 0, green = 0, blue = 0;
	
	[self rgbValues:&red green:&green blue:&blue alpha:nil];
	
	return [NSString stringWithFormat:@"%@%X%X%X", forCss ? @"#" : @"",	 
		(unsigned int) FLToRgb(red), 
		(unsigned int) FLToRgb(green), 
		(unsigned int) FLToRgb(blue)];
}

+ (UIColor_*) colorWithRgbValues:(CGFloat) red 
	green:(CGFloat) green 
	blue:(CGFloat) blue 
	alpha:(CGFloat) alpha
{
#if IOS
	return [UIColor_ colorWithRed:red/255.0f 
								green:green/255.0f 
								blue:blue/255.0f 
								alpha:alpha ];
#else
	return [UIColor_ colorWithDeviceRed:red/255.0f 
								green:green/255.0f 
								blue:blue/255.0f 
								alpha:alpha ];
#endif                                
}

- (void) rgbValues:(CGFloat*) red 
			 green:(CGFloat*) green 
			  blue:(CGFloat*) blue 
			 alpha:(CGFloat*) alpha
{
#if IOS
	CGColorRef color = self.CGColor;
	int numComponents = CGColorGetNumberOfComponents(color);
	 
	if (numComponents == 2)
	{
		const CGFloat *components = CGColorGetComponents(color);
		CGFloat all = components[0];
		*red = all;
		*green = all;
		*blue = all;
		*alpha = components[1];
	}
	else
	{
		FLAssert_v(numComponents == 4, @"didn't get 4 componants");
	
		const CGFloat *components = CGColorGetComponents(color);
		*red = components[0];
		*green = components[1];
		*blue = components[2];
        *alpha = components[3];
	}
#else
    [self getRed:red green:green blue:blue alpha:alpha];
    
#endif    
}

- (BOOL) isLightColor
{
#if IOS
	const CGFloat *componentColors = CGColorGetComponents(self.CGColor);

	CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
	return (colorBrightness > 0.5);
#endif 

    return NO;
}


@end
