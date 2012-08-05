//
//	FLTilingImageView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/7/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTilingImageView.h"


@implementation FLTilingImageView

@synthesize tiledImage = _image;

- (void) dealloc {
	FLRelease(_image);
	FLSuperDealloc();
}

- (void)drawRect:(CGRect)rect {
	// Drawing code
	CGImageRef image = CGImageRetain(_image.CGImage);

	CGRect imageRect;
	imageRect.origin = CGPointMake(0.0, 0.0);
	imageRect.size = _image.size;

	CGContextRef context = UIGraphicsGetCurrentContext();		
	CGContextClipToRect(context, CGRectMake(0.0, 0.0, rect.size.width, rect.size.height));		
	CGContextDrawTiledImage(context, imageRect, image);
	CGImageRelease(image);
}

@end
