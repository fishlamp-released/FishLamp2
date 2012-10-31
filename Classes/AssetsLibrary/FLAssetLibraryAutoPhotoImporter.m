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

@synthesize error = _error;
@synthesize importedAssets = _importedAssets;
@synthesize importedDate = _importedDate;
@synthesize delegate = _delegate;

- (void) _clearData
{
    FLReleaseWithNil_(_assetQueue);
    FLReleaseWithNil_(_importedDate);
    FLReleaseWithNil_(_importedAssets);
    FLReleaseWithNil_(_error);
    FLReleaseWithNil_(_startDate);
    _cancelled = NO;
}

- (void) dealloc
{
    [self _clearData];
    mrc_super_dealloc_();
}

- (void) cancelImport
{
    _cancelled = YES;
}

- (void) _handleFinished:(dispatch_block_t) callback
{
    if(!_cancelled)
    {
        if(callback)
        {
            callback();
        }
    }
    [self _clearData];
}

- (void) _beginBatchAddingAssetsToAssetQueue:(dispatch_block_t) completedBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            [_assetQueue batchAddAssets:_importedAssets];
            FLRetainObject_(_importedDate, [NSDate date]);
            [_delegate assetLibraryAutoPhotoImporter:self saveLastImportDate:_importedDate];
        }
        @catch(NSException* ex) {
            FLReleaseWithNil_(_importedAssets);
            FLRetainObject_(_error, ex.error);
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
        if(![_assetQueue assetIsInQueue:url] && ![_assetQueue assetWasUploaded:url])
        {
            return [_delegate assetLibraryAutoPhotoImporter:self shouldImportAsset:asset];
        }
    }
    
    return NO;
}

- (void) beginImporting:(dispatch_block_t) completedBlock
{
    FLAssert_v(_delegate != nil, @"a delegate is required.");

    completedBlock = autorelease_([completedBlock copy]);
    
    [self _clearData];
    
    FLRetainObject_(_importedAssets, [NSMutableArray array]);
    FLRetainObject_(_assetQueue, [_delegate assetLibraryAutoPhotoImporterGetAssetQueue:self]);
    FLRetainObject_(_startDate, [_delegate assetLibraryAutoPhotoImporterGetLastImportDate:self]);
    
    FLAssertIsNotNil_v(_assetQueue, nil);
    FLAssertIsNotNil_v(_startDate, nil);


#if TRACE
    FLLog(@"Beginning importer");
#endif    
    
    [[FLAssetsLibrary instance] beginLoadingAssetsForGroupType:ALAssetsGroupSavedPhotos 
        assetFilter:FLAssetsLibraryFilterPhotosOnly 
        doneBlock:^(NSError* error) {
        
            if(_cancelled)
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
            
                FLRetainObject_(_error, error);
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
            return _cancelled;
        } 
        loadedAsset:^(ALAsset* asset) {
        
           if([self _shouldAddAsset:asset minDate:_startDate])
           {
                FLAssetsLibraryImageAsset* imageAsset = [[FLAssetsLibraryImageAsset alloc] initWithALAsset:asset];

                FLQueuedAsset* newAsset = [_delegate assetLibraryAutoPhotoImporter:self 
                                                     createQueuedAssetForImageAsset:imageAsset 
                                                                          assetType:FLAssetTypeImageFromAssetsLibrary | FLAssetTypeAutoAdded];
               
#if TRACE
               FLLog(@"found asset to add: %@", newAsset.assetURL);
#endif                           
               [_importedAssets addObject:newAsset];
               mrc_release_(imageAsset);
           }
        }];
}

@end