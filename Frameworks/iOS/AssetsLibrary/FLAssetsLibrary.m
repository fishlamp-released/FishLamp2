//
//	FLAssetsLibrary.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAssetsLibrary.h"
#import "FLAssetsLibraryImageAsset.h"
#import "NSError+FLExtras.h"

#define CreatePermissionsError() [NSError errorWithDomain:FLAssetsLibraryErrorDomain code:FLAssetsLibraryErrorPermissionDenied userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(@"Access Denied", nil) forKey:NSLocalizedDescriptionKey]]

@implementation FLAssetsLibrary

FLSynthesizeSingleton(FLAssetsLibrary);

#if DEBUG
NSError* DisplayDiagnosticError(NSError* error)
{
    @try {
        FLLog(@"Got Assets Libary error: %@", [error description]);
#if ASSETS_LIBRARY_ERROR_ALERT
        if(error) 
        {
            FLAlert* alertView =  [FLAlert alertViewController:@"-- DIAGNOSTIC ERROR --" message:[error description]];
            [self addCancelButton:@"OK"];
             
            [alertView showViewControllerAnimated:YES];
        }
#endif    
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    
    return error;
}
#endif

//void InvokeDoneBlock(NSArray* assets, NSError* error, FLLoadedAssetsBlock block)
//{
//    dispatch_async(dispatch_get_main_queue(), ^{ 
//
//#if DEBUG
//        if(error) 
//            DisplayDiagnosticError(error);
//#endif
//        
//        if(block)
//        {
//            block(assets, error);
//        }
//    });
//}

//- (void) _invokeDoneBlock:(NSDictionary*) parms
//{
//    FLLoadedAssetsBlock block = [parms objectForKey:@"b"];
//    if(block)
//    {
//        block([parms objectForKey:@"a"], [parms objectForKey:@"e"]);
//    }
//}
//
//- (void) _invokeErrorBlock:(NSDictionary*) parms
//{
//    FLErrorCallback block = [parms objectForKey:@"b"];
//    if(block)
//    {
//        block([parms objectForKey:@"e"]);
//    }
//}

#define InvokeDoneBlock(assets, error, block) \
    [self performBlockOnMainThread:^{ if(block) block(assets, error); }]

//        [self performSelectorOnMainThread:@selector(_invokeDoneBlock:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:assets, @"a", error, @"e", block, @"b", nil] waitUntilDone:NO]

#define InvokeErrorBlock(error, block) \
    [self performBlockOnMainThread:^{ if(block) block(error); }]

//        [self performSelectorOnMainThread:@selector(_invokeErrorBlock:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:error, @"e", block, @"b", nil] waitUntilDone:NO]


//void InvokeErrorBlock(NSError* error, FLErrorCallback block)
//{
//    
//
//    dispatch_async(dispatch_get_main_queue(), ^{ 
//        
//#if DEBUG
//        if(error) DisplayDiagnosticError(error);
//#endif        
//        if(block)
//        {
//            block(error);
//        }
//    });
//}

- (BOOL) locationServicesAreAuthorized
{
#if DEBUG
    if(DeviceIsSimulator())
    {
        return YES;
    }
#endif

    if(![CLLocationManager locationServicesEnabled])
    {
        return NO;
    }

    switch([CLLocationManager authorizationStatus])
    {
        case kCLAuthorizationStatusAuthorized:
            return YES;
        break;
        
        
        case kCLAuthorizationStatusNotDetermined:
            
            FLAssertFailedWithComment(@"Should never get here!");
            
            return NO;
        break;
        
        case kCLAuthorizationStatusDenied:
            return NO;
        break;
        
        
        case kCLAuthorizationStatusRestricted:
            return NO;
        break;
    
    }

    return NO;
}

- (void) beginLoadingGroups:(FLLoadedAssetsBlock) doneBlock  
               shouldCancel:(FLShouldCancelBlock) shouldCancel
{
	[self beginLoadingGroupOfGroupType:ALAssetsGroupAll doneBlock:doneBlock shouldCancel:shouldCancel];
}


- (void) beginLoadingGroupOfGroupType:(ALAssetsGroupType) groupType 
                            doneBlock:(FLLoadedAssetsBlock) doneBlock  
                         shouldCancel:(FLShouldCancelBlock) shouldCancel
{
    FLAssertIsNotNilWithComment(doneBlock, nil);
    FLAssertIsNotNilWithComment(shouldCancel, nil);
    
    if(![self locationServicesAreAuthorized])
    {
        InvokeDoneBlock(nil , CreatePermissionsError(), doneBlock);
        return;
    }
    
	doneBlock = FLAutorelease([doneBlock copy]);
	shouldCancel = FLAutorelease([shouldCancel copy]);
	
	dispatch_async(
       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
       ^{
           NSMutableArray* groups = [NSMutableArray array];
           
           [[FLAssetsLibrary instance] enumerateGroupsWithTypes:groupType 
                 usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                     
                     if(shouldCancel && shouldCancel())
                     {
                         *stop = YES;
                         InvokeDoneBlock(nil, [NSError cancelError], doneBlock);
                     }
                     else
                     {
                         if(group!=nil)
                         {	
                             [groups addObject:group];
                         }
                         else
                         {
                             InvokeDoneBlock(groups , nil, doneBlock);
                         }
                     }
                 }
               failureBlock:^(NSError *error) {
                   InvokeDoneBlock(nil , error, doneBlock);
                                                   }];
       });
}


