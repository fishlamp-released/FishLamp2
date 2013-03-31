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
    NSString* _authenticationDomain;
    BOOL _rememberPassword;
}
@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;
@property (readwrite, assign, nonatomic) BOOL rememberPassword;
@property (readwrite, strong, nonatomic) NSString* authenticationDomain;

+ (id) userServiceWithAuthenticationDomain:(NSString*) authenticationDomain;

- (void) removeFromUserDefaults;
- (void) loadFromUserDefaults;
- (void) saveToUserDefaults;

- (void) loadCredentials;
- (void) saveCredentials;

- (BOOL) canAuthenticate;

@end

@protocol FLUserLoginServiceDelegate <FLServiceDelegate>
- (void) userServiceDidOpen:(FLUserService*) service;
- (void) userServiceDidClose:(FLUserService*) service;
@end

