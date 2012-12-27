//
//  FLAuthenticatedRequestContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAuthenticatedRequestContext.h"

@implementation FLAuthenticatedRequestContext

@synthesize userLogin = _userLogin;

#if FL_MRC
- (void) dealloc {
    [_userLogin release];
    [super dealloc];
}
#endif

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin {
    return userLogin;
}

- (FLFinisher*) authenticateUser:(FLUserLogin*) userLogin 
                      completion:(FLCompletionBlock) completion {
                            
    return [[self.session dispatcher] dispatchFinishableBlock:^(FLFinisher *finisher) {
        [finisher setFinishedWithResult:[self synchronouslyAuthenticateUser:userLogin]];
    }
    completion:completion];
}

- (FLFinisher*) startAuthenticatingWithUserName:(NSString*) userName 
                                       password:(NSString*) password
                                     completion:(FLCompletionBlock) completion  {

    FLFinisher* finisher = [FLFinisher finisher:completion];
    
    FLUserLogin* login = [FLUserLogin userLogin];
    login.userName = userName;
    login.password = password;
    
    [self authenticateUser:login completion:^(FLResult result) {
        if(![result error]) {
            self.userLogin = result;
//            [self openContext];
        }

//        [self postObservation:@selector(userContext:authenticationFinishedWithError:) withObject:result];
            
        [finisher setFinishedWithResult:result];
    }];
    
    return finisher;
}

- (BOOL) isAuthenticated {
    return self.userLogin.isAuthenticatedValue;
}

- (void) authenticateRequest:(FLHttpRequest*) httpRequest 
               withUserLogin:(FLUserLogin*) userLogin {
}

- (void) willStartRequest:(FLHttpRequest*) httpRequest  {
    
    self.userLogin = [self synchronouslyAuthenticateUser:_userLogin];
    [self authenticateRequest:httpRequest withUserLogin:self.userLogin];
}

@end
