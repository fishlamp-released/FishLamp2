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

// TODO: store url as NSURL in superclass
@interface FLCachedImage : FLCachedImageBaseClass {
@private
	FLJpegFile* _imageFile;
}

- (id) initWithURL:(NSURL*) url;
- (id) initWithUrlString:(NSString*) url;

+ (FLCachedImage*) cachedImageWithURL:(NSURL*) url;
+ (FLCachedImage*) cachedImageWithUrlString:(NSString*) url;
+ (FLCachedImage*) cachedImage;

@property (readwrite, retain, nonatomic) FLJpegFile* imageFile;

@end
