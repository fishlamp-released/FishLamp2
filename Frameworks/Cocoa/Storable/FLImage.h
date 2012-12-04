//
//  FLImage.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLStorable.h"
#import "FLImageStorageStrategy.h"
#import "FLImageProperties.h"

@protocol FLImageStorage;

extern NSString* const FLImageTypeThumbnail;
extern NSString* const FLImageTypePreview;
extern NSString* const FLImageTypeOriginal;

@interface FLImage : FLStorable {
@private
	NSImage_* _image;
	NSData* _imageData;
	NSDictionary* _exifDictionary;
    FLImageProperties* _imageProperties;
    id<FLImageStorageStrategy> _storageStrategy;
}

@property (readwrite, strong) FLImageProperties* imageProperties;
@property (readwrite, strong) id<FLImageStorageStrategy>  storageStrategy;

@property (readonly, strong, nonatomic) NSImage_* image;
@property (readonly, strong, nonatomic) NSData* imageData;
@property (readwrite, strong, nonatomic) NSDictionary* exifDictionary;

- (id) initWithImageProperties:(FLImageProperties*) imageProperties 
               storageStrategy:(id<FLImageStorageStrategy>) storageStrategy;

- (id) initWithImage:(NSImage_*) imageOrNil
      exifDictionary:(NSDictionary*) exifDictionaryOrNil 
           imageData:(NSData*) imageDataOrNil;

+ (id) image;

+ (id) imageWithImage:(NSImage_*) image 
       exifDictionary:(NSDictionary*) exifDictionary
            imageData:(NSData*) imageData;

+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties 
                storageStrategy:(id<FLImageStorageStrategy>) storageStrategy;

- (void) setImage:(NSImage_*) image 
   exifDictionary:(NSDictionary*) exifDictionary
        imageData:(NSData*) imageData;

- (void) releaseAllImageData;

@end

@interface FLImage (ExtendedConstruction)

- (id) initWithImage:(NSImage_*) image;
- (id) initWithData:(NSData*) data;
+ (id) imageWithData:(NSData*) imageData;
+ (id) imageWithImage:(NSImage_*) image exifDictionary:(NSDictionary*) exifDictionary;
+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties;
- (id) initWithImageProperties:(FLImageProperties*) imageProperties;

@end
