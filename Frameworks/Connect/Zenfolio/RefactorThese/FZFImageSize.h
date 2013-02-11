//
//  FLZenfolioImageSize.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioPhoto.h"

typedef uint32_t FLSizeEnum;

@interface FLZenfolioImageSize : NSObject<NSCopying> {
@private
    FLSizeEnum _sizeEnum;
    CGSize _size;
    NSString* _sizeName;
}

@property (readonly, strong) NSString* sizeName;
@property (readonly, assign) CGSize size;
@property (readonly, assign) FLSizeEnum sizeEnum;

+ (FLZenfolioImageSize*) smallThumbnailSize;
+ (FLZenfolioImageSize*) squareThumbnailSize;
+ (FLZenfolioImageSize*) mediumThumbnailSize;
+ (FLZenfolioImageSize*) largeThumbnailSize;

+ (FLZenfolioImageSize*) smallImageSize;
+ (FLZenfolioImageSize*) mediumImageSize;
+ (FLZenfolioImageSize*) largeImageSize;
+ (FLZenfolioImageSize*) xLargeImageSize;
+ (FLZenfolioImageSize*) xxLargeImageSize;

+ (FLZenfolioImageSize*) originalImageSize;
 
+ (NSArray*) allImageSizes;

+ (FLZenfolioImageSize*) imageSizeFromSizeEnum:(FLSizeEnum) sizeEnum;

+ (CGSize) sizeFromSizeEnum:(FLSizeEnum) sizeEnum;
+ (NSString*) stringFromSizeEnum:(FLSizeEnum) sizeEnum;

+ (FLZenfolioImageSize*) imageSizeEnclosingSize:(CGSize) size;
+ (FLSizeEnum) smallestSizeEnumEnclosingSize:(CGSize) size;


@end

@interface FLZenfolioPhoto (FLZenfolioImageSize)
- (NSURL*) urlForImageWithSize:(FLZenfolioImageSize*) size;
//- (NSURL*) urlForUserBrowserWithSize:(FLZenfolioImageSize*) size;
@end


typedef enum
{
	kUploadOriginalSize,
	kUploadLargeSize,	// 800
	kUploadMediumSize // 580
} FLZenfolioUploadPhotoSizeEnum;