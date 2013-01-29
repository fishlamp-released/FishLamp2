//
//  FLZfUploadQueue.h
//  ZenBrowser
//
//  Created by Mike Fullerton on 8/11/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLAssetQueue.h"
#import "FLZfUploadGallery.h"
#import "FLImageAsset.h"
#import "FLQueuedAsset.h"
#import "FLZfQueuedPhoto.h"
#import "FLService.h"

extern NSString* const FLZfUploadQueueDidChangeNotification;

@interface FLZfUploadQueue : FLAssetQueue<FLServiceProvider> {
@private
    __unsafe_unretained id _context;
}

+ (id) uploadQueue;

- (void) changeUploadGalleriesTo:(FLZfUploadGallery*) gallery 
                  forMissingOnly:(BOOL) forMissingOnly;

- (BOOL) photosNeedUploadGallery;

- (void) addImageAsset:(id<FLImageAsset>) photo 
             assetType:(FLAssetType) assetType
         uploadGallery:(FLZfUploadGallery*) uploadGalleryOrNil;

- (void) addAssetsFromAssetsBrowser:(NSArray*) assets 
                      uploadGallery:(FLZfUploadGallery*) uploadGalleryOrNil;


- (void) updateItemsToDefaultUploadGalleryIfNeeded;

@end

