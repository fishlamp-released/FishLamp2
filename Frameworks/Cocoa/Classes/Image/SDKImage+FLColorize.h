//
//  SDKColor+FLColorize.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

@interface SDKImage (FLColorize)

- (SDKImage *)colorizeImage:(SDKColor *)theColor blendMode:(CGBlendMode) blendMode;

- (SDKImage *)imageTintedWithColor:(SDKColor *)color fraction:(CGFloat)fraction;

+ (SDKImage*) imageNamed:(NSString*) name withColor:(SDKColor*) color blendMode:(CGBlendMode) blendMode; 
	// kCGBlendModeOverlay, kCGBlendModeMultiply work well.
	
+ (SDKImage*) whiteImageNamed:(NSString*) name;	// kCGBlendModeOverlay	  
@end