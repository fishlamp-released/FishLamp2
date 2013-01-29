//
//	FLZfLoadAllUserInfoForAuthenticatedUserOperation.m
//	MyZen
//
//	Created by Mike Fullerton on 10/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZfLoadAllUserInfoForAuthenticatedUserOperation.h"
#import "FLObjectDescriber.h"
#import "FLZfCacheService.h"
#import "FLZfHttpRequest.h"

@implementation FLZfLoadAllUserInfoForAuthenticatedUserOperation

- (FLResult) runSubOperations {

    FLHttpRequest* loadPrivate = [FLZfHttpRequest loadPrivateProfileHttpRequest];
    FLZfUser* privateUser = FLConfirmResultType([loadPrivate sendSynchronouslyInContext:self.context], FLZfUser);
    
    FLHttpRequest* loadPublic = [FLZfHttpRequest loadPublicProfileHttpRequest:privateUser.LoginName];
    FLZfUser* publicUser = FLConfirmResultType([loadPublic sendSynchronouslyInContext:self.context], FLZfUser);
    
    FLMergeObjects(privateUser, publicUser, FLMergeModePreserveDestination);

    return privateUser;
}


- (id) loadObjectFromDatabase {
    FLZfUser* inputUser = [FLZfUser user];
    inputUser.LoginName = [[self context] userLogin].userName;
    
    return [[self.context cacheService] readObject:inputUser];
}

- (void) saveObjectToDatabase:(id) object {
    [[self.context cacheService] updateObject:object];
}

@end
