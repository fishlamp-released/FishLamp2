//
//  FLJpegFile.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLJpegFile.h"
#import "NSFileManager+FLExtras.h"
#import "FLCoreFoundation.h"
#import "FLAsyncQueue.h"

@interface FLJpegFile ()
@property (readwrite, strong, nonatomic) NSDictionary* properties;
@property (readwrite, strong) SDKImage* imageData;
@end

@implementation FLJpegFile

@synthesize jpegData = _jpegData; // setter below
@synthesize properties = _properties;
@synthesize imageData = _image;
@synthesize exclusiveMode = _exclusiveMode;

static NSDictionary* s_destinationProperties = nil;

+ (void) initialize {
    if(!s_destinationProperties) {
       s_destinationProperties = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], (NSString*) kCGImageDestinationLossyCompressionQuality, nil ];
    }
}

- (id) initWithImage:(SDKImage*) image 
	exifDictionary:(NSDictionary*) exifDictionary
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName {

	if((self = [super init])) {
		FLAssertIsNotNilWithComment(folder, nil);
		FLAssertStringIsNotEmptyWithComment(fileName, nil);

		[self setImage:image exifDictionary:exifDictionary];
		self.folder = folder;
		self.fileName = fileName;
		self.exclusiveMode = YES;
	}

	return self;
}

- (id) initWithJpegData:(NSData*) jpeg 
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName {

	if((self = [super init])) {
		FLAssertIsNotNilWithComment(folder, nil);
		FLAssertStringIsNotEmptyWithComment(fileName, nil);

		self.jpegData = jpeg;
		self.folder = folder;
		self.fileName = fileName;
		self.exclusiveMode = YES;
	}

	return self;
}

- (FLJpegFile*) createTempFileForStreamingInFolder:(FLFolder*) inFolder fileName:(NSString*) fileName {
	return self;
}

- (id) init {
	if((self = [super init])) {
		self.exclusiveMode = YES;
	}
	return self;
}

- (void) setImage:(SDKImage*) image {
    self.imageData = image;
	_dimensions = _image ? _image.size : CGSizeZero;
}

- (void) releaseImage {
    self.imageData = nil;
    self.jpegData = nil;
}

- (void) releaseJpegData {
    self.jpegData = nil;
}

- (void) releaseImageOnly {
    self.imageData = nil;
}

- (SDKImage*) image {
	if(!_image && _jpegData) {
		_image = [[SDKImage alloc] initWithData:_jpegData];
		_dimensions = _image.size;
	}
	
	if(_exclusiveMode) {
        self.jpegData = nil;
	}
	   
	return _image;
}

#if FL_MRC
- (void) dealloc {
    [_image release];
    [_jpegData release];
    [_properties release];
    [super dealloc];
}
#endif

- (BOOL) hasImage {
	return _image || _jpegData;
}

- (void) readFromStorage {
    self.jpegData = [self readDataFromFile]; 
	FLAssertIsNotNilWithComment(_jpegData, nil);
}

- (void) setJpegData:(NSData*) data {
	self.image = nil;
	_dimensions = CGSizeZero;
	FLSetObjectWithRetain(_jpegData, data);
}

- (CGSize) imageDimensions {
	if(CGSizeEqualToSize(_dimensions, CGSizeZero)) {
		_dimensions = self.image.size;
	}
	
	return _dimensions;
}

- (unsigned  long long) sizeInStorage {
	return self.fileSize;
}

- (BOOL) existsInStorage {
    return self.fileExists;
}

- (BOOL) canDeleteFromStorage {
    return YES;
}

- (BOOL) canWriteToStorage {
    return YES;
}

- (void) _throwIfNotConfigured
{
	if(!self.folder)
	{
		FLThrowIfError([NSError errorWithDomain:FLErrorDomain code:FLErrorInvalidFolder
			userInfo:[NSDictionary dictionaryWithObject:@"No Folder Set in FLJpegFile" forKey:NSLocalizedDescriptionKey]]);
	}
	if(FLStringIsEmpty(self.fileName))
	{
		FLThrowIfError([NSError errorWithDomain:FLErrorDomain code:FLErrorInvalidName
			userInfo:[NSDictionary dictionaryWithObject:@"No FileName Set in FLJpegFile" forKey:NSLocalizedDescriptionKey]]);
	}
}

