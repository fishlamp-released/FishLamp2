//
//	FLZenfolioLoadAllUserInfoForAuthenticatedUserOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioLoadAllUserInfoForAuthenticatedUserOperation.h"
#import "FLObjectDescriber.h"
#import "FLZenfolioCacheService.h"
#import "FLZenfolioHttpRequest.h"

@implementation FLZenfolioLoadAllUserInfoForAuthenticatedUserOperation

- (FLResult) runSubOperations {

    FLHttpRequest* loadPrivate = [FLZenfolioHttpRequest loadPrivateProfileHttpRequest];
    FLZenfolioUser* privateUser = FLConfirmResultType([loadPrivate sendSynchronouslyInContext:self.context], FLZenfolioUser);
    
    FLHttpRequest* loadPublic = [FLZenfolioHttpRequest loadPublicProfileHttpRequest:privateUser.LoginName];
    FLZenfolioUser* publicUser = FLConfirmResultType([loadPublic sendSynchronouslyInContext:self.context], FLZenfolioUser);
    
    FLMergeObjects(privateUser, publicUser, FLMergeModePreserveDestination);

    return privateUser;
}


- (id) loadObjectFromDatabase {
    FLZenfolioUser* inputUser = [FLZenfolioUser user];
    inputUser.LoginName = [[self context] userLogin].userName;
    
    return [[self.context cacheService] readObject:inputUser];
}

- (void) saveObjectToDatabase:(id) object {
    [[self.context cacheService] updateObject:object];
}

@end
