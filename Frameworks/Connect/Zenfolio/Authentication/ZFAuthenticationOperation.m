//
//  ZFAuthenticationOperation.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFAuthenticationOperation.h"
#import "ZFWebApi.h"
#import "FLHttpRequest+ZenfolioAuthentication.h"

@implementation ZFAuthenticationOperation

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

    ZFUser* privateProfile = [self sendAuthenticatedRequest:[ZFHttpRequest loadPrivateProfileHttpRequest] 
                                                          userLogin:authenticatedUser
                                                          inContext:context
                                                       withObserver:observer];
    
    ZFUser* publicProfile =  [self sendAuthenticatedRequest:[ZFHttpRequest loadPublicProfileHttpRequest:authenticatedUser.userName] 
                                                          userLogin:authenticatedUser
                                                          inContext:context
                                                       withObserver:observer];
    
    
    NSNumber* videoBool =  [self sendAuthenticatedRequest:[ZFHttpRequest checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                                             privilegeName:ZFVideoPrivilege] 
                                                userLogin:authenticatedUser
                                                inContext:context
                                             withObserver:observer];
    
    
    
    NSNumber* scrapbookBool =  [self sendAuthenticatedRequest:[ZFHttpRequest checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                                                 privilegeName:ZFScrapbookPrivilege] 
                                                    userLogin:authenticatedUser
                                                    inContext:context
                                                 withObserver:observer];



    authenticatedUser.email =  [privateProfile PrimaryEmail];
    authenticatedUser.userName = [privateProfile LoginName];
    authenticatedUser.rootGroupID = [publicProfile RootGroup].Id;

    if(videoBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:ZFVideoPrivilege];
    }
    
    if(scrapbookBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:ZFScrapbookPrivilege];
    }
    
    authenticatedUser.isAuthenticatedValue = YES;
    
    FLLog(@"Authentication completed");
    
    return authenticatedUser;
}
@end
