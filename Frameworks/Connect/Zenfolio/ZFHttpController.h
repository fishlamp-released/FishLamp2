//
//  ZFHttpController.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectStorage.h"
#import "ZFWebApi.h"
#import "FLService.h"
#import "FLObjectStorageService.h"
#import "FLUserService.h"
#import "FLHttpRequest.h"
#import "FLWorkerContext.h"

@protocol ZFHttpControllerDelegate;

@interface ZFHttpController : FLWorkerContext<FLHttpRequestAuthenticationServiceDelegate, FLUserLoginServiceDelegate, FLHttpRequestContext> {
@private
    FLUserService* _userLoginService;
    FLObjectStorageService* _objectCacheService;
    FLHttpRequestAuthenticationService* _httpRequestAuthenticator;

    ZFGroup* _rootGroup;
    
    __unsafe_unretained id<ZFHttpControllerDelegate> _delegate;
}

+ (id) httpController;

@property (readwrite, assign, nonatomic) id<ZFHttpControllerDelegate> delegate;

@property (readwrite, strong) ZFGroup* rootGroup;

@property (readonly, strong) FLUserService* userService;
@property (readonly, strong) FLObjectStorageService* objectCache;
@property (readonly, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;

- (void) logoutUser;

- (void) requestCancel;

@end

@protocol ZFHttpControllerDelegate <NSObject>

- (void) httpController:(ZFHttpController*) controller
    didAuthenticateUser:(FLUserLogin*) userLogin;

- (void) httpController:(ZFHttpController*) controller 
          didLogoutUser:(FLUserLogin*) userLogin;

- (void) httpControllerDidOpenService:(ZFHttpController*) controller;

- (void) httpControllerDidCloseService:(ZFHttpController*) controller;
          
@end