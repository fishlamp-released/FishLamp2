//
//  ZFCacheService.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLDatabase.h"
#import "FLFolder.h"
#import "FLImageCacheService.h"

#import "ZFStorageService.h"

#import "ZFGroup+More.h"
#import "ZFPhotoSet+More.h"
#import "ZFPhoto+More.h"
#import "FLStorableImage+ZFCache.h"
#import "FLImageFolder.h"

@interface ZFCacheService : FLImageCacheService {
@private
}

+ (id) cacheService;

- (void) deleteGroupElement:(ZFGroupElement*) groupElement;

- (id) loadPhotoSetWithID:(int) photoSetID;
- (void) savePhotoSet:(ZFPhotoSet*) photoSet;

- (id) loadGroupWithID:(int) groupID;
- (void) saveGroup:(ZFGroup*) group;

// photos
- (ZFPhoto*) loadPhotoWithID:(int) photoId;
- (FLStorableImage*) loadCachedImageForPhoto:(ZFPhoto*) photo imageSize:(ZFImageSize*) imageSize;

- (void) savePhoto:(ZFPhoto*) photo;
- (void) deletePhoto:(ZFPhoto*) photo;
- (void) deleteCachedImagesForPhoto:(ZFPhoto*) photo;

- (void) updateObject:(id) object;
- (id) readObject:(id) inputObject;
- (void) deleteObject:(id) object;

@end
    
FLPublishService(cacheService, ZFCacheService*)
