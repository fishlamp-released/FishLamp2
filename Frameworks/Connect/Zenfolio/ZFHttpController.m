//
//  ZFHttpController.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFHttpController.h"
#import "ZFRegisteredUserAuthenticationService.h"
#import "ZFLoadGroupHierarchyOperation.h"

#import "FLDictionaryObjectStorageService.h"
#import "FLDatabaseObjectStorageService.h"

#import "ZFBatchPhotoSetDownloader.h"

#define ZFHttpControllerHiddenFolderName @".downloader"

@interface ZFHttpController ()
@end

@implementation ZFHttpController
@synthesize user = _user;

- (FLUserService*) createUserService {
    return [FLUserService userService];
}

- (FLStorageService*) createStorageService {
    return [FLDictionaryObjectStorageService dictionaryObjectStorageService];
}

- (NSString*) databaseObjectStorageServiceGetDatabasePath:(FLDatabaseObjectStorageService*) service {
    return [[self.user userDataFolderPath] stringByAppendingPathComponent:@"downloader.sqlite"];
}

//- (NSString*) databaseObjectStorageServiceGetDatabasePath:(FLDatabaseObjectStorageService*) service {
//    return [FLDictionaryObjectStorageService dictionaryObjectStorageService];
//}


- (FLHttpRequestAuthenticationService*) createHttpRequestAuthenticationService {
    return [ZFRegisteredUserAuthenticationService registeredUserAuthenticationService];
}


#if FL_MRC
- (void) dealloc {
    [_user release];
    [super dealloc];
}
#endif

- (void) userServiceDidOpen:(FLUserService*) service {
    self.user = [ZFHttpUser httpUserWithCredentials:[FLUserLogin userLogin:service.userName password:service.password]];

    [super userServiceDidOpen:service];
}

- (void) userServiceDidClose:(FLUserService*) service {
    [super userServiceDidClose:service];

    self.user = nil;
}

//- (void) operation:(ZFLoadGroupHierarchyOperation*) operation downloadedRootGroup:(FLResult) result {
//    if(![result error] ) {
//        [self.user setRootGroup:result];
//    }
//}

- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation updateDownloadInfo:(ZFTransferState*) downloadInfo {
    [operation.asyncObserver receiveObservation:@selector(httpController:updateDownloadInfo:) fromSender:self withObject:downloadInfo];
}

- (void) batchPhotoDownloaderWillBeginDownload:(ZFBatchPhotoDownloader*) operation {
//    [operation.asyncObserver receiveObservation:@selector(httpController:updateDownloadInfo:) fromSneder:self withObject:downloadInfo];
}

- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation willUpdatePhotoSet:(ZFPhotoSet*) photoSet {
    [operation.asyncObserver receiveObservation:@selector(httpController:willUpdatePhotoSet:) fromSender:self withObject:photoSet];
}

- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didUpdatePhotoSet:(ZFPhotoSet*) photoSet {
    [operation.asyncObserver receiveObservation:@selector(httpController:didUpdatePhotoSet:) fromSender:self withObject:photoSet];
}

//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation willStartDownloadingPhotosInPhotoSet:(NSDictionary*) downloadInfo {
//    [operation.asyncObserver receiveObservation:@selector(httpController:willStartDownloadingPhotosInPhotoSet:) fromSender:self withObject:photoSet];
//}

- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation willDownloadPhoto:(ZFDownloadSpec*) downloadInfo {
    [operation.asyncObserver receiveObservation:@selector(httpController:willDownloadPhoto:) fromSender:self withObject:downloadInfo];
}

- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didSkipPhoto:(ZFDownloadSpec*) downloadInfo {
    [operation.asyncObserver receiveObservation:@selector(httpController:didSkipPhoto:) fromSender:self withObject:downloadInfo];
}

- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didDownloadPhoto:(ZFDownloadSpec*) downloadInfo {
    [operation.asyncObserver receiveObservation:@selector(httpController:didDownloadPhoto:) fromSender:self withObject:downloadInfo];
}

//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didDownloadPhotosInPhotoSet:(NSDictionary*) downloadInfo {
//}



- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
             didDownloadPhotoSet:(ZFPhotoSet*) photoSet {

    [downloader.asyncObserver receiveObservation:@selector(httpController:didDownloadPhotoSetForRootGroup:) 
                                      fromSender:self 
                                      withObject:photoSet];
}             


- (void) beginDownloadingAllPhotoSetsForRootGroup:(id)observer 
                                       completion:(fl_completion_block_t) completion {
    
    ZFBatchPhotoSetDownloader* downloader =    
            [ZFBatchPhotoSetDownloader batchPhotoSetDownloaderForGroup:self.user.rootGroup withPhotos:NO];
    
    downloader.context = self;
    downloader.delegate = self;
    downloader.asyncObserver = observer;
   
    FLFinisher* finisher = [FLFinisher finisher:completion];
    finisher.finishOnMainThread = YES;

    [downloader runAsynchronously:^(FLResult result) {
        [finisher setFinishedWithResult:result];
    }];
}                                           

- (void) beginDownloadingRootGroup:(id)observer 
                        completion:(fl_completion_block_t) completion { 
    ZFLoadGroupHierarchyOperation* operation = 
        [ZFLoadGroupHierarchyOperation loadGroupHierarchyOperation:self.user.credentials]; 
    operation.context = self;
    operation.delegate = self;
    operation.asyncObserver = observer;

    FLFinisher* finisher = [FLFinisher finisher:completion];
    finisher.finishOnMainThread = YES;
    
    [operation runAsynchronously:^(FLResult result) {
        [self.user setRootGroup:result];
        [finisher setFinishedWithResult:result];
    }];
}

- (void) beginDownloadingPhotos:(ZFBatchDownloadSpec*) spec 
                       observer:(id) observer 
                     completion:(fl_completion_block_t) completion {   
    
    ZFBatchPhotoDownloader* operation = [ZFBatchPhotoDownloader batchPhotoDownloadOperation:spec];
    operation.context = self;
    operation.asyncObserver = observer;
    operation.delegate = self;
    
    FLFinisher* finisher = [FLFinisher finisher:completion];
    finisher.finishOnMainThread = YES;
    
    [operation runAsynchronously:^(FLResult result) {
        [finisher setFinishedWithResult:result];
    }];
    
}

@end
