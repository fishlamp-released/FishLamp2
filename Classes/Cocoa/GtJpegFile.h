//
//  GtJpegFile.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtStorableImage.h"
#import "GtAbstractFile.h"
#import "GtFolder.h"

@interface GtJpegFile : GtAbstractFile<GtStorableImage> {
@private
	UIImage* m_image;
	NSData* m_jpegData;
	NSDictionary* m_properties;
	struct {
		unsigned int exclusiveMode:1;
	} m_jpegFlags;
	CGSize m_dimensions;
}

// this means that calling image will return the image but release the jpegData
// this is so by default you don't have dupes in memory of the photo.
@property (readwrite, assign, nonatomic) BOOL exclusiveMode; // on by default

@property (readwrite, retain, nonatomic) NSData* jpegData;

- (void) releaseJpegData;
- (void) releaseImageOnly;

- (id) initWithJpegData:(NSData*) jpeg 
	folder:(GtFolder*) folder 
	fileName:(NSString*) fileName;

- (id) initWithImage:(UIImage*) image 
	exifData:(NSDictionary*)exifData
	folder:(GtFolder*) folder 
	fileName:(NSString*) fileName;


@end

