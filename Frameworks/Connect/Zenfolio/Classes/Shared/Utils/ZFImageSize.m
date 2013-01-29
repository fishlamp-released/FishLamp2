//
//  ZFImageSize.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFImageSize.h"

#import "ZFUtils.h"

@interface ZFImageSize ()
@property (readwrite, strong) NSString* sizeName;
@end

@interface ZFOriginalImageSize : ZFImageSize
@end


typedef enum PhotoSizeEnum
{
// these match the Zenfolio enums

// thumbnails
	kSmallThumbnail80x80        = 0,
	kSquareThumbnail60x60       = 1,
	kMediumThumbnail120x120     = 10,
	kLargeThumbnail200x200      = 11,

// images	
	kSmallImage400x400          = 2, 
	kMediumImage580x450         = 3,
	kLargeImage800x630          = 4,
	kXLargeImage1100x850        = 5,
	kXXLargeImage1550x960       = 6,

// our own value
    ZFPhotoSizeOriginal         = 100,
} ZFPhotoSizeEnum;

#define kSmallThumbnailMaxSize  80
#define kSquareThumbnailMaxSize 60
#define kMediumThumbnailMaxSize 120
#define kLargeThumbnailMaxSize  200
#define kSmallImageMaxSize      400
#define kMediumImageMaxSize     450
#define kLargeImageMaxSize      630
#define kXLargeImageMaxSize     850
#define kXXLargeImageMaxSize    960
#define kOriginalMaxSize        FL_MAX



@implementation ZFImageSize 

@synthesize sizeName = _sizeName;
@synthesize sizeEnum = _sizeEnum;
@synthesize size = _size;

#if FL_MRC
- (void) dealloc {
    [_sizeName release];
    [super dealloc];
}
#endif

+ (FLSizeEnum) smallestSizeEnumEnclosingSize:(CGSize) size  {

    FLSizeEnum outSize = ZFPhotoSizeOriginal;

    if(size.width <= kSmallThumbnailMaxSize && size.height <= kSmallThumbnailMaxSize)
    {
        outSize = kSmallThumbnail80x80;
    }
    else if(size.width <= kMediumThumbnailMaxSize && size.height <= kMediumThumbnailMaxSize)
    {
        outSize = kMediumThumbnail120x120;
    }
    else if(size.width <= kLargeThumbnailMaxSize && size.height <= kLargeThumbnailMaxSize)
    {
        outSize = kLargeThumbnail200x200;
    }
    else if(size.width <= kSmallImageMaxSize && size.height <= kSmallImageMaxSize)
    {
        outSize = kSmallImage400x400;
    }
    else if(size.width <= kMediumImageMaxSize && size.height <= kMediumImageMaxSize)
    {
        outSize = kMediumImage580x450;
    }
    else if(size.width <= kLargeImageMaxSize && size.height <= kLargeImageMaxSize)
    {
        outSize = kLargeImage800x630;
    }
    else if(size.width <= kXLargeImageMaxSize && size.height <= kXLargeImageMaxSize)
    {
        outSize = kXLargeImage1100x850;
    }
    else if(size.width <= kXXLargeImageMaxSize && size.height <= kXXLargeImageMaxSize)
    {
        outSize = kXXLargeImage1550x960;
    }

    return outSize;
}

