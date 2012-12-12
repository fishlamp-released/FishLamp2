//
//  FLTilingImageView.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTilingImageView.h"

@implementation FLTilingImageView

@synthesize image = _image;

#if FL_MRC
- (void) dealloc {
    [_image release];
    [super dealloc];
}
#endif

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
#if IOS
	// Drawing code
	CGImageRef image = CGImageRetain(_image.CGImage);

	CGRect imageRect;
	imageRect.origin = CGPointMake(0.0, 0.0);
	imageRect.size = _image.size;

	CGContextRef context = UIGraphicsGetCurrentContext();		
	CGContextClipToRect(context, CGRectMake(0.0, 0.0, rect.size.width, rect.size.height));		
	CGContextDrawTiledImage(context, imageRect, image);
	CGImageRelease(image);
#else 
    [[NSColor colorWithPatternImage:_image] set];
    NSRectFill([self bounds]);
#endif
}


@end
