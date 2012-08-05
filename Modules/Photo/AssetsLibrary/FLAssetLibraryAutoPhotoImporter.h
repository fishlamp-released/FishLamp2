//
//  FLAssetLibraryAutoPhotoImporter.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAssetQueue.h"
#import "FLImageAsset.h"
#import "FLQueuedAsset.h"

@protocol FLAssetLibraryAutoPhotoImporterDelegate;

@interface FLAssetLibraryAutoPhotoImporter : NSObject {
@private
    id<FLAssetLibraryAutoPhotoImporterDelegate> m_delegate;
    FLAssetQueue* m_assetQueue;
    NSDate* m_startDate;
    NSError* m_error;
    NSMutableArray* m_importedAssets;
    NSDate* m_importedDate;

    BOOL m_cancelled;
}

@property (readwrite, assign, nonatomic) id<FLAssetLibraryAutoPhotoImporterDelegate> delegate;

@property (readonly, retain, nonatomic) NSError* error;
@property (readonly, retain, nonatomic) NSArray* importedAssets;
@property (readonly, retain, nonatomic) NSDate* importedDate;

- (void) cancelImport;

- (void) beginImporting:(FLEventCallback) completedBlock;
    
@end

@protocol FLAssetLibraryAutoPhotoImporterDelegate <NSObject>

- (FLQueuedAsset*) assetLibraryAutoPhotoImporter:(FLAssetLibraryAutoPhotoImporter*) importer 
                  createQueuedAssetForImageAsset:(id<FLImageAsset>) imageAsset 
                                       assetType:(FLAssetType) assetType;

- (NSDate*) assetLibraryAutoPhotoImporterGetLastImportDate:(FLAssetLibraryAutoPhotoImporter*) importer;

- (void) assetLibraryAutoPhotoImporter:(FLAssetLibraryAutoPhotoImporter*) importer saveLastImportDate:(NSDate*) date;

- (FLAssetQueue*) assetLibraryAutoPhotoImporterGetAssetQueue:(FLAssetLibraryAutoPhotoImporter*) importer;

- (BOOL) assetLibraryAutoPhotoImporter:(FLAssetLibraryAutoPhotoImporter*) importer shouldImportAsset:(ALAsset*) asset;

@end