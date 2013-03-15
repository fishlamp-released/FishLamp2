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
#import "FLZenfolioChallengeResponseAuthenticationOperation.h"

@implementation FLZenfolioRegisteredUserAuthenticationService

+ (id) registeredUserAuthenticationService {
    return FLAutorelease([[[self class] alloc] init]);
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

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin 
                                     inContext:(id) context {

    FLOperation* authenticator = [FLZenfolioChallengeResponseAuthenticationOperation userAuthenticationOperation:userLogin];
    return FLThrowIfError([context runWorker:authenticator withObserver:nil]);
}

@end
