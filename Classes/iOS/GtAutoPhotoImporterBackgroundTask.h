//
//  GtAutoPhotoImporter.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/28/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtBackgroundTaskMgr.h"
#import "GtAssetQueue.h"
#import "GtAssetLibraryAutoPhotoImporter.h"

@protocol GtAutoPhotoImporterBackgroundTaskDelegate;

@interface GtAutoPhotoImporterBackgroundTask : NSObject<GtBackgroundTask> {
@private
    NSTimeInterval m_lastImportTime;
    GtAssetLibraryAutoPhotoImporter* m_importer;
}

// override points

- (GtAssetLibraryAutoPhotoImporter*) createImporter;

- (BOOL) shouldImportAssets;

- (void) didFinishImportingAssets:(NSArray*) assets;

- (void) didFailToImportAssets:(NSError*) error;
@end

