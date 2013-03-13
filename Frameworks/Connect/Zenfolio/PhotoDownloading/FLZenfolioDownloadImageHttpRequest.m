//
//	FLZenfolioDownloadImageHttpRequest.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLImageStoreService.h"

#import "FLStorableImage+ZenfolioCache.h"
#import "FLZenfolioDownloadImageHttpRequest.h"
//#import "FLZenfolioImageDownloadingService.h"
#import "FLZenfolioWebApi.h"

@interface FLZenfolioDownloadImageHttpRequest ()
@property (readwrite, strong, nonatomic) FLZenfolioPhoto* photo;
@property (readwrite, strong, nonatomic) FLZenfolioImageSize* imageSize;
@property (readwrite, strong, nonatomic) FLZenfolioCacheService* cache;
@end

@implementation FLZenfolioDownloadImageHttpRequest

@synthesize photo = _photo;
@synthesize imageSize = _imageSize;
@synthesize cache = _cache;

- (id) initWithPhoto:(FLZenfolioPhoto*) photo 
           imageSize:(FLZenfolioImageSize*) imageSize 
               cache:(FLZenfolioCacheService*) cache {
    
    FLAssertNotNil_(photo);
    FLAssertNotNil_(imageSize);
                                     
	self = [self initWithRequestURL:[photo urlForImageWithSize:imageSize]];
	if(self) {
        self.imageSize = imageSize;
		self.photo = photo;
        self.cache = cache;
	}
	
	return self;
}

+ (FLZenfolioDownloadImageHttpRequest*) downloadImageHttpRequest:(FLZenfolioPhoto*) photo 
                                                     imageSize:(FLZenfolioImageSize*) imageSize
                                                         cache:(FLZenfolioCacheService*) cache {
    return FLAutorelease([[FLZenfolioDownloadImageHttpRequest alloc] initWithPhoto:photo  imageSize:imageSize cache:cache]);
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

- (void) startWorking:(FLFinisher*) finisher {
    
    if(self.cache) {
        FLStorableImage* image = [self.cache loadCachedImageForPhoto:self.photo imageSize:self.imageSize];
        if(image || [image isStaleComparedToPhotoSequenceNumber:self.photo.Sequence]) {
            [super startWorking:finisher];
        }
        else {
            [finisher setFinishedWithResult:image];
        }
    }
    else {
        [super startWorking:finisher];
    }
}

@end

