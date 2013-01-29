//
//  FLZfImageDisplaySize.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfImageSize.h"
#import "FLZfAccessDescriptor.h"

@interface FLZfImageDisplaySize : NSObject {
@private
    FLZfImageSize* _highResolutionImageDownloadSize;
    FLZfImageSize* _imageDownloadSize;
    FLZfImageSize* _galleryThumbnailDownloadSize;
    FLZfImageSize* _photoThumbnailSize;
}

@property (readonly, assign) BOOL isRetinaDevice;

@property (readwrite,strong) FLZfImageSize* highResolutionImageDownloadSize;
@property (readwrite,strong) FLZfImageSize* imageDownloadSize;
@property (readwrite,strong) FLZfImageSize* galleryThumbnailDownloadSize;
@property (readwrite,strong) FLZfImageSize* photoThumbnailSize;

+ (FLZfImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size;


+ (FLZfImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size 
                             limitAccessToSize:(FLZfAccessDescriptor*) accessDescriptorOrNil;

@end 
