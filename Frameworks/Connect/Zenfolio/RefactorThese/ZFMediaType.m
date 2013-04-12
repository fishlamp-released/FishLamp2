//
//  ZFMediaType.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFMediaType.h"
#import "ZFWebApi.h"


@interface ZFMediaType ()
@property (readwrite, strong, nonatomic) NSString* abbreviation;
@property (readwrite, strong, nonatomic) NSString* localizedDisplayName;
@property (readwrite, assign, nonatomic) CGSize size;
@property (readwrite, assign, nonatomic) ZFMediaTypeID mediaTypeID;
@end

//@interface ZFMediaTypeOriginalImage : ZFMediaType
//@end



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

@implementation ZFMediaType 

@synthesize localizedDisplayName = _localizedDisplayName;
@synthesize mediaTypeID = _mediaTypeID;
@synthesize size = _size;
@synthesize abbreviation = _abbreviation;

#if FL_MRC
- (void) dealloc {
    [_abbreviation release];
    [_localizedDisplayName release];
    [super dealloc];
}
#endif

+ (ZFMediaType*) imageTypeFittingInSize:(CGSize) size {

    ZFMediaTypeID typeID = ZFMediaTypeOriginalImage;

    if(size.width <= kSmallThumbnailMaxSize && size.height <= kSmallThumbnailMaxSize)
    {
        typeID = ZFMediaTypeSmallThumbnail;
    }
    else if(size.width <= kMediumThumbnailMaxSize && size.height <= kMediumThumbnailMaxSize)
    {
        typeID = ZFMediaTypeMediumThumbnail;
    }
    else if(size.width <= kLargeThumbnailMaxSize && size.height <= kLargeThumbnailMaxSize)
    {
        typeID = ZFMediaTypeLargeThumbnail;
    }
    else if(size.width <= kSmallImageMaxSize && size.height <= kSmallImageMaxSize)
    {
        typeID = ZFMediaTypeSmallImage;
    }
    else if(size.width <= kMediumImageMaxSize && size.height <= kMediumImageMaxSize)
    {
        typeID = ZFMediaTypeMediumImage;
    }
    else if(size.width <= kLargeImageMaxSize && size.height <= kLargeImageMaxSize)
    {
        typeID = ZFMediaTypeLargeImage;
    }
    else if(size.width <= kXLargeImageMaxSize && size.height <= kXLargeImageMaxSize)
    {
        typeID = ZFMediaTypeXLargeImage;
    }
    else if(size.width <= kXXLargeImageMaxSize && size.height <= kXXLargeImageMaxSize)
    {
        typeID = ZFMediaTypeXXLImage;
    }

    return [self mediaType:typeID];
}

+ (CGSize) imageSizeFromID:(ZFMediaTypeID) mediaTypeID {
    switch(mediaTypeID) {
        case ZFMediaTypeSmallThumbnail:
            return CGSizeMake(kSmallThumbnailMaxSize,kSmallThumbnailMaxSize);
        break;

        case ZFMediaTypeSquareThumbnail:
            return CGSizeMake(kSquareThumbnailMaxSize,kSquareThumbnailMaxSize);
        break;

        case ZFMediaTypeMediumThumbnail:
            return CGSizeMake(kMediumThumbnailMaxSize,kMediumThumbnailMaxSize);
        break;

        case ZFMediaTypeLargeThumbnail:
            return CGSizeMake(kLargeThumbnailMaxSize,kLargeThumbnailMaxSize);
        break;

        case ZFMediaTypeSmallImage:
            return CGSizeMake(kSmallImageMaxSize,kSmallImageMaxSize);
        break;

        case ZFMediaTypeMediumImage:
            return CGSizeMake(kMediumImageMaxSize,kMediumImageMaxSize);
        break;

        case ZFMediaTypeLargeImage:
            return CGSizeMake(kLargeImageMaxSize,kLargeImageMaxSize);
        break;

        case ZFMediaTypeXLargeImage:
            return CGSizeMake(kXLargeImageMaxSize,kXLargeImageMaxSize);
        break;

        case ZFMediaTypeXXLImage:
            return CGSizeMake(kXXLargeImageMaxSize,kXXLargeImageMaxSize);
        break;

        case ZFMediaTypeOriginalImage:
            return CGSizeMake(FLT_MAX,FLT_MAX);
        break;
        
        case ZFMediaTypeVideo:
            return CGSizeZero;
        break;
    }

    return CGSizeZero;
}

