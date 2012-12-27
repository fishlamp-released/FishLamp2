//
//  FLImageCacheService.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLStorableImage.h"
#import "FLSession.h"

@class FLDatabase;
@class FLImageFolder;

@interface FLImageCacheService : FLService {
@private
    FLDatabase* cacheDatabase;
    FLImageFolder* imageCacheFolder;
}

- (void) deleteImage:(FLStorableImage*) image;
- (void) updateImage:(FLStorableImage*) image;

- (FLStorableImage*) readImageWithURLKey:(NSURL*) url;

@end

@interface FLSession (FLImageCacheService)
@property (readwrite, strong) FLImageCacheService* imageCacheService;
@end
