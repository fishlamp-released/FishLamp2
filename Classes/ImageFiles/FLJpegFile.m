//
//  FLJpegFile.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLJpegFile.h"
#import "NSFileManager+FLExtras.h"

@interface FLJpegFile ()
@property (readwrite, retain, nonatomic) NSDictionary* properties;
@end

@implementation FLJpegFile

@synthesize jpegData = _jpegData; // setter below
@synthesize properties = _properties;

@dynamic sizeInStorage;
@dynamic existsInStorage;
@dynamic canDeleteFromStorage;
@dynamic canWriteToStorage;

FLSynthesizeStructProperty(exclusiveMode, setExclusiveMode, BOOL, _jpegFlags);

- (id) initWithImage:(CocoaImage*) image 
	exifData:(NSDictionary*) exifData
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName
{
	if((self = [super init]))
	{
		FLAssertIsNotNil(folder);
		FLAssertStringIsNotEmpty(fileName);

		[self setImage:image exifData:exifData];
		self.folder = folder;
		self.fileName = fileName;
		self.exclusiveMode = YES;
	}

	return self;}

- (id) initWithJpegData:(NSData*) jpeg 
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName
{
	if((self = [super init]))
	{
		FLAssertIsNotNil(folder);
		FLAssertStringIsNotEmpty(fileName);

		self.jpegData = jpeg;
		self.folder = folder;
		self.fileName = fileName;
		self.exclusiveMode = YES;
	}

	return self;
}

- (FLJpegFile*) createTempFileForStreamingInFolder:(FLFolder*) inFolder fileName:(NSString*) fileName
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

- (void) setImage:(CocoaImage*) image
{
	FLAssignObject(_image, image);
	_dimensions = _image ? _image.size : FLSizeZero;
}

- (void) releaseImage
{
	FLReleaseWithNil(_image);
	FLReleaseWithNil(_jpegData);
}

- (void) releaseJpegData
{
	FLReleaseWithNil(_jpegData);
}

- (void) releaseImageOnly
{
	FLReleaseWithNil(_image);
}

- (CocoaImage*) image
{
	if(!_image && _jpegData)
	{
		_image = [[CocoaImage alloc] initWithData:_jpegData];
		_dimensions = _image.size;
	}
	
	if(_jpegFlags.exclusiveMode)
	{
		FLReleaseWithNil(_jpegData);
	}
	   
	return _image;
}

- (void) dealloc
{
	FLReleaseWithNil(_image);
	FLReleaseWithNil(_jpegData);
	FLReleaseWithNil(_properties);
	FLSuperDealloc();
}

- (BOOL) hasImage
{
	return _image || _jpegData;
}

- (void) readFromStorage
{
	[self _throwIfNotConfigured];
	
	FLReleaseWithNil(_jpegData);
	FLReleaseWithNil(_image);
	_dimensions = FLSizeZero;
	
	FLAssignObject(
        _jpegData, [self.folder readDataFromFile:self.fileName]);
	
	FLAssertIsNotNil(_jpegData);
}

- (void) setJpegData:(NSData*) data
{
	FLAssignObject(_jpegData, data);
	FLReleaseWithNil(_image);
	_dimensions = FLSizeZero;
}