+ (NSString*) localizedDisplayNameFromID:(ZFMediaTypeID) mediaTypeID {
    switch(mediaTypeID) {
        case ZFMediaTypeSmallThumbnail:
            return NSLocalizedString(@"Small Thumbnail", nil);
        break;
        case ZFMediaTypeSquareThumbnail:
            return NSLocalizedString(@"Square Thumbnail", nil);
        break;
        case ZFMediaTypeMediumThumbnail:
            return NSLocalizedString(@"Medium Thumbnail", nil);
        break;
        case ZFMediaTypeLargeThumbnail:
            return NSLocalizedString(@"Large Thumbnail", nil);
        break;
        case ZFMediaTypeSmallImage:
            return NSLocalizedString(@"Small Image", nil);
        break;
        case ZFMediaTypeMediumImage:
            return NSLocalizedString(@"Medium Image", nil);
        break;
        case ZFMediaTypeLargeImage:
            return NSLocalizedString(@"Large Image", nil);
        break;
        case ZFMediaTypeXLargeImage:
            return NSLocalizedString(@"X-Large Image", nil);
        break;
        case ZFMediaTypeXXLImage:
            return NSLocalizedString(@"XX-Large Image", nil);
        break;
        case ZFMediaTypeOriginalImage:
            return NSLocalizedString(@"Original", nil);
        break;
        case ZFMediaTypeVideo:
            return NSLocalizedString(@"Video", nil);
        break;
    }
    
    return nil;
}

+ (NSString*) shortNameFromID:(ZFMediaTypeID) mediaTypeID {
    switch(mediaTypeID) {
        case ZFMediaTypeSmallThumbnail:
            return NSLocalizedString(@"ST", @"media type abbreviation");
        break;
        case ZFMediaTypeSquareThumbnail:
            return NSLocalizedString(@"T", @"media type abbreviation");
        break;
        case ZFMediaTypeMediumThumbnail:
            return NSLocalizedString(@"MT", @"media type abbreviation");
        break;
        case ZFMediaTypeLargeThumbnail:
            return NSLocalizedString(@"LT", @"media type abbreviation");
        break;
        case ZFMediaTypeSmallImage:
            return NSLocalizedString(@"S", @"media type abbreviation");
        break;
        case ZFMediaTypeMediumImage:
            return NSLocalizedString(@"M", @"media type abbreviation");
        break;
        case ZFMediaTypeLargeImage:
            return NSLocalizedString(@"L", @"media type abbreviation");
        break;
        case ZFMediaTypeXLargeImage:
            return NSLocalizedString(@"XL", @"media type abbreviation");
        break;
        case ZFMediaTypeXXLImage:
            return NSLocalizedString(@"XXL", @"media type abbreviation");
        break;
        case ZFMediaTypeOriginalImage:
            return NSLocalizedString(@"O", @"media type abbreviation");
        break;
        case ZFMediaTypeVideo:
            return NSLocalizedString(@"V", @"media type abbreviation");
        break;
    }
    
    return nil;
}

- (id) initWithMediaTypeID:(ZFMediaTypeID) typeID {
    self = [super init];
    if(self) {
        _mediaTypeID = typeID;
        _size = [ZFMediaType imageSizeFromID:typeID];
        self.localizedDisplayName = [ZFMediaType localizedDisplayNameFromID:typeID];
        self.abbreviation = [ZFMediaType shortNameFromID:typeID];
    }
    return self;
}

