//
//  FLColor+FLColorize.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "SDKImage.h"

@interface SDKImage (FLColorize)

- (SDKImage *)colorizeImage:(FLColor *)theColor blendMode:(CGBlendMode) blendMode;

- (SDKImage *)imageTintedWithColor:(FLColor *)color fraction:(CGFloat)fraction;

+ (SDKImage*) imageNamed:(NSString*) name withColor:(FLColor*) color blendMode:(CGBlendMode) blendMode; 
	// kCGBlendModeOverlay, kCGBlendModeMultiply work well.
	
+ (SDKImage*) whiteImageNamed:(NSString*) name;	// kCGBlendModeOverlay	  
@end