+ (CGSize) sizeFromSizeEnum:(FLSizeEnum) sizeEnum {
    switch(sizeEnum) {
        case kSmallThumbnail80x80:
            return CGSizeMake(kSmallThumbnailMaxSize,kSmallThumbnailMaxSize);
        break;

        case kSquareThumbnail60x60:
            return CGSizeMake(kSquareThumbnailMaxSize,kSquareThumbnailMaxSize);
        break;

        case kMediumThumbnail120x120:
            return CGSizeMake(kMediumThumbnailMaxSize,kMediumThumbnailMaxSize);
        break;

        case kLargeThumbnail200x200:
            return CGSizeMake(kLargeThumbnailMaxSize,kLargeThumbnailMaxSize);
        break;

        case kSmallImage400x400:
            return CGSizeMake(kSmallImageMaxSize,kSmallImageMaxSize);
        break;

        case kMediumImage580x450:
            return CGSizeMake(kMediumImageMaxSize,kMediumImageMaxSize);
        break;

        case kLargeImage800x630:
            return CGSizeMake(kLargeImageMaxSize,kLargeImageMaxSize);
        break;

        case kXLargeImage1100x850:
            return CGSizeMake(kXLargeImageMaxSize,kXLargeImageMaxSize);
        break;

        case kXXLargeImage1550x960:
            return CGSizeMake(kXXLargeImageMaxSize,kXXLargeImageMaxSize);
        break;

        case ZFPhotoSizeOriginal:
            return CGSizeMake(FLT_MAX,FLT_MAX);
        break;
    }

    return CGSizeZero;
}

+ (NSString*) stringFromSizeEnum:(FLSizeEnum) sizeEnum {
    switch(sizeEnum) {
        case kSmallThumbnail80x80:
            return NSLocalizedString(@"Small Thumbnail", nil);
        break;
        case kSquareThumbnail60x60:
            return NSLocalizedString(@"Square Thumbnail", nil);
        break;
        case kMediumThumbnail120x120:
            return NSLocalizedString(@"Medium Thumbnail", nil);
        break;
        case kLargeThumbnail200x200:
            return NSLocalizedString(@"Large Thumbnail", nil);
        break;
        case kSmallImage400x400:
            return NSLocalizedString(@"Small Image", nil);
        break;
        case kMediumImage580x450:
            return NSLocalizedString(@"Medium Image", nil);
        break;
        case kLargeImage800x630:
            return NSLocalizedString(@"Large Image", nil);
        break;
        case kXLargeImage1100x850:
            return NSLocalizedString(@"X-Large Image", nil);
        break;
        case kXXLargeImage1550x960:
            return NSLocalizedString(@"XX-Large Image", nil);
        break;
        case ZFPhotoSizeOriginal:
            return NSLocalizedString(@"Original", nil);
        break;
    }
    
    return nil;
}

- (id) initWithSizeEnum:(FLSizeEnum) size {
    self = [super init];
    if(self) {
        _sizeEnum = size;
        _size = [ZFImageSize sizeFromSizeEnum:size];
        self.sizeName = [ZFImageSize stringFromSizeEnum:size];

    }
    return self;
}

+ (id) imageSize:(FLSizeEnum) size {
    return FLAutorelease([[[self class] alloc] initWithSizeEnum:size]);
}

+ (ZFImageSize*) smallThumbnailSize {
    FLReturnStaticObject([[ZFImageSize alloc] initWithSizeEnum:kSmallThumbnail80x80]; );
}

+ (ZFImageSize*) squareThumbnailSize {
    FLReturnStaticObject([[ZFImageSize alloc] initWithSizeEnum:kSquareThumbnail60x60]; );
}

+ (ZFImageSize*) mediumThumbnailSize {
    FLReturnStaticObject([[ZFImageSize alloc] initWithSizeEnum:kMediumThumbnail120x120]; );
}

+ (ZFImageSize*) largeThumbnailSize {
    FLReturnStaticObject([[ZFImageSize alloc] initWithSizeEnum:kLargeThumbnail200x200]; );
}

+ (ZFImageSize*) smallImageSize {
    FLReturnStaticObject([[ZFImageSize alloc] initWithSizeEnum:kSmallImage400x400]; );
}

+ (ZFImageSize*) mediumImageSize {
    FLReturnStaticObject([[ZFImageSize alloc] initWithSizeEnum:kMediumImage580x450]; );
}

+ (ZFImageSize*) largeImageSize {
    FLReturnStaticObject([[ZFImageSize alloc] initWithSizeEnum:kLargeImage800x630]; );
}

+ (ZFImageSize*) xLargeImageSize {
    FLReturnStaticObject([[ZFImageSize alloc] initWithSizeEnum:kXLargeImage1100x850]; );
}

