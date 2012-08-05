//
//  FLAssetLibraryAutoPhotoImporter.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/6/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAssetLibraryAutoPhotoImporter.h"
#import "FLAssetsLibraryImageAsset.h"
#import "FLAssetsLibrary.h"

#if DEBUG
#define TRACE 0
#endif

@implementation FLAssetLibraryAutoPhotoImporter 

@synthesize error = m_error;
@synthesize importedAssets = m_importedAssets;
@synthesize importedDate = m_importedDate;
@synthesize delegate = m_delegate;

- (void) _clearData
{
    FLReleaseWithNil(m_assetQueue);
    FLReleaseWithNil(m_importedDate);
    FLReleaseWithNil(m_importedAssets);
    FLReleaseWithNil(m_error);
    FLReleaseWithNil(m_startDate);
    m_cancelled = NO;
}

- (void) dealloc
{
    [self _clearData];
    FLSuperDealloc();
}

- (void) cancelImport
{
    m_cancelled = YES;
}

- (void) _handleFinished:(FLEventCallback) callback
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

- (void) _beginBatchAddingAssetsToAssetQueue:(FLEventCallback) completedBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            [m_assetQueue batchAddAssets:m_importedAssets];
            FLAssignObject(m_importedDate, [NSDate date]);
            [m_delegate assetLibraryAutoPhotoImporter:self saveLastImportDate:m_importedDate];
        }
        @catch(NSException* ex) {
            FLReleaseWithNil(m_importedAssets);
            FLAssignObject(m_error, ex.error);
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

- (void) beginImporting:(FLEventCallback) completedBlock
{
    FLAssert(m_delegate != nil, @"a delegate is required.");

    completedBlock = FLReturnAutoreleased([completedBlock copy]);
    
    [self _clearData];
    
    FLAssignObject(m_importedAssets, [NSMutableArray array]);
    FLAssignObject(m_assetQueue, [m_delegate assetLibraryAutoPhotoImporterGetAssetQueue:self]);
    FLAssignObject(m_startDate, [m_delegate assetLibraryAutoPhotoImporterGetLastImportDate:self]);
    
    FLAssertIsNotNil(m_assetQueue);
    FLAssertIsNotNil(m_startDate);


#if TRACE
    FLLog(@"Beginning importer");
#endif    
    
    [[FLAssetsLibrary instance] beginLoadingAssetsForGroupType:ALAssetsGroupSavedPhotos 
        assetFilter:FLAssetsLibraryFilterPhotosOnly 
        doneBlock:^(NSError* error) {
        
            if(m_cancelled)
            {
#if TRACE
                FLLog(@"Importer got cancelled");
#endif                
                [self _clearData];
            }
            else if(error)
            {
#if TRACE
                FLLog(@"Importer got error: %@", [error description]);
#endif                
            
                FLAssignObject(m_error, error);
                [self performBlockOnMainThread:^{ [self _handleFinished:completedBlock]; }];
            }
            else
            {
#if TRACE
                FLLog(@"Importer begin batch adding");
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
                FLAssetsLibraryImageAsset* imageAsset = [[FLAssetsLibraryImageAsset alloc] initWithALAsset:asset];

                FLQueuedAsset* newAsset = [m_delegate assetLibraryAutoPhotoImporter:self 
                                                     createQueuedAssetForImageAsset:imageAsset 
                                                                          assetType:FLAssetTypeImageFromAssetsLibrary | FLAssetTypeAutoAdded];
               
#if TRACE
               FLLog(@"found asset to add: %@", newAsset.assetURL);
#endif                           
               [m_importedAssets addObject:newAsset];
               FLRelease(imageAsset);
           }
        }];
}

@end