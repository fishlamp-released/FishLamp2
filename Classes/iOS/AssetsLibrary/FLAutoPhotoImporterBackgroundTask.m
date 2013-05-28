//
//  FLAutoPhotoImporter.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/28/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAutoPhotoImporterBackgroundTask.h"

#import "FLAssetsLibrary.h"
#import "FLAssetsLibraryImageAsset.h"

#import "FLUserSession.h"
#import "FLViewController.h"

#import "FLOldUserNotificationView.h"
#import "UIDevice+FLExtras.h"

#import "FLAssetsLibraryImageAsset.h"
#import "FLImageAsset.h"

#if 1
#define TRACE DEBUG
#endif

@implementation FLAutoPhotoImporterBackgroundTask

- (FLAssetLibraryAutoPhotoImporter*) createImporter
{
    return FLAutorelease([[FLAssetLibraryAutoPhotoImporter alloc] init]);
}

- (BOOL) shouldImportAssets
{
	return YES;
}

- (void) didFinishImportingAssets:(NSArray*) assets
{
}

- (void) didFailToImportAssets:(NSError*) error
{
}

#define kBuffer 5.0f

- (BOOL) canBeginBackgroundTask:(FLBackgroundTaskMgr *)taskMgr
{
    if(_importer)
    {
        return NO;
    }

    NSTimeInterval lastActivate = [FLApplication instance].lastActivateTime;
    
    if( lastActivate > _lastImportTime)
    {   
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        if((lastActivate + kBuffer) > now)
        {
            [taskMgr scheduleNextBackgroundTaskWithDelay:((lastActivate + kBuffer) - now)];
            return NO;
        }
        else if ([self shouldImportAssets])
        {
            return YES;
        }
        else
        {
            _lastImportTime = lastActivate;
        }
    }
    
    return NO;
}

- (void) cancelBackgroundTask:(FLBackgroundTaskMgr *)taskMgr
{
    if(_importer)
    {
        [_importer cancelImport];
        FLReleaseWithNil(_importer);
    }
}

- (void) resetBackgroundTask:(FLBackgroundTaskMgr*) taskMgr
{
    [self cancelBackgroundTask:taskMgr];
}

- (BOOL) isExecuting
{
    return _importer != nil;
}

- (void) _finishedImporting
{
    if(_importer.error)
    {
        FLLog(@"failed auto-adding assets. error = %@", [_importer.error description]);
    
        [self didFailToImportAssets:_importer.error];
        FLReleaseWithNil(_importer);
    }   
    else
    {
#if TRACE
        FLLog(@"finished auto-adding %d assets.", _importer.importedAssets.count);
#endif
    
        _lastImportTime = [_importer.importedDate timeIntervalSinceReferenceDate];
        [self didFinishImportingAssets:_importer.importedAssets];
        
        FLReleaseWithNil(_importer);
        [[FLBackgroundTaskMgr instance] scheduleNextBackgroundTask];
    }
}

- (void) beginBackgroundTask:(FLBackgroundTaskMgr*) taskMgr  {
#if TRACE
    FLLog(@"Beginning to add photos");
#endif

    FLSetObjectWithRetain(_importer, [self createImporter]);
    [_importer beginImporting:^{
            [self _finishedImporting];
        }];

}

@end