- (void) writeJpegToStorage
{
    FLAssertStringIsNotEmptyWithComment(self.filePath, nil);

    NSURL* url = [[NSURL alloc] initFileURLWithPath:self.filePath];
    FLAssertIsNotNilWithComment(url, nil);
    
    CGImageDestinationRef imageDestRef = nil;
    CGImageSourceRef imageSourceRef = nil;
    @try {
        NSData* jpgData = self.jpegData;
        FLAssertIsNotNilWithComment(jpgData, nil);
        FLAssertWithComment(jpgData.length > 0, @"image is of size zero");
    
        imageDestRef = CGImageDestinationCreateWithURL(bridge_(void*,url), kUTTypeJPEG, 1, nil /* always nil */);
        FLConfirmIsNotNil(imageDestRef);

        CGImageDestinationSetProperties(imageDestRef, bridge_(void*,s_destinationProperties));

        imageSourceRef = CGImageSourceCreateWithData(bridge_(void*,jpgData), nil);
        FLConfirmIsNotNil(imageSourceRef);
        
        CGImageDestinationAddImageFromSource(imageDestRef, imageSourceRef, 0, bridge_(void*,self.properties));
        
        if(!CGImageDestinationFinalize(imageDestRef)){
             FLDebugLog(@"wth - image finalize failed");
        } 
    }
    @finally {
        FLReleaseCRef_(imageSourceRef);
        FLReleaseCRef_(imageDestRef);
        FLReleaseWithNil(url);
    }
}

- (void) writeImageToStorage {
    FLAssertStringIsNotEmptyWithComment(self.filePath, nil);

    NSURL* url = [[NSURL alloc] initFileURLWithPath:self.filePath];
    FLAssertIsNotNilWithComment(url, nil);
    
    CGImageDestinationRef imageSourceRef = nil;
    @try {
        SDKImage* image = self.image;
        FLAssertIsNotNilWithComment(image, nil);

#if IOS        
        CGImageRef imageRef = image.CGImage;
#else
// TODO: (how to get CGImage from SDKImage?)
        
        CGImageRef imageRef = nil;
        
        FLAssertIsImplementedWithComment(nil);
        
        #pragma unused (image)
#endif        
        
        FLAssertIsNotNilWithComment(imageRef, nil);
    
        imageSourceRef = CGImageDestinationCreateWithURL(bridge_(void*,url), kUTTypeJPEG, 1, nil /* always nil */);
        
        CGImageDestinationSetProperties(imageSourceRef, bridge_(void*,s_destinationProperties));
        
        CGImageDestinationAddImage(imageSourceRef, imageRef, bridge_(void*,self.properties));

        if(!CGImageDestinationFinalize(imageSourceRef)) {
            FLDebugLog(@"Writing image failed");
        
// TODO: there must be a wait to get an error code or something?? wtf.        
        }
    }
    @finally {
        if(imageSourceRef) {		
            CFRelease(imageSourceRef);
        }
        FLRelease(url);
    }
}

- (void) writeToStorage {
	[self _throwIfNotConfigured];
	
	if(!_image && !_jpegData) {
		FLThrowIfError([NSError errorWithDomain:FLErrorDomain code:FLErrorNoDataToSave
			userInfo:[NSDictionary dictionaryWithObject:@"No image data to save" forKey:NSLocalizedDescriptionKey]]);
 
	}
	
    if(_jpegData) {
		[self writeJpegToStorage];
	}
	else {
        [self writeImageToStorage];
    }

#if DEBUG	
	if(![[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
		FLDebugLog(@"Saving image file Failed:%@", self.filePath);
	}
#endif
}

- (NSDictionary*) properties {
	if(!_properties) {
		[self _throwIfNotConfigured];

		NSURL* url = [[NSURL alloc] initFileURLWithPath:[self.folder pathForFile:self.fileName]];
		CGImageSourceRef imageSourceRef = nil;
		@try
		{
			imageSourceRef = CGImageSourceCreateWithURL(bridge_(void*,url), nil);
			if(imageSourceRef)
			{
				self.properties = 
                    FLAutorelease(bridge_(NSDictionary*,
                        CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, nil)));
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


- (void) deleteFromStorage {
	[self deleteFile];
}

- (id) copyWithZone:(NSZone *)zone
{
	FLJpegFile* imageFile = [[FLJpegFile alloc] initWithJpegData:self.jpegData folder:self.folder fileName:self.fileName];
	imageFile.fileName = self.fileName;
    imageFile.properties = self.properties;
	imageFile.imageData = self.imageData;
	imageFile.exclusiveMode = self.exclusiveMode;
	return imageFile;
}

- (void) setImage:(SDKImage*) image exifDictionary:(NSDictionary*) exif
{
	FLReleaseWithNil(_jpegData);
	[self setImage:image];
	FLSetObjectWithRetain(_properties, exif);
}

- (void) readRepresentation {
}

//- (NSReadStream*) createReadStream {
//    return [self readStreamForFile];
//}

@end