//
//  FLZenfolioAuthenticationOperation.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioAuthenticationOperation.h"
#import "FLZenfolioWebApi.h"
#import "FLHttpRequest+ZenfolioAuthentication.h"

@implementation FLZenfolioAuthenticationOperation

- (FLResult) sendAuthenticatedRequest:(FLHttpRequest*) request 
                            userLogin:(FLUserLogin*) userLogin
                            inContext:(id) context 
                         withObserver:(id) observer  {

    request.disableAuthenticator = YES;
    [request setAuthenticationToken:userLogin.authToken];
    
    return FLThrowIfError([context runWorker:request withObserver:observer]);
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {

    FLUserLogin* authenticatedUser = self.userLogin;

    FLZenfolioUser* privateProfile = [self sendAuthenticatedRequest:[FLZenfolioHttpRequest loadPrivateProfileHttpRequest] 
                                                          userLogin:authenticatedUser
                                                          inContext:context
                                                       withObserver:observer];
    
    FLZenfolioUser* publicProfile =  [self sendAuthenticatedRequest:[FLZenfolioHttpRequest loadPublicProfileHttpRequest:authenticatedUser.userName] 
                                                          userLogin:authenticatedUser
                                                          inContext:context
                                                       withObserver:observer];
    
    
    NSNumber* videoBool =  [self sendAuthenticatedRequest:[FLZenfolioHttpRequest checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                                             privilegeName:FLZenfolioVideoPrivilege] 
                                                userLogin:authenticatedUser
                                                inContext:context
                                             withObserver:observer];
    
    
    
    NSNumber* scrapbookBool =  [self sendAuthenticatedRequest:[FLZenfolioHttpRequest checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                                                 privilegeName:FLZenfolioScrapbookPrivilege] 
                                                    userLogin:authenticatedUser
                                                    inContext:context
                                                 withObserver:observer];



    authenticatedUser.email =  [privateProfile PrimaryEmail];
    authenticatedUser.userName = [privateProfile LoginName];
    authenticatedUser.rootGroupID = [publicProfile RootGroup].Id;

    if(videoBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:FLZenfolioVideoPrivilege];
    }
    
    if(scrapbookBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:FLZenfolioScrapbookPrivilege];
    }
    
    authenticatedUser.isAuthenticatedValue = YES;
    
    FLLog(@"Authentication completed");
    
    return authenticatedUser;
}
@end
