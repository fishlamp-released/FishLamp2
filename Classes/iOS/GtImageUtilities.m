//
//	GtImageUtilities.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/21/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

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

@property (readwrite, retain, nonatomic) UIImage* outputImage;
@property (readwrite, retain, nonatomic) NSData* outputData;
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

- (id) init
{
	if((self = [super init]))
	{
		self.compression = 1.0;
	}
	
	return self;
}

-(void) dealloc
{
	GtReleaseWithNil(m_outputData);
	GtReleaseWithNil(m_outputImage);
	GtSuperDealloc();
}
@end


@implementation UIImage (Utils)

//- (NSUInteger) imageSize
//{
//	  CGSize size = self.size;
//		
//	size_t bits = CGImageGetBitsPerComponent(self.CGImage);
//		
//	unsigned long outSize = bits * (size.width * size.height);
//	
//	return outSize;
//}

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
		scaledWidth	 = width * scaleFactor;
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
	thumbnailRect.size.width = scaledWidth;
	thumbnailRect.size.height = scaledHeight;

	[sourceImage drawInRect:thumbnailRect];

	newImage = UIGraphicsGetImageFromCurrentImageContext(); // returns autoreleased image
	if(newImage == nil)
	{
		GtLog(@"could not scale image");
	}

	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	*outImage = GtRetain(newImage);
}
- (void) shrinkImagePrivate:(GtImageOperationData*) shrinkData
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	UIImage* newImage = nil;
	@try
	{
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
		
		GtDrainPool(&pool);
	}
	@catch(NSException* ex)
	{
		GtDrainPoolAndRethrow(&pool, ex);
	}
	@finally
	{
		GtReleaseWithNil(newImage);
	}
}

- (void) shrinkImage:(UIImage**) outImage maxLongSide:(float) maxLongSide makeSquare:(BOOL) makeSquare;
{
	GtImageOperationData* shrinkData = [[GtImageOperationData alloc] init];
	shrinkData.maxLongSide = maxLongSide;
	shrinkData.makeSquare = makeSquare;
	
#if RUN_ON_MAIN_THREAD	
	[self performSelectorOnMainThread:@selector(shrinkImagePrivate:) withObject:shrinkData waitUntilDone:YES];
#else
	[self shrinkImagePrivate:shrinkData];
#endif	

	*outImage = GtRetain(shrinkData.outputImage);

	GtReleaseWithNil(shrinkData);
}

- (void) convertToJpegPrivate:(GtImageOperationData*) imageData
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	@try
	{
		NSData* data = UIImageJPEGRepresentation(self, imageData.compression);
		GtAssert(data == nil || [data length] == 0, @"ImageUtilities Error - conversion to Jpeg failed");
		
		imageData.outputData = data;
		GtDrainPool(&pool);
	}
	@catch(NSException* ex)
	{
		GtDrainPoolAndRethrow(&pool, ex);
	}
}

- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData
{
	GtImageOperationData* imageData = [[GtImageOperationData alloc] init];
	imageData.compression = compression;
	
#if RUN_ON_MAIN_THREAD	
	[self performSelectorOnMainThread:@selector(convertToJpegPrivate:) withObject:imageData waitUntilDone:YES];
#else
	[self convertToJpegPrivate:imageData];
#endif	

	*outData = GtRetain(imageData.outputData);
	GtReleaseWithNil(imageData);
}

- (void) rotate:(CGFloat) degrees
	outImage:(UIImage**) outImage
{
	if(degrees == -180)
	{
		degrees = 180;
	}

	CGRect rotatedFrame = degrees == ABS(180.0) ?	CGRectMake(0,0, self.size.width, self.size.height) :
													CGRectMake(0,0, self.size.height, self.size.width);
	CGSize rotatedSize = rotatedFrame.size;

	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();

	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);

	//	 // Rotate the image context
	CGContextRotateCTM(bitmap, GtDegreesToRadians(degrees));

	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0); // why -1? 
	CGContextDrawImage(bitmap, 
		CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), // center the image on center point, set above
		[self CGImage]);

	*outImage = GtRetain(UIGraphicsGetImageFromCurrentImageContext());
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

	//	 // Rotate the image context
	CGContextRotateCTM(bitmap, GtDegreesToRadians(180.0));

	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);

	CGContextDrawImage(bitmap, 
		CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), 
		[self CGImage]);

	*outImage = GtRetain(UIGraphicsGetImageFromCurrentImageContext());
	UIGraphicsEndImageContext();

}

static void GtAddRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
	float fw, fh;
	if (ovalWidth == 0 || ovalHeight == 0) {
		CGContextAddRect(context, rect);
		return;
	}
	CGContextSaveGState(context);
	CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextScaleCTM (context, ovalWidth, ovalHeight);
	fw = CGRectGetWidth (rect) / ovalWidth;
	fh = CGRectGetHeight (rect) / ovalHeight;
	CGContextMoveToPoint(context, fw, fh/2);
	CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
	CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
	CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
	CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}
 
+(UIImage *)makeRoundCornerImage : (UIImage*) img : (int) cornerWidth : (int) cornerHeight
{
	UIImage * newImage = nil;
 
	if( nil != img)
	{
		NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		CGImageRef imageMasked = nil;
		CGContextRef context = nil;
		CGColorSpaceRef colorSpace = nil;
		@try
		{
			int w = img.size.width;
			int h = img.size.height;
	 
			colorSpace = CGColorSpaceCreateDeviceRGB();
			context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
	 
			CGContextBeginPath(context);
			CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
			GtAddRoundedRectToPath(context, rect, cornerWidth, cornerHeight);
			CGContextClosePath(context);
			CGContextClip(context);
	 
			CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
	 
			imageMasked = CGBitmapContextCreateImage(context);
			GtRelease(img);
	 
			newImage = [[UIImage imageWithCGImage:imageMasked] retain];
			GtDrainPool(&pool);
		}
		@catch(NSException* ex)
		{
			GtDrainPoolAndRethrow(&pool, ex);
		}
		@finally
		{
			if(colorSpace) CGColorSpaceRelease(colorSpace);
			if(imageMasked) CGImageRelease(imageMasked);
			if(context) CGContextRelease(context);
		}
	}
 
	return GtAutorelease(newImage);
}
//CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

@end
