//
//  ZFImageDisplaySize.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFMediaType.h"
#import "ZFAccessDescriptor.h"

@interface ZFImageDisplaySize : NSObject {
@private
    ZFMediaType* _highResolutionImageDownloadSize;
    ZFMediaType* _imageDownloadSize;
    ZFMediaType* _galleryThumbnailDownloadSize;
    ZFMediaType* _photoThumbnail;
}

@property (readonly, assign) BOOL isRetinaDevice;

@property (readwrite,strong) ZFMediaType* highResolutionImageDownloadSize;
@property (readwrite,strong) ZFMediaType* imageDownloadSize;
@property (readwrite,strong) ZFMediaType* galleryThumbnailDownloadSize;
@property (readwrite,strong) ZFMediaType* photoThumbnail;

+ (ZFMediaType*) imageDisplaySizeEnclosingSize:(CGSize) size;


+ (ZFMediaType*) imageDisplaySizeEnclosingSize:(CGSize) size 
                             limitAccessToSize:(ZFAccessDescriptor*) accessDescriptorOrNil;

@end 
