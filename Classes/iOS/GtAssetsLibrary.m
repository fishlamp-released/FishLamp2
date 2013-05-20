//
//	GtAssetsLibrary.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetsLibrary.h"
#import "GtAssetsLibraryImageAsset.h"
#import "NSError+GtExtras.h"

#define CreatePermissionsError() [NSError errorWithDomain:GtAssetsLibraryErrorDomain code:GtAssetsLibraryErrorPermissionDenied userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(@"Access Denied", nil) forKey:NSLocalizedDescriptionKey]]

@implementation GtAssetsLibrary

GtSynthesizeSingleton(GtAssetsLibrary);

#if DEBUG
NSError* DisplayDiagnosticError(NSError* error)
{
    @try {
        GtLog(@"Got Assets Libary error: %@", [error description]);
#if ASSETS_LIBRARY_ERROR_ALERT
        if(error) 
        {
            UIAlertView* alertView =  [[[UIAlertView alloc] initWithTitle:@"-- DIAGNOSTIC ERROR --" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] autorelease];
            [alertView show];
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

//void InvokeDoneBlock(NSArray* assets, NSError* error, GtLoadedAssetsBlock block)
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
//    GtLoadedAssetsBlock block = [parms objectForKey:@"b"];
//    if(block)
//    {
//        block([parms objectForKey:@"a"], [parms objectForKey:@"e"]);
//    }
//}
//
//- (void) _invokeErrorBlock:(NSDictionary*) parms
//{
//    GtErrorCallback block = [parms objectForKey:@"b"];
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


//void InvokeErrorBlock(NSError* error, GtErrorCallback block)
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
            
            GtAssertFailed(@"Should never get here!");
            
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

- (void) beginLoadingGroups:(GtLoadedAssetsBlock) doneBlock  
               shouldCancel:(GtShouldCancelBlock) shouldCancel
{
	[self beginLoadingGroupOfGroupType:ALAssetsGroupAll doneBlock:doneBlock shouldCancel:shouldCancel];
}


- (void) beginLoadingGroupOfGroupType:(ALAssetsGroupType) groupType 
                            doneBlock:(GtLoadedAssetsBlock) doneBlock  
                         shouldCancel:(GtShouldCancelBlock) shouldCancel
{
    GtAssertNotNil(doneBlock);
    GtAssertNotNil(shouldCancel);
    
    if(![self locationServicesAreAuthorized])
    {
        InvokeDoneBlock(nil , CreatePermissionsError(), doneBlock);
        return;
    }
    
	doneBlock = GtReturnAutoreleased([doneBlock copy]);
	shouldCancel = GtReturnAutoreleased([shouldCancel copy]);
	
	dispatch_async(
       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
       ^{
           NSMutableArray* groups = [NSMutableArray array];
           
           [[GtAssetsLibrary instance] enumerateGroupsWithTypes:groupType 
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
                        assetFilter:(GtAssetsLibraryFilter) assetFilter
                          doneBlock:(GtErrorCallback) doneBlock  
                       shouldCancel:(GtShouldCancelBlock) shouldCancel
                        loadedAsset:(GtAssetBlock) loadedAsset
{
    GtAssertNotNil(doneBlock);
    GtAssertNotNil(shouldCancel);

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
        doneBlock = GtReturnAutoreleased([doneBlock copy]);
        shouldCancel = GtReturnAutoreleased([shouldCancel copy]);
        
        dispatch_async(
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                       ^{
                           switch(assetFilter)
                           {
                               case GtAssetsLibraryFilterNone:
                                   [group setAssetsFilter:[ALAssetsFilter allAssets]];
                                   break;
                               case GtAssetsLibraryFilterPhotosOnly:
                                   [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                                   break;
                               case GtAssetsLibraryFilterVideoOnly:
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
                               @catch (NSException* ex) {
                                   InvokeErrorBlock(ex.error, doneBlock);
                               }
                           }];
                           
                       });
    }
}

- (void) _beginLoadingAssetsForGroups:(NSArray*) groups
                                  idx:(NSUInteger) idx
                          assetFilter:(GtAssetsLibraryFilter) assetFilter
                            doneBlock:(GtErrorCallback) doneBlock
                         shouldCancel:(GtShouldCancelBlock) shouldCancel
                          loadedAsset:(GtAssetBlock) loadedAsset
{
    GtAssertNotNil(doneBlock);
    GtAssertNotNil(shouldCancel);
    
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
                         assetFilter:(GtAssetsLibraryFilter) assetFilter
                           doneBlock:(GtErrorCallback) doneBlock
                        shouldCancel:(GtShouldCancelBlock) shouldCancel
                         loadedAsset:(GtAssetBlock) loadedAsset
{
    [self _beginLoadingAssetsForGroups:groups idx:0 assetFilter:assetFilter doneBlock:doneBlock shouldCancel:shouldCancel loadedAsset:loadedAsset];
}

- (void) beginLoadingAssetsForGroupType:(ALAssetsGroupType) groupType  
                            assetFilter:(GtAssetsLibraryFilter) assetFilter
                              doneBlock:(GtErrorCallback) doneBlock  
                           shouldCancel:(GtShouldCancelBlock) shouldCancel
                            loadedAsset:(GtAssetBlock) loadedAsset
{
    if(![self locationServicesAreAuthorized])
    {
        InvokeErrorBlock(CreatePermissionsError(), doneBlock);
    }
    else 
    {
        doneBlock = GtReturnAutoreleased([doneBlock copy]);
        shouldCancel = GtReturnAutoreleased([shouldCancel copy]);
        
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
                            assetFilter:(GtAssetsLibraryFilter) assetFilter
                              doneBlock:(GtLoadedAssetsBlock) doneBlock  
                           shouldCancel:(GtShouldCancelBlock) shouldCancel
{
    if(![self locationServicesAreAuthorized])
    {
        InvokeDoneBlock(nil, CreatePermissionsError(), doneBlock);
    }
    else 
    {
        doneBlock = GtReturnAutoreleased([doneBlock copy]);
        shouldCancel = GtReturnAutoreleased([shouldCancel copy]);
        
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
    
        GtAssetsLibraryImageAsset* gt_asset = [[GtAssetsLibraryImageAsset alloc] initWithALAsset:asset];
        [array addObject:gt_asset];
		GtRelease(gt_asset);
    }
}

- (void) beginLoadingAssetsForGroup:(ALAssetsGroup*) group 
                        assetFilter:(GtAssetsLibraryFilter) assetFilter
                          doneBlock:(GtLoadedAssetsBlock) doneBlock  
                       shouldCancel:(GtShouldCancelBlock) shouldCancel
{
    GtAssertNotNil(doneBlock);
    GtAssertNotNil(shouldCancel);

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

- (void) beginLoadingAssets:(GtAssetsLibraryFilter) assetFilter
                  doneBlock:(GtLoadedAssetsBlock) doneBlock  
               shouldCancel:(GtShouldCancelBlock) shouldCancel
{
    GtAssertNotNil(doneBlock);
    GtAssertNotNil(shouldCancel);

    if(![self locationServicesAreAuthorized])
    {
        InvokeDoneBlock(nil, CreatePermissionsError(), doneBlock);
    }
    else 
    {
        doneBlock = GtReturnAutoreleased([doneBlock copy]);
        shouldCancel = GtReturnAutoreleased([shouldCancel copy]);

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
                         assetFilter:(GtAssetsLibraryFilter) assetFilter
                           doneBlock:(GtLoadedAssetsBlock) doneBlock
                        shouldCancel:(GtShouldCancelBlock) shouldCancel
{
    GtAssertNotNil(doneBlock);
    GtAssertNotNil(shouldCancel);
    
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

            doneBlock = GtReturnAutoreleased([doneBlock copy]);
            shouldCancel = GtReturnAutoreleased([shouldCancel copy]);
            
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
//	NSIndexSet* indexes = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(startIndex, MIN(PageSize, m_assets.count - startIndex))];
//	[m_group enumerateAssetsAtIndexes:indexes
//		options:NSEnumerationConcurrent
//		usingBlock:^(ALAsset *result, NSUInteger idx, BOOL *stop) {
//			if(idx != NSNotFound && result)
//			{
//				[m_assets replaceObjectAtIndex:idx withObject:result];
//			}
//		}];
//	GtReleaseWithNil(indexes);
//}



@end
