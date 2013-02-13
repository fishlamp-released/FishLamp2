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
#import "FLZenfolioCache.h"

@interface FLZenfolioDownloadImageHttpRequest : FLDownloadImageHttpRequest {
@private
	FLZenfolioPhoto* _photo;
	FLZenfolioImageSize* _imageSize;
    FLZenfolioCache* _cache;
}

- (id) initWithPhoto:(FLZenfolioPhoto*) photo 
           imageSize:(FLZenfolioImageSize*) imageSize 
               cache:(FLZenfolioCache*) cache;

+ (FLZenfolioDownloadImageHttpRequest*) downloadImageOperation:(FLZenfolioPhoto*) photo 
                                                     imageSize:(FLZenfolioImageSize*) imageSize
                                                         cache:(FLZenfolioCache*) cache;

// NOTE: successful result returns a FLStorableImage.

@end

