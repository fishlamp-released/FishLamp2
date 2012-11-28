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
	NSData* _imageBytes;
	NSDictionary* _exifData;
    FLImageProperties* _imageProperties;
    id<FLImageStorageStrategy> _storageStrategy;
}

@property (readwrite, strong) FLImageProperties* imageProperties;
@property (readwrite, strong) id<FLImageStorageStrategy>  storageStrategy;

@property (readwrite, strong, nonatomic) NSImage_* image;
@property (readwrite, strong, nonatomic) NSData* imageBytes;
@property (readwrite, strong, nonatomic) NSDictionary* exifData;

- (id) initWithImageBytes:(NSData*) imageBytes;
 
+ (id) photoWithImageBytes:(NSData*) imageBytes;

- (id) initWithImage:(NSImage_*) image 
          exifData:(NSDictionary*)exifData;

- (void) clearAll;

- (void) setImage:(NSImage_*) image 
       exifData:(NSDictionary*) exifData;

- (void) setImage:(NSImage_*) image 
       imageBytes:(NSData*) bytes 
       exifData:(NSDictionary*) exifData;

@end

