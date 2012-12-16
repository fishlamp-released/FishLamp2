// UIImage+Resize.m
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"

// Private helper methods
@interface UIImage (ResizeUtils)
- (UIImage *)resizedImage:(CGSize)newSize
				transform:(CGAffineTransform)transform
		   drawTransposed:(BOOL)transpose
	 interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
@end

@implementation UIImage (ResizeUtils)

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)croppedImage:(CGRect)bounds {
#if IOS
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
	UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return croppedImage;
#endif
    return nil;
}

// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
		  transparentBorder:(NSUInteger)borderSize
			   cornerRadius:(NSUInteger)cornerRadius
	   interpolationQuality:(CGInterpolationQuality)quality 
				 makeSquare:(BOOL) makeSquare 
{

	UIImage *resizedImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
													   bounds:FLSizeMake(thumbnailSize, thumbnailSize)
										 interpolationQuality:quality];
	
	if(makeSquare)
	{
		// Crop out any part of the image that's larger than the thumbnail size
		// The cropped rect must be centered on the resized image
		// Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
		CGRect cropRect = FLRectMake(round((resizedImage.size.width - thumbnailSize) / 2),
									 round((resizedImage.size.height - thumbnailSize) / 2),
									 thumbnailSize,
								 thumbnailSize);
		resizedImage = [resizedImage croppedImage:cropRect];
	}
	
	UIImage *transparentBorderImage = borderSize ? [resizedImage transparentBorderImage:borderSize] : resizedImage;

	return [transparentBorderImage roundedCornerImage:cornerRadius borderSize:borderSize];
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
	BOOL drawTransposed = NO;
    
#if IOS
	switch (self.imageOrientation) {
		case FLImageOrientationLeft:
		case FLImageOrientationLeftMirrored:
		case FLImageOrientationRight:
		case FLImageOrientationRightMirrored:
			drawTransposed = YES;
			break;
			
		default:
			drawTransposed = NO;
	}
#endif

	return [self resizedImage:newSize
					transform:[self transformForOrientation:newSize]
			   drawTransposed:drawTransposed
		 interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
								  bounds:(CGSize)bounds
					interpolationQuality:(CGInterpolationQuality)quality {
	CGFloat horizontalRatio = bounds.width / self.size.width;
	CGFloat verticalRatio = bounds.height / self.size.height;
	CGFloat ratio = 0.0;
	
	switch (contentMode) {
		case UIViewContentModeScaleAspectFill:
			ratio = MAX(horizontalRatio, verticalRatio);
			break;
			
		case UIViewContentModeScaleAspectFit:
			ratio = MIN(horizontalRatio, verticalRatio);
			break;
			
		default:
			[NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %d", contentMode];
	}
	
	CGSize newSize = FLSizeMake(self.size.width * ratio, self.size.height * ratio);
	
	return [self resizedImage:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be FLImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
				transform:(CGAffineTransform)transform
		   drawTransposed:(BOOL)transpose
	 interpolationQuality:(CGInterpolationQuality)quality {
	
#if IOS
    CGRect newRect = FLRectIntegral(FLRectMake(0, 0, newSize.width, newSize.height));
	CGRect transposedRect = FLRectMake(0, 0, newRect.size.height, newRect.size.width);
	CGImageRef imageRef = self.CGImage;
	
	// Build a context that's the same dimensions as the new size
	CGContextRef bitmap = CGBitmapContextCreate(NULL,
												newRect.size.width,
												newRect.size.height,
												CGImageGetBitsPerComponent(imageRef),
												0,
												CGImageGetColorSpace(imageRef),
												CGImageGetBitmapInfo(imageRef));
	
	UIImage *newImage = nil;
	if(bitmap)
	{
		// Rotate and/or flip the image if required by its orientation
		CGContextConcatCTM(bitmap, transform);
		
		// Set the quality level to use when rescaling
		CGContextSetInterpolationQuality(bitmap, quality);
		
		// Draw into the context; this scales the image
		CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
		
		// Get the resized image from the context and a UIImage
		CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
		if(newImageRef)
		{
			newImage = [UIImage imageWithCGImage:newImageRef];
		}
		
		// Clean up
		CGContextRelease(bitmap);
		CGImageRelease(newImageRef);
	}
	
	return newImage;
#endif

    return nil;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
	CGAffineTransform transform = CGAffineTransformIdentity;
	
#if IOS
	switch (self.imageOrientation) {
		case FLImageOrientationDown:		   // EXIF = 3
		case FLImageOrientationDownMirrored:   // EXIF = 4
			transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case FLImageOrientationLeft:		   // EXIF = 6
		case FLImageOrientationLeftMirrored:   // EXIF = 5
			transform = CGAffineTransformTranslate(transform, newSize.width, 0);
			transform = CGAffineTransformRotate(transform, M_PI_2);
			break;
			
		case FLImageOrientationRight:		   // EXIF = 8
		case FLImageOrientationRightMirrored: // EXIF = 7
			transform = CGAffineTransformTranslate(transform, 0, newSize.height);
			transform = CGAffineTransformRotate(transform, -M_PI_2);
			break;
			
		default:
			break;
	}
	
	switch (self.imageOrientation) {
		case FLImageOrientationUpMirrored:	   // EXIF = 2
		case FLImageOrientationDownMirrored:   // EXIF = 4
			transform = CGAffineTransformTranslate(transform, newSize.width, 0);
			transform = CGAffineTransformScale(transform, -1, 1);
			break;
			
		case FLImageOrientationLeftMirrored:   // EXIF = 5
		case FLImageOrientationRightMirrored: // EXIF = 7
			transform = CGAffineTransformTranslate(transform, newSize.height, 0);
			transform = CGAffineTransformScale(transform, -1, 1);
			break;
		default:
			break;
	}
#endif
	
	return transform;
}

- (CGRect) proportionalBoundsWithMaxSize:(CGSize) maxSize
{
	return FLRectFitInRectInRectProportionally(FLRectMakeWithSize(maxSize), FLRectMakeWithSize(self.size));
}

- (CGSize) proportionalSizeWithMaxSize:(CGSize) maxSize
{
	return [self proportionalBoundsWithMaxSize:maxSize].size;
}


@end