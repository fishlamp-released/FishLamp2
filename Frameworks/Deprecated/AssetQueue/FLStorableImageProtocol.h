//
//	FLJpegFile.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLFolder.h"

@class FLFolder;
@class FLJpegFile;

@protocol FLStorableImageProtocol <NSCopying>

@property (readonly, strong, nonatomic) UIImage* image;
@property (readonly, strong, nonatomic) NSDictionary* properties;
@property (readonly, assign, nonatomic) CGSize imageDimensions;
@property (readonly, assign, nonatomic) BOOL hasImage;

- (void) setImage:(UIImage*) image exifDictionary:(NSDictionary*) exif;
- (void) releaseImage;

- (FLJpegFile*) createTempFileForStreamingInFolder:(FLFolder*) inFolder 
                                          fileName:(NSString*) fileName;

@end

