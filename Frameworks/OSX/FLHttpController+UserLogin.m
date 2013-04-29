//
//  FLHttpController+UserLogin.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpController+UserLogin.h"
#import "FLLoginPanel.h"

@implementation FLHttpController (UserLogin)

- (FLLoginPanelCredentials*) loginPanelGetCredentials:(FLLoginPanel*) panel {
    [self.userService loadCredentials];
    
    FLLoginPanelCredentials* user = [FLLoginPanelCredentials loginPanelUser];
    user.userName = [self.userService userName];
    user.password = [self.userService password ];
    user.rememberPassword = [self.userService rememberPassword];
    return user;
}

- (void) setCredentials:(FLLoginPanelCredentials*) user {
    [self.userService setUserName:user.userName];
    [self.userService setPassword:user.password];
    [self.userService setRememberPassword:user.rememberPassword];
}

- (void) saveCredentials:(FLLoginPanelCredentials*) user {
    [self setCredentials:user];
    [self.userService saveCredentials];
}

- (void) loginPanel:(FLLoginPanel*) loginPanel 
didChangeCredentials:(FLLoginPanelCredentials*) user {
    
    if(self.userService.isServiceOpen) {
        [self.userService closeService:self];
    }
    
    [self setCredentials:user];
}

- (void) loginPanel:(FLLoginPanel*) panel 
beginAuthenticatingWithCredentials:(FLLoginPanelCredentials*) credentials
         completion:(fl_result_block_t) completion {
         
    [self openUserService];
    [self saveCredentials:credentials];
    [self.httpRequestAuthenticator beginAuthenticating:completion];
}

- (void) loginPanelDidCancelAuthentication:(FLLoginPanel*) panel {
    [self requestCancel];
}

- (void) loginPanel:(FLLoginPanel*) loginPanel 
   saveCredentials:(FLLoginPanelCredentials*) credentials {

    [self saveCredentials:credentials];
}

- (BOOL) loginPanel:(FLLoginPanel*) panel 
credentialsAreAuthenticated:(FLLoginPanelCredentials*) credentials {

    return  FLStringsAreEqual(credentials.userName, [self.userService userName]) &&
            (FLStringIsNotEmpty([self.userService password]) && FLStringsAreEqual(credentials.password, [self.userService password])) &&
            [self isAuthenticated];
}


@end
