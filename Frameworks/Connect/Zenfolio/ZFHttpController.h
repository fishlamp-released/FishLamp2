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
#import "ZFBatchPhotoSetDownloader.h"
#import "ZFBatchPhotoDownloader.h"
#import "FLDatabaseObjectStorageService.h"

@protocol ZFHttpControllerDelegate;

@interface ZFHttpController : FLHttpController<FLDatabaseObjectStorageServiceDelegate> {
@private
    ZFHttpUser* _user;
}

@property (readwrite, strong) ZFHttpUser* user;

- (ZFBatchPhotoDownloader*) createBatchDownloader:(ZFBatchDownloadSpec*) spec;

- (FLFinisher*) beginDownloadingAllPhotoSetsForRootGroup:(id)observer
                                              completion:(fl_completion_block_t) completion;

- (FLFinisher*) beginDownloadingRootGroup:(id) observer 
                               completion:(fl_completion_block_t) completion;

@end

@protocol FLHttpControllerObserver <NSObject>
@optional

- (void) httpController:(ZFHttpController*) controller didDownloadRootGroupWithResult:(FLResult) result;

- (void) httpController:(ZFHttpController*) controller didDownloadPhotoSetForRootGroupWithResult:(FLResult) result;
- (void) httpController:(ZFHttpController*) controller didDownloadAllPhotoSetsForRootGroupWithResult:(FLResult) result;
@end




