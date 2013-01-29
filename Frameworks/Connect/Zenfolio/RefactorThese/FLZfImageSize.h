//
//  FLZfImageSize.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfPhoto.h"

typedef uint32_t FLSizeEnum;

@interface FLZfImageSize : NSObject<NSCopying> {
@private
    FLSizeEnum _sizeEnum;
    CGSize _size;
    NSString* _sizeName;
}

@property (readonly, strong) NSString* sizeName;
@property (readonly, assign) CGSize size;
@property (readonly, assign) FLSizeEnum sizeEnum;

+ (FLZfImageSize*) smallThumbnailSize;
+ (FLZfImageSize*) squareThumbnailSize;
+ (FLZfImageSize*) mediumThumbnailSize;
+ (FLZfImageSize*) largeThumbnailSize;

+ (FLZfImageSize*) smallImageSize;
+ (FLZfImageSize*) mediumImageSize;
+ (FLZfImageSize*) largeImageSize;
+ (FLZfImageSize*) xLargeImageSize;
+ (FLZfImageSize*) xxLargeImageSize;

+ (FLZfImageSize*) originalImageSize;
 
+ (NSArray*) allImageSizes;

+ (FLZfImageSize*) imageSizeFromSizeEnum:(FLSizeEnum) sizeEnum;

+ (CGSize) sizeFromSizeEnum:(FLSizeEnum) sizeEnum;
+ (NSString*) stringFromSizeEnum:(FLSizeEnum) sizeEnum;

+ (FLZfImageSize*) imageSizeEnclosingSize:(CGSize) size;
+ (FLSizeEnum) smallestSizeEnumEnclosingSize:(CGSize) size;


@end

@interface FLZfPhoto (FLZfImageSize)
- (NSURL*) urlForImageWithSize:(FLZfImageSize*) size;
//- (NSURL*) urlForUserBrowserWithSize:(FLZfImageSize*) size;
@end


typedef enum
{
	kUploadOriginalSize,
	kUploadLargeSize,	// 800
	kUploadMediumSize // 580
} FLZfUploadPhotoSizeEnum;