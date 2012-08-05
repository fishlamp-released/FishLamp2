//
//	FLJpegFile.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"
#import "FLCocoaCompatibility.h"
#import "FLStorableObject.h"

@class FLFolder;
@class FLJpegFile;

@protocol FLStorableImage <FLStorableObject, NSCopying>

@property (readonly, retain, nonatomic) CocoaImage* image;
@property (readonly, retain, nonatomic) NSDictionary* properties;
@property (readonly, assign, nonatomic) FLSize imageDimensions;
@property (readonly, assign, nonatomic) BOOL hasImage;

- (void) setImage:(CocoaImage*) image exifData:(NSDictionary*) exif;
- (void) releaseImage;

- (FLJpegFile*) createTempFileForStreamingInFolder:(FLFolder*) inFolder 
                                          fileName:(NSString*) fileName;

@end

