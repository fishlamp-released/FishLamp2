//
//  ZFImageDisplaySize.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFImageDisplaySize.h"
#import "ZFAccessDescriptor.h"

@implementation ZFImageDisplaySize

- (BOOL) isRetinaDevice {
#if IOS
    return [UIScreen mainScreen].scale >= 2;
#else
    return NO;
#endif    
}


@synthesize highResolutionImageDownloadSize = _highResolutionImageDownloadSize;
@synthesize imageDownloadSize = _imageDownloadSize;
@synthesize galleryThumbnailDownloadSize = _galleryThumbnailDownloadSize;
@synthesize photoThumbnail = _photoThumbnail;

- (id) init {
    self = [super init];
    if(self) {

#if REFACTOR
#if IOS

        if(DeviceIsPad())
        {
            self.imageDownloadSize = [ZenfolioPhotoSize xLargeImage];
            self.highResolutionImageDownloadSize = [ZenfolioPhotoSize xxLargeImage];
            self.galleryThumbnailDownloadSize = [ZenfolioPhotoSize mediumThumbnail];
            self.photoThumbnail = [ZenfolioPhotoSize mediumThumbnail];
        
            ((FLCachedImageCacheBehavior*)[FLCachedImage sharedCacheBehavior]).maxLongSideForInMemoryCache = 202.0f;
        }
        else if(self.isRetinaDevice || [UIScreen mainScreen].bounds.size.width > 320)
        {
            self.imageDownloadSize = [ZenfolioPhotoSize largeImage];
            self.highResolutionImageDownloadSize = [ZenfolioPhotoSize xLargeImage];
            self.galleryThumbnailDownloadSize = [ZenfolioPhotoSize largeThumbnail];
            self.photoThumbnail = [ZenfolioPhotoSize largeThumbnail];

//            kImageDownloadSize = ZFMediaTypeLargeImage;
//            kImageHighResDownloadSize = ZFMediaTypeXLargeImage;
//            kGalleryThumbnailDownloadSize = ZFMediaTypeLargeThumbnail;
//            kPhotoThumbnail				  = ZFMediaTypeLargeThumbnail;
            ((FLCachedImageCacheBehavior*)[FLCachedImage sharedCacheBehavior]).maxLongSideForInMemoryCache = 202.0f;
        }
        else {
            ((FLCachedImageCacheBehavior*)[FLCachedImage sharedCacheBehavior]).maxLongSideForInMemoryCache = 82.0f;

//            ZFMediaTypeID kImageHighResDownloadSize	  = ZFMediaTypeXLargeImage;
//            ZFMediaTypeID kImageDownloadSize			  = ZFMediaTypeMediumImage; 
//            ZFMediaTypeID kGalleryThumbnailDownloadSize = ZFMediaTypeMediumThumbnail;
//            ZFMediaTypeID kPhotoThumbnail				  = ZFMediaTypeMediumThumbnail;

            self.imageDownloadSize = [ZenfolioPhotoSize mediumImage];
            self.highResolutionImageDownloadSize = [ZenfolioPhotoSize xLargeImage];
            self.galleryThumbnailDownloadSize = [ZenfolioPhotoSize mediumThumbnail];
            self.photoThumbnail = [ZenfolioPhotoSize mediumThumbnail];
        
        }
#endif        
#endif
        
    }
    return self;
}

+ (ZFMediaType*) imageDisplaySizeEnclosingSize:(CGSize) size {
#if IOS
    size.width *= [UIScreen mainScreen].scale;
    size.height *= [UIScreen mainScreen].scale;
#endif

    return [ZFMediaType imageTypeFittingInSize:size];
}

+ (ZFMediaType*) imageDisplaySizeEnclosingSize:(CGSize) size 
                          limitAccessToSize:(ZFAccessDescriptor*) accessMask {


    ZFMediaType* outSize = [self imageDisplaySizeEnclosingSize:size];

    if(accessMask) {
        ZFMediaType* biggest = accessMask.largestAllowedImageSize;
        if(biggest.mediaTypeID < outSize.mediaTypeID) {
            outSize = biggest;
        }
    }

    return outSize;
}

@end

