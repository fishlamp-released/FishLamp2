//
//	FLZfDownloadImageHttpRequest.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLImageCacheService.h"

#import "FLStorableImage+ZfCache.h"
#import "FLZfDownloadImageHttpRequest.h"
#import "FLZfImageDownloadingService.h"

@interface FLZfDownloadImageHttpRequest ()
@property (readwrite, strong) FLZfPhoto* photo;
@property (readwrite, strong) FLZfImageSize* imageSize;
@end

@implementation FLZfDownloadImageHttpRequest

@synthesize photo = _photo;
@synthesize imageSize = _imageSize;

- (id) initWithPhoto:(FLZfPhoto*) photo imageSize:(FLZfImageSize*) imageSize {
	self = [self initWithRequestURL:[_photo urlForImageWithSize:_imageSize]];
	if(self) {
        self.imageSize = imageSize;
		self.photo = photo;
	}
	
	return self;
}

+ (FLZfDownloadImageHttpRequest*) downloadImageOperation:(FLZfPhoto*) photo  imageSize:(FLZfImageSize*) imageSize{
    return FLAutorelease([[FLZfDownloadImageHttpRequest alloc] initWithPhoto:photo  imageSize:imageSize]);
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

@interface FLZfLoadImageFromCacheOperation ()

@property (readwrite, strong) FLZfPhoto* photo;
@property (readwrite, strong) FLZfImageSize* imageSize;
@property (readwrite, strong) NSURL* imageURL;
@end

@implementation FLZfLoadImageFromCacheOperation

@synthesize photo = _photo;
@synthesize imageSize = _imageSize;
@synthesize imageURL = _imageURL;

- (id) initWithPhoto:(FLZfPhoto*) photo imageSize:(FLZfImageSize*) imageSize {
	
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
    
    FLZfDownloadImageHttpRequest* request = 
        [FLZfDownloadImageHttpRequest downloadImageOperation:self.photo imageSize:self.imageSize];
    
    return [request sendSynchronouslyInContext:self.context];
}

+ (id) downloadImageOperation:(FLZfPhoto*) photo  imageSize:(FLZfImageSize*) imageSize {
    return FLAutorelease([[FLZfLoadImageFromCacheOperation alloc] initWithPhoto:photo  imageSize:imageSize]);
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