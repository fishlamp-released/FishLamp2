//
//  GtImageUtilities.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/21/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#if IPHONE

#import "GtImageUtilities.h"
#import "GtGeometry.h"

#define RUN_ON_MAIN_THREAD 1

@interface GtImageOperationData :NSObject {
	UIImage* m_outputImage;
	NSData* m_outputData;
	BOOL m_square;
	CGFloat m_maxLongSide;
	CGFloat m_compression;
}

@property (readwrite, assign, nonatomic) UIImage* outputImage;
@property (readwrite, assign, nonatomic) NSData* outputData;
@property (readwrite, assign, nonatomic) BOOL makeSquare;
@property (readwrite, assign, nonatomic) CGFloat maxLongSide;
@property (readwrite, assign, nonatomic) CGFloat compression;

@end

@implementation GtImageOperationData
@synthesize outputImage = m_outputImage;
@synthesize makeSquare = m_square;
@synthesize maxLongSide = m_maxLongSide;
@synthesize compression = m_compression;
@synthesize outputData = m_outputData;

GtSynthesizeSetter(setOutputImage, UIImage*, m_outputImage);
GtSynthesizeSetter(setOutputData, NSData*, m_outputData);

- (id) init
{
	if(self = [super init])
	{
		self.compression = 1.0;
	}
	
	return self;
}

-(void) dealloc
{
	GtRelease(m_outputData);
	GtRelease(m_outputImage);
	[super dealloc];
}
@end


@implementation UIImage (Utils)

- (void)imageByScalingAndCroppingForSize:(UIImage**) outImage targetSize:(CGSize)targetSize
{
	UIImage *sourceImage = self;
	UIImage *newImage = nil;       
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);

	if (CGSizeEqualToSize(imageSize, targetSize) == NO)
	{
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
	  
		if (widthFactor > heightFactor)
		{
			scaleFactor = widthFactor; // scale to fit height
		}
		else
		{
			scaleFactor = heightFactor; // scale to fit width
		}
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
	  
		// center the image
		if (widthFactor > heightFactor)
		{
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		}
		else if (widthFactor < heightFactor)
		{
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}       

	UIGraphicsBeginImageContext(targetSize); // this will crop

	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;

	[sourceImage drawInRect:thumbnailRect];

	newImage = UIGraphicsGetImageFromCurrentImageContext(); // returns autoreleased image
	if(newImage == nil)
	{
		GtLog(@"could not scale image");
	}

	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	*outImage = [newImage retain];
}
- (void) shrinkImagePrivate:(GtImageOperationData*) shrinkData
{
	NSAutoreleasePool *pool = [GtAlloc(NSAutoreleasePool) init];
	
	UIImage* newImage = nil;
	if(shrinkData.makeSquare)
	{
		[self imageByScalingAndCroppingForSize:&newImage targetSize:CGSizeMake(shrinkData.maxLongSide,shrinkData.maxLongSide)];
	}
	else
	{
		CGSize size = self.size;
		CGSize targetSize = size;
		
		if(size.width > size.height)
		{
			targetSize.width = shrinkData.maxLongSide;
			targetSize.height = size.height / (size.width / shrinkData.maxLongSide);
		}
		else
		{
			targetSize.height = shrinkData.maxLongSide;
			targetSize.width = size.width / (size.height / shrinkData.maxLongSide);
		}
		
		[self imageByScalingAndCroppingForSize:&newImage targetSize:targetSize];
	}
	
	shrinkData.outputImage = newImage;
	GtRelease(newImage);
	
	GtRelease(pool);
}

- (void) shrinkImage:(UIImage**) outImage  maxLongSide:(float) maxLongSide makeSquare:(BOOL) makeSquare;
{
	GtImageOperationData* shrinkData = [GtAlloc(GtImageOperationData) init];
	shrinkData.maxLongSide = maxLongSide;
	shrinkData.makeSquare = makeSquare;
	
#if RUN_ON_MAIN_THREAD	
	[self performSelectorOnMainThread:@selector(shrinkImagePrivate:) withObject:shrinkData waitUntilDone:YES];
#else
	[self shrinkImagePrivate:shrinkData];
#endif	

	*outImage = [shrinkData.outputImage retain];

	GtRelease(shrinkData);
}

- (void) convertToJpegPrivate:(GtImageOperationData*) imageData
{
	NSAutoreleasePool *pool = [GtAlloc(NSAutoreleasePool) init];
	
	NSData* data = UIImageJPEGRepresentation(self, imageData.compression);
	GtThrowIf(data == nil || [data length] == 0, @"ImageUtilities Error",  @"conversion to Jpeg failed");
	
	imageData.outputData = data;

	GtRelease(pool);
}

- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData
{
	GtImageOperationData* imageData = [GtAlloc(GtImageOperationData) init];
	imageData.compression = compression;
	
#if RUN_ON_MAIN_THREAD	
	[self performSelectorOnMainThread:@selector(convertToJpegPrivate:) withObject:imageData waitUntilDone:YES];
#else
	[self convertToJpegPrivate:imageData];
#endif	

	*outData = [imageData.outputData retain];
	GtRelease(imageData);
}

- (void) resizeImageToMinimumSize:(CGSize) minSize
{
	if(self.size.width > self.size.height)
	{
		
	}
	else
	{
	}

}

- (void) rotate:(CGFloat) degrees
	outImage:(UIImage**) outImage
{
	CGRect rotatedFrame = CGRectMake(0,0, self.size.height, self.size.width);
	CGSize rotatedSize = rotatedFrame.size;

	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();

	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);

	//   // Rotate the image context
	CGContextRotateCTM(bitmap, GtDegreesToRadian(degrees));

	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
	CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);

	*outImage = [UIGraphicsGetImageFromCurrentImageContext() retain];
	UIGraphicsEndImageContext();
}


- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(UIImage**) outImage
{   
	[self rotate:clockWise ? 90.0 : -90.0 outImage:outImage];
}

- (void) flip:(UIImage**) outImage
{
	CGRect rotatedFrame = CGRectMake(0,0, self.size.width, self.size.height);
	CGSize rotatedSize = rotatedFrame.size;

	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();

	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);

	//   // Rotate the image context
	CGContextRotateCTM(bitmap, GtDegreesToRadian(180.0));

	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
//	CGContextDrawImage(bitmap, rotatedFrame, self.CGImage);
//		CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);

	CGContextDrawImage(bitmap, 
		CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), 
		[self CGImage]);

	*outImage = [UIGraphicsGetImageFromCurrentImageContext() retain];
	UIGraphicsEndImageContext();

}

@end

	
#endif