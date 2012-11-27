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
@synthesize properties = _properties;

- (id) initWithImage:(NSImage_*) image 
            properties:(NSDictionary*) properties {

    self = [super init];
	if(self) {
		[self setImage:image imageBytes:nil properties:properties];
	}

	return self;
}

- (id) initWithImageBytes:(NSData*) data {
    
    self = [super init];
	if(self) {
		[self setImage:nil imageBytes:data properties:nil];
	}

	return self;
}

+ (id) photoWithImageBytes:(NSData*) imageBytes {
    return autorelease_([[[self class] alloc] initWithImageBytes:imageBytes]);
}

+ (id) photoWithImage:(NSImage_*) image properties:(NSDictionary*) properties{
    return autorelease_([[[self class] alloc] initWithImage:image properties:properties]);
}

- (void) setImage:(NSImage_*) image 
       imageBytes:(NSData*) bytes 
       properties:(NSDictionary*) properties {
    
    FLRetainObject_(_image, image);
    FLRetainObject_(_imageBytes, bytes);
    FLRetainObject_(_properties, properties);
//    _dimensions = _image ? _image.size : FLSizeZero;
}       

- (void) clearAll {
    [self setImage:nil imageBytes:nil properties:nil];
}

- (void) setImage:(NSImage_*) image {
    [self setImage:image imageBytes:nil properties:nil];
}

- (void) setImage:(NSImage_*) image properties:(NSDictionary*) exif {
    [self setImage:image imageBytes:nil properties:exif];
}

#if FL_MRC
- (void) dealloc { 
    [_image release];
    [_imageBytes release];
    [_properties release];
    [super dealloc];
}
#endif

- (void) setImageBytes:(NSData*) data {
    [self setImage:nil imageBytes:data properties:nil];
}

- (void) copySelfTo:(id) object {
    [super copySelfTo:object];
    [object setImage:self.image imageBytes:self.imageBytes properties:self.properties];
}

@end