+ (ZFImageSize*) xxLargeImageSize {
    FLReturnStaticObject([[ZFImageSize alloc] initWithSizeEnum:kXXLargeImage1550x960]; );
}

+ (ZFImageSize*) originalImageSize {
    FLReturnStaticObject([[ZFOriginalImageSize alloc] initWithSizeEnum:ZFPhotoSizeOriginal]; );
}
 
+ (NSArray*) allImageSizes {

    FLReturnStaticObject( 
        [[NSArray alloc] initWithObjects:
                        [self smallThumbnailSize],
                        [self squareThumbnailSize],
                        [self mediumThumbnailSize],
                        [self smallThumbnailSize],
                        [self largeThumbnailSize],
                        [self smallImageSize],
                        [self mediumImageSize],
                        [self largeImageSize],
                        [self xLargeImageSize],
                        [self xxLargeImageSize],
                        [self originalImageSize],
                        nil
                ];
    );
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+ (ZFImageSize*) imageSizeFromSizeEnum:(FLSizeEnum) sizeEnum {
    for(ZFImageSize* size in [self allImageSizes]) {
        if(sizeEnum == size.sizeEnum) {
            return size;
        }
    }
    
    return nil;
}

+ (ZFImageSize*) imageSizeEnclosingSize:(CGSize) size {
    return [self imageSizeFromSizeEnum:[self smallestSizeEnumEnclosingSize:size]];
}


//
//+ (ZFImageSize*) smallestSizeEnclosingSize:(CGSize) size {
//
//    FLSizeEnum outSize = kSmallThumbnail80x80;
//
//    if(size.width <= 80 && size.height <= 80)
//    {
//        outSize = kSmallThumbnail80x80;
//    }
//    else if(size.width <= 120 && size.height <= 120)
//    {
//        outSize = kMediumThumbnail120x120;
//    }
//    else if(size.width <= 200 && size.height <= 200)
//    {
//        outSize = kLargeThumbnail200x200;
//    }
//    else if(size.width <= 400 && size.height <= 400)
//    {
//        outSize = kSmallImage400x400;
//    }
//    else if(size.width <= 450 && size.height <= 450)
//    {
//        outSize = kMediumImage580x450;
//    }
//    else if(size.width <= 630 && size.height <= 630)
//    {
//        outSize = kLargeImage800x630;
//    }
//    else if(size.width <= 850 && size.height <= 850)
//    {
//        outSize = kXLargeImage1100x850;
//    }
//    else
//    {
//        outSize = kXXLargeImage1550x960;
//    }
//    
//
//    
//    return nil;
//}

//#define URL_FORMAT @"http://www.zenfolio.com%@-%d.jpg?sn=%@&tk=%@"

- (NSURL*) urlForImage:(ZFPhoto*) photo {
	FLAssertStringIsNotEmpty_(photo.UrlCore);
	
    if(FLStringIsNotEmpty(photo.UrlToken)) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@-%d.jpg?sn=%@&tk=%@",
            photo.UrlHost,
            photo.UrlCore,
            self.sizeEnum,
            FLStringIsEmpty(photo.Sequence) ? @"" : photo.Sequence,
            photo.UrlToken]];
    }
    else {
        return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@-%d.jpg?sn=%@",
            photo.UrlHost,
            photo.UrlCore,
            self.sizeEnum,
            FLStringIsEmpty(photo.Sequence) ? @"" : photo.Sequence]];
    }
		
}	

//- (NSURL*) linkForPhoto:(ZFPhoto*) photo {
//	return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@-%d.jpg", self.UrlHost, self.UrlCore, photoSize]];
//}
@end

@implementation ZFOriginalImageSize
- (NSURL*) urlForImage:(ZFPhoto*) photo {
    return [NSURL URLWithString:[photo OriginalUrl]];
}
@end

@implementation ZFPhoto (ZFImageSize)

- (NSURL*) urlForImageWithSize:(ZFImageSize*) size {
    return [size urlForImage:self];
}

//- (NSURL*) urlForPhoto:(ZFImageSize*) size {
//    return [size linkForPhoto:self];
//}

@end




