//
//	GtCachedPhotoInfo.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/30/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCachedImageBaseClass.h"
#import "GtJpegFile.h"

@interface GtCachedImage : GtCachedImageBaseClass {
@private
	GtJpegFile* m_imageFile;
}

- (id) initWithUrlString:(NSString*) url;

+ (GtCachedImage*) cachedImageWithUrlString:(NSString*) url;
+ (GtCachedImage*) cachedImage;

@property (readwrite, retain, nonatomic) GtJpegFile* imageFile;

@end
