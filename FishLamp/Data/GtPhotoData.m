//
//  GtPhotoData.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtPhotoData.h"
#import "GtImageUtilities.h"
#import "GtPhotoFolder.h"

@implementation GtPhotoData

@synthesize dimensions = m_dimensions;

- (id) initWithImage:(UIImage*) image
{
	if(self = [self init])
	{
		self.image = image;
	}
	return self;
}

- (void) dealloc
{
#if DEBUG
	if(self.hasImageAndData)
	{
		GtLog(@"Warning: bloated GtPhotoData dealloc, consider calling compress or expand on this object to prevent dupe data in memory");
		GtPrintStackTrace();
	}
#endif

	GtRelease(m_image);
	
	[super dealloc];
}

- (BOOL) isLoaded
{
	return self.hasImage || self.hasData;
}

- (BOOL) hasImageAndData
{
	return self.hasImage && self.hasData;
}

- (BOOL) hasImage
{
	return m_image != nil;
}

- (void) createCustomSize:(GtPhotoData*) originalImageFile
	longSide:(NSUInteger) longSide
	makeSquare:(BOOL) makeSquare
{
	BOOL loadedIt = [originalImageFile readFromFile];

	UIImage* newImage = nil;
	UIImage* originalImage = originalImageFile.image;
	
	
	[originalImage shrinkImage:&newImage 
			  maxLongSide:longSide 
			   makeSquare:makeSquare];
	
	GtRelease(originalImage);
	
	[self setImage:newImage];
	GtRelease(newImage);
	
	if(loadedIt)
	{
		[originalImageFile releaseImage];
	}
}

- (void) setDataFromImage
{
	GtAssert(self.hasImage, @"no image for conversion");

	if(self.hasImage)
	{
		NSData* data = nil;
		[GtPhotoData convertImageToData:m_image outData:&data];
		self.data = data;
		GtRelease(data);
	}
}

- (void) setImageFromData
{
	GtAssert(self.hasData, @"no data for conversion");

	if(self.hasData)
	{
        UIImage* image = [GtAlloc(UIImage) initWithData:self.data];
		self.image = image;
        GtRelease(image);
	}
}

- (void) setImage:(UIImage*) image
{
	if(image != m_image)
	{
		GtReleaseWithNil(m_image);
		m_image = [image retain];
        
        if(m_image)
        {
            m_dimensions = m_image.size;
        }
	}
}

- (UIImage*) image
{
	if(!self.hasImage && self.hasData)
	{
		[self setImageFromData];
	}
	
	return m_image;
}

- (NSData*) data
{
	if(!self.hasData && self.hasImage)
	{
		[self setDataFromImage];
	}
	
	return [super data];
}



- (void) releaseImage
{
	self.image = nil;
}

+ (void) convertImageToData:(UIImage*) image 
                    outData:(NSData**) outData
{
	GtAssertNotNil(image);

	NSAutoreleasePool* pool = [GtAlloc(NSAutoreleasePool) init];
	*outData = [UIImageJPEGRepresentation(image, 1.0) retain];
	GtRelease(pool);
}

- (unsigned long) size
{
	if(self.hasData)
	{
		return self.data.length;
	}
	
	if(m_image)
	{
		CGSize size = m_image.size;
		
		size_t bits = CGImageGetBitsPerComponent(m_image.CGImage);
		
		unsigned long outSize = bits * (size.width * size.height);
	
		return outSize;
	}

	return 0;
}


- (void) releaseImageAndData
{
	[self releaseData];
    [self releaseImage];
}

- (BOOL) readFromFile:(BOOL) forceReload
{
    if([super readFromFile:forceReload])
    {
        [self releaseImage];
        return YES;
    }
    return NO;
}   


@end
