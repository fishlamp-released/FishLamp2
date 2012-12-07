//
//  FLColor+FLColorize.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImage.h"

@interface FLImage (FLColorize)

- (FLImage *)colorizeImage:(FLColor *)theColor blendMode:(CGBlendMode) blendMode;

- (FLImage *)imageTintedWithColor:(FLColor *)color fraction:(CGFloat)fraction;

+ (FLImage*) imageNamed:(NSString*) name withColor:(FLColor*) color blendMode:(CGBlendMode) blendMode; 
	// kCGBlendModeOverlay, kCGBlendModeMultiply work well.
	
+ (FLImage*) whiteImageNamed:(NSString*) name;	// kCGBlendModeOverlay	  
@end