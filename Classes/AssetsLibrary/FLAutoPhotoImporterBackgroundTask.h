//
//  FLAutoPhotoImporter.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/28/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLBackgroundTaskMgr.h"
#import "FLAssetQueue.h"
#import "FLAssetLibraryAutoPhotoImporter.h"

@protocol FLAutoPhotoImporterBackgroundTaskDelegate;

@interface FLAutoPhotoImporterBackgroundTask : NSObject<FLBackgroundTask> {
@private
    NSTimeInterval _lastImportTime;
    FLAssetLibraryAutoPhotoImporter* _importer;
}

// override points

- (FLAssetLibraryAutoPhotoImporter*) createImporter;

- (BOOL) shouldImportAssets;

- (void) didFinishImportingAssets:(NSArray*) assets;

- (void) didFailToImportAssets:(NSError*) error;
@end

