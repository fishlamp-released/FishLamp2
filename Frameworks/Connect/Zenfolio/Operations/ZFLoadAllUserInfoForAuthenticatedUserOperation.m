//
//	ZFLoadAllUserInfoForAuthenticatedUserOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "ZFLoadAllUserInfoForAuthenticatedUserOperation.h"
#import "FLObjectDescriber.h"
#import "ZFCacheService.h"
#import "ZFWebApi.h"
#if REFACTOR
@implementation ZFLoadAllUserInfoForAuthenticatedUserOperation

- (FLResult) runSubOperations {

    FLHttpRequest* loadPrivate = [ZFHttpRequest loadPrivateProfileHttpRequest];
    ZFUser* privateUser = [self runChildSynchronously:loadPrivate];
    
    FLHttpRequest* loadPublic = [ZFHttpRequest loadPublicProfileHttpRequest:privateUser.LoginName];
    ZFUser* publicUser = [self runChildSynchronously:loadPublic];
    
    FLMergeObjects(privateUser, publicUser, FLMergeModePreserveDestination);

    return privateUser;
}


- (id) loadObjectFromDatabase {
    ZFUser* inputUser = [ZFUser user];
    inputUser.LoginName = [self.userContext userLogin].userName;
    
    return [[self.userContext cache] readObject:inputUser];
}

- (void) saveObjectToDatabase:(id) object {
    [[self.userContext cache] writeObject:object];
}

@end
#endif