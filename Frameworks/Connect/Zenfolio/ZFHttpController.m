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

#define ZFHttpControllerHiddenFolderName @".Composer"

@interface ZFHttpController ()
@end

@implementation ZFHttpController
@synthesize user = _user;

- (FLUserService*) createUserService {
    return [FLUserService userService];
}

- (FLObjectStorageService*) createObjectStorageService {
    return [FLDictionaryObjectStorageService dictionaryObjectStorageService];
}

- (NSString*) databaseObjectStorageServiceGetDatabasePath:(FLDatabaseObjectStorageService*) service {
    return [[self.user userDataFolderPath] stringByAppendingPathComponent:@"Composer.sqlite"];
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

- (void) operation:(ZFLoadGroupHierarchyOperation*) operation downloadedRootGroup:(FLResult) result {
    if(![result error]) {
        [self.user setRootGroup:result];
    }
}

- (id) createRootGroupComposer {
    ZFLoadGroupHierarchyOperation* operation = 
        [ZFLoadGroupHierarchyOperation loadGroupHierarchyOperation:self.user.credentials]; 
    operation.context = self;
    [operation setFinishedDelegate:self action:@selector(operation:downloadedRootGroup:)];
    return operation;
}

- (id) createAllPhotoSetsComposer {

    ZFDownloadPhotoSetsOperation* operation = 
            [ZFDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:self.user.rootGroup];
    operation.context = self;
    return operation;
}

- (ZFBatchDownloadOperation*) createBatchComposer:(ZFBatchDownloadSpec*) spec {
    ZFBatchDownloadOperation* operation = [ZFBatchDownloadOperation downloadOperation:spec];
    operation.context = self;
    return operation;
}

@end
