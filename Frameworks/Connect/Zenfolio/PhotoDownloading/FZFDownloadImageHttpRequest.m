//
//	FLZenfolioDownloadImageHttpRequest.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLImageCacheService.h"

#import "FLStorableImage+ZenfolioCache.h"
#import "FLZenfolioDownloadImageHttpRequest.h"
//#import "FLZenfolioImageDownloadingService.h"

@interface FLZenfolioDownloadImageHttpRequest ()
@property (readwrite, strong) FLZenfolioPhoto* photo;
@property (readwrite, strong) FLZenfolioImageSize* imageSize;
@end

@implementation FLZenfolioDownloadImageHttpRequest

@synthesize photo = _photo;
@synthesize imageSize = _imageSize;

- (id) initWithPhoto:(FLZenfolioPhoto*) photo imageSize:(FLZenfolioImageSize*) imageSize {
	self = [self initWithRequestURL:[_photo urlForImageWithSize:_imageSize]];
	if(self) {
        self.imageSize = imageSize;
		self.photo = photo;
	}
	
	return self;
}

+ (FLZenfolioDownloadImageHttpRequest*) downloadImageOperation:(FLZenfolioPhoto*) photo  imageSize:(FLZenfolioImageSize*) imageSize{
    return FLAutorelease([[FLZenfolioDownloadImageHttpRequest alloc] initWithPhoto:photo  imageSize:imageSize]);
}

#if FL_MRC
- (void) dealloc {
    [_photo release];
    [_imageSize release];
    [super dealloc];
}
#endif

- (id) didReceiveHttpResponse:(FLHttpResponse*) httpResponse {
    FLStorableImage* image = [super didReceiveHttpResponse:httpResponse];
    image.imageProperties.imageVersion = self.photo.Sequence;
    return image;
}

@end

@interface FLZenfolioLoadImageFromCacheOperation ()

@property (readwrite, strong) FLZenfolioPhoto* photo;
@property (readwrite, strong) FLZenfolioImageSize* imageSize;
@property (readwrite, strong) NSURL* imageURL;
@end

@implementation FLZenfolioLoadImageFromCacheOperation

@synthesize photo = _photo;
@synthesize imageSize = _imageSize;
@synthesize imageURL = _imageURL;

- (id) initWithPhoto:(FLZenfolioPhoto*) photo imageSize:(FLZenfolioImageSize*) imageSize {
	
    self = [super init];
	if(self) {
        self.imageSize = imageSize;
		self.photo = photo;
        self.imageURL = [photo urlForImageWithSize:imageSize];
    }
	
	return self;
}

- (id) loadObjectFromDatabase {
    FLStorableImage* image = [[self.context imageCacheService] readImageWithURLKey:self.imageURL];
    if(image) {
        self.alwaysRunSubOperations = image && [image isStaleComparedToPhotoSequenceNumber:self.photo.Sequence];
    }
   
    return image;
}

- (void) saveObjectToDatabase:(id) object {
    [[self.context imageCacheService] updateImage:object];
}

- (FLResult) runSubOperations {
    
    FLZenfolioDownloadImageHttpRequest* request = 
        [FLZenfolioDownloadImageHttpRequest downloadImageOperation:self.photo imageSize:self.imageSize];
    
    return [request sendSynchronouslyInContext:self.context];
}

+ (id) downloadImageOperation:(FLZenfolioPhoto*) photo  imageSize:(FLZenfolioImageSize*) imageSize {
    return FLAutorelease([[FLZenfolioLoadImageFromCacheOperation alloc] initWithPhoto:photo  imageSize:imageSize]);
}

#if FL_MRC
- (void) dealloc {
    [_imageURL release];
    [_photo release];
    [_imageSize release];
    [super dealloc];
}
#endif

@end