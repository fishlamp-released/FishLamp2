//
//	GtJpegFile.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtStorableObject.h"

@class GtFolder;
@class GtJpegFile;

@protocol GtStorableImage <GtStorableObject, NSCopying>

@property (readonly, retain, nonatomic) UIImage* image;
@property (readonly, retain, nonatomic) NSDictionary* properties;
@property (readonly, assign, nonatomic) CGSize imageDimensions;
@property (readonly, assign, nonatomic) BOOL hasImage;

- (void) setImage:(UIImage*) image exifData:(NSDictionary*) exif;
- (void) releaseImage;

- (GtJpegFile*) createTempFileForStreamingInFolder:(GtFolder*) inFolder 
                                          fileName:(NSString*) fileName;

@end

