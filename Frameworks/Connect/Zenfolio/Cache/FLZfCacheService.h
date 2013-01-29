//
//  FLZfCacheService.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLDatabase.h"
#import "FLFolder.h"
#import "FLImageCacheService.h"

#import "FLZfGroup+More.h"
#import "FLZfPhotoSet+More.h"
#import "FLZfPhoto+More.h"
#import "FLStorableImage+FLZfCache.h"
#import "FLImageFolder.h"

@interface FLZfCacheService : FLImageCacheService {
@private
}

+ (id) cacheService;

- (void) deleteGroupElement:(FLZfGroupElement*) groupElement;

- (id) loadPhotoSetWithID:(int) photoSetID;
- (void) savePhotoSet:(FLZfPhotoSet*) photoSet;

- (id) loadGroupWithID:(int) groupID;
- (void) saveGroup:(FLZfGroup*) group;

// photos
- (FLZfPhoto*) loadPhotoWithID:(int) photoId;
- (FLStorableImage*) loadCachedImageForPhoto:(FLZfPhoto*) photo imageSize:(FLZfImageSize*) imageSize;

- (void) savePhoto:(FLZfPhoto*) photo;
- (void) deletePhoto:(FLZfPhoto*) photo;
- (void) deleteCachedImagesForPhoto:(FLZfPhoto*) photo;

- (void) updateObject:(id) object;
- (id) readObject:(id) inputObject;
- (void) deleteObject:(id) object;

@end
    
FLPublishService(cacheService, FLZfCacheService*)
