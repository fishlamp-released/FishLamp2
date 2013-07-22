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

NSString* const FLHttpControllerDidLogoutUserNotification = @"FLHttpControllerDidLogoutUserNotification";

@interface FLHttpController ()
@property (readwrite, strong) id<FLUserService> userService;
@property (readwrite, strong) id<FLStorageService> storageService;
@property (readwrite, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;
@property (readwrite, strong) FLService* authenticatedServices;
@property (readwrite, strong) id httpUser;
@end

@implementation FLHttpController
@synthesize userService = _userService;
@synthesize storageService = _storageService;
@synthesize httpRequestAuthenticator = _httpRequestAuthenticator;
@synthesize delegate = _delegate;
@synthesize authenticatedServices = _authenticatedServices;
@synthesize streamSecurity = _streamSecurity;
@synthesize httpUser = _httpUser;
@synthesize serviceFactory = _serviceFactory;

- (id) init {
    return [self initWithServiceFactory:nil];
}

- (id) initWithServiceFactory:(id<FLHttpControllerServiceFactory>) factory {

    self = [super init];
    if(self) {
        _serviceFactory = FLRetain(factory);
        FLAssertNotNil(_serviceFactory);

        self.authenticatedServices = [FLService service];
                         
        self.userService = [self.serviceFactory httpControllerCreateUserService:self];
    
        FLAssertNotNil(self.userService);
        [self.userService.observers addObserver:[FLNonretainedObject nonretainedObject:self]];

        self.httpRequestAuthenticator = [self.serviceFactory httpControllerCreateHttpRequestAuthenticationService:self];
        FLAssertNotNil(self.httpRequestAuthenticator);
        self.httpRequestAuthenticator.delegate = self;
        [self.userService addSubService:self.httpRequestAuthenticator];    
    
        self.storageService = [self.serviceFactory httpControllerCreateStorageService:self];
        if(self.storageService) {
            [self.authenticatedServices addSubService:self.storageService];
        }
     
        [self.userService openService:self];
    }
    return self;
}

+ (id) httpController {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) httpController:(id<FLHttpControllerServiceFactory>) factory {
    return FLAutorelease([[[self class] alloc] initWithServiceFactory:factory]);
}

- (void) userServiceDidOpen:(id<FLUserService>) service {
    self.httpUser = [self.serviceFactory httpController:self
                           createHttpUserForCredentials:service.credentials];
}

- (void) userServiceDidClose:(id<FLUserService>) service {
    [[NSNotificationCenter defaultCenter] postNotificationName:FLHttpControllerDidLogoutUserNotification object:self];
    self.httpUser = nil;
}

- (BOOL) isAuthenticated {
    return self.httpUser && [self.httpUser isLoginAuthenticated];
}

#if FL_MRC
- (void) dealloc {
    [_serviceFactory release];
    [_httpUser release];
    [_httpRequestAuthenticator release];
    [_storageService release];
    [_userService release];
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

- (NSString*) databaseObjectStorageServiceGetDatabasePath:(FLDatabaseObjectStorageService*) service {
    return [[self.httpUser userDataFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", [FLAppInfo bundleIdentifier]]];
}
@end

@implementation FLHttpControllerServiceFactory

+ (id<FLHttpControllerServiceFactory>) httpControllerServiceFactory {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id<FLUserService>) httpControllerCreateUserService:(FLHttpController*) controller {
    return [FLUserService userService];
}

- (id<FLStorageService>) httpControllerCreateStorageService:(FLHttpController*) controller {
    return [FLDatabaseObjectStorageService databaseObjectStorageService:controller];
}

- (FLHttpUser*) httpController:(FLHttpController*) controller
  createHttpUserForCredentials:(id<FLCredentials>) credentials {
    return  [FLHttpUser httpUser:[FLUserLogin userLoginWithCredentials:credentials]];
}

- (FLHttpRequestAuthenticationService*) httpControllerCreateHttpRequestAuthenticationService:(FLHttpController*) controller {
    return [FLHttpRequestAuthenticationService httpRequestAuthenticationService];
}
@end