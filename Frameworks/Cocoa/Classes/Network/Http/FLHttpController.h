//
//  FLHttpController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/30/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkOperationContext.h"

#import "FLStorageService.h"
#import "FLUserService.h"
#import "FLHttpRequest.h"
#import "FLHttpUser.h"
#import "FLHttpRequestAuthenticationService.h"

extern NSString* const FLHttpControllerDidLogoutUserNotification;

@protocol FLHttpControllerImplementation <NSObject>
- (FLHttpUser*) createHttpUserForCredentials:(id<FLCredentials>) credentials;
- (FLUserService*) createUserService;
- (FLStorageService*) createStorageService;
- (FLHttpRequestAuthenticationService*) createHttpRequestAuthenticationService;
@end

@interface FLHttpController : FLNetworkOperationContext<
    FLHttpRequestAuthenticationServiceDelegate, FLUserLoginServiceDelegate,  FLHttpRequestContext> {
@private
    id _httpUser;
    FLUserService* _userLoginService;
    FLService* _authenticatedServices;
    FLStorageService* _storageService;
    FLHttpRequestAuthenticationService* _httpRequestAuthenticator;
    FLNetworkStreamSecurity _streamSecurity;

    __unsafe_unretained id _delegate;
    __unsafe_unretained id<FLHttpControllerImplementation> _implementation;
}

@property (readwrite, nonatomic) FLNetworkStreamSecurity streamSecurity;
@property (readwrite, assign, nonatomic) id delegate;

@property (readonly, assign, nonatomic) BOOL isAuthenticated;
@property (readonly, strong) FLService* authenticatedServices;
@property (readonly, strong) FLUserService* userService;
@property (readonly, strong) FLStorageService* storageService;
@property (readonly, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;
@property (readonly, strong) id httpUser;

- (id) initWithImplementation:(id<FLHttpControllerImplementation>) implementation;

- (void) logoutUser;

- (void) openUserService;

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