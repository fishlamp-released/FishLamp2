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

    ZFHttpUser* _user;
}

+ (id) httpController;

@property (readwrite, strong) ZFHttpUser* user;

@property (readonly, strong) FLUserService* userService;
@property (readonly, strong) FLObjectStorageService* objectCache;
@property (readonly, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;

- (void) logoutUser;


- (FLFinisher*) beginDownloadingPhotoSetsForRootGroup:(id) observer 
                           downloadedPhotoSetSelector:(SEL) photoSetSelector
                                     finishedSelector:(SEL) finishedSelector;

- (FLFinisher*) beginDownloadingRootGroup:(id) observer 
                         finishedSelector:(SEL) selector; // @selector(something:result:)

@end

@protocol ZFHttpControllerDelegate <NSObject>
@optional

- (void) httpController:(ZFHttpController*) controller
    didAuthenticateUser:(ZFHttpUser*) userLogin;

- (void) httpController:(ZFHttpController*) controller 
          didLogoutUser:(ZFHttpUser*) userLogin;


- (void) httpControllerDidClose:(ZFHttpController*) controller;
- (void) httpControllerDidOpen:(ZFHttpController*) controller;
         
         
         
@end

@protocol ZFHttpControllerObserver <NSObject>

//- (void) httpController:(ZFHttpController*) controller didDownloadGroupWithResult:(FLResult) result;
//- (void) httpController:(ZFHttpController*) controller didDownloadPhotoSetWithResult:(FLResult) result;
//- (void) httpController:(ZFHttpController*) controller didDownloadPhotoSetsWithResult:(FLResult) groupOrError;

@end