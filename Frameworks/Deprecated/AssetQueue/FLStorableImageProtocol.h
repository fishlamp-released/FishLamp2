//
//	FLJpegFile.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"

#import "FLGeometry.h"
#import "FLFolder.h"

@class FLFolder;
@class FLJpegFile;

@protocol FLStorableImageProtocol <NSCopying>

@property (readonly, strong, nonatomic) FLImage* image;
@property (readonly, strong, nonatomic) NSDictionary* properties;
@property (readonly, assign, nonatomic) FLSize imageDimensions;
@property (readonly, assign, nonatomic) BOOL hasImage;

- (void) setImage:(FLImage*) image exifDictionary:(NSDictionary*) exif;
- (void) releaseImage;

- (FLJpegFile*) createTempFileForStreamingInFolder:(FLFolder*) inFolder 
                                          fileName:(NSString*) fileName;

@end

