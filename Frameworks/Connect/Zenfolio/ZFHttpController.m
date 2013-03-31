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

#import "FLDictionaryObjectStorage.h"

@interface ZFHttpController ()
@end

@implementation ZFHttpController

- (FLUserService*) createUserService {
    return [FLUserService userServiceWithAuthenticationDomain:@"www.zenfolio.com"];
}

- (FLObjectStorageService*) createObjectStorageService {
    return [FLObjectStorageService objectStorageService:[FLDictionaryObjectStorage dictionaryObjectStorage]];
}

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
                                         mediaTypes:mediaTypes];
                                         
    operation.context = self;
    return operation;
}

@end
