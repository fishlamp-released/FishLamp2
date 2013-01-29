//
//  ZFImageSize.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFPhoto.h"

typedef uint32_t FLSizeEnum;

@interface ZFImageSize : NSObject<NSCopying> {
@private
    FLSizeEnum _sizeEnum;
    CGSize _size;
    NSString* _sizeName;
}

@property (readonly, strong) NSString* sizeName;
@property (readonly, assign) CGSize size;
@property (readonly, assign) FLSizeEnum sizeEnum;

+ (ZFImageSize*) smallThumbnailSize;
+ (ZFImageSize*) squareThumbnailSize;
+ (ZFImageSize*) mediumThumbnailSize;
+ (ZFImageSize*) largeThumbnailSize;

+ (ZFImageSize*) smallImageSize;
+ (ZFImageSize*) mediumImageSize;
+ (ZFImageSize*) largeImageSize;
+ (ZFImageSize*) xLargeImageSize;
+ (ZFImageSize*) xxLargeImageSize;

+ (ZFImageSize*) originalImageSize;
 
+ (NSArray*) allImageSizes;

+ (ZFImageSize*) imageSizeFromSizeEnum:(FLSizeEnum) sizeEnum;

+ (CGSize) sizeFromSizeEnum:(FLSizeEnum) sizeEnum;
+ (NSString*) stringFromSizeEnum:(FLSizeEnum) sizeEnum;

+ (ZFImageSize*) imageSizeEnclosingSize:(CGSize) size;
+ (FLSizeEnum) smallestSizeEnumEnclosingSize:(CGSize) size;


@end

@interface ZFPhoto (ZFImageSize)
- (NSURL*) urlForImageWithSize:(ZFImageSize*) size;
//- (NSURL*) urlForUserBrowserWithSize:(ZFImageSize*) size;
@end


typedef enum
{
	kUploadOriginalSize,
	kUploadLargeSize,	// 800
	kUploadMediumSize // 580
} ZFUploadPhotoSizeEnum;