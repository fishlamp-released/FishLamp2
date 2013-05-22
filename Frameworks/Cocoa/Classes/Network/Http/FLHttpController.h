//
//  FLHttpController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/30/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLNetworkOperationContext.h"

#import "FLStorageService.h"
#import "FLUserService.h"
#import "FLHttpRequest.h"
#import "FLHttpUser.h"
#import "FLHttpRequestAuthenticationService.h"

// TODO (MWF): removing this coupling
#import "FLDatabaseObjectStorageService.h"

extern NSString* const FLHttpControllerDidLogoutUserNotification;

@interface FLHttpController : FLNetworkOperationContext<
    FLHttpRequestAuthenticationServiceDelegate, FLUserLoginServiceDelegate,  FLHttpRequestContext,
    FLDatabaseObjectStorageServiceDelegate> {
@private
    id _httpUser;
    FLUserService* _userLoginService;
    FLService* _authenticatedServices;
    FLStorageService* _storageService;
    FLHttpRequestAuthenticationService* _httpRequestAuthenticator;
    FLNetworkStreamSecurity _streamSecurity;

    __unsafe_unretained id _delegate;
}

@property (readwrite, nonatomic) FLNetworkStreamSecurity streamSecurity;
@property (readwrite, assign, nonatomic) id delegate;

@property (readonly, assign, nonatomic) BOOL isAuthenticated;
@property (readonly, strong) FLService* authenticatedServices;
@property (readonly, strong) FLUserService* userService;
@property (readonly, strong) FLStorageService* storageService;
@property (readonly, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;
@property (readonly, strong) id httpUser;

- (void) logoutUser;

- (void) openUserService;


// TODO (MWF): Not too happy with this construction abstraction.
// optional overrides
- (FLHttpUser*) createHttpUserForCredentials:(id<FLCredentials>) credentials;
- (FLUserService*) createUserService;
- (FLStorageService*) createStorageService;
- (FLHttpRequestAuthenticationService*) createHttpRequestAuthenticationService;

@end

@protocol FLHttpControllerDelegate <NSObject>
@optional

- (void) httpController:(FLHttpController*) controller
    didAuthenticateUser:(FLHttpUser*) userLogin;

- (void) httpController:(FLHttpController*) controller 
          didLogoutUser:(FLHttpUser*) userLogin;

- (void) httpControllerDidClose:(FLHttpController*) controller;
- (void) httpControllerDidOpen:(FLHttpController*) controller;
@end


