//
//  UIColor+FLColorize.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
@interface UIImage (FLColorize)

- (UIImage *)colorizeImage:(UIColor *)theColor blendMode:(CGBlendMode) blendMode;

- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

+ (UIImage*) imageNamed:(NSString*) name withColor:(UIColor*) color blendMode:(CGBlendMode) blendMode; 
	// kCGBlendModeOverlay, kCGBlendModeMultiply work well.
	
+ (UIImage*) whiteImageNamed:(NSString*) name;	// kCGBlendModeOverlay	  
@end