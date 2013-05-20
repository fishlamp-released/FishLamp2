//
//  NSColor+More.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/10/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIColor+More.h"

@implementation UIColor (More)

+ (UIColor*) colorWithCSSStyleString:(NSString*) string
{
    if(string.length == 7 && [string characterAtIndex:0] == '#')
    {
        char redStr[3] = { 
            [string characterAtIndex:1], 
            [string characterAtIndex:2], 
            0 
            };
        char blueStr[3] = {
            [string characterAtIndex:3], 
            [string characterAtIndex:4], 
            0 
        };
        char greenStr[3] = {
            [string characterAtIndex:5], 
            [string characterAtIndex:6], 
            0 
        };
        char* endPtr;
        long red = strtol( redStr, &endPtr, 16 );
        long green = strtol( blueStr, &endPtr, 16 );
        long blue = strtol( greenStr, &endPtr, 16 );
        return [UIColor colorWithRgbValues:red green:green blue:blue alpha:1.0f];
    }
    
    return nil;
}

+ (UIColor*) colorWithRgbString:(NSString*) string
{
    UIColor* color = [UIColor colorWithCSSStyleString:string];
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
            for(NSUInteger i = 4; i < string.length; i++)
            {
                char c = [string characterAtIndex:i];
                
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
        
            color = [UIColor colorWithRgbValues:rgb[0] green:rgb[1] blue:rgb[2] alpha:rgb[3]];
        } 
    }
    
    return color;
}

- (NSString*) toRgbString
{
	CGFloat red = 0, green = 0, blue = 0, alpha = 0;
	
	[self rgbValues:&red green:&green blue:&blue alpha:&alpha];
	
	return [NSString stringWithFormat:@"rgb(%d,%d,%d,%f)", 
		(unsigned int) TO_RGB(red), 
		(unsigned int) TO_RGB(green), 
		(unsigned int) TO_RGB(blue),
        alpha];
}

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
#if IOS
	return [UIColor colorWithRed:red/255.0f 
								green:green/255.0f 
								blue:blue/255.0f 
								alpha:alpha ];
#else
	return [UIColor colorWithDeviceRed:red/255.0f 
								green:green/255.0f 
								blue:blue/255.0f 
								alpha:alpha ];
#endif                                
}

+ (UIColor*) colorWithRgbValues:(GtColorStruct) color
{
	return [UIColor colorWithRgbValues:color.red 
								green:color.green 
								blue:color.blue 
								alpha:color.alpha ];
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
		GtAssert(numComponents == 4, @"didn't get 4 componants");
	
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

- (GtColorStruct) colorStruct
{
   GtColorStruct color;
   [self rgbValues:&color.red green:&color.green blue:&color.blue alpha:&color.alpha];
   return color;
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
