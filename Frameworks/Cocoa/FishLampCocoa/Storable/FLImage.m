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
@property (readwrite, strong, nonatomic) NSImage_* image;
@property (readwrite, strong, nonatomic) NSData* imageData;
//@property (readwrite, strong, nonatomic) NSDictionary* exifDictionary;
@end

@implementation FLImage

@synthesize image = _image;
@synthesize imageData = _imageData;
@synthesize exifDictionary = _exifDictionary;
@synthesize imageProperties = _imageProperties;
@synthesize storageStrategy = _storageStrategy;

- (id) init {
    return [self initWithImage:nil exifDictionary:nil imageData:nil];
}

- (id) initWithImage:(NSImage_*) image 
      exifDictionary:(NSDictionary*) exifDictionary 
           imageData:(NSData*) imageData  {
    
    self = [super init];
    if(self) {
		[self setImage:image exifDictionary:exifDictionary imageData:imageData ];
    }
    return self;
}       

- (id) initWithImageProperties:(FLImageProperties*) imageProperties 
               storageStrategy:(id<FLImageStorageStrategy>) storageStrategy
{
    self = [self initWithImage:nil exifDictionary:nil imageData:nil];
    if(self) {
        self.imageProperties = imageProperties;
        self.storageStrategy = storageStrategy;
    }
    
    return self;
}

+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties 
               storageStrategy:(id<FLImageStorageStrategy>) storageStrategy {
    return autorelease_([[[self class] alloc] initWithImageProperties:imageProperties storageStrategy:storageStrategy]);
}

+ (id) image {
    return autorelease_([[[self class] alloc] initWithImage:nil exifDictionary:nil imageData:nil ]);
}

+ (id) imageWithImage:(NSImage_*) image 
             exifDictionary:(NSDictionary*)exifDictionary
            imageData:(NSData*) imageData {
    return autorelease_([[[self class] alloc] initWithImage:image exifDictionary:exifDictionary imageData:imageData]);
}            

- (void) setImage:(NSImage_*) image 
   exifDictionary:(NSDictionary*) exifDictionary 
        imageData:(NSData*) imageData {
    
    self.image = image;
    self.imageData = imageData;
    self.exifDictionary = exifDictionary;
//    _dimensions = _image ? _image.size : FLSizeZero;
}       

- (void) releaseAllImageData {
    [self setImage:nil exifDictionary:nil imageData:nil];
}

//- (void) clear {
//    [self setImage:nil imageData:nil exifDictionary:nil];
//}

#if FL_MRC
- (void) dealloc { 
    [_storageStrategy release];
    [_imageProperties release];
    [_image release];
    [_imageData release];
    [_exifDictionary release];
    [super dealloc];
}
#endif

//- (void) setImageData:(NSData*) data {
//    [self setImage:nil imageData:data exifDictionary:nil];
//}

- (void) copySelfTo:(FLImage*) image {
    [super copySelfTo:image];
    [image setImage:self.image exifDictionary:self.exifDictionary imageData:self.imageData];
    image.imageProperties = self.imageProperties;
    image.storageStrategy = self.storageStrategy;
}

@end

@implementation FLImage (ExtendedConstruction)

- (id) initWithImage:(NSImage_*) image 
            exifDictionary:(NSDictionary*) exifDictionary {
	
    return [self initWithImage:image exifDictionary:exifDictionary imageData:nil];
}

- (id) initWithImage:(NSImage_*) image {
    return [self initWithImage:image exifDictionary:nil imageData:nil];
}

- (id) initWithData:(NSData*) data {
    return [self initWithImage:nil exifDictionary:nil imageData:data];
}

+ (id) imageWithData:(NSData*) imageData {
    return autorelease_([[[self class] alloc] initWithData:imageData]);
}

+ (id) imageWithImage:(NSImage_*) image exifDictionary:(NSDictionary*) exifDictionary{
    return autorelease_([[[self class] alloc] initWithImage:image exifDictionary:exifDictionary]);
}

+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties {
    return autorelease_([[[self class] alloc] initWithImageProperties:imageProperties storageStrategy:nil]);
}

- (id) initWithImageProperties:(FLImageProperties*) imageProperties {
    return [self initWithImageProperties:imageProperties storageStrategy:nil];
}

@end




//- (void) setImage:(NSImage_*) image {
//    [self setImage:image imageData:nil exifDictionary:nil];
//}
//
//- (void) setImage:(NSImage_*) image exifDictionary:(NSDictionary*) exif {
//    [self setImage:image imageData:nil exifDictionary:exif];
//}