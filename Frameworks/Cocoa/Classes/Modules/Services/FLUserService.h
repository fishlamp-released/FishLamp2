//
//	FLUserService.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLampCore.h"
#import "FLService.h"
#import "FLAuthenticated.h"
#import "FLCredentialsStorage.h"

@protocol FLUserLoginServiceDelegate;

@interface FLUserService : FLService<FLAuthenticated> {
@private    
    id<FLCredentials> _authCredentials;
    id<FLCredentialsStorage> _credentialStorage;
}
@property (readwrite, strong, nonatomic) id<FLCredentialsStorage> credentialStorage;

+ (id) userService;

- (BOOL) canAuthenticate;
- (NSString*) userName;

@end

@protocol FLUserLoginServiceDelegate <FLServiceDelegate>
- (void) userServiceDidOpen:(FLUserService*) service;
- (void) userServiceDidClose:(FLUserService*) service;
@end

