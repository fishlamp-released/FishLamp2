//
//  FLZfImageDisplaySize.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfImageDisplaySize.h"
#import "FLZfAccessDescriptor.h"

@implementation FLZfImageDisplaySize

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

//            FLZfPhotoSizeEnum kImageHighResDownloadSize	  = kXLargeImage1100x850;
//            FLZfPhotoSizeEnum kImageDownloadSize			  = kMediumImage580x450; 
//            FLZfPhotoSizeEnum kGalleryThumbnailDownloadSize = kMediumThumbnail120x120;
//            FLZfPhotoSizeEnum kPhotoThumbnail				  = kMediumThumbnail120x120;

            self.imageDownloadSize = [ZfPhotoSize mediumImage];
            self.highResolutionImageDownloadSize = [ZfPhotoSize xLargeImage];
            self.galleryThumbnailDownloadSize = [ZfPhotoSize mediumThumbnail];
            self.photoThumbnailSize = [ZfPhotoSize mediumThumbnail];
        
        }
#endif        
        
    }
    return self;
}

+ (FLZfImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size {
#if IOS
    size.width += [UIScreen mainScreen].scale;
    height.width += [UIScreen mainScreen].scale;
#endif

    return [FLZfImageSize imageSizeEnclosingSize:size];
}

+ (FLZfImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size 
                          limitAccessToSize:(FLZfAccessDescriptor*) accessMask {


    FLZfImageSize* outSize = [self imageDisplaySizeEnclosingSize:size];

    if(accessMask) {
        FLZfImageSize* biggest = accessMask.largestAllowedImageSize;
        if(biggest.sizeEnum < outSize.sizeEnum) {
            outSize = biggest;
        }
    }

    return outSize;
}

@end

