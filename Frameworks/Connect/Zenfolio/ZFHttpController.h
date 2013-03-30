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
#import "FLOperationContext.h"

@protocol ZFHttpControllerDelegate;

@interface ZFHttpController : FLOperationContext<FLHttpRequestAuthenticationServiceDelegate, FLUserLoginServiceDelegate, FLHttpRequestContext> {
@private
    FLUserService* _userLoginService;
    FLObjectStorageService* _objectCacheService;
    FLHttpRequestAuthenticationService* _httpRequestAuthenticator;
    id _delegate;
}

+ (id) httpController;

@property (readonly, assign, nonatomic) BOOL isAuthenticated;

@property (readwrite, assign, nonatomic) id delegate;

@property (readonly, strong) FLUserService* userService;
@property (readonly, strong) FLObjectStorageService* objectCache;
@property (readonly, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;

- (void) logoutUser;
- (ZFHttpUser*) user;

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

@interface ZFHttpController (FLOperationFactory)
- (id) createRootGroupDownloader;
- (id) createAllPhotoSetsDownloader;
@end


//@protocol ZFHttpControllerObserver <NSObject>
//@optional
//
//- (void) httpController:(id) sender didDownloadRootGroup:(ZFGroup*) rootGroup;
//- (void) httpController:(id) sender didDownloadPhotoSet:(ZFPhotoSet*) rootGroup;
//
////- (void) httpController:(ZFHttpController*) controller didDownloadGroupWithResult:(FLResult) result;
////- (void) httpController:(ZFHttpController*) controller didDownloadPhotoSetWithResult:(FLResult) result;
////- (void) httpController:(ZFHttpController*) controller didDownloadPhotoSetsWithResult:(FLResult) groupOrError;
//
//@end
