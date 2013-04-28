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

- (FLPromisedResult) runSubOperations {

    FLHttpRequest* loadPrivate = [ZFHttpRequestFactory loadPrivateProfileHttpRequest];
    FLPromisedResult privateUser = [self runChildSynchronously:loadPrivate];
    FLThrowIfError(privateUser);
    
    FLHttpRequest* loadPublic = [ZFHttpRequestFactory loadPublicProfileHttpRequest:privateUser.LoginName];
    FLPromisedResult publicUser = [self runChildSynchronously:loadPublic];
    FLThrowIfError(publicUser);
    
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