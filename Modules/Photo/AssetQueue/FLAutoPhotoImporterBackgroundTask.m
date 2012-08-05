//
//  FLAutoPhotoImporter.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/28/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
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
    return FLReturnAutoreleased([[FLAssetLibraryAutoPhotoImporter alloc] init]);
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
    if(m_importer)
    {
        return NO;
    }

    NSTimeInterval lastActivate = [FLUserSession instance].lastActivateTime.timeIntervalSinceReferenceDate;
    if( lastActivate > m_lastImportTime)
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
            m_lastImportTime = lastActivate;
        }
    }
    
    return NO;
}

- (void) cancelBackgroundTask:(FLBackgroundTaskMgr *)taskMgr
{
    if(m_importer)
    {
        [m_importer cancelImport];
        FLReleaseWithNil(m_importer);
    }
}

- (void) resetBackgroundTask:(FLBackgroundTaskMgr*) taskMgr
{
    [self cancelBackgroundTask:taskMgr];
}

- (BOOL) isExecuting
{
    return m_importer != nil;
}

- (void) _finishedImporting
{
    if(m_importer.error)
    {
        FLLog(@"failed auto-adding assets. error = %@", [m_importer.error description]);
    
        [self didFailToImportAssets:m_importer.error];
        FLReleaseWithNil(m_importer);
    }   
    else
    {
#if TRACE
        FLLog(@"finished auto-adding %d assets.", m_importer.importedAssets.count);
#endif
    
        m_lastImportTime = [m_importer.importedDate timeIntervalSinceReferenceDate];
        [self didFinishImportingAssets:m_importer.importedAssets];
        
        FLReleaseWithNil(m_importer);
        [[FLBackgroundTaskMgr instance] scheduleNextBackgroundTask];
    }
}

- (void) beginBackgroundTask:(FLBackgroundTaskMgr*) taskMgr;
{
#if TRACE
    FLLog(@"Beginning to add photos");
#endif

    FLAssignObject(m_importer, [self createImporter]);
    [m_importer beginImporting:^{
            [self _finishedImporting];
        }];

}

@end

