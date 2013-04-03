//
//  ZFAuthenticationService.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFAuthenticationService.h"
#import "FLHttpRequest+ZenfolioAuthentication.h"

@implementation ZFAuthenticationService

+ (id) authenticationService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) authenticateHttpRequest:(FLHttpRequest*) httpRequest 
     withAuthenticatedUser:(FLHttpUser*) user {

    [httpRequest setAuthenticationToken:user.credentials.authToken];
}       

@end

