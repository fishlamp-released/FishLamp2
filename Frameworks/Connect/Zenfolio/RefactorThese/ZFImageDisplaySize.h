//
//  ZFImageDisplaySize.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFImageSize.h"
#import "ZFAccessDescriptor.h"

@interface ZFImageDisplaySize : NSObject {
@private
    ZFImageSize* _highResolutionImageDownloadSize;
    ZFImageSize* _imageDownloadSize;
    ZFImageSize* _galleryThumbnailDownloadSize;
    ZFImageSize* _photoThumbnailSize;
}

@property (readonly, assign) BOOL isRetinaDevice;

@property (readwrite,strong) ZFImageSize* highResolutionImageDownloadSize;
@property (readwrite,strong) ZFImageSize* imageDownloadSize;
@property (readwrite,strong) ZFImageSize* galleryThumbnailDownloadSize;
@property (readwrite,strong) ZFImageSize* photoThumbnailSize;

+ (ZFImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size;


+ (ZFImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size 
                             limitAccessToSize:(ZFAccessDescriptor*) accessDescriptorOrNil;

@end 