- (void) beginLoadingAssetsForGroup:(ALAssetsGroup*) group 
                        assetFilter:(FLAssetsLibraryFilter) assetFilter
                          doneBlock:(FLErrorCallback) doneBlock  
                       shouldCancel:(FLShouldCancelBlock) shouldCancel
                        loadedAsset:(FLAssetBlock) loadedAsset
{
    FLAssertIsNotNilWithComment(doneBlock, nil);
    FLAssertIsNotNilWithComment(shouldCancel, nil);

    if(![self locationServicesAreAuthorized])
    {
        InvokeErrorBlock(CreatePermissionsError(), doneBlock);
    }
    else if(!group)
    {
        InvokeErrorBlock(nil, doneBlock);
    }
    else    
    {
        doneBlock = FLAutorelease([doneBlock copy]);
        shouldCancel = FLAutorelease([shouldCancel copy]);
        
        dispatch_async(
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                       ^{
                           switch(assetFilter)
                           {
                               case FLAssetsLibraryFilterNone:
                                   [group setAssetsFilter:[ALAssetsFilter allAssets]];
                                   break;
                               case FLAssetsLibraryFilterPhotosOnly:
                                   [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                                   break;
                               case FLAssetsLibraryFilterVideoOnly:
                                   [group setAssetsFilter:[ALAssetsFilter allVideos]];
                                   break;
                                   
                           }
                           [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger idx, BOOL *stop) {
                               @try {
                                   if(shouldCancel && shouldCancel())
                                   {
                                       *stop = YES;
                                       InvokeErrorBlock([NSError cancelError], doneBlock);
                                   }
                                   else
                                   {
                                       if(idx != NSNotFound && result)
                                       {
                                           loadedAsset(result);
                                       }
                                       else
                                       {
                                           InvokeErrorBlock(nil, doneBlock);
                                       }
                                   }
                               }
                               @catch(NSException* ex) {
                                   InvokeErrorBlock(ex.error, doneBlock);
                               }
                           }];
                           
                       });
    }
}

- (void) _beginLoadingAssetsForGroups:(NSArray*) groups
                                  idx:(NSUInteger) idx
                          assetFilter:(FLAssetsLibraryFilter) assetFilter
                            doneBlock:(FLErrorCallback) doneBlock
                         shouldCancel:(FLShouldCancelBlock) shouldCancel
                          loadedAsset:(FLAssetBlock) loadedAsset
{
    FLAssertIsNotNilWithComment(doneBlock, nil);
    FLAssertIsNotNilWithComment(shouldCancel, nil);
    
    if(![self locationServicesAreAuthorized])
    {
        InvokeErrorBlock(CreatePermissionsError(), doneBlock);
    }
    else if(!groups || groups.count == 0)
    {
        InvokeErrorBlock(nil, doneBlock);
    }
    else
    {
        @try {
            [self beginLoadingAssetsForGroup:[groups objectAtIndex:idx] 
                                 assetFilter:assetFilter 
                                 doneBlock:^(NSError* error) {
                                    if(error)
                                    {
                                        InvokeErrorBlock(error, doneBlock);
                                    }
                                    else if((idx + 1) < groups.count)
                                    {
                                        [self _beginLoadingAssetsForGroups:groups idx:(idx + 1) 
                                                              assetFilter:assetFilter 
                                                              doneBlock:doneBlock 
                                                              shouldCancel:shouldCancel 
                                                              loadedAsset:loadedAsset];
                                    }
                                    else
                                    {
                                        InvokeErrorBlock(nil, doneBlock);
                                    }
                                }
                                shouldCancel:shouldCancel
                                loadedAsset:loadedAsset];
        }
        @catch(NSException* ex)
        {
            InvokeErrorBlock(ex.error, doneBlock);
        }
    }
}

