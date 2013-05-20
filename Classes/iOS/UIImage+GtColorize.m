//
//	UIImage+GtColorize.m
//	Milton_iOS
//
//	Created by Mike Fullerton on 12/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIImage+GtColorize.h"


@implementation UIImage (GtColorize)

-(UIImage *)colorizeImage:(UIColor *)theColor blendMode:(CGBlendMode) blendMode
{
#if __IPHONE_4_0
	if(OSVersionIsAtLeast4_0())
	{
		UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
	}
	else
#endif
	{	 
		UIGraphicsBeginImageContext(self.size);
	}

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
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

+ (UIImage*) imageNamed:(NSString*) name colorizeImage:(UIColor*) color blendMode:(CGBlendMode) blendMode
{
    UIImage* image = [UIImage imageNamed:name];
    GtAssertNotNil(image);

	return [image colorizeImage:color blendMode:blendMode];
}

+ (UIImage*) whiteImageNamed:(NSString*) name
{
	return [UIImage imageNamed:name colorizeImage:[UIColor whiteColor] blendMode:kCGBlendModeOverlay];
}

- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction
{
	if (color) {
			// Construct new image the same size as this one.
		UIImage *image;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
			UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
		}
#else
		if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0) {
			UIGraphicsBeginImageContext([self size]);
		}
#endif

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

return self;
}

@end
