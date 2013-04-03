//
//	ZFDownloadImageHttpRequest.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLImageStoreService.h"

#import "FLStorableImage+ZenfolioCache.h"
#import "ZFDownloadImageHttpRequest.h"
//#import "ZFImageDownloadingService.h"
#import "ZFWebApi.h"

@interface ZFDownloadImageHttpRequest ()
@property (readwrite, strong, nonatomic) ZFPhoto* photo;
@property (readwrite, strong, nonatomic) ZFMediaType* imageSize;
@property (readwrite, strong, nonatomic) ZFCacheService* cache;
@end

@implementation ZFDownloadImageHttpRequest

@synthesize photo = _photo;
@synthesize imageSize = _imageSize;
@synthesize cache = _cache;

- (id) initWithPhoto:(ZFPhoto*) photo 
           imageSize:(ZFMediaType*) imageSize 
               cache:(ZFCacheService*) cache {
    
    FLAssertNotNil(photo);
    FLAssertNotNil(imageSize);
                                     
	self = [self initWithRequestURL:[photo urlForImageWithSize:imageSize]];
	if(self) {
        self.imageSize = imageSize;
		self.photo = photo;
        self.cache = cache;
	}
	
	return self;
}

+ (ZFDownloadImageHttpRequest*) downloadImageHttpRequest:(ZFPhoto*) photo 
                                                     imageSize:(ZFMediaType*) imageSize
                                                         cache:(ZFCacheService*) cache {
    return FLAutorelease([[ZFDownloadImageHttpRequest alloc] initWithPhoto:photo  imageSize:imageSize cache:cache]);
}

#if FL_MRC
- (void) dealloc {
    [_cache release];
    [_photo release];
    [_imageSize release];
    [super dealloc];
}
#endif

- (FLResult) resultFromHttpResponse:(FLHttpResponse*) httpResponse {
    FLStorableImage* image = [super resultFromHttpResponse:httpResponse];
    
    image.imageProperties.imageVersion = self.photo.Sequence;
    
    if(self.cache) {
        [self.cache writeObject:image];
    }
    
    return image;
}

- (void) performUntilFinished:(FLFinisher*) finisher {
    
    if(self.cache) {
        FLStorableImage* image = [self.cache loadCachedImageForPhoto:self.photo imageSize:self.imageSize];
        if(image || [image isStaleComparedToPhotoSequenceNumber:self.photo.Sequence]) {
            [super performUntilFinished:finisher];
        }
        else {
            [finisher setFinishedWithResult:image];
        }
    }
    else {
        [super performUntilFinished:finisher];
    }
}

@end

