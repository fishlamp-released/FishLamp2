//
//  FLJpegFile.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLStorableObject.h"
#import "FLStorableImage.h"
#import "FLFolderFile.h"

@interface FLJpegFile : FLFolderFile<FLStorableImage, FLStorableObject> {
@private
	NSImage_* _image;
	NSData* _jpegData;
	NSDictionary* _properties;
	FLSize _dimensions;
    BOOL _exclusiveMode;
}

// this means that calling image will return the image but release the jpegData
// this is so by default you don't have dupes in memory of the photo.
@property (readwrite, assign, nonatomic) BOOL exclusiveMode; // on by default

@property (readwrite, strong, nonatomic) NSData* jpegData;

- (void) releaseJpegData;
- (void) releaseImageOnly;

- (id) initWithJpegData:(NSData*) jpeg 
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName;

- (id) initWithImage:(NSImage_*) image 
	exifDictionary:(NSDictionary*)exifDictionary
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName;


@end

