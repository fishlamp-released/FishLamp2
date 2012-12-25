//
//  FLImageCacheService.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLStorableImage.h"

@class FLDatabase;
@class FLImageFolder;

@interface FLImageCacheService : FLService {
@private
    FLDatabase* cacheDatabase;
    FLImageFolder* imageCacheFolder;
}
@end
