//
//  SDKColor+FLColorize.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "SDKImage+FLColorize.h"

@implementation SDKImage (FLColorize)

-(SDKImage *)colorizeImage:(SDKColor *)theColor blendMode:(CGBlendMode) blendMode
{
#if IOS
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);

	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);

	CGContextScaleCTM(ctx, 1.0, -1.0);
	CGContextTranslateCTM(ctx, 0, -area.size.height);
	CGContextSaveGState(ctx);
	CGContextClipToMask(ctx, area, self.CGImage);
	[theColor set];
	CGContextFillRect(ctx, area);
	CGContextRestoreGState(ctx);
	CGContextSetBlendMode(ctx, blendMode);
	CGContextDrawImage(ctx, area, self.CGImage);
	
	SDKImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
#else 
    FLAssertIsImplementedWithComment(nil);
    return nil;
#endif
}

+ (SDKImage*) imageNamed:(NSString*) name withColor:(SDKColor*) color blendMode:(CGBlendMode) blendMode {
    SDKImage* image = [SDKImage imageNamed:name];
    FLAssertIsNotNilWithComment(image, nil);

	return [image colorizeImage:color blendMode:blendMode];
}

+ (SDKImage*) whiteImageNamed:(NSString*) name {
	return [SDKImage imageNamed:name withColor:[SDKColor whiteColor] blendMode:kCGBlendModeOverlay];
}

- (SDKImage *)imageTintedWithColor:(SDKColor *)color fraction:(CGFloat)fraction {
#if IOS
	if (color) {
			// Construct new image the same size as this one.
		SDKImage *image;
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
			UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
		}

		CGRect rect = CGRectZero;
		rect.size = [self size];

		// Composite tint color at its own opacity.
		[color set];
		UIRectFill(rect);

		// Mask tint color-swatch to this image's opaque mask.
		// We want behaviour like NSCompositeDestinationIn on Mac OS X.
		[self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];

		// Finally, composite this image over the tinted mask at desired opacity.
		if (fraction > 0.0) {
		// We want behaviour like NSCompositeSourceOver on Mac OS X.
			[self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
		}
		
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();

		return image;
	}
#else
    FLAssertIsImplementedWithComment(nil);
    
#endif

    return self;
}

@end
