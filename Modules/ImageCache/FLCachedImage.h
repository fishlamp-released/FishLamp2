//
//	FLCachedPhotoInfo.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/30/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLCachedImageBaseClass.h"
#import "FLJpegFile.h"

@interface FLCachedImage : FLCachedImageBaseClass {
@private
	FLJpegFile* _imageFile;
}

- (id) initWithUrlString:(NSString*) url;

+ (FLCachedImage*) cachedImageWithUrlString:(NSString*) url;
+ (FLCachedImage*) cachedImage;

@property (readwrite, retain, nonatomic) FLJpegFile* imageFile;

@end
