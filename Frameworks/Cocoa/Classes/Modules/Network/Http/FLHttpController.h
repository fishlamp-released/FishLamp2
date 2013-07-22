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

@protocol FLHttpControllerServiceFactory;

@protocol FLUserService;

extern NSString* const FLHttpControllerDidLogoutUserNotification;

@interface FLHttpController : FLNetworkOperationContext<
    FLHttpRequestAuthenticationServiceDelegate, FLUserServiceDelegate,  FLHttpRequestContext,
    FLDatabaseObjectStorageServiceDelegate> {
@private
    id _httpUser;
    id<FLUserService> _userService;

    id<FLStorageService> _storageService;

    FLService* _authenticatedServices;
    FLHttpRequestAuthenticationService* _httpRequestAuthenticator;
    FLNetworkStreamSecurity _streamSecurity;

    id<FLHttpControllerServiceFactory> _serviceFactory;

    __unsafe_unretained id _delegate;
}

- (id) initWithServiceFactory:(id<FLHttpControllerServiceFactory>) factory;

+ (id) httpController:(id<FLHttpControllerServiceFactory>) factory;

@property (readonly, strong) id<FLHttpControllerServiceFactory> serviceFactory;

@property (readwrite, assign, nonatomic) FLNetworkStreamSecurity streamSecurity;
@property (readwrite, assign, nonatomic) id delegate;

@property (readonly, assign, nonatomic) BOOL isAuthenticated;
@property (readonly, strong) FLService* authenticatedServices;

@property (readonly, strong) id<FLUserService> userService;

@property (readonly, strong) id<FLStorageService> storageService;

@property (readonly, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;

@property (readonly, strong) id httpUser;

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

@protocol FLHttpControllerServiceFactory <NSObject>
- (FLHttpUser*) httpController:(FLHttpController*) controller
  createHttpUserForCredentials:(id<FLCredentials>) credentials;

- (id<FLUserService>) httpControllerCreateUserService:(FLHttpController*) controller;

- (id<FLStorageService>) httpControllerCreateStorageService:(FLHttpController*) controller;

- (FLHttpRequestAuthenticationService*) httpControllerCreateHttpRequestAuthenticationService:(FLHttpController*) controller;

@end

@interface FLHttpControllerServiceFactory : NSObject<FLHttpControllerServiceFactory>
+ (id<FLHttpControllerServiceFactory>) httpControllerServiceFactory;
@end