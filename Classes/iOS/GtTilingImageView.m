//
//	GtTilingImageView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/7/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTilingImageView.h"


@implementation GtTilingImageView

@synthesize tiledImage = m_image;

- (void) dealloc
{
	GtRelease(m_image);
	GtSuperDealloc();
}


- (void)drawRect:(CGRect)rect {
	// Drawing code
	CGImageRef image = CGImageRetain(m_image.CGImage);

	CGRect imageRect;
	imageRect.origin = CGPointMake(0.0, 0.0);
	imageRect.size = m_image.size;

	CGContextRef context = UIGraphicsGetCurrentContext();		
	CGContextClipToRect(context, CGRectMake(0.0, 0.0, rect.size.width, rect.size.height));		
	CGContextDrawTiledImage(context, imageRect, image);
	CGImageRelease(image);
}

@end
