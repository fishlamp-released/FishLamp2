//
//  FLImage.h
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLStorable.h"
#import "FLCocoaCompatibility.h"

extern NSString* const FLImageTypeThumbnail;
extern NSString* const FLImageTypePreview;
extern NSString* const FLImageTypeOriginal;

@interface FLImage : FLStorable {
@private
	NSImage_* _image;
	NSData* _imageBytes;
	NSDictionary* _properties;
}

@property (readwrite, strong, nonatomic) NSImage_* image;
@property (readwrite, strong, nonatomic) NSData* imageBytes;
@property (readwrite, strong, nonatomic) NSDictionary* properties;

- (id) initWithImageBytes:(NSData*) imageBytes;
 
+ (id) photoWithImageBytes:(NSData*) imageBytes;

- (id) initWithImage:(NSImage_*) image 
          properties:(NSDictionary*)properties;

- (void) clearAll;

- (void) setImage:(NSImage_*) image 
       properties:(NSDictionary*) properties;

- (void) setImage:(NSImage_*) image 
       imageBytes:(NSData*) bytes 
       properties:(NSDictionary*) properties;

@end
