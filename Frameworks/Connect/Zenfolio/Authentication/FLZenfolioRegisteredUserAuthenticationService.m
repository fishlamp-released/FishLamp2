//
//  FLZenfolioRegisteredUserAuthenticationService.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioRegisteredUserAuthenticationService.h"
#import "FLZenfolioErrors.h"
#import "FLHttpRequest+ZenfolioAuthentication.h"
#import "FLZenfolioAuthenticateOperation.h"

@implementation FLZenfolioRegisteredUserAuthenticationService

- (FLResult) sendAuthenticatedRequest:(FLHttpRequest*) request 
                            userLogin:(FLUserLogin*) userLogin
                            inContext:(id) context 
                         withObserver:(id) observer  {

    [request setAuthenticationToken:userLogin.authToken];
    return [context runWorker:request withObserver:observer];
}

- (BOOL) userLoginIsAuthenticated:(FLUserLogin*) userLogin {
    if(![super userLoginIsAuthenticated:userLogin]) {
        return NO;
    }

    // check a couple of things for registered users.
    // check to see if userName is email address, if it is, we'll have to authenticated and find out userName
    if( (userLogin.userName && [userLogin.userName rangeOfString:@"@"].length > 0) || FLStringIsEmpty(userLogin.email)) {
        return NO;
    }

#if REFACTOR

// if IOS
    int rootGroupId = userLogin.userValueValue; // YUCK. 

    if(rootGroupId == 0) {
       return NO;
    }

    if(token) {
        FLZenfolioPreferences* prefs = [[FLZenfolioPrefsService serviceFromContext:operation.context] loadPreferences];
        if(!prefs.didCheckScrapbookPrivilegeValue) {
            return NO;
        }
    }
#endif        
    
    return YES;
}

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin inContext:(id) context withObserver:(id) observer {

    FLTrace(@"Authenticating %@:", userLogin.userName );

    if(FLStringIsEmpty(userLogin.password)) {
    // can't authenticate because we don't have a pw. So put an error in the httpRequestFactory so ui can prompt for password.

        FLTrace(@"auth failed because password is empty");
        
        FLThrowError( [NSError errorWithDomain:FLZenfolioErrorDomain
                                           code:FLZenfolioErrorCodeInvalidCredentials
                           localizedDescription:NSLocalizedString(@"Password is incorrect", nil)]);
    }
    
    FLOperation* authenticator = [FLZenfolioAuthenticateOperation userAuthenticationOperation:userLogin];
    
    FLUserLogin* authenticatedUser = [context runWorker:authenticator withObserver:observer];
    
    FLZenfolioUser* privateProfile = [self sendAuthenticatedRequest:[FLZenfolioHttpRequest loadPrivateProfileHttpRequest] 
                                                          userLogin:authenticatedUser
                                                          inContext:context
                                                       withObserver:observer];
    
    FLZenfolioUser* publicProfile =  [self sendAuthenticatedRequest:[FLZenfolioHttpRequest loadPublicProfileHttpRequest:userLogin.userName] 
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

    return authenticatedUser;
}

@end
