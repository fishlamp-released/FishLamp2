//
//  FLZenfolioCacheService.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLObjectStorage.h"
#import "FLImageStoreService.h"
#import "FLZenfolioImageSize.h"

//#import "FLZenfolioGroup+More.h"
//#import "FLZenfolioPhotoSet+More.h"
//#import "FLZenfolioPhoto+More.h"
//#import "FLStorableImage+ZenfolioCache.h"
//#import "FLImageFolder.h"

@class FLZenfolioPhoto;
@class FLZenfolioGroup;
@class FLZenfolioPhotoSet;
@class FLZenfolioGroupElement;

@protocol FLZenfolioDataStorage;

@interface FLZenfolioCacheService : FLImageStoreService<FLObjectStorage> {
@private
    
}

+ (id) cacheService;

// helpers
- (id) loadPhotoSetWithID:(int) photoSetID;
- (id) loadGroupWithID:(int) groupID;
- (id) loadPhotoWithID:(int) photoId;

// photo utils
- (FLStorableImage*) loadCachedImageForPhoto:(FLZenfolioPhoto*) photo 
                                   imageSize:(FLZenfolioImageSize*) imageSize;

- (void) deleteCachedImagesForPhoto:(FLZenfolioPhoto*) photo;


@end
    
@interface FLZenfolioCacheOpener <NSObject>
- (void) openZenfolioCache:(FLZenfolioCacheService*) cache;
- (void) closeZenfolioCache:(FLZenfolioCacheService*) cache;
@end