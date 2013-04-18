//
//  FLHttpController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/30/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkOperationContext.h"

#import "FLObjectStorageService.h"
#import "FLUserService.h"
#import "FLHttpRequest.h"
#import "FLHttpUser.h"
#import "FLHttpRequestAuthenticationService.h"

extern NSString* const FLHttpControllerDidLogoutUserNotification;

@interface FLHttpController : FLNetworkOperationContext<
    FLHttpRequestAuthenticationServiceDelegate, FLUserLoginServiceDelegate,  FLHttpRequestContext> {
@private
    FLUserService* _userLoginService;
    FLService* _authenticatedServices;
    FLObjectStorageService* _objectStorageService;
    FLHttpRequestAuthenticationService* _httpRequestAuthenticator;
    __unsafe_unretained id _delegate;
    FLNetworkStreamSecurity _streamSecurity;
}

@property (readwrite, nonatomic) FLNetworkStreamSecurity streamSecurity;
@property (readwrite, assign, nonatomic) id delegate;
@property (readonly, assign, nonatomic) BOOL isAuthenticated;
@property (readonly, strong) FLService* authenticatedServices;
@property (readonly, strong) FLUserService* userService;
@property (readonly, strong) FLObjectStorageService* objectStorageService;
@property (readonly, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;

- (id) initWithAuthenticationDomain:(NSString*) authenticationDomain;

+ (id) httpController;

- (void) logoutUser;

- (void) openUserService;

// required overrides
- (FLHttpUser*) user;
- (FLUserService*) createUserService;
- (FLObjectStorageService*) createObjectStorageService;
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