+ (id) mediaType:(ZFMediaTypeID) mediaTypeID {

    switch(mediaTypeID) {
        case ZFMediaTypeSmallThumbnail:
            return [self smallThumbnail];
        break;
        case ZFMediaTypeSquareThumbnail:
            return [self squareThumbnail];
        break;
        case ZFMediaTypeMediumThumbnail:
            return [self mediumThumbnail];
        break;
        case ZFMediaTypeLargeThumbnail:
            return [self largeThumbnail];
        break;
        case ZFMediaTypeSmallImage:
            return [self smallImage];
        break;
        case ZFMediaTypeMediumImage:
            return [self mediumImage];
        break;
        case ZFMediaTypeLargeImage:
            return [self largeImage];
        break;
        case ZFMediaTypeXLargeImage:
            return [self xLargeImage];
        break;
        case ZFMediaTypeXXLImage:
            return [self xxLargeImage];
        break;
        case ZFMediaTypeOriginalImage:
            return [self originalImage];
        break;
        case ZFMediaTypeVideo:
            return [self video];
        break;
    }

    return nil;
}

+ (ZFMediaType*) smallThumbnail {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeSmallThumbnail]; );
}

+ (ZFMediaType*) squareThumbnail {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeSquareThumbnail]; );
}

+ (ZFMediaType*) mediumThumbnail {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeMediumThumbnail]; );
}

+ (ZFMediaType*) largeThumbnail {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeLargeThumbnail]; );
}

+ (ZFMediaType*) smallImage {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeSmallImage]; );
}

+ (ZFMediaType*) mediumImage {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeMediumImage]; );
}

+ (ZFMediaType*) largeImage {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeLargeImage]; );
}

+ (ZFMediaType*) xLargeImage {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeXLargeImage]; );
}

+ (ZFMediaType*) xxLargeImage {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeXXLImage]; );
}

+ (ZFMediaType*) originalImage {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeOriginalImage]; );
}

+ (ZFMediaType*) video {
    FLReturnStaticObject([[ZFMediaType alloc] initWithMediaTypeID:ZFMediaTypeVideo]; );
}

+ (NSArray*) allMediaTypes {

    FLReturnStaticObject( 
        [[NSArray alloc] initWithObjects:
                        [self smallThumbnail],
                        [self squareThumbnail],
                        [self mediumThumbnail],
                        [self smallThumbnail],
                        [self largeThumbnail],
                        [self smallImage],
                        [self mediumImage],
                        [self largeImage],
                        [self xLargeImage],
                        [self xxLargeImage],
                        [self originalImage],
                        [self video],
                        nil
                ];
    );
}

