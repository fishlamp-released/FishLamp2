//
//	FLUserService.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "FLService.h"

@protocol FLUserLoginServiceDelegate;

@interface FLUserService : FLService {
@private    
    NSString* _userName;
    NSString* _password;
    BOOL _rememberPassword;
    BOOL _loaded;
}
@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;
@property (readwrite, assign, nonatomic) BOOL rememberPassword;

+ (id) userService;

- (void) loadCredentials;
- (void) saveCredentials;
- (void) clearCredentials;

- (BOOL) canAuthenticate;

@end

@protocol FLUserLoginServiceDelegate <FLServiceDelegate>
- (void) userServiceDidOpen:(FLUserService*) service;
- (void) userServiceDidClose:(FLUserService*) service;
@end