- (FLSize) imageDimensions
{
	if(FLSizeEqualToSize(_dimensions, FLSizeZero))
	{
		_dimensions = self.image.size;
	}
	
	return _dimensions;
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
    FLAssertStringIsNotEmpty(self.filePath);

    NSURL* url = [[NSURL alloc] initFileURLWithPath:self.filePath];
    FLAssertIsNotNil(url);
    
    CGImageDestinationRef imageDestRef = nil;
    CGImageSourceRef imageSourceRef = nil;
    @try
    {
        NSData* jpgData = self.jpegData;
        FLAssertIsNotNil(jpgData);
        FLAssert(jpgData.length > 0, @"image is of size zero");
    
        imageDestRef = CGImageDestinationCreateWithURL((__fl_bridge CFURLRef)url, kUTTypeJPEG, 1, nil /* always nil */);

        CGImageDestinationSetProperties(imageDestRef, (__fl_bridge CFDictionaryRef) s_destinationProperties);

        imageSourceRef = CGImageSourceCreateWithData((__fl_bridge CFDataRef) jpgData, nil);
        FLAssertIsNotNil(imageSourceRef);
        
        CGImageDestinationAddImageFromSource(imageDestRef, imageSourceRef, 0, (__fl_bridge CFDictionaryRef) self.properties);
        
        if(!CGImageDestinationFinalize(imageDestRef))
        {
            FLDebugLog(@"image finalize failed");
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
        
        FLReleaseWithNil(url);
    }
}

- (void) writeImageToStorage
{
    FLAssertStringIsNotEmpty(self.filePath);

    NSURL* url = [[NSURL alloc] initFileURLWithPath:self.filePath];
    FLAssertIsNotNil(url);
    
    CGImageDestinationRef imageSourceRef = nil;
    @try
    {
        CocoaImage* image = self.image;
        FLAssertIsNotNil(image);

        
#if IOS        
        CGImageRef imageRef = image.CGImage;
#else
// TODO: (how to get CGImage from NSImage?)
        
        CGImageRef imageRef = nil;
        
        FLNotImplemented(@"convert NSImage to CGImage?");
        
        #pragma unused (image)
#endif        
        
        FLAssertIsNotNil(imageRef);
    
        imageSourceRef = CGImageDestinationCreateWithURL((__fl_bridge CFURLRef)url, kUTTypeJPEG, 1, nil /* always nil */);
        
        CGImageDestinationSetProperties(imageSourceRef, (__fl_bridge CFDictionaryRef) s_destinationProperties);
        
        CGImageDestinationAddImage(imageSourceRef, imageRef,  (__fl_bridge CFDictionaryRef) self.properties);

        if(!CGImageDestinationFinalize(imageSourceRef))
        {
            FLDebugLog(@"Writing image failed");
        
// TODO: there must be a wait to get an error code or something?? wtf.        
        }
    }
    @finally
    {
        if(imageSourceRef)
        {		
            CFRelease(imageSourceRef);
        }
        FLRelease(url);
    }
}

- (void) writeToStorage
{
	[self _throwIfNotConfigured];
	
	if(!_image && !_jpegData)
	{
		FLThrowError([NSError errorWithDomain:FLErrorDomain code:FLErrorNoDataToSave
			userInfo:[NSDictionary dictionaryWithObject:@"No image data to save" forKey:NSLocalizedDescriptionKey]]);
 
	}
	if(_jpegData)
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
		FLDebugLog(@"Saving image file Failed:%@", self.filePath);
	}
#endif
}

- (NSDictionary*) properties
{
	if(!_properties)
	{
		[self _throwIfNotConfigured];

		NSURL* url = [[NSURL alloc] initFileURLWithPath:[self.folder pathForFile:self.fileName]];
		CGImageSourceRef imageSourceRef = nil;
		@try
		{
			imageSourceRef = CGImageSourceCreateWithURL((__fl_bridge CFURLRef) url, nil);
			if(imageSourceRef)
			{
				NSDictionary* properties = (__fl_bridge_transfer NSDictionary*)	CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, nil);
				self.properties = properties;
				FLReleaseWithNil(properties);
			}
		}
		@finally
		{
			if(imageSourceRef)
			{
				CFRelease(imageSourceRef);
			}
		
			FLReleaseWithNil(url);
		}
	}

	return _properties;
}

- (NSInputStream*) createReadStream
{
	return [super createReadStream];
}

- (void) deleteFromStorage
{
	[super deleteFromStorage];
}

- (void) beginReadFromStorage:(FLErrorCallback) completionBlock
{
    [self readFromStorage];
    if(completionBlock)
    {
        completionBlock(nil);
    }
}
- (void) beginWriteToStorage:(FLErrorCallback) completionBlock
{
    [self writeToStorage];
    if(completionBlock)
    {
        completionBlock(nil);
    }
}
- (void) beginDeleteFromStorage:(FLErrorCallback) completionBlock
{
    [self deleteFromStorage];
    if(completionBlock)
    {
        completionBlock(nil);
    }
}

- (CocoaImage*) _image
{
	return _image;
}

- (id) copyWithZone:(NSZone *)zone
{
	FLJpegFile* imageFile = [[FLJpegFile alloc] initWithJpegData:self.jpegData folder:self.folder fileName:self.fileName];
	imageFile.fileName = self.fileName;
    imageFile.properties = self.properties;
	[imageFile setImage:self._image];
	imageFile.exclusiveMode = self.exclusiveMode;
	return imageFile;
}

- (void) setImage:(CocoaImage*) image exifData:(NSDictionary*) exif
{
	FLReleaseWithNil(_jpegData);
	[self setImage:image];
	FLAssignObject(_properties, exif);
}

- (void) beginLoadingRepresentation:(FLErrorCallback) completionBlock
{
	[super beginLoadingRepresentation:completionBlock];
}

@end