- (void) beginLoadingAssetsForGroups:(NSArray*) groups
                         assetFilter:(FLAssetsLibraryFilter) assetFilter
                           doneBlock:(FLErrorCallback) doneBlock
                        shouldCancel:(FLShouldCancelBlock) shouldCancel
                         loadedAsset:(FLAssetBlock) loadedAsset
{
    [self _beginLoadingAssetsForGroups:groups idx:0 assetFilter:assetFilter doneBlock:doneBlock shouldCancel:shouldCancel loadedAsset:loadedAsset];
}

- (void) beginLoadingAssetsForGroupType:(ALAssetsGroupType) groupType  
                            assetFilter:(FLAssetsLibraryFilter) assetFilter
                              doneBlock:(FLErrorCallback) doneBlock  
                           shouldCancel:(FLShouldCancelBlock) shouldCancel
                            loadedAsset:(FLAssetBlock) loadedAsset
{
    if(![self locationServicesAreAuthorized])
    {
        InvokeErrorBlock(CreatePermissionsError(), doneBlock);
    }
    else 
    {
        doneBlock = FLAutorelease([doneBlock copy]);
        shouldCancel = FLAutorelease([shouldCancel copy]);
        
        [self beginLoadingGroupOfGroupType:groupType 
            doneBlock:^(NSArray* groups, NSError* error) {
                if(!error)
                {
                    [self beginLoadingAssetsForGroups:groups assetFilter:assetFilter doneBlock:doneBlock shouldCancel:shouldCancel loadedAsset:loadedAsset];
                }
                else
                {
                    InvokeErrorBlock(error, doneBlock);
                }
            }
            shouldCancel:shouldCancel];
    }
}

- (void) beginLoadingAssetsForGroupType:(ALAssetsGroupType) groupType  
                            assetFilter:(FLAssetsLibraryFilter) assetFilter
                              doneBlock:(FLLoadedAssetsBlock) doneBlock  
                           shouldCancel:(FLShouldCancelBlock) shouldCancel
{
    if(![self locationServicesAreAuthorized])
    {
        InvokeDoneBlock(nil, CreatePermissionsError(), doneBlock);
    }
    else 
    {
        doneBlock = FLAutorelease([doneBlock copy]);
        shouldCancel = FLAutorelease([shouldCancel copy]);
        
        [self beginLoadingGroupOfGroupType:groupType 
            doneBlock:^(NSArray* groups, NSError* error) {
                if(!error)
                {
                    [self beginLoadingAssetsForGroups:groups assetFilter:assetFilter doneBlock:doneBlock shouldCancel:shouldCancel];
                }
                else
                {
                    InvokeDoneBlock(nil , error, doneBlock);
                }
                
            }
            shouldCancel:shouldCancel];
    }
}

// arrays

- (void) _addAssetToArray:(NSMutableArray*) array
    membership:(NSMutableSet*) membership
    asset:(ALAsset*) asset
{
    NSURL* assetUrl = asset.defaultRepresentation.url;
    if(![membership containsObject:assetUrl])
    {
        [membership addObject:assetUrl];
    
        FLAssetsLibraryImageAsset* gt_asset = [[FLAssetsLibraryImageAsset alloc] initWithALAsset:asset];
        [array addObject:gt_asset];
		FLRelease(gt_asset);
    }
}

