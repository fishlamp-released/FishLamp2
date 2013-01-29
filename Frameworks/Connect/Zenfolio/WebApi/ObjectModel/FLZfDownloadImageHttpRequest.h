//
//	FLZfDownloadImageHttpRequest.h
//	MyZen
//
//	Created by Mike Fullerton on 10/3/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZfUtils.h"
#import "FLCachedObjectOperation.h"
#import "FLZfImageSize.h"
#import "FLDownloadImageHttpRequest.H"
#import "FLStorableImage.h"

@interface FLZfDownloadImageHttpRequest : FLDownloadImageHttpRequest {
@private
	FLZfPhoto* _photo;
	FLZfImageSize* _imageSize;
}

- (id) initWithPhoto:(FLZfPhoto*) photo imageSize:(FLZfImageSize*) imageSize;

+ (FLZfDownloadImageHttpRequest*) downloadImageOperation:(FLZfPhoto*) photo imageSize:(FLZfImageSize*) imageSize;

@end

@interface FLZfLoadImageFromCacheOperation : FLCachedObjectOperation<FLCacheObjectOperationSubclass> {
@private
	FLZfPhoto* _photo;
	FLZfImageSize* _imageSize;
    NSURL* _imageURL;
}

@property (readonly, strong) FLZfPhoto* photo;
@property (readonly, strong) FLZfImageSize* imageSize;

- (id) initWithPhoto:(FLZfPhoto*) photo imageSize:(FLZfImageSize*) imageSize;

+ (id) downloadImageOperation:(FLZfPhoto*) photo imageSize:(FLZfImageSize*) imageSize;

@end