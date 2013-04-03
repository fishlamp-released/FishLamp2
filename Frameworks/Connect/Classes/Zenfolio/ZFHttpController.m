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
#import "ZFDownloadPhotoSetsOperation.h"

#import "FLDictionaryObjectStorageService.h"
#import "FLDatabaseObjectStorageService.h"

#define ZFHttpControllerHiddenFolderName @".downloader"

@interface ZFHttpController ()
@end

@implementation ZFHttpController

- (FLUserService*) createUserService {
    return [FLUserService userService];
}

- (FLObjectStorageService*) createObjectStorageService {
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

- (ZFHttpUser*) user {
    return nil;
}

- (void) operation:(ZFLoadGroupHierarchyOperation*) operation downloadedRootGroup:(FLResult) result {
    if(![result error]) {
        [self.user setRootGroup:result];
    }
}

- (id) createRootGroupDownloader {
    ZFLoadGroupHierarchyOperation* operation = 
        [ZFLoadGroupHierarchyOperation loadGroupHierarchyOperation:self.user.credentials]; 
    operation.context = self;
    [operation setFinishedDelegate:self action:@selector(operation:downloadedRootGroup:)];
    return operation;
}

- (id) createAllPhotoSetsDownloader {

    ZFDownloadPhotoSetsOperation* operation = 
            [ZFDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:self.user.rootGroup];
    operation.context = self;
    return operation;
}

- (ZFBatchDownloadOperation*) createBatchDownloader:(NSSet*) photoSets
                              destinationFolderPath:(NSString*) destinationPath
                                         mediaTypes:(NSArray*) mediaTypes {

    ZFBatchDownloadOperation* operation = 
        [ZFBatchDownloadOperation downloadOperation:photoSets 
                                          rootGroup:[self.user rootGroup]
                                    destinationPath:destinationPath
                                 downloadFolderName:ZFHttpControllerHiddenFolderName 
                                         mediaTypes:mediaTypes];
                                         
    operation.context = self;
    return operation;
}

@end
