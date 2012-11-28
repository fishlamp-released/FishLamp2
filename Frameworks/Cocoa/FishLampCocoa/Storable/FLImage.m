//
//  FLImage.m
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImage.h"

NSString* const FLImageTypeThumbnail =  @"com.fishlamp.image.thumbnail";
NSString* const FLImageTypePreview =    @"com.fishlamp.image.preview";
NSString* const FLImageTypeOriginal =   @"com.fishlamp.image.original";

@interface FLImage ()
@end

@implementation FLImage

@synthesize image = _image;
@synthesize imageBytes = _imageBytes;
@synthesize exifData = _exifData;
@synthesize imageProperties = _imageProperties;
@synthesize storageStrategy = _storageStrategy;

- (id) initWithImage:(NSImage_*) image 
            exifData:(NSDictionary*) exifData {

    self = [super init];
	if(self) {
		[self setImage:image imageBytes:nil exifData:exifData];
	}

	return self;
}

- (id) initWithImageBytes:(NSData*) data {
    
    self = [super init];
	if(self) {
		[self setImage:nil imageBytes:data exifData:nil];
	}

	return self;
}

+ (id) photoWithImageBytes:(NSData*) imageBytes {
    return autorelease_([[[self class] alloc] initWithImageBytes:imageBytes]);
}

+ (id) photoWithImage:(NSImage_*) image exifData:(NSDictionary*) exifData{
    return autorelease_([[[self class] alloc] initWithImage:image exifData:exifData]);
}

- (void) setImage:(NSImage_*) image 
       imageBytes:(NSData*) bytes 
       exifData:(NSDictionary*) exifData {
    
    FLRetainObject_(_image, image);
    FLRetainObject_(_imageBytes, bytes);
    FLRetainObject_(_exifData, exifData);
//    _dimensions = _image ? _image.size : FLSizeZero;
}       

- (void) clearAll {
    [self setImage:nil imageBytes:nil exifData:nil];
}

- (void) setImage:(NSImage_*) image {
    [self setImage:image imageBytes:nil exifData:nil];
}

- (void) setImage:(NSImage_*) image exifData:(NSDictionary*) exif {
    [self setImage:image imageBytes:nil exifData:exif];
}

#if FL_MRC
- (void) dealloc { 
    [_storageStrategy release];
    [_imageProperties release];
    [_image release];
    [_imageBytes release];
    [_exifData release];
    [super dealloc];
}
#endif

- (void) setImageBytes:(NSData*) data {
    [self setImage:nil imageBytes:data exifData:nil];
}

- (void) copySelfTo:(FLImage*) image {
    [super copySelfTo:image];
    [image setImage:self.image imageBytes:self.imageBytes exifData:self.exifData];
    image.imageProperties = self.imageProperties;
    image.storageStrategy = self.storageStrategy;
}

@end
