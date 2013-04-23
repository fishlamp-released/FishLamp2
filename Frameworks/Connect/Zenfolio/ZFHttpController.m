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

- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
   didDownloadPhotoSetWithResult:(FLResult) result {

    [downloader.asyncObserver receiveObservation:@selector(httpController:didDownloadPhotoSetForRootGroupWithResult:) 
                                      fromSender:self 
                                      withObject:result];
}             


- (FLFinisher*) beginDownloadingAllPhotoSetsForRootGroup:(id)observer
                                           completion:(fl_completion_block_t) completion {
    
    ZFBatchPhotoSetDownloader* downloader =    
            [ZFBatchPhotoSetDownloader batchPhotoSetDownloaderForGroup:self.user.rootGroup withPhotos:NO];
    
    downloader.context = self;
    downloader.delegate = self;
    downloader.asyncObserver = observer;

    FLFinisher* finisher = [FLFinisher finisher:completion];
    
    [downloader runAsynchronously:^(FLResult result) {
        [self.user setRootGroup:result];
        [observer receiveObservation:@selector(httpController:didDownloadAllPhotoSetsForRootGroupWithResult:) 
                          fromSender:self 
                          withObject:result];
        [finisher setFinishedWithResult:result];
    }];
    
    return finisher;

                                           
}                                           

- (FLFinisher*) beginDownloadingRootGroup:(id) observer 
                               completion:(fl_completion_block_t) completion {
    ZFLoadGroupHierarchyOperation* operation = 
        [ZFLoadGroupHierarchyOperation loadGroupHierarchyOperation:self.user.credentials]; 
    operation.context = self;
 //   operation.delegate = self;
    
    FLFinisher* finisher = [FLFinisher finisher:completion];
    
    [operation runAsynchronously:^(FLResult result) {
        [self.user setRootGroup:result];
        [observer receiveObservation:@selector(httpController:didDownloadRootGroupWithResult:) fromSender:self withObject:result];
        [finisher setFinishedWithResult:result];
    }];
    
    return finisher;
}



- (ZFBatchPhotoDownloader*) createBatchDownloader:(ZFBatchDownloadSpec*) spec {
    ZFBatchPhotoDownloader* operation = [ZFBatchPhotoDownloader batchPhotoDownloadOperation:spec];
    operation.context = self;
    return operation;
}

@end
