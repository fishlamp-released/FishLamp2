// [Generated]
//
// FLUserLogin.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
// [/Generated]

#import "__FLUserLogin.h"
#import "FLUserLogin.h"

@implementation FLUserLogin (ObjC)

+ (id) userLogin:(NSString*) userName password:(NSString*) password {
    FLUserLogin* userLogin = [FLUserLogin userLogin];
    userLogin.userName = userName;
    userLogin.password = password;
    return userLogin;
}

- (void) setPropertiesWithUserLogin:(FLUserLogin*) login {
    self.userName = login.userName;
    self.authToken = login.authToken;
    self.email = login.email;
    self.isAuthenticated = login.isAuthenticated;
    self.authTokenLastUpdateTime = login.authTokenLastUpdateTime;
    self.password = login.password;
    self.userGuid = login.userGuid;
}

+ (id) userLoginWithCredentials:(id<FLCredentials>) credentials {
    return [self userLogin:credentials.userName password:credentials.password];
}

@end
