//
//  FLImageCacheService.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLStorableImage.h"
#import "FLServiceManagingContext.h"

@class FLDatabase;
@class FLImageFolder;

@interface FLImageCacheService : FLService {
@private
    FLDatabase* _cacheDatabase;
    FLImageFolder* _imageCacheFolder;
}

- (void) deleteImage:(FLStorableImage*) image;
- (void) updateImage:(FLStorableImage*) image;

- (FLStorableImage*) readImageWithURLKey:(NSURL*) url;

@end

FLPublishService(imageCacheService, FLImageCacheService*)

//@interface FLServiceManagingContext (FLImageCacheService)
//@property (readwrite, strong) FLImageCacheService* imageCacheService;
//@end
