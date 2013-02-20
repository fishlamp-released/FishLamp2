//
//  FLZenfolioAuthenticationService.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioAuthenticationService.h"
#import "FLZenfolioAuthenticateOperation.h"

#import "FLReachableNetwork.h"
#import "FLTraceOn.h"

#import "FLZenfolioWebApi.h"
#import "FLUserLogin+ZenfolioAdditions.h"
#import "FLZenfolioErrors.h"
#import "FLZenfolioUserService.h"
#import "FLHttpRequest+ZenfolioAuthentication.h"

@implementation FLZenfolioAuthenticationService

+ (id) authenticationService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) updateHttpRequest:(FLHttpRequest*) httpRequest 
     withAuthenticatedUser:(FLUserLogin*) userLogin {

    [httpRequest setAuthenticationToken:userLogin.authToken];
}       

- (BOOL) userLoginIsAuthenticated:(FLUserLogin*) userLogin {
    
    if(FLStringIsEmpty(userLogin.authToken) || !userLogin.isAuthenticatedValue) {
        return NO;
    }
    
#if TEST_CACHE_EXPIRE
	userLogin.authTokenLastUpdateTimeValue = userLogin.authTokenLastUpdateTimeValue - (_timeoutInterval*2);
#endif
	
	if( (([NSDate timeIntervalSinceReferenceDate] - [userLogin authTokenLastUpdateTimeValue]) > self.lastAuthenticationTimestamp)) {
		
        // only expire the timeout if we're connect to network.

        if([FLReachableNetwork instance].isReachable) {
            FLTrace(@"Login expired, will reauthenticate %@", userLogin.userName);
            userLogin.authToken = nil;
            userLogin.isAuthenticatedValue = NO;
            return NO;
        }
	}
    
    return YES;
}
    
@end

