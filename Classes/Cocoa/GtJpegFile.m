//
//  GtJpegFile.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtJpegFile.h"
#import "NSFileManager+GtExtras.h"

@interface GtJpegFile ()
@property (readwrite, retain, nonatomic) NSDictionary* properties;
@end

@implementation GtJpegFile

@synthesize jpegData = m_jpegData; // setter below
@synthesize properties = m_properties;

@dynamic sizeInStorage;
@dynamic existsInStorage;
@dynamic canDeleteFromStorage;
@dynamic canWriteToStorage;

GtSynthesizeStructProperty(exclusiveMode, setExclusiveMode, BOOL, m_jpegFlags);

- (id) initWithImage:(UIImage*) image 
	exifData:(NSDictionary*) exifData
	folder:(GtFolder*) folder 
	fileName:(NSString*) fileName
{
	if((self = [super init]))
	{
		GtAssertNotNil(folder);
		GtAssertIsValidString(fileName);

		[self setImage:image exifData:exifData];
		self.folder = folder;
		self.fileName = fileName;
		self.exclusiveMode = YES;
	}

	return self;}

- (id) initWithJpegData:(NSData*) jpeg 
	folder:(GtFolder*) folder 
	fileName:(NSString*) fileName
{
	if((self = [super init]))
	{
		GtAssertNotNil(folder);
		GtAssertIsValidString(fileName);

		self.jpegData = jpeg;
		self.folder = folder;
		self.fileName = fileName;
		self.exclusiveMode = YES;
	}

	return self;
}

- (GtJpegFile*) createTempFileForStreamingInFolder:(GtFolder*) inFolder fileName:(NSString*) fileName
{
	return self;
}

- (id) init
{
	if((self = [super init]))
	{
		self.exclusiveMode = YES;
	}
	return self;
}

- (void) setImage:(UIImage*) image
{
	GtAssignObject(m_image, image);
	m_dimensions = m_image ? m_image.size : CGSizeZero;
}

- (void) releaseImage
{
	GtReleaseWithNil(m_image);
	GtReleaseWithNil(m_jpegData);
}

- (void) releaseJpegData
{
	GtReleaseWithNil(m_jpegData);
}

- (void) releaseImageOnly
{
	GtReleaseWithNil(m_image);
}

- (UIImage*) image
{
	if(!m_image && m_jpegData)
	{
		m_image = [[UIImage alloc] initWithData:m_jpegData];
		m_dimensions = m_image.size;
	}
	
	if(m_jpegFlags.exclusiveMode)
	{
		GtReleaseWithNil(m_jpegData);
	}
	   
	return m_image;
}

- (void) dealloc
{
	GtReleaseWithNil(m_image);
	GtReleaseWithNil(m_jpegData);
	GtReleaseWithNil(m_properties);
	GtSuperDealloc();
}

- (BOOL) hasImage
{
	return m_image || m_jpegData;
}

- (void) readFromStorage
{
	[self _throwIfNotConfigured];
	
	GtReleaseWithNil(m_jpegData);
	GtReleaseWithNil(m_image);
	m_dimensions = CGSizeZero;
	
	[self.folder readDataFromFile:self.fileName outData:&m_jpegData];
	
	GtAssertNotNil(m_jpegData);
}

- (void) setJpegData:(NSData*) data
{
	GtAssignObject(m_jpegData, data);
	GtReleaseWithNil(m_image);
	m_dimensions = CGSizeZero;
}

- (CGSize) imageDimensions
{
	if(CGSizeEqualToSize(m_dimensions, CGSizeZero))
	{
		m_dimensions = self.image.size;
	}
	
	return m_dimensions;
}

static NSDictionary* s_destinationProperties = nil;

+ (void) initialize
{
    if(!s_destinationProperties)
    {
       s_destinationProperties = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], (NSString*) kCGImageDestinationLossyCompressionQuality, nil ];
    }
}

- (void) writeJpegToStorage
{
    GtAssertIsValidString(self.filePath);

    NSURL* url = [[NSURL alloc] initFileURLWithPath:self.filePath];
    GtAssertNotNil(url);
    
    CGImageDestinationRef imageDestRef = nil;
    CGImageSourceRef imageSourceRef = nil;
    @try
    {
        NSData* jpgData = self.jpegData;
        GtAssertNotNil(jpgData);
        GtAssert(jpgData.length > 0, @"image is of size zero");
    
        imageDestRef = CGImageDestinationCreateWithURL((CFURLRef)url, kUTTypeJPEG, 1, nil /* always nil */);

        CGImageDestinationSetProperties(imageDestRef, (CFDictionaryRef) s_destinationProperties);

        imageSourceRef = CGImageSourceCreateWithData((CFDataRef) jpgData, nil);
        GtAssertNotNil(imageSourceRef);
        
        CGImageDestinationAddImageFromSource(imageDestRef, imageSourceRef, 0, (CFDictionaryRef) self.properties);
        
        if(!CGImageDestinationFinalize(imageDestRef))
        {
            GtLog(@"image finalize failed");
        } 
    }
    @finally
    {
        if(imageSourceRef)
        {
            CFRelease(imageSourceRef);
        }
        if(imageDestRef)
        {
            CFRelease(imageDestRef);
        }
        
        GtReleaseWithNil(url);
    }
}

