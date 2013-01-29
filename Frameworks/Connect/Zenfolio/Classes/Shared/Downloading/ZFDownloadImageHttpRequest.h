//
//	ZFDownloadImageHttpRequest.h
//	MyZen
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "ZFUtils.h"
#import "FLCachedObjectOperation.h"
#import "ZFImageSize.h"
#import "FLDownloadImageHttpRequest.H"
#import "FLStorableImage.h"

@interface ZFDownloadImageHttpRequest : FLDownloadImageHttpRequest {
@private
	ZFPhoto* _photo;
	ZFImageSize* _imageSize;
}

- (id) initWithPhoto:(ZFPhoto*) photo imageSize:(ZFImageSize*) imageSize;

+ (ZFDownloadImageHttpRequest*) downloadImageOperation:(ZFPhoto*) photo imageSize:(ZFImageSize*) imageSize;

@end

@interface ZFLoadImageFromCacheOperation : FLCachedObjectOperation<FLCacheObjectOperationSubclass> {
@private
	ZFPhoto* _photo;
	ZFImageSize* _imageSize;
    NSURL* _imageURL;
}

@property (readonly, strong) ZFPhoto* photo;
@property (readonly, strong) ZFImageSize* imageSize;

- (id) initWithPhoto:(ZFPhoto*) photo imageSize:(ZFImageSize*) imageSize;

+ (id) downloadImageOperation:(ZFPhoto*) photo imageSize:(ZFImageSize*) imageSize;

@end