//
//  NSColor+More.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 3/10/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLCocoaCompatibility.h"

#define FLToRgb(__c) (__c * 255.0f) 

#if IOS
#define FLRgbColor(r,g,b,a) [CocoaColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#else
#define FLRgbColor(r,g,b,a) [CocoaColor colorWithDeviceRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

@interface CocoaColor (FLExtras)

+ (CocoaColor*) colorWithRgbValues:(CGFloat) red /* 0-255 */
	green:(CGFloat) green /* 0-255 */
	blue:(CGFloat) blue /* 0-255 */
	alpha:(CGFloat) alpha;

- (void) rgbValues:(CGFloat*) red 
			 green:(CGFloat*) green 
			  blue:(CGFloat*) blue 
			 alpha:(CGFloat*) alpha;

- (NSString*) toHexString:(BOOL) forCss;


- (BOOL) isLightColor;

// #112233
// rgb(10,11,12)
// rgb(10,11,12, 0.5);
+ (CocoaColor*) colorWithRgbString:(NSString*) string;

- (NSString*) toRgbString; // rgb(11,11,11,0.5)


@end