- (void) writeImageToStorage
{
    GtAssertIsValidString(self.filePath);

    NSURL* url = [[NSURL alloc] initFileURLWithPath:self.filePath];
    GtAssertNotNil(url);
    
    CGImageDestinationRef imageSourceRef = nil;
    @try
    {
        UIImage* image = self.image;
        GtAssertNotNil(image);

        
#if IOS        
        CGImageRef imageRef = image.CGImage;
#else
        //TODO: how to get CGImage from NSImage?
        CGImageRef imageRef = nil;
        GtAssertFailedNotImplemented();
#endif        
        
        GtAssertNotNil(imageRef);
    
        imageSourceRef = CGImageDestinationCreateWithURL((CFURLRef)url, kUTTypeJPEG, 1, nil /* always nil */);
        
        CGImageDestinationSetProperties(imageSourceRef, (CFDictionaryRef) s_destinationProperties);
        
        CGImageDestinationAddImage(imageSourceRef, imageRef,  (CFDictionaryRef) self.properties);

        if(!CGImageDestinationFinalize(imageSourceRef))
        {
            GtLog(@"Writing image failed");
        
// TODO: there must be a wait to get an error code or something?? wtf.        
        }
    }
    @finally
    {
        if(imageSourceRef)
        {		
            CFRelease(imageSourceRef);
        }
        GtRelease(url);
    }
}

- (void) writeToStorage
{
	[self _throwIfNotConfigured];
	
	if(!m_image && !m_jpegData)
	{
		GtThrowError([NSError errorWithDomain:GtErrorDomain code:GtErrorNoDataToSave
			userInfo:[NSDictionary dictionaryWithObject:@"No image data to save" forKey:NSLocalizedDescriptionKey]]);
 
	}
	if(m_jpegData)
	{
		[self writeJpegToStorage];
	}
	else
	{
        [self writeImageToStorage];
    }

#if DEBUG	
	if(![[NSFileManager defaultManager] fileExistsAtPath:self.filePath])
	{
		GtLog(@"Saving image file Failed:%@", self.filePath);
	}
#endif
}

- (NSDictionary*) properties
{
	if(!m_properties)
	{
		[self _throwIfNotConfigured];

		NSURL* url = [[NSURL alloc] initFileURLWithPath:[self.folder pathForFile:self.fileName]];
		CGImageSourceRef imageSourceRef = nil;
		@try
		{
			imageSourceRef = CGImageSourceCreateWithURL((CFURLRef) url, nil);
			if(imageSourceRef)
			{
				NSDictionary* properties = (NSDictionary*)	CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, nil);
				self.properties = properties;
				GtReleaseWithNil(properties);
			}
		}
		@finally
		{
			if(imageSourceRef)
			{
				CFRelease(imageSourceRef);
			}
		
			GtReleaseWithNil(url);
		}
	}

	return m_properties;
}

- (NSInputStream*) createReadStream
{
	return [super createReadStream];
}

- (void) deleteFromStorage
{
	[super deleteFromStorage];
}

- (void) beginReadFromStorage:(GtErrorCallback) completionBlock
{
    [self readFromStorage];
    if(completionBlock)
    {
        completionBlock(nil);
    }
}
- (void) beginWriteToStorage:(GtErrorCallback) completionBlock
{
    [self writeToStorage];
    if(completionBlock)
    {
        completionBlock(nil);
    }
}
- (void) beginDeleteFromStorage:(GtErrorCallback) completionBlock
{
    [self deleteFromStorage];
    if(completionBlock)
    {
        completionBlock(nil);
    }
}

- (UIImage*) _image
{
	return m_image;
}

- (id) copyWithZone:(NSZone *)zone
{
	GtJpegFile* imageFile = [[GtJpegFile alloc] initWithJpegData:self.jpegData folder:self.folder fileName:self.fileName];
	imageFile.fileName = self.fileName;
    imageFile.properties = self.properties;
	[imageFile setImage:self._image];
	imageFile.exclusiveMode = self.exclusiveMode;
	return imageFile;
}

- (void) setImage:(UIImage*) image exifData:(NSDictionary*) exif
{
	GtReleaseWithNil(m_jpegData);
	[self setImage:image];
	GtAssignObject(m_properties, exif);
}

- (void) beginLoadingRepresentation:(GtErrorCallback) completionBlock
{
	[super beginLoadingRepresentation:completionBlock];
}

@end