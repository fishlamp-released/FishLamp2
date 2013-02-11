//
//  FLZenfolioImageDisplaySize.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioImageSize.h"
#import "FLZenfolioAccessDescriptor.h"

@interface FLZenfolioImageDisplaySize : NSObject {
@private
    FLZenfolioImageSize* _highResolutionImageDownloadSize;
    FLZenfolioImageSize* _imageDownloadSize;
    FLZenfolioImageSize* _galleryThumbnailDownloadSize;
    FLZenfolioImageSize* _photoThumbnailSize;
}

@property (readonly, assign) BOOL isRetinaDevice;

@property (readwrite,strong) FLZenfolioImageSize* highResolutionImageDownloadSize;
@property (readwrite,strong) FLZenfolioImageSize* imageDownloadSize;
@property (readwrite,strong) FLZenfolioImageSize* galleryThumbnailDownloadSize;
@property (readwrite,strong) FLZenfolioImageSize* photoThumbnailSize;

+ (FLZenfolioImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size;


+ (FLZenfolioImageSize*) imageDisplaySizeEnclosingSize:(CGSize) size 
                             limitAccessToSize:(FLZenfolioAccessDescriptor*) accessDescriptorOrNil;

@end 
