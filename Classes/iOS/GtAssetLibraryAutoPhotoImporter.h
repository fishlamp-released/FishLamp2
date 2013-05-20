//
//  GtAssetLibraryAutoPhotoImporter.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtAssetQueue.h"
#import "GtImageAsset.h"
#import "GtQueuedAsset.h"

@protocol GtAssetLibraryAutoPhotoImporterDelegate;

@interface GtAssetLibraryAutoPhotoImporter : NSObject {
@private
    id<GtAssetLibraryAutoPhotoImporterDelegate> m_delegate;
    GtAssetQueue* m_assetQueue;
    NSDate* m_startDate;
    NSError* m_error;
    NSMutableArray* m_importedAssets;
    NSDate* m_importedDate;

    BOOL m_cancelled;
}

@property (readwrite, assign, nonatomic) id<GtAssetLibraryAutoPhotoImporterDelegate> delegate;

@property (readonly, retain, nonatomic) NSError* error;
@property (readonly, retain, nonatomic) NSArray* importedAssets;
@property (readonly, retain, nonatomic) NSDate* importedDate;

- (void) cancelImport;

- (void) beginImporting:(GtBlock) completedBlock;
    
@end

@protocol GtAssetLibraryAutoPhotoImporterDelegate <NSObject>

- (GtQueuedAsset*) assetLibraryAutoPhotoImporter:(GtAssetLibraryAutoPhotoImporter*) importer 
                  createQueuedAssetForImageAsset:(id<GtImageAsset>) imageAsset 
                                       assetType:(GtAssetType) assetType;

- (NSDate*) assetLibraryAutoPhotoImporterGetLastImportDate:(GtAssetLibraryAutoPhotoImporter*) importer;

- (void) assetLibraryAutoPhotoImporter:(GtAssetLibraryAutoPhotoImporter*) importer saveLastImportDate:(NSDate*) date;

- (GtAssetQueue*) assetLibraryAutoPhotoImporterGetAssetQueue:(GtAssetLibraryAutoPhotoImporter*) importer;

- (BOOL) assetLibraryAutoPhotoImporter:(GtAssetLibraryAutoPhotoImporter*) importer shouldImportAsset:(ALAsset*) asset;

@end