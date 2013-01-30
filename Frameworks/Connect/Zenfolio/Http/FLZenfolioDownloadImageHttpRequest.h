//
//	FLZenfolioDownloadImageHttpRequest.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioUtils.h"
#import "FLCachedObjectOperation.h"
#import "FLZenfolioImageSize.h"
#import "FLDownloadImageHttpRequest.H"
#import "FLStorableImage.h"

@interface FLZenfolioDownloadImageHttpRequest : FLDownloadImageHttpRequest {
@private
	FLZenfolioPhoto* _photo;
	FLZenfolioImageSize* _imageSize;
}

- (id) initWithPhoto:(FLZenfolioPhoto*) photo imageSize:(FLZenfolioImageSize*) imageSize;

+ (FLZenfolioDownloadImageHttpRequest*) downloadImageOperation:(FLZenfolioPhoto*) photo imageSize:(FLZenfolioImageSize*) imageSize;

@end

@interface FLZenfolioLoadImageFromCacheOperation : FLCachedObjectOperation<FLCacheObjectOperationSubclass> {
@private
	FLZenfolioPhoto* _photo;
	FLZenfolioImageSize* _imageSize;
    NSURL* _imageURL;
}

@property (readonly, strong) FLZenfolioPhoto* photo;
@property (readonly, strong) FLZenfolioImageSize* imageSize;

- (id) initWithPhoto:(FLZenfolioPhoto*) photo imageSize:(FLZenfolioImageSize*) imageSize;

+ (id) downloadImageOperation:(FLZenfolioPhoto*) photo imageSize:(FLZenfolioImageSize*) imageSize;

@end