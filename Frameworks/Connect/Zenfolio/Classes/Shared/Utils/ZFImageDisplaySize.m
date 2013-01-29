//
//  ZFImageDisplaySize.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFImageDisplaySize.h"
#import "ZFAccessDescriptor.h"

@implementation ZFImageDisplaySize

- (BOOL) isRetinaDevice {
#if IOS
    [UIScreen mainScreen].scale >= 2;
#else
    return NO;
#endif    
}


@synthesize highResolutionImageDownloadSize = _highResolutionImageDownloadSize;
@synthesize imageDownloadSize = _imageDownloadSize;
@synthesize galleryThumbnailDownloadSize = _galleryThumbnailDownloadSize;
@synthesize photoThumbnailSize = _photoThumbnailSize;

- (id) init {
    self = [super init];
    if(self) {

#if IOS

        if(DeviceIsPad())
        {
            self.imageDownloadSize = [ZfPhotoSize xLargeImage];
            self.highResolutionImageDownloadSize = [ZfPhotoSize xxLargeImage];
            self.galleryThumbnailDownloadSize = [ZfPhotoSize mediumThumbnail];
            self.photoThumbnailSize = [ZfPhotoSize mediumThumbnail];
        
            ((FLCachedImageCacheBehavior*)[FLCachedImage sharedCacheBehavior]).maxLongSideForInMemoryCache = 202.0f;
        }
        else if(self.isRetinaDevice || [UIScreen mainScreen].bounds.size.width > 320)
        {
            self.imageDownloadSize = [ZfPhotoSize largeImage];
            self.highResolutionImageDownloadSize = [ZfPhotoSize xLargeImage];
            self.galleryThumbnailDownloadSize = [ZfPhotoSize largeThumbnail];
            self.photoThumbnailSize = [ZfPhotoSize largeThumbnail];

//            kImageDownloadSize = kLargeImage800x630;
//            kImageHighResDownloadSize = kXLargeImage1100x850;
//            kGalleryThumbnailDownloadSize = kLargeThumbnail200x200;
//            kPhotoThumbnail				  = kLargeThumbnail200x200;
            ((FLCachedImageCacheBehavior*)[FLCachedImage sharedCacheBehavior]).maxLongSideForInMemoryCache = 202.0f;
        }
        else {
            ((FLCachedImageCacheBehavior*)[FLCachedImage sharedCacheBehavior]).maxLongSideForInMemoryCache = 82.0f;

//            ZFPhotoSizeEnum kImageHighResDownloadSize	  = kXLargeImage1100x850;
//            ZFPhotoSizeEnum kImageDownloadSize			  = kMediumImage580x450; 
//            ZFPhotoSizeEnum kGalleryThumbnailDownloadSize = kMediumThumbnail120x120;
//            ZFPhotoSizeEnum kPhotoThumbnail				  = kMediumThumbnail120x120;

            self.imageDownloadSize = [ZfPhotoSize mediumImage];
            self.highResolutionImageDownloadSize = [ZfPhotoSize xLargeImage];
            self.galleryThumbnailDownloadSize = [ZfPhotoSize mediumThumbnail];
            self.photoThumbnailSize = [ZfPhotoSize mediumThumbnail];
        
        }
#endif        
        
    }
    return self;
}

+ (ZFImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size {
#if IOS
    size.width += [UIScreen mainScreen].scale;
    height.width += [UIScreen mainScreen].scale;
#endif

    return [ZFImageSize imageSizeEnclosingSize:size];
}

+ (ZFImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size 
                          limitAccessToSize:(ZFAccessDescriptor*) accessMask {


    ZFImageSize* outSize = [self imageDisplaySizeEnclosingSize:size];

    if(accessMask) {
        ZFImageSize* biggest = accessMask.largestAllowedImageSize;
        if(biggest.sizeEnum < outSize.sizeEnum) {
            outSize = biggest;
        }
    }

    return outSize;
}

@end

