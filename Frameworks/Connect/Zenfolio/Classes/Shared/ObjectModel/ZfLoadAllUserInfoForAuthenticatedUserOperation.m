//
//	ZFLoadAllUserInfoForAuthenticatedUserOperation.m
//	MyZen
//
//	Created by Mike Fullerton on 10/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "ZFLoadAllUserInfoForAuthenticatedUserOperation.h"
#import "FLObjectDescriber.h"
#import "ZFCacheService.h"
#import "ZFHttpRequest.h"

@implementation ZFLoadAllUserInfoForAuthenticatedUserOperation

- (FLResult) runSubOperations {

    FLHttpRequest* loadPrivate = [ZFHttpRequest loadPrivateProfileHttpRequest];
    ZFUser* privateUser = FLConfirmResultType([loadPrivate sendSynchronouslyInContext:self.context], ZFUser);
    
    FLHttpRequest* loadPublic = [ZFHttpRequest loadPublicProfileHttpRequest:privateUser.LoginName];
    ZFUser* publicUser = FLConfirmResultType([loadPublic sendSynchronouslyInContext:self.context], ZFUser);
    
    FLMergeObjects(privateUser, publicUser, FLMergeModePreserveDestination);

    return privateUser;
}


- (id) loadObjectFromDatabase {
    ZFUser* inputUser = [ZFUser user];
    inputUser.LoginName = [[self context] userLogin].userName;
    
    return [[self.context cacheService] readObject:inputUser];
}

- (void) saveObjectToDatabase:(id) object {
    [[self.context cacheService] updateObject:object];
}

@end
