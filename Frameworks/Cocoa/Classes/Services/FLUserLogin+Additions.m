//
// FLUserLogin.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2013 GreenTongue Software, LLC., Mike Fullerton
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUserLogin.h"
#import "FLCredentials.h"

@implementation FLUserLogin (c)

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
