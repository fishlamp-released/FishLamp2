//
//	UIImage+FLColorize.h
//	Milton_iOS
//
//	Created by Mike Fullerton on 12/26/10.
//	Copyright 2010 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (FLColorize)

-(UIImage *)colorizeImage:(UIColor *)theColor blendMode:(CGBlendMode) blendMode;


- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;


+ (UIImage*) imageNamed:(NSString*) name withColor:(UIColor*) color blendMode:(CGBlendMode) blendMode; 
	// kCGBlendModeOverlay, kCGBlendModeMultiply work well.
	
+ (UIImage*) whiteImageNamed:(NSString*) name;	// kCGBlendModeOverlay	  
@end
