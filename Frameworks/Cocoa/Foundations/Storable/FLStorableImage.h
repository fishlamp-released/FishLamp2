//
//  UIImage.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLStorable.h"
#import "FLImageProperties.h"

@protocol FLImageStorage;

extern NSString* const FLImageTypeThumbnail;
extern NSString* const FLImageTypePreview;
extern NSString* const FLImageTypeOriginal;

@interface FLStorableImage : NSObject<FLStorable> {
@private
	UIImage* _image;
	NSData* _imageData;
	NSDictionary* _exifDictionary;
    FLImageProperties* _imageProperties;
    NSString* _storableSubType;
    NSURL* _fileURL;
}

@property (readonly, strong, nonatomic) NSString* fileName;
@property (readonly, strong, nonatomic) NSURL* fileURL;

@property (readwrite, strong) FLImageProperties* imageProperties;

@property (readonly, strong, nonatomic) UIImage* image;
@property (readonly, strong, nonatomic) NSData* imageData;
@property (readwrite, strong, nonatomic) NSDictionary* exifDictionary;

- (id) initWithImageProperties:(FLImageProperties*) imageProperties 
                       fileURL:(NSURL*) fileURL;

- (id) initWithImage:(UIImage*) imageOrNil
      exifDictionary:(NSDictionary*) exifDictionaryOrNil 
           imageData:(NSData*) imageDataOrNil;

+ (id) image;

+ (id) imageWithImage:(UIImage*) image 
       exifDictionary:(NSDictionary*) exifDictionary
            imageData:(NSData*) imageData;

+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties 
                        fileURL:(NSURL*) fileURL;

- (void) setImage:(UIImage*) image 
   exifDictionary:(NSDictionary*) exifDictionary
        imageData:(NSData*) imageData;

- (void) releaseAllImageData;

@end

@interface FLStorableImage (ExtendedConstruction)

- (id) initWithImage:(UIImage*) image;
- (id) initWithData:(NSData*) data;
+ (id) imageWithData:(NSData*) imageData;
+ (id) imageWithImage:(UIImage*) image exifDictionary:(NSDictionary*) exifDictionary;
+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties;
- (id) initWithImageProperties:(FLImageProperties*) imageProperties;

@end
