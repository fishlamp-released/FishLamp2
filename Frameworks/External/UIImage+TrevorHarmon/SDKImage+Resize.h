// SDKImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the SDKImage class to support resizing/cropping

#import "FLCore.h"
#import "FLGeometry.h"
#import "SDKImage.h"

#if !IOS

// temp
typedef enum {
    UIViewContentModeScaleToFill,
    UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
    UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
    UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
    UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
    UIViewContentModeTop,
    UIViewContentModeBottom,
    UIViewContentModeLeft,
    UIViewContentModeRight,
    UIViewContentModeTopLeft,
    UIViewContentModeTopRight,
    UIViewContentModeBottomLeft,
    UIViewContentModeBottomRight,
} UIViewContentMode;
#endif

@interface SDKImage (Resize)

- (SDKImage *)croppedImage:(SDKRect)bounds;

- (SDKImage *)thumbnailImage:(NSInteger)thumbnailSize
		  transparentBorder:(NSUInteger)borderSize
			   cornerRadius:(NSUInteger)cornerRadius
	   interpolationQuality:(CGInterpolationQuality)quality
				 makeSquare:(BOOL) makeSquare;

- (SDKImage *)resizedImage:(SDKSize)newSize
	 interpolationQuality:(CGInterpolationQuality)quality;

- (SDKImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
								  bounds:(SDKSize)bounds
					interpolationQuality:(CGInterpolationQuality)quality;

- (SDKRect) proportionalBoundsWithMaxSize:(SDKSize) maxSize;

- (SDKSize) proportionalSizeWithMaxSize:(SDKSize) maxSize;

@end
