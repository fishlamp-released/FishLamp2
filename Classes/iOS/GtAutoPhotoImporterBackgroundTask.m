//
//  GtAutoPhotoImporter.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/28/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAutoPhotoImporterBackgroundTask.h"

#import "GtAssetsLibrary.h"
#import "GtAssetsLibraryImageAsset.h"

#import "GtUserSession.h"
#import "GtViewController.h"

#import "GtUserNotificationView.h"
#import "UIDevice+GtExtras.h"

#import "GtAssetsLibraryImageAsset.h"
#import "GtImageAsset.h"

#if 1
#define TRACE DEBUG
#endif

@implementation GtAutoPhotoImporterBackgroundTask

- (GtAssetLibraryAutoPhotoImporter*) createImporter
{
    return GtReturnAutoreleased([[GtAssetLibraryAutoPhotoImporter alloc] init]);
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

- (BOOL) canBeginBackgroundTask:(GtBackgroundTaskMgr *)taskMgr
{
    if(m_importer)
    {
        return NO;
    }

    NSTimeInterval lastActivate = [GtUserSession instance].lastActivateTime.timeIntervalSinceReferenceDate;
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

- (void) cancelBackgroundTask:(GtBackgroundTaskMgr *)taskMgr
{
    if(m_importer)
    {
        [m_importer cancelImport];
        GtReleaseWithNil(m_importer);
    }
}

- (void) resetBackgroundTask:(GtBackgroundTaskMgr*) taskMgr
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
        GtLog(@"failed auto-adding assets. error = %@", [m_importer.error description]);
    
        [self didFailToImportAssets:m_importer.error];
        GtReleaseWithNil(m_importer);
    }   
    else
    {
#if TRACE
        GtLog(@"finished auto-adding %d assets.", m_importer.importedAssets.count);
#endif
    
        m_lastImportTime = [m_importer.importedDate timeIntervalSinceReferenceDate];
        [self didFinishImportingAssets:m_importer.importedAssets];
        
        GtReleaseWithNil(m_importer);
        [[GtBackgroundTaskMgr instance] scheduleNextBackgroundTask];
    }
}

- (void) beginBackgroundTask:(GtBackgroundTaskMgr*) taskMgr;
{
#if TRACE
    GtLog(@"Beginning to add photos");
#endif

    GtAssignObject(m_importer, [self createImporter]);
    [m_importer beginImporting:^{
            [self _finishedImporting];
        }];

}

@end

