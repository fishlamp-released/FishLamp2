//
//  FLImageCacheService.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLUserDataStorageService.h"

service_declare_(imageCacheService, FLImageCacheService);

@interface FLImageCacheService : FLService

@property (readonly, strong) FLDatabase* cacheDatabase;
@property (readonly, strong) FLImageFolder* imageCacheFolder;

- (FLImage*) loadImageForURL:(NSURL*) url;

- (void) deleteImage:(FLImage*) image;
- (void) saveImage:(FLImage*) image;
@end
