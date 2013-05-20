    //
    //	FLAssetsLibrary.h
    //	FishLamp
    //
    //	Created by Mike Fullerton on 7/22/10.
    //	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
    //

#import <Foundation/Foundation.h>

#define FLAssetsLibraryErrorDomain @"FLAssetsLibraryErrorDomain"

typedef enum {
    FLAssetsLibraryErrorNone,
    FLAssetsLibraryErrorPermissionDenied
} FLAssetsLibraryErrorCode;


typedef void (^FLLoadedAssetsBlock)(NSArray* assets, NSError* error);

typedef BOOL (^FLShouldCancelBlock)();

typedef void (^FLAssetBlock)(ALAsset* asset);

typedef enum {
	FLAssetsLibraryFilterNone,
	FLAssetsLibraryFilterPhotosOnly,
	FLAssetsLibraryFilterVideoOnly
} FLAssetsLibraryFilter;

@interface FLAssetsLibrary : ALAssetsLibrary<CLLocationManagerDelegate> {
@private
    
}

FLSingletonProperty(FLAssetsLibrary);

// load groups

- (void) beginLoadingGroups:(FLLoadedAssetsBlock) doneBlock  
               shouldCancel:(FLShouldCancelBlock) shouldCancel;

- (void) beginLoadingGroupOfGroupType:(ALAssetsGroupType) groupType 
                            doneBlock:(FLLoadedAssetsBlock) doneBlock 
                         shouldCancel:(FLShouldCancelBlock) shouldCancel;


// load assets
- (void) beginLoadingAssetsForGroup:(ALAssetsGroup*) group 
                        assetFilter:(FLAssetsLibraryFilter) assetFilter
                          doneBlock:(FLErrorCallback) doneBlock  
                       shouldCancel:(FLShouldCancelBlock) shouldCancel
                        loadedAsset:(FLAssetBlock) loadedAsset;

- (void) beginLoadingAssetsForGroupType:(ALAssetsGroupType) groupType  
                            assetFilter:(FLAssetsLibraryFilter) assetFilter
                              doneBlock:(FLErrorCallback) doneBlock  
                           shouldCancel:(FLShouldCancelBlock) shouldCancel
                            loadedAsset:(FLAssetBlock) loadedAsset;

- (void) beginLoadingAssetsForGroups:(NSArray*) groups
                         assetFilter:(FLAssetsLibraryFilter) assetFilter
                           doneBlock:(FLErrorCallback) doneBlock
                        shouldCancel:(FLShouldCancelBlock) shouldCancel
                         loadedAsset:(FLAssetBlock) loadedAsset;

// load assets, returns array with FLAssets


- (void) beginLoadingAssetsForGroups:(NSArray*) groups 
                         assetFilter:(FLAssetsLibraryFilter) assetFilter
                           doneBlock:(FLLoadedAssetsBlock) doneBlock  
                        shouldCancel:(FLShouldCancelBlock) shouldCancel;

- (void) beginLoadingAssetsForGroupType:(ALAssetsGroupType) groupType 
                            assetFilter:(FLAssetsLibraryFilter) assetFilter
                              doneBlock:(FLLoadedAssetsBlock) doneBlock  
                           shouldCancel:(FLShouldCancelBlock) shouldCancel;

- (void) beginLoadingAssetsForGroup:(ALAssetsGroup*) group
                        assetFilter:(FLAssetsLibraryFilter) assetFilter
                          doneBlock:(FLLoadedAssetsBlock) doneBlock  
                       shouldCancel:(FLShouldCancelBlock) shouldCancel;

- (void) beginLoadingAssets:(FLAssetsLibraryFilter) assetFilter
                  doneBlock:(FLLoadedAssetsBlock) doneBlock  
               shouldCancel:(FLShouldCancelBlock) shouldCancel;

- (BOOL) locationServicesAreAuthorized;

@end
