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

- (void) beginDownloadingPhotos:(ZFBatchDownloadSpec*) spec 
                       observer:(id) observer 
                     completion:(fl_completion_block_t) completion;

- (void) beginDownloadingAllPhotoSetsForRootGroup:(id)observer 
                                       completion:(fl_completion_block_t) completion;

- (void) beginDownloadingRootGroup:(id)observer 
                        completion:(fl_completion_block_t) completion;

@end

@protocol FLHttpControllerObserver <NSObject>
@optional
- (void) httpController:(ZFHttpController*) controller didDownloadPhotoSetForRootGroup:(ZFPhotoSet*) photoSet;
@end

@protocol FLHttpControllerPhotoDownloaderObserver <NSObject>


- (void) httpController:(ZFHttpController*) controller updateDownloadInfo:(ZFTransferState*) downloadInfo;

//- (void) batchPhotoDownloaderWillBeginDownload:(ZFBatchPhotoDownloader*) operation;

- (void) httpController:(ZFHttpController*) controller willUpdatePhotoSet:(ZFPhotoSet*) photoSet;
- (void) httpController:(ZFHttpController*) controller didUpdatePhotoSet:(ZFPhotoSet*) photoSet;

// these are called per photo set
- (void) httpController:(ZFHttpController*) controller willStartDownloadingPhotosInPhotoSet:(NSDictionary*) downloadInfo;

- (void) httpController:(ZFHttpController*) controller willDownloadPhoto:(ZFDownloadSpec*) downloadInfo;
- (void) httpController:(ZFHttpController*) controller didSkipPhoto:(ZFDownloadSpec*) downloadInfo;
- (void) httpController:(ZFHttpController*) controller didDownloadPhoto:(ZFDownloadSpec*) downloadInfo;

- (void) httpController:(ZFHttpController*) controller 
          photoDownload:(ZFDownloadSpec*) downloadInfo 
       didFailWithError:(NSError*) error;

- (void) httpController:(ZFHttpController*) controller didDownloadPhotosInPhotoSet:(NSDictionary*) downloadInfo;


@end




