//
//  FLColor+Utils.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLColor.h"

@interface FLColor (FLUtils)

+ (FLColor*) colorWithRgbValues:(CGFloat) red /* 0-255 */
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
+ (FLColor*) colorWithRgbString:(NSString*) string;

- (NSString*) toRgbString; // rgb(11,11,11,0.5)


@end

