// UIImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the UIImage class to support resizing/cropping

#import "FLCore.h"
#import "FLGeometry.h"
#import "FLCocoaCompatibility.h"

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

@interface UIImage_ (Resize)

- (UIImage_ *)croppedImage:(FLRect)bounds;

- (UIImage_ *)thumbnailImage:(NSInteger)thumbnailSize
		  transparentBorder:(NSUInteger)borderSize
			   cornerRadius:(NSUInteger)cornerRadius
	   interpolationQuality:(CGInterpolationQuality)quality
				 makeSquare:(BOOL) makeSquare;

- (UIImage_ *)resizedImage:(FLSize)newSize
	 interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage_ *)resizedImageWithContentMode:(UIViewContentMode)contentMode
								  bounds:(FLSize)bounds
					interpolationQuality:(CGInterpolationQuality)quality;

- (FLRect) proportionalBoundsWithMaxSize:(FLSize) maxSize;

- (FLSize) proportionalSizeWithMaxSize:(FLSize) maxSize;

@end
