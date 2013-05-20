//
//  GtAssetLibraryAutoPhotoImporter.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetLibraryAutoPhotoImporter.h"
#import "GtAssetsLibraryImageAsset.h"
#import "GtAssetsLibrary.h"

#if DEBUG
#define TRACE 0
#endif

@implementation GtAssetLibraryAutoPhotoImporter 

@synthesize error = m_error;
@synthesize importedAssets = m_importedAssets;
@synthesize importedDate = m_importedDate;
@synthesize delegate = m_delegate;

- (void) _clearData
{
    GtReleaseWithNil(m_assetQueue);
    GtReleaseWithNil(m_importedDate);
    GtReleaseWithNil(m_importedAssets);
    GtReleaseWithNil(m_error);
    GtReleaseWithNil(m_startDate);
    m_cancelled = NO;
}

- (void) dealloc
{
    [self _clearData];
    GtSuperDealloc();
}

- (void) cancelImport
{
    m_cancelled = YES;
}

- (void) _handleFinished:(GtBlock) callback
{
    if(!m_cancelled)
    {
        if(callback)
        {
            callback();
        }
    }
    [self _clearData];
}

- (void) _beginBatchAddingAssetsToAssetQueue:(GtBlock) completedBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            [m_assetQueue batchAddAssets:m_importedAssets];
            GtAssignObject(m_importedDate, [NSDate date]);
            [m_delegate assetLibraryAutoPhotoImporter:self saveLastImportDate:m_importedDate];
        }
        @catch(NSException* ex) {
            GtReleaseWithNil(m_importedAssets);
            GtAssignObject(m_error, ex.error);
        }
        [self performBlockOnMainThread:^{ [self _handleFinished:completedBlock]; }];
    });
}

- (BOOL) _shouldAddAsset:(ALAsset*) asset 
                 minDate:(NSDate*) minDate
{
    NSDate* takenDate = [asset valueForProperty:ALAssetPropertyDate];
    
    NSTimeInterval takenTime = takenDate ? takenDate.timeIntervalSinceReferenceDate : 0;
    NSTimeInterval minTime = minDate.timeIntervalSinceReferenceDate;
    
    minTime -= 5.0;
    
    if(takenTime > minTime)
    {
        NSString* url = asset.defaultRepresentation.url.absoluteString;
        if(![m_assetQueue assetIsInQueue:url] && ![m_assetQueue assetWasUploaded:url])
        {
            return [m_delegate assetLibraryAutoPhotoImporter:self shouldImportAsset:asset];
        }
    }
    
    return NO;
}

- (void) beginImporting:(GtBlock) completedBlock
{
    GtAssert(m_delegate != nil, @"a delegate is required.");

    completedBlock = GtReturnAutoreleased([completedBlock copy]);
    
    [self _clearData];
    
    GtAssignObject(m_importedAssets, [NSMutableArray array]);
    GtAssignObject(m_assetQueue, [m_delegate assetLibraryAutoPhotoImporterGetAssetQueue:self]);
    GtAssignObject(m_startDate, [m_delegate assetLibraryAutoPhotoImporterGetLastImportDate:self]);
    
    GtAssertNotNil(m_assetQueue);
    GtAssertNotNil(m_startDate);


#if TRACE
    GtLog(@"Beginning importer");
#endif    
    
    [[GtAssetsLibrary instance] beginLoadingAssetsForGroupType:ALAssetsGroupSavedPhotos 
        assetFilter:GtAssetsLibraryFilterPhotosOnly 
        doneBlock:^(NSError* error) {
        
            if(m_cancelled)
            {
#if TRACE
                GtLog(@"Importer got cancelled");
#endif                
                [self _clearData];
            }
            else if(error)
            {
#if TRACE
                GtLog(@"Importer got error: %@", [error description]);
#endif                
            
                GtAssignObject(m_error, error);
                [self performBlockOnMainThread:^{ [self _handleFinished:completedBlock]; }];
            }
            else
            {
#if TRACE
                GtLog(@"Importer begin batch adding");
#endif                
            
                [self _beginBatchAddingAssetsToAssetQueue:completedBlock];
            }
        }
        shouldCancel:^{
            return m_cancelled;
        } 
        loadedAsset:^(ALAsset* asset) {
        
           if([self _shouldAddAsset:asset minDate:m_startDate])
           {
                GtAssetsLibraryImageAsset* imageAsset = [[GtAssetsLibraryImageAsset alloc] initWithALAsset:asset];

                GtQueuedAsset* newAsset = [m_delegate assetLibraryAutoPhotoImporter:self 
                                                     createQueuedAssetForImageAsset:imageAsset 
                                                                          assetType:GtAssetTypeImageFromAssetsLibrary | GtAssetTypeAutoAdded];
               
#if TRACE
               GtLog(@"found asset to add: %@", newAsset.assetURL);
#endif                           
               [m_importedAssets addObject:newAsset];
               GtRelease(imageAsset);
           }
        }];
}

@end