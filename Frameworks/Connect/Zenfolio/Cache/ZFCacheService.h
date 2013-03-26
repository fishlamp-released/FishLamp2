//
//  ZFCacheService.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLObjectStorage.h"
#import "FLImageStoreService.h"
#import "ZFMediaType.h"

//#import "ZFGroup+More.h"
//#import "ZFPhotoSet+More.h"
//#import "ZFPhoto+More.h"
//#import "FLStorableImage+ZenfolioCache.h"
//#import "FLImageFolder.h"

@class ZFPhoto;
@class ZFGroup;
@class ZFPhotoSet;
@class ZFGroupElement;

@protocol ZFDataStorage;

@interface ZFCacheService : FLImageStoreService<FLObjectStorage> {
@private
    
}

+ (id) cacheService;

// helpers
- (id) loadPhotoSetWithID:(int) photoSetID;
- (id) loadGroupWithID:(int) groupID;
- (id) loadPhotoWithID:(int) photoId;

// photo utils
- (FLStorableImage*) loadCachedImageForPhoto:(ZFPhoto*) photo 
                                   imageSize:(ZFMediaType*) imageSize;

- (void) deleteCachedImagesForPhoto:(ZFPhoto*) photo;


@end
    
@interface ZFCacheOpener <NSObject>
- (void) openZenfolioCache:(ZFCacheService*) cache;
- (void) closeZenfolioCache:(ZFCacheService*) cache;
@end