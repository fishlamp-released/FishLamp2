//
//  ZFUploadQueue.h
//  ZenBrowser
//
//  Created by Mike Fullerton on 8/11/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLAssetQueue.h"
#import "ZFUploadGallery.h"
#import "FLImageAsset.h"
#import "FLQueuedAsset.h"
#import "ZFQueuedPhoto.h"
#import "FLService.h"

extern NSString* const ZFUploadQueueDidChangeNotification;

@interface ZFUploadQueue : FLAssetQueue<FLServiceProvider> {
@private
    __unsafe_unretained id _context;
}

+ (id) uploadQueue;

- (void) changeUploadGalleriesTo:(ZFUploadGallery*) gallery 
                  forMissingOnly:(BOOL) forMissingOnly;

- (BOOL) photosNeedUploadGallery;

- (void) addImageAsset:(id<FLImageAsset>) photo 
             assetType:(FLAssetType) assetType
         uploadGallery:(ZFUploadGallery*) uploadGalleryOrNil;

- (void) addAssetsFromAssetsBrowser:(NSArray*) assets 
                      uploadGallery:(ZFUploadGallery*) uploadGalleryOrNil;


- (void) updateItemsToDefaultUploadGalleryIfNeeded;

@end

