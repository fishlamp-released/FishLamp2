//
//  FLColorUtilities.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLColorUtilities.h"
#import "FLColorValues.h"

NSString* FLRgbStringFromColor(UIColor* color) { //rgb(11,11,11,0.5)

    FLColorValues colorValues = color.rgbColorValues;
    	
	return [NSString stringWithFormat:@"rgb(%d,%d,%d,%f)", 
		(unsigned int) colorValues.red,
		(unsigned int) colorValues.green,
		(unsigned int) colorValues.blue,
        colorValues.alpha];
}

CGColorRef FLCreateCGColorFromNSColor(NSColor *color, CGColorSpaceRef colorSpace) {

    if(!colorSpace) {
        colorSpace = [[color colorSpace] CGColorSpace];
    }

    NSColor *deviceColor = [color colorUsingColorSpaceName:NSDeviceRGBColorSpace];

    CGFloat components[4];
    [deviceColor getRed: &components[0] green: &components[1] blue:
    &components[2] alpha: &components[3]];

    return CGColorCreate (colorSpace, components);
}

UIColor*  FLColorFromRGBString(NSString* string) {
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
        
        
    
        return [UIColor colorWithRGBRed:rgb[0] green:rgb[1] blue:rgb[2] alpha:rgb[3]];
    }
    
    return nil;
}

NSString* FLCssColorStringFromColor(UIColor* color) {
    FLColorValues colorValues = color.rgbColorValues;
		
	return [NSString stringWithFormat:@"#%X%X%X",
            (unsigned int) colorValues.red,
            (unsigned int) colorValues.green,
            (unsigned int) colorValues.blue];
}


UIColor* FLColorFromCssColorString(NSString* string) {
    if(string.length == 7 && [string characterAtIndex:0] == '#') {
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
        return [UIColor colorWithRGBRed:red green:green blue:blue alpha:1.0f];
    }
    
    return nil;
}

NSString* FLHexColorStringFromColor(UIColor* color) {
    FLColorValues colorValues = color.rgbColorValues;
	return [NSString stringWithFormat:@"%X%X%X",
            (unsigned int) colorValues.red,
            (unsigned int) colorValues.green,
            (unsigned int) colorValues.blue];
}

#if OSX
@implementation NSColor (FLColorConversions)
+(CGColorRef) CIColorToCGColor: (CIColor *) ciColor {
    CGColorSpaceRef colorSpace = [ciColor colorSpace];
    const CGFloat *components = [ciColor components];
    CGColorRef cgColor = CGColorCreate (colorSpace, components);
    CGColorSpaceRelease(colorSpace);
    return cgColor;
}
+(CGColorRef) NSColorToCGColor: (NSColor *) nsColor {
    CIColor *ciColor = [[CIColor alloc] initWithColor: nsColor];
    CGColorRef cgColor = [NSColor CIColorToCGColor: ciColor];
    [ciColor release];
    return cgColor;
}
+(NSColor *) CGColorToNSColor: (CGColorRef) cgColor {
    return [NSColor colorWithCIColor: [CIColor colorWithCGColor: cgColor]];
}
@end
#endif