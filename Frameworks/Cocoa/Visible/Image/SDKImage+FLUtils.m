//
//  SDKColor+FLUtils.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "SDKImage+FLUtils.h"

// TODO: for god's sake, use a block.
#define RUN_ON_MAIN_THREAD 1

@interface FLImageOperationData :NSObject {
	SDKImage* _outputImage;
	NSData* _outputData;
	BOOL _square;
	CGFloat _maxLongSide;
	CGFloat _compression;
}

@property (readwrite, retain, nonatomic) SDKImage* outputImage;
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


@implementation SDKImage (FLUtils)

//- (NSUInteger) imageSize
//{
//	  SDKSize size = self.size;
//		
//	size_t bits = CGImageGetBitsPerComponent(self.CGImage);
//		
//	unsigned long outSize = bits * (size.width * size.height);
//	
//	return outSize;
//}

- (void)imageByScalingAndCroppingForSize:(SDKImage**) outImage targetSize:(SDKSize)targetSize
{
#if IOS
	SDKImage *sourceImage = self;
	SDKImage *newImage = nil;	   
	SDKSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	SDKPoint thumbnailPoint = CGPointMake(0.0,0.0);

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

	SDKRect thumbnailRect = CGRectZero;
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
	__block SDKImage* newImage = nil;
	@try {
#if FL_MRC
        FLPerformBlockInAutoreleasePool(
        ^{
#endif
            if(shrinkData.makeSquare)
            {
                [self imageByScalingAndCroppingForSize:&newImage targetSize:FLSizeMake(shrinkData.maxLongSide,shrinkData.maxLongSide)];
            }
            else
            {
                SDKSize size = self.size;
                SDKSize targetSize = size;
                
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
#if FL_MRC
        }); 
#endif        
    }
    @finally {
    	FLReleaseWithNil_(newImage);
	};
}

- (void) shrinkImage:(SDKImage**) outImage
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
#if FL_MRC
	FLPerformBlockInAutoreleasePool(^{
#endif    
		NSData* data = UIImageJPEGRepresentation(self, imageData.compression);
		if(data == nil || [data length] == 0) {
            FLThrowErrorCode_v(@"FLImageErrorDomain", 1, @"Conversion to Jpeg failed");
        }
		
		imageData.outputData = data;
#if FL_MRC
	});
#endif    
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
	outImage:(SDKImage**) outImage {
    
#if IOS
	SDKRect rotatedFrame = FLFloatEqualToFloat(FLFloatAbs(degrees), FLFloatAbs(180.0)) ?
        CGRectMake(0,0, self.size.width, self.size.height) :
		CGRectMake(0,0, self.size.height, self.size.width);
	
    SDKSize rotatedSize = rotatedFrame.size;

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
	outImage:(SDKImage**) outImage
{	
	[self rotate:clockWise ? 90.0 : -90.0 outImage:outImage];
}

- (void) flip:(SDKImage**) outImage
{
#if IOS
	SDKRect rotatedFrame = CGRectMake(0,0, self.size.width, self.size.height);
	SDKSize rotatedSize = rotatedFrame.size;

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

static void FLAddRoundedRectToPath(CGContextRef context, SDKRect rect, float ovalWidth, float ovalHeight)
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
 
+(SDKImage *)makeRoundCornerImage : (SDKImage*) img : (int) cornerWidth : (int) cornerHeight
{
	__block SDKImage * newImage = nil;
 
	if( nil != img)
	{
		__block CGImageRef imageMasked = nil;
		__block CGContextRef context = nil;
		__block CGColorSpaceRef colorSpace = nil;
        @try {
#if FL_MRC
            FLPerformBlockInAutoreleasePool(^{
#endif            
                int w = img.size.width;
                int h = img.size.height;
         
                colorSpace = CGColorSpaceCreateDeviceRGB();
                context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
         
                CGContextBeginPath(context);
                SDKRect rect = FLRectMake(0, 0, img.size.width, img.size.height);
                FLAddRoundedRectToPath(context, rect, cornerWidth, cornerHeight);
                CGContextClosePath(context);
                CGContextClip(context);
         
                CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
         
                imageMasked = CGBitmapContextCreateImage(context);
                release_(img);
         
                newImage = retain_([SDKImage imageWithCGImage:imageMasked]);
#if FL_MRC
            });
#endif            
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



