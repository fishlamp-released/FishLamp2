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
#import "FLCoreFoundation.h"
#import "FLDispatchQueue.h"

@interface FLJpegFile ()
@property (readwrite, strong, nonatomic) NSDictionary* properties;
@property (readwrite, strong) UIImage* imageData;
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

- (id) initWithImage:(UIImage*) image 
	exifDictionary:(NSDictionary*) exifDictionary
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName {

	if((self = [super init])) {
		FLAssertIsNotNil_v(folder, nil);
		FLAssertStringIsNotEmpty_v(fileName, nil);

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
		FLAssertIsNotNil_v(folder, nil);
		FLAssertStringIsNotEmpty_v(fileName, nil);

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

- (void) setImage:(UIImage*) image {
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

- (UIImage*) image {
	if(!_image && _jpegData) {
		_image = [[UIImage alloc] initWithData:_jpegData];
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
	FLAssertIsNotNil_v(_jpegData, nil);
}

- (void) setJpegData:(NSData*) data {
	self.image = nil;
	_dimensions = CGSizeZero;
	FLAssignObjectWithRetain(_jpegData, data);
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
		FLThrowError_([NSError errorWithDomain:[FLFrameworkErrorDomain instance] code:FLErrorInvalidFolder
			userInfo:[NSDictionary dictionaryWithObject:@"No Folder Set in FLJpegFile" forKey:NSLocalizedDescriptionKey]]);
	}
	if(FLStringIsEmpty(self.fileName))
	{
		FLThrowError_([NSError errorWithDomain:[FLFrameworkErrorDomain instance] code:FLErrorInvalidName
			userInfo:[NSDictionary dictionaryWithObject:@"No FileName Set in FLJpegFile" forKey:NSLocalizedDescriptionKey]]);
	}
}

- (void) writeJpegToStorage
{
    FLAssertStringIsNotEmpty_v(self.filePath, nil);

    NSURL* url = [[NSURL alloc] initFileURLWithPath:self.filePath];
    FLAssertIsNotNil_v(url, nil);
    
    CGImageDestinationRef imageDestRef = nil;
    CGImageSourceRef imageSourceRef = nil;
    @try {
        NSData* jpgData = self.jpegData;
        FLAssertIsNotNil_v(jpgData, nil);
        FLAssert_v(jpgData.length > 0, @"image is of size zero");
    
        imageDestRef = CGImageDestinationCreateWithURL(bridge_(void*,url), kUTTypeJPEG, 1, nil /* always nil */);
        FLConfirmIsNotNil_(imageDestRef);

        CGImageDestinationSetProperties(imageDestRef, bridge_(void*,s_destinationProperties));

        imageSourceRef = CGImageSourceCreateWithData(bridge_(void*,jpgData), nil);
        FLConfirmIsNotNil_(imageSourceRef);
        
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
    FLAssertStringIsNotEmpty_v(self.filePath, nil);

    NSURL* url = [[NSURL alloc] initFileURLWithPath:self.filePath];
    FLAssertIsNotNil_v(url, nil);
    
    CGImageDestinationRef imageSourceRef = nil;
    @try {
        UIImage* image = self.image;
        FLAssertIsNotNil_v(image, nil);

#if IOS        
        CGImageRef imageRef = image.CGImage;
#else
// TODO: (how to get CGImage from UIImage?)
        
        CGImageRef imageRef = nil;
        
        FLAssertIsImplemented_v(nil);
        
        #pragma unused (image)
#endif        
        
        FLAssertIsNotNil_v(imageRef, nil);
    
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
		FLThrowError_([NSError errorWithDomain:[FLFrameworkErrorDomain instance] code:FLErrorNoDataToSave
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

- (void) setImage:(UIImage*) image exifDictionary:(NSDictionary*) exif
{
	FLReleaseWithNil(_jpegData);
	[self setImage:image];
	FLAssignObjectWithRetain(_properties, exif);
}

- (void) readRepresentation {
}

//- (NSReadStream*) createReadStream {
//    return [self readStreamForFile];
//}

@end