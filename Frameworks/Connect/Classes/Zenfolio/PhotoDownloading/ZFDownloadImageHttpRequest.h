//
//	ZFDownloadImageHttpRequest.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//


#import "FLCachedObjectOperation.h"
#import "ZFMediaType.h"
#import "FLDownloadImageHttpRequest.h"
#import "FLStorableImage.h"
#import "ZFCacheService.h"

@interface ZFDownloadImageHttpRequest : FLDownloadImageHttpRequest {
@private
	ZFPhoto* _photo;
	ZFMediaType* _imageSize;
    ZFCacheService* _cache;
}

- (id) initWithPhoto:(ZFPhoto*) photo 
           imageSize:(ZFMediaType*) imageSize 
               cache:(ZFCacheService*) cache;

+ (ZFDownloadImageHttpRequest*) downloadImageHttpRequest:(ZFPhoto*) photo 
                                                     imageSize:(ZFMediaType*) imageSize
                                                         cache:(ZFCacheService*) cache;

// NOTE: successful result returns a FLStorableImage.

@end

