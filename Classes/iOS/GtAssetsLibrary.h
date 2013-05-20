    //
    //	GtAssetsLibrary.h
    //	FishLamp
    //
    //	Created by Mike Fullerton on 7/22/10.
    //	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
    //

#import <Foundation/Foundation.h>

#define GtAssetsLibraryErrorDomain @"GtAssetsLibraryErrorDomain"

typedef enum {
    GtAssetsLibraryErrorNone,
    GtAssetsLibraryErrorPermissionDenied
} GtAssetsLibraryErrorCode;


typedef void (^GtLoadedAssetsBlock)(NSArray* assets, NSError* error);

typedef BOOL (^GtShouldCancelBlock)();

typedef void (^GtAssetBlock)(ALAsset* asset);

typedef enum {
	GtAssetsLibraryFilterNone,
	GtAssetsLibraryFilterPhotosOnly,
	GtAssetsLibraryFilterVideoOnly
} GtAssetsLibraryFilter;

@interface GtAssetsLibrary : ALAssetsLibrary<CLLocationManagerDelegate> {
@private
    
}

GtSingletonProperty(GtAssetsLibrary);

// load groups

- (void) beginLoadingGroups:(GtLoadedAssetsBlock) doneBlock  
               shouldCancel:(GtShouldCancelBlock) shouldCancel;

- (void) beginLoadingGroupOfGroupType:(ALAssetsGroupType) groupType 
                            doneBlock:(GtLoadedAssetsBlock) doneBlock 
                         shouldCancel:(GtShouldCancelBlock) shouldCancel;


// load assets
- (void) beginLoadingAssetsForGroup:(ALAssetsGroup*) group 
                        assetFilter:(GtAssetsLibraryFilter) assetFilter
                          doneBlock:(GtErrorCallback) doneBlock  
                       shouldCancel:(GtShouldCancelBlock) shouldCancel
                        loadedAsset:(GtAssetBlock) loadedAsset;

- (void) beginLoadingAssetsForGroupType:(ALAssetsGroupType) groupType  
                            assetFilter:(GtAssetsLibraryFilter) assetFilter
                              doneBlock:(GtErrorCallback) doneBlock  
                           shouldCancel:(GtShouldCancelBlock) shouldCancel
                            loadedAsset:(GtAssetBlock) loadedAsset;

- (void) beginLoadingAssetsForGroups:(NSArray*) groups
                         assetFilter:(GtAssetsLibraryFilter) assetFilter
                           doneBlock:(GtErrorCallback) doneBlock
                        shouldCancel:(GtShouldCancelBlock) shouldCancel
                         loadedAsset:(GtAssetBlock) loadedAsset;

// load assets, returns array with GtAssets


- (void) beginLoadingAssetsForGroups:(NSArray*) groups 
                         assetFilter:(GtAssetsLibraryFilter) assetFilter
                           doneBlock:(GtLoadedAssetsBlock) doneBlock  
                        shouldCancel:(GtShouldCancelBlock) shouldCancel;

- (void) beginLoadingAssetsForGroupType:(ALAssetsGroupType) groupType 
                            assetFilter:(GtAssetsLibraryFilter) assetFilter
                              doneBlock:(GtLoadedAssetsBlock) doneBlock  
                           shouldCancel:(GtShouldCancelBlock) shouldCancel;

- (void) beginLoadingAssetsForGroup:(ALAssetsGroup*) group
                        assetFilter:(GtAssetsLibraryFilter) assetFilter
                          doneBlock:(GtLoadedAssetsBlock) doneBlock  
                       shouldCancel:(GtShouldCancelBlock) shouldCancel;

- (void) beginLoadingAssets:(GtAssetsLibraryFilter) assetFilter
                  doneBlock:(GtLoadedAssetsBlock) doneBlock  
               shouldCancel:(GtShouldCancelBlock) shouldCancel;

- (BOOL) locationServicesAreAuthorized;

@end
