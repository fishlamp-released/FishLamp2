//
//  FLJpegFile.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"
#import "FLCocoaRequired.h"

#import "FLStorableImageProtocol.h"
#import "FLStorableObject.h"
#import "FLStorableImage.h"
#import "FLFolderFile.h"

@interface FLJpegFile : FLFolderFile<FLStorableImageProtocol, FLStorableObject> {
@private
	UIImage* _image;
	NSData* _jpegData;
	NSDictionary* _properties;
	CGSize _dimensions;
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

- (id) initWithImage:(UIImage*) image 
	exifDictionary:(NSDictionary*)exifDictionary
	folder:(FLFolder*) folder 
	fileName:(NSString*) fileName;


@end

