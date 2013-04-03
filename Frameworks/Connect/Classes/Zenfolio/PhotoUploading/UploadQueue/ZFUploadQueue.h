//
//  ZFUploadQueue.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/11/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//
#if REFACTOR

#import "FLAssetQueue.h"
#import "ZFUploadGallery.h"
#import "FLImageAsset.h"
#import "FLQueuedAsset.h"
#import "ZFQueuedPhoto.h"

extern NSString* const ZFUploadQueueDidChangeNotification;

@protocol ZFUploadQueueDelegate;

@interface ZFUploadQueue : FLAssetQueue {
@private
    __unsafe_unretained id<ZFUploadQueueDelegate> _delegate;
}

@property (readwrite, assign) id<ZFUploadQueueDelegate> delegate;

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

@protocol ZFUploadQueueDelegate <NSObject>
- (NSNumber*) defaultUploadSize;
- (NSNumber*) scaledUploadSize;
- (NSNumber*) saveToDeviceBeforeUpload;
- (ZFUploadGallery*) defaultUploadGallery;
- (ZFAccessDescriptor*) defaultAccessDescriptor;
@end

#endif