//
//  FLHttpController.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHttpController.h"
#import "FLReachableNetwork.h" 
#import "FLDatabaseObjectStorageService.h"
#import "FLAppInfo.h"
#import "FLSynchronousOperation.h"
#import "FLUserLogin+Additions.h"
NSString* const FLHttpControllerDidLogoutUserNotification = @"FLHttpControllerDidLogoutUserNotification";

@interface FLHttpController ()
@property (readwrite, strong) FLUserService* userService;
@property (readwrite, strong) FLStorageService* storageService;
@property (readwrite, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;
@property (readwrite, strong) FLService* authenticatedServices;
@property (readwrite, strong) id httpUser;
@end

@implementation FLHttpController
@synthesize userService = _userLoginService;
@synthesize storageService = _storageService;
@synthesize httpRequestAuthenticator = _httpRequestAuthenticator;
@synthesize delegate = _delegate;
@synthesize authenticatedServices = _authenticatedServices;
@synthesize streamSecurity = _streamSecurity;
@synthesize httpUser = _httpUser;

- (id) init {

    self = [super init]; 
    if(self) {
        self.authenticatedServices = [FLService service];
                         
        self.userService = [self createUserService];
    
        FLAssertNotNil(self.userService);
        [self.userService.observers addObserver:[FLNonretainedObject nonretainedObject:self]];

        self.httpRequestAuthenticator = [self createHttpRequestAuthenticationService];
        FLAssertNotNil(self.httpRequestAuthenticator);
        self.httpRequestAuthenticator.delegate = self;
        [self.userService addSubService:self.httpRequestAuthenticator];    
    
        self.storageService = [self createStorageService];
        FLAssertNotNil(self.storageService);
        [self.authenticatedServices addSubService:self.storageService];
     
        [self.userService openService:self];
    }
    return self;
}

+ (id) httpController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) userServiceDidOpen:(FLUserService*) service {
    self.httpUser = [self createHttpUserForCredentials:service.credentials];
}

- (void) userServiceDidClose:(FLUserService*) service {
    [[NSNotificationCenter defaultCenter] postNotificationName:FLHttpControllerDidLogoutUserNotification object:self];
    self.httpUser = nil;
}

- (BOOL) isAuthenticated {
    return self.httpUser && [self.httpUser isLoginAuthenticated];
}

#if FL_MRC
- (void) dealloc { 
    [_httpUser release];
    [_httpRequestAuthenticator release];
    [_storageService release];
    [_userLoginService release];
    [super dealloc];
}
#endif

- (void) didAddOperation:(FLOperation*) operation {
    [super didAddOperation:operation];
    [self openUserService];
    
    id object = operation; // for casting
    
// TODO: abstract this better.    
    if([object respondsToSelector:@selector(setStorageService:)]) {
        if([object storageService] == nil) {
            [object setStorageService:[self storageService]];
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

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                      didAuthenticateUser:(FLHttpUser*) userLogin {
    
    [self.authenticatedServices openService:self];
    [self.delegate httpController:self didAuthenticateUser:userLogin];
}

- (void) logoutUser {
    [self.httpUser setLoginUnathenticated];
    
    FLCredentialsEditor* editor = [self.userService credentialEditor];
    editor.password = nil;
    [editor stopEditing];
    
//    [self.userService setPassword:nil];
//    [self.userService saveCredentials];
//    [self.userService closeService:self];
//    [self.authenticatedServices closeService:self];
    [self.delegate httpController:self didLogoutUser:self.httpUser];

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
    return self.httpUser;
}

- (FLUserService*) createUserService {
    return [FLUserService userService];
}

- (FLStorageService*) createStorageService {
    return [FLDatabaseObjectStorageService databaseObjectStorageService:self];
}

- (FLHttpUser*) createHttpUserForCredentials:(id<FLCredentials>) credentials {
    return  [FLHttpUser httpUser:[FLUserLogin userLoginWithCredentials:credentials]];
}

- (FLHttpRequestAuthenticationService*) createHttpRequestAuthenticationService {
    return [FLHttpRequestAuthenticationService httpRequestAuthenticationService];
}

- (NSString*) databaseObjectStorageServiceGetDatabasePath:(FLDatabaseObjectStorageService*) service {
    return [[self.httpUser userDataFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", [FLAppInfo bundleIdentifier]]];
}


@end


