//
//	FLJpegFile.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLGeometry.h"
#import "FLFolder.h"

@class FLFolder;
@class FLJpegFile;

@protocol FLStorableImage <NSCopying>

@property (readonly, strong, nonatomic) NSImage_* image;
@property (readonly, strong, nonatomic) NSDictionary* properties;
@property (readonly, assign, nonatomic) FLSize imageDimensions;
@property (readonly, assign, nonatomic) BOOL hasImage;

- (void) setImage:(NSImage_*) image exifData:(NSDictionary*) exif;
- (void) releaseImage;

- (FLJpegFile*) createTempFileForStreamingInFolder:(FLFolder*) inFolder 
                                          fileName:(NSString*) fileName;

@end

