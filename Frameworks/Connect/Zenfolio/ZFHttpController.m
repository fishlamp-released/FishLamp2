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

//- (void) operation:(ZFLoadGroupHierarchyOperation*) operation downloadedRootGroup:(id<FLAsyncResult>) result {
//    if(![result error] ) {
//        [self.user setRootGroup:result];
//    }
//}

//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation updateDownloadInfo:(ZFTransferState*) downloadInfo {
//    [operation.asyncObserver receiveObservation:@selector(httpController:updateDownloadInfo:) fromSender:self withObject:downloadInfo];
//}
//
//- (void) batchPhotoDownloaderWillBeginDownload:(ZFBatchPhotoDownloader*) operation {
////    [operation.asyncObserver receiveObservation:@selector(httpController:updateDownloadInfo:) fromSneder:self withObject:downloadInfo];
//}
//
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation willUpdatePhotoSet:(ZFPhotoSet*) photoSet {
//    [operation.asyncObserver receiveObservation:@selector(httpController:willUpdatePhotoSet:) fromSender:self withObject:photoSet];
//}
//
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didUpdatePhotoSet:(ZFPhotoSet*) photoSet {
//    [operation.asyncObserver receiveObservation:@selector(httpController:didUpdatePhotoSet:) fromSender:self withObject:photoSet];
//}
//
////- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation willStartDownloadingPhotosInPhotoSet:(NSDictionary*) downloadInfo {
////    [operation.asyncObserver receiveObservation:@selector(httpController:willStartDownloadingPhotosInPhotoSet:) fromSender:self withObject:photoSet];
////}
//
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation willDownloadPhoto:(ZFDownloadSpec*) downloadInfo {
//    [operation.asyncObserver receiveObservation:@selector(httpController:willDownloadPhoto:) fromSender:self withObject:downloadInfo];
//}
//
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didSkipPhoto:(ZFDownloadSpec*) downloadInfo {
//    [operation.asyncObserver receiveObservation:@selector(httpController:didSkipPhoto:) fromSender:self withObject:downloadInfo];
//}
//
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didDownloadPhoto:(ZFDownloadSpec*) downloadInfo {
//    [operation.asyncObserver receiveObservation:@selector(httpController:didDownloadPhoto:) fromSender:self withObject:downloadInfo];
//}
//
////- (void) batchPhotoDownloader:(ZFBatchPhotoDownloader*) operation didDownloadPhotosInPhotoSet:(NSDictionary*) downloadInfo {
////}
//
//
//
//- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
//             didDownloadPhotoSet:(ZFPhotoSet*) photoSet {
//
//    [downloader.asyncObserver receiveObservation:@selector(httpController:didDownloadPhotoSetForRootGroup:) 
//                                      fromSender:self 
//                                      withObject:photoSet];
//}             


- (void) beginDownloadingAllPhotoSetsForRootGroup:(id<ZFAsyncObserving>)observer {
    
    ZFBatchPhotoSetDownloader* downloader =    
            [ZFBatchPhotoSetDownloader batchPhotoSetDownloaderForGroup:self.user.rootGroup withPhotos:NO];
    
    downloader.context = self;
    downloader.delegate = self;
    downloader.observer = observer;
   
    [downloader runAsynchronously];
}   

- (void) loadGroupHierarchyOperation:(ZFLoadGroupHierarchyOperation*) operation didLoadRootGroupWithResult:(id<FLAsyncResult>) result {
    if(![result error]) {
        [self.user setRootGroup:result.returnedObject];
    }
}                                        

- (void) beginDownloadingRootGroup:(id<ZFAsyncObserving>) observer { 
    ZFLoadGroupHierarchyOperation* operation = 
        [ZFLoadGroupHierarchyOperation loadGroupHierarchyOperation:self.user.credentials]; 
    operation.context = self;
    operation.observer = observer;
    operation.delegate = self;
    [operation runAsynchronously];
}

- (void) beginDownloadingPhotos:(ZFBatchDownloadSpec*) spec 
                       observer:(id) observer  {   
    
    ZFBatchPhotoDownloader* operation = [ZFBatchPhotoDownloader batchPhotoDownloadOperation:spec];
    operation.context = self;
    operation.observer = observer;
    operation.delegate = self;
    
    [operation runAsynchronously];
    
}

@end
