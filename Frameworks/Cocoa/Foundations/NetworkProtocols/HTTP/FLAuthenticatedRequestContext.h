//
//  FLAuthenticatedRequestContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequestContext.h"
#import "FLUserLogin.h"

@interface FLAuthenticatedRequestContext : FLRequestContext {
@private
    FLUserLogin* _userLogin;
}

@property (readonly, assign, getter=isAuthenticated) BOOL isAuthenticated;

@property (readwrite, strong) FLUserLogin* userLogin;

- (FLFinisher*) authenticateUser:(FLUserLogin*) userLogin 
                      completion:(FLCompletionBlock) completion;

- (FLFinisher*) startAuthenticatingWithUserName:(NSString*) userName 
                                       password:(NSString*) password
                                     completion:(FLCompletionBlock) completion;

// overrides

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin;

@end

FLPublishService(httpService, FLAuthenticatedRequestContext*)

