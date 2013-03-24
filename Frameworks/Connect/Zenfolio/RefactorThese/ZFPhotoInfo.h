//
//	ZFPhotoInfo.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FishLampCocoa.h"
#import "ZFImageSize.h"

@interface ZFPhotoInfo : NSObject {
	unsigned long long _fileSize;
	unsigned long long _sizeInDatabase;
	SDKImage* _cachedImage;
    ZFImageSize* _imageSize;
}

@property (readwrite, assign, nonatomic) unsigned long long sizeInDatabase;
@property (readwrite, assign, nonatomic) unsigned long long fileSize;
@property (readwrite, strong, nonatomic) ZFImageSize* imageSize;
@property (readwrite, retain, nonatomic) SDKImage* cachedImage;

@end