+ (NSArray*) allImageTypes {

    FLReturnStaticObject( 
        [[NSArray alloc] initWithObjects:
                        [self smallThumbnail],
                        [self squareThumbnail],
                        [self mediumThumbnail],
                        [self smallThumbnail],
                        [self largeThumbnail],
                        [self smallImage],
                        [self mediumImage],
                        [self largeImage],
                        [self xLargeImage],
                        [self xxLargeImage],
                        [self originalImage],
                        nil
                ];
    );
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

//+ (ZFMediaType*) mediaType:(ZFMediaTypeID) mediaTypeID {
//    for(ZFMediaType* size in [self allMediaTypes]) {
//        if(mediaTypeID == size.mediaTypeID) {
//            return size;
//        }
//    }
//    
//    return nil;
//}

//+ (ZFMediaType*) imageTypeFittingInSize:(CGSize) size {
//    return [self mediaType:[self smallImageTypeFittingInSize:size]];
//}


// see http://www.zenfolio.com/zf/help/api/guide/download

- (NSURL*) URLWithPhoto:(ZFPhoto*) photo {

    int zenSize = -1;
    
    switch(self.mediaTypeID) {
        case ZFMediaTypeSmallThumbnail:
            zenSize = 0;
        break;

        case ZFMediaTypeSquareThumbnail:
            zenSize = 1;
        break;

        case ZFMediaTypeMediumThumbnail:
            zenSize = 10;
        break;

        case ZFMediaTypeLargeThumbnail:
            zenSize = 11;
        break;

        case ZFMediaTypeSmallImage:
            zenSize = 2;
        break;

        case ZFMediaTypeMediumImage:
            zenSize = 3;
        break;

        case ZFMediaTypeLargeImage:
            zenSize = 4;
        break;

        case ZFMediaTypeXLargeImage:
            zenSize = 5;
        break;

        case ZFMediaTypeXXLImage:
            zenSize = 6;
        break;
        
        case ZFMediaTypeOriginalImage:
            return [NSURL URLWithString:[photo OriginalUrl]];
            break;
            
        case ZFMediaTypeVideo:
            zenSize = -1;
            break;
    }

    FLAssertStringIsNotEmpty(photo.UrlCore);
	
    NSMutableString* url = [NSString stringWithFormat:@"http://%@%@", photo.UrlHost, photo.UrlCore];

    if(zenSize >= 0) {
        [url appendFormat:@"-%d.jpg", zenSize];
    }
    else {
        [url appendString:@".jpg"];
    }
    
    char nextDelim = '?';
    if(FLStringIsNotEmpty(photo.Sequence)) {
        [url appendFormat:@"%csn=%@", nextDelim, photo.Sequence];
        nextDelim = '&';
    }
    
    if(FLStringIsNotEmpty(photo.UrlToken)) {
        [url appendFormat:@"%ctk=%@", nextDelim, photo.UrlToken];
//        nextDelim = '&';
    }
                
    
//    NSString* sequence = FLStringIsEmpty(photo.Sequence) ? @"" : ,
//                [NSString stringWithFormat:@"sn=%@", photo.Sequence];
//    
//    if(zenSize >= 0) {
//        if(FLStringIsNotEmpty(photo.UrlToken)) {
//            return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@-%d.jpg?sn=%@&tk=%@",
//                photo.UrlHost,
//                photo.UrlCore,
//                zenSize,
//                sequence,
//                photo.UrlToken]];
//        }
//        else {
//            return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@-%d.jpg?sn=%@",
//                photo.UrlHost,
//                photo.UrlCore,
//                zenSize,
//                FLStringIsEmpty(photo.Sequence) ? @"" : photo.Sequence]];
//        }
//    }
//    else {
//        if(FLStringIsNotEmpty(photo.UrlToken)) {
//            return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@.jpg?&tk=%@",
//                photo.UrlHost,
//                photo.UrlCore,
//                photo.UrlToken]];
//        }
//        else {
//            return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@.jpg",
//                photo.UrlHost,
//                photo.UrlCore]];
//        }
//    }


    return [NSURL URLWithString:url];
}

- (NSString*) humanReadableFileNameForPhoto:(ZFPhoto*) photo {
    if(photo.IsVideoValue) {
        return [NSString stringWithFormat:@"%@-Master.mp4", [photo.FileName stringByDeletingPathExtension]];
    }

    NSMutableString* name = [NSMutableString stringWithFormat:@"%@-%@", [photo.FileName stringByDeletingPathExtension], [photo Id]]; 
            
    if(FLStringIsNotEmpty(photo.Sequence)) {
        [name appendFormat:@"-%@", photo.Sequence];
    }
    if(FLStringIsNotEmpty(photo.Sequence)) {
        [name appendFormat:@"-%@", self.abbreviation];
    }
    [name appendFormat:@".%@", [photo.FileName pathExtension]];

    return name;
}

@end

//@implementation ZFMediaTypeOriginalImage
//- (NSURL*) URLWithPhoto:(ZFPhoto*) photo {
//    return [NSURL URLWithString:[photo OriginalUrl]];
//}
//@end
//
//
//
//
//
