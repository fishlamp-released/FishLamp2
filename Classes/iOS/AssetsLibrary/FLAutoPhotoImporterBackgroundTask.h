//
//  FLAutoPhotoImporter.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/28/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

