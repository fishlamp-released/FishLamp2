//
//  ZFMediaType.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZFPhoto;

typedef enum PhotoMediaTypeID
{
	ZFMediaTypeSmallThumbnail,
	ZFMediaTypeSquareThumbnail,
	ZFMediaTypeMediumThumbnail,
	ZFMediaTypeLargeThumbnail,

	ZFMediaTypeSmallImage, 
	ZFMediaTypeMediumImage,
	ZFMediaTypeLargeImage,
	ZFMediaTypeXLargeImage,
	ZFMediaTypeXXLImage,
    ZFMediaTypeOriginalImage,

    ZFMediaTypeVideo                     
} ZFMediaTypeID;

@interface ZFMediaType : NSObject<NSCopying> {
@private
    ZFMediaTypeID _mediaTypeID;
    CGSize _size;
    NSString* _localizedDisplayName;
    NSString* _abbreviation;
}
@property (readonly, assign, nonatomic) BOOL isImage;
@property (readonly, assign, nonatomic) BOOL isVideo;

@property (readonly, strong, nonatomic) NSString* localizedDisplayName;
@property (readonly, strong, nonatomic) NSString* abbreviation;
@property (readonly, assign, nonatomic) CGSize size;
@property (readonly, assign, nonatomic) ZFMediaTypeID mediaTypeID;

+ (ZFMediaType*) smallThumbnail;
+ (ZFMediaType*) squareThumbnail;
+ (ZFMediaType*) mediumThumbnail;
+ (ZFMediaType*) largeThumbnail;

+ (ZFMediaType*) smallImage;
+ (ZFMediaType*) mediumImage;
+ (ZFMediaType*) largeImage;
+ (ZFMediaType*) xLargeImage;
+ (ZFMediaType*) xxLargeImage;

+ (ZFMediaType*) originalImage;

+ (ZFMediaType*) video;

+ (ZFMediaType*) mediaType:(ZFMediaTypeID) mediaTypeID;

+ (ZFMediaType*) imageTypeFittingInSize:(CGSize) size;

+ (NSArray*) allMediaTypes;
+ (NSArray*) allImageTypes;
@end

@interface ZFMediaType (PhotoUtils)
- (NSURL*) URLWithPhoto:(ZFPhoto*) photo;
- (NSString*) humanReadableFileNameForPhoto:(ZFPhoto*) photo inPhotoSet:(ZFPhotoSet*) photoSet;
@end

typedef enum
{
	kUploadOriginalSize,
	kUploadLargeSize,	// 800
	kUploadMediumSize // 580
} ZFUploadPhotoMediaTypeID;