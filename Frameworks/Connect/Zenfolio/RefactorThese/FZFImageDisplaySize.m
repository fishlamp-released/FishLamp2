//
//  FLZenfolioImageDisplaySize.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioImageDisplaySize.h"
#import "FLZenfolioAccessDescriptor.h"

@implementation FLZenfolioImageDisplaySize

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
            self.imageDownloadSize = [ZenfolioPhotoSize xLargeImage];
            self.highResolutionImageDownloadSize = [ZenfolioPhotoSize xxLargeImage];
            self.galleryThumbnailDownloadSize = [ZenfolioPhotoSize mediumThumbnail];
            self.photoThumbnailSize = [ZenfolioPhotoSize mediumThumbnail];
        
            ((FLCachedImageCacheBehavior*)[FLCachedImage sharedCacheBehavior]).maxLongSideForInMemoryCache = 202.0f;
        }
        else if(self.isRetinaDevice || [UIScreen mainScreen].bounds.size.width > 320)
        {
            self.imageDownloadSize = [ZenfolioPhotoSize largeImage];
            self.highResolutionImageDownloadSize = [ZenfolioPhotoSize xLargeImage];
            self.galleryThumbnailDownloadSize = [ZenfolioPhotoSize largeThumbnail];
            self.photoThumbnailSize = [ZenfolioPhotoSize largeThumbnail];

//            kImageDownloadSize = kLargeImage800x630;
//            kImageHighResDownloadSize = kXLargeImage1100x850;
//            kGalleryThumbnailDownloadSize = kLargeThumbnail200x200;
//            kPhotoThumbnail				  = kLargeThumbnail200x200;
            ((FLCachedImageCacheBehavior*)[FLCachedImage sharedCacheBehavior]).maxLongSideForInMemoryCache = 202.0f;
        }
        else {
            ((FLCachedImageCacheBehavior*)[FLCachedImage sharedCacheBehavior]).maxLongSideForInMemoryCache = 82.0f;

//            FLZenfolioPhotoSizeEnum kImageHighResDownloadSize	  = kXLargeImage1100x850;
//            FLZenfolioPhotoSizeEnum kImageDownloadSize			  = kMediumImage580x450; 
//            FLZenfolioPhotoSizeEnum kGalleryThumbnailDownloadSize = kMediumThumbnail120x120;
//            FLZenfolioPhotoSizeEnum kPhotoThumbnail				  = kMediumThumbnail120x120;

            self.imageDownloadSize = [ZenfolioPhotoSize mediumImage];
            self.highResolutionImageDownloadSize = [ZenfolioPhotoSize xLargeImage];
            self.galleryThumbnailDownloadSize = [ZenfolioPhotoSize mediumThumbnail];
            self.photoThumbnailSize = [ZenfolioPhotoSize mediumThumbnail];
        
        }
#endif        
        
    }
    return self;
}

+ (FLZenfolioImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size {
#if IOS
    size.width += [UIScreen mainScreen].scale;
    height.width += [UIScreen mainScreen].scale;
#endif

    return [FLZenfolioImageSize imageSizeEnclosingSize:size];
}

+ (FLZenfolioImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size 
                          limitAccessToSize:(FLZenfolioAccessDescriptor*) accessMask {


    FLZenfolioImageSize* outSize = [self imageDisplaySizeEnclosingSize:size];

    if(accessMask) {
        FLZenfolioImageSize* biggest = accessMask.largestAllowedImageSize;
        if(biggest.sizeEnum < outSize.sizeEnum) {
            outSize = biggest;
        }
    }

    return outSize;
}

@end

