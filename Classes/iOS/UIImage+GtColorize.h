//
//	UIImage+GtColorize.h
//	Milton_iOS
//
//	Created by Mike Fullerton on 12/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


@interface UIImage (GtColorize)

-(UIImage *)colorizeImage:(UIColor *)theColor blendMode:(CGBlendMode) blendMode;


- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;


+ (UIImage*) imageNamed:(NSString*) name colorizeImage:(UIColor*) color blendMode:(CGBlendMode) blendMode; 
	// kCGBlendModeOverlay, kCGBlendModeMultiply work well.
	
+ (UIImage*) whiteImageNamed:(NSString*) name;	// kCGBlendModeOverlay	  
@end
