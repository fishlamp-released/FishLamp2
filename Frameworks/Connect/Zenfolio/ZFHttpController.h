//
//  ZFHttpController.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpController.h"
#import "ZFWebApi.h"
#import "ZFLoadGroupHierarchyOperation.h"
#import "ZFDownloadPhotoSetsOperation.h"
#import "ZFBatchDownloadOperation.h"

@protocol ZFHttpControllerDelegate;

@interface ZFHttpController : FLHttpController {
@private
}

- (ZFHttpUser*) user;

- (ZFLoadGroupHierarchyOperation*) createRootGroupDownloader;
- (ZFDownloadPhotoSetsOperation*) createAllPhotoSetsDownloader;
- (ZFBatchDownloadOperation*) createBatchDownloader:(NSSet*) photoSets
                              destinationFolderPath:(NSString*) destinationPath
                                         mediaTypes:(NSArray*) mediaTypes;
@end




