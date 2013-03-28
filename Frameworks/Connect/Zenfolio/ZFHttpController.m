//
//  ZFHttpController.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFHttpController.h"
#import "ZFRegisteredUserAuthenticationService.h"

#import "FLDictionaryObjectStorage.h"

#import "FLGlobalNetworkActivityIndicator.h"

@interface ZFHttpController ()
@property (readwrite, strong) FLUserService* userService;
@property (readwrite, strong) id<FLObjectStorage> objectCache;
@property (readwrite, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;
@end

@implementation ZFHttpController
@synthesize userService = _userLoginService;
@synthesize rootGroup = _rootGroup;
@synthesize delegate = _delegate;
@synthesize objectCache = _objectCache;
@synthesize httpRequestAuthenticator = _httpRequestAuthenticator;


+ (id) httpController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    self = [super init];
    if(self) {
        _objectCacheService = [[FLObjectStorageService alloc] init];
        [_objectCache setObjectStorage:[FLDictionaryObjectStorage dictionaryObjectStorage]];
        [self addSubService:_objectCache];
        
        self.httpRequestAuthenticator = [ZFRegisteredUserAuthenticationService registeredUserAuthenticationService];
        self.httpRequestAuthenticator.delegate = self;
        [self addSubService:self.httpRequestAuthenticator];    
                
        self.userService = [FLUserService userService];
        self.userService.authenticationDomain = @"www.zenfolio.com";
        self.userService.delegate = self;
//        [self addSubService:self.userContext];   

        
    }
    return self;
}

- (void) openService {
    [super openService];
    [self.delegate httpControllerDidOpenService:self];
}

- (void) closeService {
    [super closeService];
    self.rootGroup = nil;

    [self.delegate httpControllerDidCloseService:self];
}

#if FL_MRC
- (void) dealloc {
    [_httpRequestAuthenticator release];
    [_rootGroup release];
    [_objectCacheService release];
    [_userLoginService release];
    [super dealloc];
}
#endif

- (void) didStartWorking {
    [super didStartWorking];
    [FLGlobalNetworkActivityIndicator instance].networkBusy = YES;
}

- (void) didStopWorking {
    [super didStopWorking];
    [FLGlobalNetworkActivityIndicator instance].networkBusy = NO;
}

- (void) userServiceDidOpen:(FLUserService*) service {
    [self openService];
}

- (void) userServiceDidClose:(FLUserService*) service {
    [self closeService];
}

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service
                      didAuthenticateUser:(FLUserLogin*) userLogin {
    
    [self.delegate httpController:self didAuthenticateUser:userLogin];
}

- (void) httpRequestAuthenticationServiceDidOpen:(FLHttpRequestAuthenticationService*) service {
}

- (void) httpRequestAuthenticationServiceDidClose:(FLHttpRequestAuthenticationService*) service {
}


- (BOOL) isContextAuthenticated {
    return self.httpRequestAuthenticator.isAuthenticated;
}

- (void) logoutUser {
    [self.httpRequestAuthenticator logoutUser];
}

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                            didLogoutUser:(FLUserLogin*) userLogin {

    [self.userService closeService];
    [self.delegate httpController:self didLogoutUser:userLogin];
} 


- (FLUserLogin*) httpRequestAuthenticationServiceGetUserLogin:(FLHttpRequestAuthenticationService*) service {
    return self.userService.userLogin;
}

- (void) requestCancel {
    [[self userContextService] requestCancel];
}
@end
