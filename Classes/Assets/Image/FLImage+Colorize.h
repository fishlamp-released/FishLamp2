//
//	FLImage+FLColorize.h
//	Milton_iOS
//
//	Created by Mike Fullerton on 12/26/10.
//	Copyright 2010 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FLImage (Colorize)

-(FLImage *)colorizeImage:(FLColor *)theColor blendMode:(CGBlendMode) blendMode;


- (FLImage *)imageTintedWithColor:(FLColor *)color fraction:(CGFloat)fraction;


+ (FLImage*) imageNamed:(NSString*) name withColor:(FLColor*) color blendMode:(CGBlendMode) blendMode; 
	// kCGBlendModeOverlay, kCGBlendModeMultiply work well.
	
+ (FLImage*) whiteImageNamed:(NSString*) name;	// kCGBlendModeOverlay	  
@end
