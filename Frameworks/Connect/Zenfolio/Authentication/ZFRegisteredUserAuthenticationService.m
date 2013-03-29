//
//  ZFRegisteredUserAuthenticationService.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFRegisteredUserAuthenticationService.h"
#import "ZFErrors.h"
#import "FLHttpRequest+ZenfolioAuthentication.h"
#import "ZFChallengeResponseAuthenticationOperation.h"

@implementation ZFRegisteredUserAuthenticationService

+ (id) registeredUserAuthenticationService {
    return FLAutorelease([[[self class] alloc] init]);
}

//- (BOOL) userLoginIsAuthenticated:(FLUserLogin*) userLogin {
//    if(![super userLoginIsAuthenticated:userLogin]) {
//        return NO;
//    }
//
//    // check a couple of things for registered users.
//    // check to see if userName is email address, if it is, we'll have to authenticated and find out userName
//    if( (userLogin.userName && [userLogin.userName rangeOfString:@"@"].length > 0) || FLStringIsEmpty(userLogin.email)) {
//        return NO;
//    }
//
//#if REFACTOR
//
//// if IOS
//    int rootGroupId = userLogin.userValueValue; // YUCK. 
//
//    if(rootGroupId == 0) {
//       return NO;
//    }
//
//    if(token) {
//        ZFPreferences* prefs = [[ZFPrefsService serviceFromContext:operation.context] loadPreferences];
//        if(!prefs.didCheckScrapbookPrivilegeValue) {
//            return NO;
//        }
//    }
//#endif        
//    
//    return YES;
//}

- (void) authenticateUser:(ZFHttpUser*) user {

    FLOperation* authenticator = [ZFChallengeResponseAuthenticationOperation authenticationOperation:user];
    [authenticator runInContext:self.workerContext];
}

@end
