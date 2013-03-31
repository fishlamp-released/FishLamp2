//
//  FLHttpController.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpController.h"

#import "FLSynchronousOperation.h"

@interface FLHttpController ()
@property (readwrite, strong) FLUserService* userService;
@property (readwrite, strong) id<FLObjectStorage> objectStorageService;
@property (readwrite, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;
@end

@implementation FLHttpController
@synthesize userService = _userLoginService;
@synthesize objectStorageService = _objectStorageService;
@synthesize httpRequestAuthenticator = _httpRequestAuthenticator;
@synthesize delegate = _delegate;

- (id) init {
    self = [super init]; // [super initWithRootNameForDelegateMethods:@"httpController"];
    if(self) {
                
        self.userService = [self createUserService];
        FLAssertNotNil(self.userService);
        FLAssertStringIsNotEmptyWithComment(self.userService.authenticationDomain, @"needs a domain, like http:www.fishlamp.com");
        
//        self.userService.authenticationDomain = @"www.zenfolio.com";
        self.userService.delegate = self;
    
        self.objectStorageService = [self createObjectStorageService];
        FLAssertNotNil(self.objectStorageService);
        
        [self.userService addSubService:self.objectStorageService];
        
        self.httpRequestAuthenticator = [self createHttpRequestAuthenticationService];
        FLAssertNotNil(self.httpRequestAuthenticator);

        self.httpRequestAuthenticator.delegate = self;
        [self.userService addSubService:self.httpRequestAuthenticator];    
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
    
}

- (void) userServiceDidOpen:(FLUserService*) service {
}

- (void) userServiceDidClose:(FLUserService*) service {
}

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                      didAuthenticateUser:(FLHttpUser*) userLogin {
    
    [self.delegate httpController:self didAuthenticateUser:userLogin];
}

- (void) logoutUser {
    [self.user setUnathenticated];
    [self.userService closeService:self];
    [self.delegate httpController:self didLogoutUser:self.user];
}

- (FLOperationContext*) httpRequestAuthenticationServiceGetWorkerContext:(FLHttpRequestAuthenticationService*) service {
    return self;
}

- (FLHttpUser*) httpRequestAuthenticationServiceGetUser:(FLHttpRequestAuthenticationService*) service {
    return self.user;
}

@end
