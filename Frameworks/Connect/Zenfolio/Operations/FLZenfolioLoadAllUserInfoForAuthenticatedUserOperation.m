//
//	FLZenfolioLoadAllUserInfoForAuthenticatedUserOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioLoadAllUserInfoForAuthenticatedUserOperation.h"
#import "FLObjectDescriber.h"
#import "FLZenfolioCache.h"
#import "FLZenfolioWebApi.h"

@implementation FLZenfolioLoadAllUserInfoForAuthenticatedUserOperation

- (FLResult) runSubOperations {

    FLHttpRequest* loadPrivate = [FLZenfolioHttpRequest loadPrivateProfileHttpRequest];
    FLZenfolioUser* privateUser = FLConfirmResultType([self sendHttpRequest:loadPrivate], FLZenfolioUser);
    
    FLHttpRequest* loadPublic = [FLZenfolioHttpRequest loadPublicProfileHttpRequest:privateUser.LoginName];
    FLZenfolioUser* publicUser = FLConfirmResultType([self sendHttpRequest:loadPublic], FLZenfolioUser);
    
    FLMergeObjects(privateUser, publicUser, FLMergeModePreserveDestination);

    return privateUser;
}


- (id) loadObjectFromDatabase {
    FLZenfolioUser* inputUser = [FLZenfolioUser user];
    inputUser.LoginName = [self.userContext userLogin].userName;
    
    return [[self.userContext objectCache] readObject:inputUser];
}

- (void) saveObjectToDatabase:(id) object {
    [[self.userContext objectCache] writeObject:object];
}

@end
