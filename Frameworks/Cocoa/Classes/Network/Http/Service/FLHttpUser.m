//
//  FLHttpUser.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpUser.h"
#import "FLAppInfo.h"

@implementation FLHttpUser

@synthesize credentials = _userLogin;
@synthesize lastAuthenticationTimestamp = _lastAuthenticationTimestamp;
@synthesize timeoutInterval = _timeoutInterval;

- (id) init {
    return [self initWithCredentials:nil];
}

- (id) initWithCredentials:(FLUserLogin*) userLogin {
    self = [super init];
    if(self) {
        _timeoutInterval = 60 * 60;

        self.credentials = userLogin;
    }
    return self;
}

+ (id) httpUserWithCredentials:(FLUserLogin*) userLogin {
    return FLAutorelease([[[self class] alloc] initWithCredentials:userLogin]);
}

#if FL_MRC
- (void) dealloc {
    [_userLogin release];
    [super dealloc];
}
#endif

- (NSString*) userName {
    return self.credentials.userName;
}

- (BOOL) isAuthenticated {
    return _userLogin.isAuthenticatedValue;
}

- (void) setUnathenticated {
    _userLogin.isAuthenticated = NO;
    _userLogin.authToken = NO;
    _userLogin.authTokenLastUpdateTime = nil;
    _userLogin.password = @"";
    [self resetAuthenticationTimestamp];
}

- (void) touchAuthenticationTimestamp {
    _lastAuthenticationTimestamp = [NSDate timeIntervalSinceReferenceDate];
}

- (void) resetAuthenticationTimestamp {
	_lastAuthenticationTimestamp = 0;
}

- (id) copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithCredentials:self.credentials];
}

- (BOOL) authenticationHasExpired {
    return ([NSDate timeIntervalSinceReferenceDate] - _lastAuthenticationTimestamp) > _timeoutInterval;
}

- (NSString*) userFolderPath {
    return [NSString stringWithFormat:@"%@/%@", [FLAppInfo bundleIdentifier], self.userName];
}

- (NSString*) cacheFolderPath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [cachePath stringByAppendingPathComponent:[self userFolderPath]];
}
 
- (NSString*) userDataFolderPath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:[self userFolderPath]];
} 
 

@end