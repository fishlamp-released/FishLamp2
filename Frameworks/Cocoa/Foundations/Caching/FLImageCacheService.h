//
//  FLImageCacheService.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLUserDataStorageService.h"
#import "FLStorableImage.h"

FLDeclareService(imageCacheService, FLImageCacheService);

@interface FLImageCacheService : FLService

@property (readonly, strong) FLDatabase* cacheDatabase;
@property (readonly, strong) FLImageFolder* imageCacheFolder;

- (FLStorableImage*) loadImageForURL:(NSURL*) url;

- (void) deleteImage:(FLStorableImage*) image;
- (void) saveImage:(FLStorableImage*) image;
@end
