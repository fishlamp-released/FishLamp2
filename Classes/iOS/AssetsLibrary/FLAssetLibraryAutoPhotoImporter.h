//
//  FLAssetLibraryAutoPhotoImporter.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLAssetQueue.h"
#import "FLImageAsset.h"
#import "FLQueuedAsset.h"

@protocol FLAssetLibraryAutoPhotoImporterDelegate;

@interface FLAssetLibraryAutoPhotoImporter : NSObject {
@private
    __unsafe_unretained id<FLAssetLibraryAutoPhotoImporterDelegate> _delegate;
    FLAssetQueue* _assetQueue;
    NSDate* _startDate;
    NSError* _error;
    NSMutableArray* _importedAssets;
    NSDate* _importedDate;

    BOOL _cancelled;
}

@property (readwrite, assign, nonatomic) id<FLAssetLibraryAutoPhotoImporterDelegate> delegate;

@property (readonly, retain, nonatomic) NSError* error;
@property (readonly, retain, nonatomic) NSArray* importedAssets;
@property (readonly, retain, nonatomic) NSDate* importedDate;

- (void) cancelImport;

- (void) beginImporting:(dispatch_block_t) completedBlock;
    
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