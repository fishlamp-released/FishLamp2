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
#import "ZFBatchPhotoDownloadOperation.h"
#import "FLDatabaseObjectStorageService.h"

@protocol ZFHttpControllerDelegate;

@interface ZFHttpController : FLHttpController<FLDatabaseObjectStorageServiceDelegate> {
@private
    ZFHttpUser* _user;
}

@property (readwrite, strong) ZFHttpUser* user;

- (ZFLoadGroupHierarchyOperation*) createRootGroupDownloader;
- (ZFDownloadPhotoSetsOperation*) createAllPhotoSetsDownloader;
- (ZFBatchPhotoDownloadOperation*) createBatchDownloader:(ZFBatchDownloadSpec*) spec;

@end