- (void) beginLoadingAssetsForGroup:(ALAssetsGroup*) group 
                        assetFilter:(FLAssetsLibraryFilter) assetFilter
                          doneBlock:(FLLoadedAssetsBlock) doneBlock  
                       shouldCancel:(FLShouldCancelBlock) shouldCancel
{
    FLAssertIsNotNilWithComment(doneBlock, nil);
    FLAssertIsNotNilWithComment(shouldCancel, nil);

    if(![self locationServicesAreAuthorized])
    {
        InvokeDoneBlock(nil, CreatePermissionsError(), doneBlock);
    }
    else if(!group)
    {
        InvokeDoneBlock([NSArray array], nil, doneBlock);
    }
    else    
    {
        // use set to prevent dupes, cause ALAssetMgr definitely returns dupes.
        NSMutableSet* membership = [NSMutableSet set];
        NSMutableArray* assets = [NSMutableArray array];
            
        [self beginLoadingAssetsForGroup:group 
            assetFilter:assetFilter 
            doneBlock:^(NSError* error) {
                InvokeDoneBlock(assets, error, doneBlock);
            }
            shouldCancel:shouldCancel 
            loadedAsset:^(ALAsset* asset) {
                [self _addAssetToArray:assets membership:membership asset:asset];
            }];
    }
}

- (void) beginLoadingAssets:(FLAssetsLibraryFilter) assetFilter
                  doneBlock:(FLLoadedAssetsBlock) doneBlock  
               shouldCancel:(FLShouldCancelBlock) shouldCancel
{
    FLAssertIsNotNilWithComment(doneBlock, nil);
    FLAssertIsNotNilWithComment(shouldCancel, nil);

    if(![self locationServicesAreAuthorized])
    {
        InvokeDoneBlock(nil, CreatePermissionsError(), doneBlock);
    }
    else 
    {
        doneBlock = FLAutorelease([doneBlock copy]);
        shouldCancel = FLAutorelease([shouldCancel copy]);

        [self beginLoadingGroups:^(NSArray* groups, NSError* error) {
                if(!error)
                {
                    [self beginLoadingAssetsForGroups:groups assetFilter:assetFilter doneBlock:doneBlock shouldCancel:shouldCancel];
                }
                else
                {
                    InvokeDoneBlock(nil , error, doneBlock);
                }
                
            }
            shouldCancel:shouldCancel];
    }
}


- (void) beginLoadingAssetsForGroups:(NSArray*) groups
                         assetFilter:(FLAssetsLibraryFilter) assetFilter
                           doneBlock:(FLLoadedAssetsBlock) doneBlock
                        shouldCancel:(FLShouldCancelBlock) shouldCancel
{
    FLAssertIsNotNilWithComment(doneBlock, nil);
    FLAssertIsNotNilWithComment(shouldCancel, nil);
    
    if(![self locationServicesAreAuthorized])
    {
        InvokeDoneBlock(nil, CreatePermissionsError(), doneBlock);
    }
    else 
    {
        if(!groups || groups.count == 0)
        {
            InvokeDoneBlock([NSArray array], nil, doneBlock);
        }
        else
        {
            // use set to prevent dupes, cause ALAssetMgr definitely returns dupes.
            NSMutableSet* membership = [NSMutableSet set];
            NSMutableArray* assets = [NSMutableArray array];

            doneBlock = FLAutorelease([doneBlock copy]);
            shouldCancel = FLAutorelease([shouldCancel copy]);
            
            [self _beginLoadingAssetsForGroups:groups 
                                           idx:0 
                                   assetFilter:assetFilter 
                                     doneBlock:^(NSError* error) { 
                                         InvokeDoneBlock(assets, error, doneBlock);
                                     } 
                                  shouldCancel:shouldCancel 
                                   loadedAsset:^(ALAsset* asset) {
                                         [self _addAssetToArray:assets membership:membership asset:asset];
                                    }];
        }
    }
}

//- (void) loadPageOfAssets:(NSUInteger) startIndex
//{
//	NSIndexSet* indexes = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(startIndex, MIN(PageSize, _assets.count - startIndex))];
//	[_group enumerateAssetsAtIndexes:indexes
//		options:NSEnumerationConcurrent
//		usingBlock:^(ALAsset *result, NSUInteger idx, BOOL *stop) {
//			if(idx != NSNotFound && result)
//			{
//				[_assets replaceObjectAtIndex:idx withObject:result];
//			}
//		}];
//	FLReleaseWithNil(indexes);
//}



@end
