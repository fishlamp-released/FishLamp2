//
//  FLJpegFile.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLStorableImage.h"
#import "FLAbstractFile.h"
#import "FLFolder.h"

@interface FLJpegFile : FLAbstractFile<FLStorableImage> {
@private
	CocoaImage* _image;
	NSData* _jpegData;
	NSDictionary* _properties;
	struct {
		unsigned int exclusiveMode:1;
	} _jpegFlags;
	FLSize _dimensions;
}

// this means that calling image will return the image but release the jpegData
// this is so by default you don't have dupes in memory of the photo.
@property (readwrite, assign, nonatomic) BOOL exclusiveMode; // on by default

@property (readwrite, retain, nonatomic) NSData* jpegData;

- (void) releaseJpegData;
- (void) releaseImageOnly;

- (id) initWithJpegData:(NSData*) jpeg 
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName;

- (id) initWithImage:(CocoaImage*) image 
	exifData:(NSDictionary*)exifData
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName;


@end

