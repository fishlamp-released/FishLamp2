//
//	UIImageUtilities.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/21/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "UIImageUtilities.h"
#import "FLGeometry.h"

#define RUN_ON_MAIN_THREAD 1

@interface FLImageOperationData :NSObject {
	NSImage_* _outputImage;
	NSData* _outputData;
	BOOL _square;
	CGFloat _maxLongSide;
	CGFloat _compression;
}

@property (readwrite, retain, nonatomic) NSImage_* outputImage;
@property (readwrite, retain, nonatomic) NSData* outputData;
@property (readwrite, assign, nonatomic) BOOL makeSquare;
@property (readwrite, assign, nonatomic) CGFloat maxLongSide;
@property (readwrite, assign, nonatomic) CGFloat compression;

@end

@implementation FLImageOperationData
@synthesize outputImage = _outputImage;
@synthesize makeSquare = _square;
@synthesize maxLongSide = _maxLongSide;
@synthesize compression = _compression;
@synthesize outputData = _outputData;

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
	FLReleaseWithNil_(_outputData);
	FLReleaseWithNil_(_outputImage);
	super_dealloc_();
}
@end


@implementation UIImage_ (Utils)

//- (NSUInteger) imageSize
//{
//	  FLSize size = self.size;
//		
//	size_t bits = CGImageGetBitsPerComponent(self.CGImage);
//		
//	unsigned long outSize = bits * (size.width * size.height);
//	
//	return outSize;
//}

- (void)imageByScalingAndCroppingForSize:(NSImage_**) outImage targetSize:(FLSize)targetSize
{
#if IOS
	NSImage_ *sourceImage = self;
	NSImage_ *newImage = nil;	   
	FLSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	FLPoint thumbnailPoint = CGPointMake(0.0,0.0);

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

	FLRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width = scaledWidth;
	thumbnailRect.size.height = scaledHeight;

	[sourceImage drawInRect:thumbnailRect];

	newImage = UIGraphicsGetImageFromCurrentImageContext(); // returns autoreleased image
	if(newImage == nil)
	{
		FLLog(@"could not scale image");
	}

	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	*outImage = retain_(newImage);
#else 
    FLAssertIsImplemented_v(nil);
#endif
}
- (void) shrinkImagePrivate:(FLImageOperationData*) shrinkData
{
	__block NSImage_* newImage = nil;
	@try {
        FLPerformBlockInAutoreleasePool(
        ^{
            if(shrinkData.makeSquare)
            {
                [self imageByScalingAndCroppingForSize:&newImage targetSize:FLSizeMake(shrinkData.maxLongSide,shrinkData.maxLongSide)];
            }
            else
            {
                FLSize size = self.size;
                FLSize targetSize = size;
                
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
        }); 
    }
    @finally {
    	FLReleaseWithNil_(newImage);
	};
}

- (void) shrinkImage:(NSImage_**) outImage
         maxLongSide:(float) maxLongSide
          makeSquare:(BOOL) makeSquare
{
	FLImageOperationData* shrinkData = [[FLImageOperationData alloc] init];
	shrinkData.maxLongSide = maxLongSide;
	shrinkData.makeSquare = makeSquare;
	
#if RUN_ON_MAIN_THREAD	
	[self performSelectorOnMainThread:@selector(shrinkImagePrivate:) withObject:shrinkData waitUntilDone:YES];
#else
	[self shrinkImagePrivate:shrinkData];
#endif	

	*outImage = retain_(shrinkData.outputImage);

	FLReleaseWithNil_(shrinkData);
}

- (void) convertToJpegPrivate:(FLImageOperationData*) imageData
{
#if IOS
	FLPerformBlockInAutoreleasePool(^{
		NSData* data = UIImageJPEGRepresentation(self, imageData.compression);
		if(data == nil || [data length] == 0) {
            FLThrowErrorCode_v(@"FLImageErrorDomain", 1, @"Conversion to Jpeg failed");
        }
		
		imageData.outputData = data;
	});
#else 
    FLAssertIsImplemented_v(nil);
#endif
}

- (void) convertToJpegData:(CGFloat) compression outData:(NSData**) outData
{
	FLImageOperationData* imageData = [[FLImageOperationData alloc] init];
	imageData.compression = compression;
	
#if RUN_ON_MAIN_THREAD	
	[self performSelectorOnMainThread:@selector(convertToJpegPrivate:) withObject:imageData waitUntilDone:YES];
#else
	[self convertToJpegPrivate:imageData];
#endif	

	*outData = retain_(imageData.outputData);
	FLReleaseWithNil_(imageData);
}

- (void) rotate:(CGFloat) degrees
	outImage:(NSImage_**) outImage {
    
#if IOS
	FLRect rotatedFrame = FLFloatEqualToFloat(FLFloatAbs(degrees), FLFloatAbs(180.0)) ?
        CGRectMake(0,0, self.size.width, self.size.height) :
		CGRectMake(0,0, self.size.height, self.size.width);
	
    FLSize rotatedSize = rotatedFrame.size;

	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();

	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);

	//	 // Rotate the image context
	CGContextRotateCTM(bitmap, FLDegreesToRadians(degrees));

	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0); // why -1? 
	CGContextDrawImage(bitmap, 
		CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), // center the image on center point, set above
		[self CGImage]);

	*outImage = retain_(UIGraphicsGetImageFromCurrentImageContext());
	UIGraphicsEndImageContext();
