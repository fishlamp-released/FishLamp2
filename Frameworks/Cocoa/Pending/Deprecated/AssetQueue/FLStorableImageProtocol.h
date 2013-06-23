//
//	FLJpegFile.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLFolder.h"

@class FLFolder;
@class FLJpegFile;

@protocol FLStorableImageProtocol <NSCopying>

@property (readonly, strong, nonatomic) SDKImage* image;
@property (readonly, strong, nonatomic) NSDictionary* properties;
@property (readonly, assign, nonatomic) CGSize imageDimensions;
@property (readonly, assign, nonatomic) BOOL hasImage;

- (void) setImage:(SDKImage*) image exifDictionary:(NSDictionary*) exif;
- (void) releaseImage;

- (FLJpegFile*) createTempFileForStreamingInFolder:(FLFolder*) inFolder 
                                          fileName:(NSString*) fileName;

@end

