//
//	FLZenfolioDownloadImageHttpRequest.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//


#import "FLCachedObjectOperation.h"
#import "FLZenfolioImageSize.h"
#import "FLDownloadImageHttpRequest.h"
#import "FLStorableImage.h"
#import "FLZenfolioCacheService.h"

@interface FLZenfolioDownloadImageHttpRequest : FLDownloadImageHttpRequest {
@private
	FLZenfolioPhoto* _photo;
	FLZenfolioImageSize* _imageSize;
    FLZenfolioCacheService* _cache;
}

- (id) initWithPhoto:(FLZenfolioPhoto*) photo 
           imageSize:(FLZenfolioImageSize*) imageSize 
               cache:(FLZenfolioCacheService*) cache;

+ (FLZenfolioDownloadImageHttpRequest*) downloadImageHttpRequest:(FLZenfolioPhoto*) photo 
                                                     imageSize:(FLZenfolioImageSize*) imageSize
                                                         cache:(FLZenfolioCacheService*) cache;

// NOTE: successful result returns a FLStorableImage.

@end

