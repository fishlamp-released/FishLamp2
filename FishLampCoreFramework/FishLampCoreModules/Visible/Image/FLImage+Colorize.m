//
//	FLImage+FLColorize.m
//	Milton_iOS
//
//	Created by Mike Fullerton on 12/26/10.
//	Copyright 2010 GreenTongue Software, LLC. All rights reserved.
//

#import "FLImage+Colorize.h"

@implementation FLImage (FLColorize)

-(FLImage *)colorizeImage:(FLColor *)theColor blendMode:(CGBlendMode) blendMode
{
#if IOS
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);

	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	FLRect area = CGRectMake(0, 0, self.size.width, self.size.height);

	CGContextScaleCTM(ctx, 1.0, -1.0);
	CGContextTranslateCTM(ctx, 0, -area.size.height);
	CGContextSaveGState(ctx);
	CGContextClipToMask(ctx, area, self.CGImage);
	[theColor set];
	CGContextFillRect(ctx, area);
	CGContextRestoreGState(ctx);
	CGContextSetBlendMode(ctx, blendMode);
	CGContextDrawImage(ctx, area, self.CGImage);
	
	FLImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
#else 
    FLAssertIsImplemented_v(nil);
    return nil;
#endif
}

+ (FLImage*) imageNamed:(NSString*) name withColor:(FLColor*) color blendMode:(CGBlendMode) blendMode {
    FLImage* image = [FLImage imageNamed:name];
    FLAssertIsNotNil_v(image, nil);

	return [image colorizeImage:color blendMode:blendMode];
}

+ (FLImage*) whiteImageNamed:(NSString*) name {
	return [FLImage imageNamed:name withColor:[FLColor whiteColor] blendMode:kCGBlendModeOverlay];
}

- (FLImage *)imageTintedWithColor:(FLColor *)color fraction:(CGFloat)fraction {
#if IOS
	if (color) {
			// Construct new image the same size as this one.
		FLImage *image;
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
			UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
		}

		FLRect rect = CGRectZero;
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
    FLAssertIsImplemented_v(nil);
    
#endif

    return self;
}

@end