#else 
    FLAssertIsImplemented_v(nil);
#endif
}


- (void) rotate90Degrees:(BOOL) clockWise 
	outImage:(NSImage_**) outImage
{	
	[self rotate:clockWise ? 90.0 : -90.0 outImage:outImage];
}

- (void) flip:(NSImage_**) outImage
{
#if IOS
	FLRect rotatedFrame = CGRectMake(0,0, self.size.width, self.size.height);
	FLSize rotatedSize = rotatedFrame.size;

	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();

	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);

	//	 // Rotate the image context
	CGContextRotateCTM(bitmap, FLDegreesToRadians(180.0));

	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);

	CGContextDrawImage(bitmap, 
		CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), 
		[self CGImage]);

	*outImage = retain_(UIGraphicsGetImageFromCurrentImageContext());
	UIGraphicsEndImageContext();
#else
    FLAssertIsImplemented_v(nil);
#endif

}

static void FLAddRoundedRectToPath(CGContextRef context, FLRect rect, float ovalWidth, float ovalHeight)
{
#if IOS
	float fw, fh;
	if (ovalWidth == 0.0f || ovalHeight == 0.0f) {
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
#else 
    FLAssertIsImplemented_();
#endif
}
 
+(NSImage_ *)makeRoundCornerImage : (NSImage_*) img : (int) cornerWidth : (int) cornerHeight
{
	__block NSImage_ * newImage = nil;
 
	if( nil != img)
	{
		__block CGImageRef imageMasked = nil;
		__block CGContextRef context = nil;
		__block CGColorSpaceRef colorSpace = nil;
        @try {
            FLPerformBlockInAutoreleasePool(
            ^{
                int w = img.size.width;
                int h = img.size.height;
         
                colorSpace = CGColorSpaceCreateDeviceRGB();
                context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
         
                CGContextBeginPath(context);
                FLRect rect = FLRectMake(0, 0, img.size.width, img.size.height);
                FLAddRoundedRectToPath(context, rect, cornerWidth, cornerHeight);
                CGContextClosePath(context);
                CGContextClip(context);
         
                CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
         
                imageMasked = CGBitmapContextCreateImage(context);
                release_(img);
         
                newImage = retain_([NSImage_ imageWithCGImage:imageMasked]);
            });
        }
        @finally {
			if(colorSpace) CGColorSpaceRelease(colorSpace);
			if(imageMasked) CGImageRelease(imageMasked);
			if(context) CGContextRelease(context);
		};
    }
 
	return autorelease_(newImage);
}
//CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

@end
