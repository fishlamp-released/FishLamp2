//
//  ZFHttpUser.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFHttpUser.h"

@implementation ZFHttpUser

@synthesize privateProfile = _privateProfile;
@synthesize publicProfile = _publicProfile;
@synthesize rootGroup = _rootGroup;

- (id) init {
    self = [super init];
    if(self) {
        self.timeoutInterval = ZFHttpAuthenticationTimeout;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_privateProfile release];
    [_publicProfile release];
    [_rootGroup release];
    [super dealloc];
}
#endif

- (BOOL) isAuthenticated {
    FLUserLogin* userLogin = self.credentials;

    return userLogin.isAuthenticatedValue && 
            FLStringIsNotEmpty([userLogin authToken]);
}

- (id) copyWithZone:(NSZone *)zone {
    ZFHttpUser* user = [super copyWithZone:zone];
    user.privateProfile = self.privateProfile;
    user.publicProfile = self.publicProfile;
    return user;
}

- (NSString*) userName {
    return self.privateProfile.LoginName;
}

@end
