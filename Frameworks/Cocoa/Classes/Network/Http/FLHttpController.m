//
//  FLHttpController.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpController.h"
#import "FLReachableNetwork.h" 

#import "FLSynchronousOperation.h"

NSString* const FLHttpControllerDidLogoutUserNotification = @"FLHttpControllerDidLogoutUserNotification";

@interface FLHttpController ()
@property (readwrite, strong) FLUserService* userService;
@property (readwrite, strong) id<FLObjectStorage> objectStorageService;
@property (readwrite, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;
@property (readwrite, strong) FLService* authenticatedServices;
@end

@implementation FLHttpController
@synthesize userService = _userLoginService;
@synthesize objectStorageService = _objectStorageService;
@synthesize httpRequestAuthenticator = _httpRequestAuthenticator;
@synthesize delegate = _delegate;
@synthesize authenticatedServices = _authenticatedServices;
@synthesize streamSecurity = _streamSecurity;

- (id) init {
    self = [super init]; // [super initWithRootNameForDelegateMethods:@"httpController"];
    if(self) {
        self.authenticatedServices = [FLService service];
                         
        self.userService = [self createUserService];
        FLAssertNotNil(self.userService);
        FLAssertStringIsNotEmptyWithComment(self.userService.authenticationDomain, @"needs a domain, like http:www.fishlamp.com");
        self.userService.delegate = self;

        self.httpRequestAuthenticator = [self createHttpRequestAuthenticationService];
        FLAssertNotNil(self.httpRequestAuthenticator);
        self.httpRequestAuthenticator.delegate = self;
        [self.userService addSubService:self.httpRequestAuthenticator];    
    
        self.objectStorageService = [self createObjectStorageService];
        FLAssertNotNil(self.objectStorageService);
        [self.authenticatedServices addSubService:self.objectStorageService];
        
    }
    return self;
}

- (FLUserService*) createUserService {
    return nil;
}

- (FLObjectStorageService*) createObjectStorageService {
    return nil;
}

- (FLHttpRequestAuthenticationService*) createHttpRequestAuthenticationService {
    return nil;
}

+ (id) httpController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLHttpUser*) user {
    return nil;
}

- (BOOL) isAuthenticated {
    return self.user && [self.user isAuthenticated];
}

#if FL_MRC
- (void) dealloc { 
    [_httpRequestAuthenticator release];
    [_objectStorageService release];
    [_userLoginService release];
    [super dealloc];
}
#endif

- (void) didAddOperation:(FLOperation*) operation {
    [super didAddOperation:operation];
    
    id object = operation; // for casting
    
// TODO: abstract this better.    
    if([object respondsToSelector:@selector(setObjectStorage:)]) {
        if([object objectStorage] == nil) {
            [object setObjectStorage:[self objectStorageService]];
        }
    }

    if(_streamSecurity != FLNetworkStreamSecurityNone) {
        if([object respondsToSelector:@selector(setStreamSecurity:)]) {
            if([object streamSecurity] == FLNetworkStreamSecurityNone) {
                [object setStreamSecurity:_streamSecurity]; 
            }
        }
    }
}

- (void) userServiceDidOpen:(FLUserService*) service {
}

- (void) userServiceDidClose:(FLUserService*) service {
    [[NSNotificationCenter defaultCenter] postNotificationName:FLHttpControllerDidLogoutUserNotification object:self];
}

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                      didAuthenticateUser:(FLHttpUser*) userLogin {
    
    [self.authenticatedServices openService:self];
    [self.delegate httpController:self didAuthenticateUser:userLogin];
}

- (void) logoutUser {
    [self.user setUnathenticated];
    [self.userService setPassword:nil];
    [self.userService saveCredentials];
    [self.userService closeService:self];
    [self.authenticatedServices closeService:self];
    [self.delegate httpController:self didLogoutUser:self.user];

    [[NSNotificationCenter defaultCenter] postNotificationName:FLHttpControllerDidLogoutUserNotification object:self];
}

- (void) openUserService {
    if(!self.userService.isServiceOpen) {
        [self.userService openService:self];
    }
}


- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                         operationContext:(FLOperationContext**) outOperationContext {
    *outOperationContext = FLRetain(self);
}                         



- (FLOperationContext*) httpRequestAuthenticationServiceGetWorkerContext:(FLHttpRequestAuthenticationService*) service {
    return self;
}

- (FLHttpUser*) httpRequestAuthenticationServiceGetUser:(FLHttpRequestAuthenticationService*) service {
    return self.user;
}

@end
