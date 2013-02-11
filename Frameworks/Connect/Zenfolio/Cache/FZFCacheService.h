//
//  FLZenfolioCacheService.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLDatabase.h"
#import "FLFolder.h"
#import "FLImageCacheService.h"

#import "FLZenfolioGroup+More.h"
#import "FLZenfolioPhotoSet+More.h"
#import "FLZenfolioPhoto+More.h"
#import "FLStorableImage+ZenfolioCache.h"
#import "FLImageFolder.h"

@interface FLZenfolioCacheService : FLImageCacheService {
@private
}

+ (id) cacheService;

- (void) deleteGroupElement:(FLZenfolioGroupElement*) groupElement;

- (id) loadPhotoSetWithID:(int) photoSetID;
- (void) savePhotoSet:(FLZenfolioPhotoSet*) photoSet;

- (id) loadGroupWithID:(int) groupID;
- (void) saveGroup:(FLZenfolioGroup*) group;

// photos
- (FLZenfolioPhoto*) loadPhotoWithID:(int) photoId;
- (FLStorableImage*) loadCachedImageForPhoto:(FLZenfolioPhoto*) photo imageSize:(FLZenfolioImageSize*) imageSize;

- (void) savePhoto:(FLZenfolioPhoto*) photo;
- (void) deletePhoto:(FLZenfolioPhoto*) photo;
- (void) deleteCachedImagesForPhoto:(FLZenfolioPhoto*) photo;

- (void) updateObject:(id) object;
- (id) readObject:(id) inputObject;
- (void) deleteObject:(id) object;

@end
    
FLPublishService(cacheService, FLZenfolioCacheService*)
