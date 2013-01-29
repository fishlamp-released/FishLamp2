//
//	ZFDownloadImageHttpRequest.m
//	MyZen
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLImageCacheService.h"

#import "FLStorableImage+ZFCache.h"
#import "ZFDownloadImageHttpRequest.h"
#import "ZFImageDownloadingService.h"

@interface ZFDownloadImageHttpRequest ()
@property (readwrite, strong) ZFPhoto* photo;
@property (readwrite, strong) ZFImageSize* imageSize;
@end

@implementation ZFDownloadImageHttpRequest

@synthesize photo = _photo;
@synthesize imageSize = _imageSize;

- (id) initWithPhoto:(ZFPhoto*) photo imageSize:(ZFImageSize*) imageSize {
	self = [self initWithRequestURL:[_photo urlForImageWithSize:_imageSize]];
	if(self) {
        self.imageSize = imageSize;
		self.photo = photo;
	}
	
	return self;
}

+ (ZFDownloadImageHttpRequest*) downloadImageOperation:(ZFPhoto*) photo  imageSize:(ZFImageSize*) imageSize{
    return FLAutorelease([[ZFDownloadImageHttpRequest alloc] initWithPhoto:photo  imageSize:imageSize]);
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

@interface ZFLoadImageFromCacheOperation ()

@property (readwrite, strong) ZFPhoto* photo;
@property (readwrite, strong) ZFImageSize* imageSize;
@property (readwrite, strong) NSURL* imageURL;
@end

@implementation ZFLoadImageFromCacheOperation

@synthesize photo = _photo;
@synthesize imageSize = _imageSize;
@synthesize imageURL = _imageURL;

- (id) initWithPhoto:(ZFPhoto*) photo imageSize:(ZFImageSize*) imageSize {
	
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
    
    ZFDownloadImageHttpRequest* request = 
        [ZFDownloadImageHttpRequest downloadImageOperation:self.photo imageSize:self.imageSize];
    
    return [request sendSynchronouslyInContext:self.context];
}

+ (id) downloadImageOperation:(ZFPhoto*) photo  imageSize:(ZFImageSize*) imageSize {
    return FLAutorelease([[ZFLoadImageFromCacheOperation alloc] initWithPhoto:photo  imageSize:imageSize]);
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