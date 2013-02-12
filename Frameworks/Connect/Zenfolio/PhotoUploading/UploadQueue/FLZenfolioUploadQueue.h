//
//  FLZenfolioUploadQueue.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/11/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLAssetQueue.h"
#import "FLZenfolioUploadGallery.h"
#import "FLImageAsset.h"
#import "FLQueuedAsset.h"
#import "FLZenfolioQueuedPhoto.h"

extern NSString* const FLZenfolioUploadQueueDidChangeNotification;

@protocol FLZenfolioUploadQueueDelegate;

@interface FLZenfolioUploadQueue : FLAssetQueue {
@private
    __unsafe_unretained id<FLZenfolioUploadQueueDelegate> _delegate;
}

@property (readwrite, assign) id<FLZenfolioUploadQueueDelegate> delegate;

+ (id) uploadQueue;

- (void) changeUploadGalleriesTo:(FLZenfolioUploadGallery*) gallery 
                  forMissingOnly:(BOOL) forMissingOnly;

- (BOOL) photosNeedUploadGallery;

- (void) addImageAsset:(id<FLImageAsset>) photo 
             assetType:(FLAssetType) assetType
         uploadGallery:(FLZenfolioUploadGallery*) uploadGalleryOrNil;

- (void) addAssetsFromAssetsBrowser:(NSArray*) assets 
                      uploadGallery:(FLZenfolioUploadGallery*) uploadGalleryOrNil;

- (void) updateItemsToDefaultUploadGalleryIfNeeded;

@end

@protocol FLZenfolioUploadQueueDelegate <NSObject>
- (NSNumber*) defaultUploadSize;
- (NSNumber*) scaledUploadSize;
- (NSNumber*) saveToDeviceBeforeUpload;
- (FLZenfolioUploadGallery*) defaultUploadGallery;
- (FLZenfolioAccessDescriptor*) defaultAccessDescriptor;
@end
