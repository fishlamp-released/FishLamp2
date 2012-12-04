// UIImage+Resize.m
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"

// Private helper methods
@interface UIImage_ (ResizeUtils)
- (UIImage_ *)resizedImage:(FLSize)newSize
				transform:(CGAffineTransform)transform
		   drawTransposed:(BOOL)transpose
	 interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(FLSize)newSize;
@end

@implementation UIImage_ (ResizeUtils)

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage_ *)croppedImage:(FLRect)bounds {
#if IOS
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
	UIImage_ *croppedImage = [UIImage_ imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return croppedImage;
#endif
    return nil;
}

// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
- (UIImage_ *)thumbnailImage:(NSInteger)thumbnailSize
		  transparentBorder:(NSUInteger)borderSize
			   cornerRadius:(NSUInteger)cornerRadius
	   interpolationQuality:(CGInterpolationQuality)quality 
				 makeSquare:(BOOL) makeSquare 
{

	UIImage_ *resizedImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
													   bounds:FLSizeMake(thumbnailSize, thumbnailSize)
										 interpolationQuality:quality];
	
	if(makeSquare)
	{
		// Crop out any part of the image that's larger than the thumbnail size
		// The cropped rect must be centered on the resized image
		// Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
		FLRect cropRect = FLRectMake(round((resizedImage.size.width - thumbnailSize) / 2),
									 round((resizedImage.size.height - thumbnailSize) / 2),
									 thumbnailSize,
								 thumbnailSize);
		resizedImage = [resizedImage croppedImage:cropRect];
	}
	
	UIImage_ *transparentBorderImage = borderSize ? [resizedImage transparentBorderImage:borderSize] : resizedImage;

	return [transparentBorderImage roundedCornerImage:cornerRadius borderSize:borderSize];
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage_ *)resizedImage:(FLSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
	BOOL drawTransposed = NO;
    
#if IOS
	switch (self.imageOrientation) {
		case UIImageOrientationLeft:
		case UIImageOrientationLeftMirrored:
		case UIImageOrientationRight:
		case UIImageOrientationRightMirrored:
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
- (UIImage_ *)resizedImageWithContentMode:(UIViewContentMode)contentMode
								  bounds:(FLSize)bounds
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
	
	FLSize newSize = FLSizeMake(self.size.width * ratio, self.size.height * ratio);
	
	return [self resizedImage:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage_ *)resizedImage:(FLSize)newSize
				transform:(CGAffineTransform)transform
		   drawTransposed:(BOOL)transpose
	 interpolationQuality:(CGInterpolationQuality)quality {
	
#if IOS
    FLRect newRect = FLRectIntegral(FLRectMake(0, 0, newSize.width, newSize.height));
	FLRect transposedRect = FLRectMake(0, 0, newRect.size.height, newRect.size.width);
	CGImageRef imageRef = self.CGImage;
	
	// Build a context that's the same dimensions as the new size
	CGContextRef bitmap = CGBitmapContextCreate(NULL,
												newRect.size.width,
												newRect.size.height,
												CGImageGetBitsPerComponent(imageRef),
												0,
												CGImageGetColorSpace(imageRef),
												CGImageGetBitmapInfo(imageRef));
	
	UIImage_ *newImage = nil;
	if(bitmap)
	{
		// Rotate and/or flip the image if required by its orientation
		CGContextConcatCTM(bitmap, transform);
		
		// Set the quality level to use when rescaling
		CGContextSetInterpolationQuality(bitmap, quality);
		
		// Draw into the context; this scales the image
		CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
		
		// Get the resized image from the context and a UIImage_
		CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
		if(newImageRef)
		{
			newImage = [UIImage_ imageWithCGImage:newImageRef];
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
- (CGAffineTransform)transformForOrientation:(FLSize)newSize {
	CGAffineTransform transform = CGAffineTransformIdentity;
	
#if IOS
	switch (self.imageOrientation) {
		case UIImageOrientationDown:		   // EXIF = 3
		case UIImageOrientationDownMirrored:   // EXIF = 4
			transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationLeft:		   // EXIF = 6
		case UIImageOrientationLeftMirrored:   // EXIF = 5
			transform = CGAffineTransformTranslate(transform, newSize.width, 0);
			transform = CGAffineTransformRotate(transform, M_PI_2);
			break;
			
		case UIImageOrientationRight:		   // EXIF = 8
		case UIImageOrientationRightMirrored: // EXIF = 7
			transform = CGAffineTransformTranslate(transform, 0, newSize.height);
			transform = CGAffineTransformRotate(transform, -M_PI_2);
			break;
			
		default:
			break;
	}
	
	switch (self.imageOrientation) {
		case UIImageOrientationUpMirrored:	   // EXIF = 2
		case UIImageOrientationDownMirrored:   // EXIF = 4
			transform = CGAffineTransformTranslate(transform, newSize.width, 0);
			transform = CGAffineTransformScale(transform, -1, 1);
			break;
			
		case UIImageOrientationLeftMirrored:   // EXIF = 5
		case UIImageOrientationRightMirrored: // EXIF = 7
			transform = CGAffineTransformTranslate(transform, newSize.height, 0);
			transform = CGAffineTransformScale(transform, -1, 1);
			break;
		default:
			break;
	}
#endif
	
	return transform;
}

- (FLRect) proportionalBoundsWithMaxSize:(FLSize) maxSize
{
	return FLRectFitInRectInRectProportionally(FLRectMakeWithSize(maxSize), FLRectMakeWithSize(self.size));
}

- (FLSize) proportionalSizeWithMaxSize:(FLSize) maxSize
{
	return [self proportionalBoundsWithMaxSize:maxSize].size;
}


@end
