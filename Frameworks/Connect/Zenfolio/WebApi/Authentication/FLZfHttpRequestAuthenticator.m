//
//  FLZfHttpRequestAuthenticator.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfHttpRequestAuthenticator.h"
#import "FLZfAuthenticator.h"

#import "FLReachableNetwork.h"
#import "FLTraceOn.h"

#import "FLZfHttpRequest.h"
#import "FLUserLogin+ZfAdditions.h"

@implementation FLHttpRequest (ZenAuth)

- (void) setAuthenticationToken:(NSString*) token {
    [self.headers setValue:token forHTTPHeaderField:@"X-Zenfolio-Token"];
    [self.headers setValue:self.headers.userAgentHeader forHTTPHeaderField:@"X-Zenfolio-User-Agent"];
}
@end

@implementation FLZfHttpRequestAuthenticator
- (void) authenticateHttpRequest:(FLHttpRequest*) httpRequest 
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
		
        // only expire the timeout if we're online.

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

@implementation FLZfRegisteredUserHttpRequestAuthenticator 


- (FLResult) sendAuthenticatedRequest:(FLHttpRequest*) request 
                            userLogin:(FLUserLogin*) userLogin {

    request.authenticationDisabled = YES;
    [request setAuthenticationToken:userLogin.authToken];
    FLResult result = [request sendSynchronouslyInContext:self.context];
    FLAssertNotNil_(result);
    return result;
}

- (BOOL) userLoginIsAuthenticated:(FLUserLogin*) userLogin {
    if(![super userLoginIsAuthenticated:userLogin]) {
        return NO;
    }

    // check a couple of things for registered users.
    // check to see if userName is email address, if it is, we'll have to authenticated and find out userName
    if( (userLogin.userName && [userLogin.userName rangeOfString:@"@"].length > 0) || FLStringIsEmpty(userLogin.email)) {
        return NO;
    }

#if IOS
    int rootGroupId = userLogin.userValueValue; // YUCK. 

    if(rootGroupId == 0) {
       return NO;
    }

    if(token) {
        FLZfPreferences* prefs = [[FLZfPrefsService serviceFromContext:operation.context] loadPreferences];
        if(!prefs.didCheckScrapbookPrivilegeValue) {
            return NO;
        }
    }
#endif        
    
    return YES;
}

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin {

    FLTrace(@"Authenticating %@:", userLogin.userName );

    if(FLStringIsEmpty(userLogin.password)) {
    // can't authenticate because we don't have a pw. So put an error in the httpRequestFactory so ui can prompt for password.

        FLTrace(@"auth failed because password is empty");
        
        FLThrowError( [NSError errorWithDomain:FLZfErrorDomain
                                           code:FLZfErrorCodeInvalidCredentials
                           localizedDescription:NSLocalizedString(@"Password is incorrect", nil)]);
    }
    
    FLUserLogin* authenticatedUser = [[FLZfAuthenticator userAuthenticator:userLogin] runSynchronouslyInContext:self.context];
    
    FLZfUser* privateProfile = [self sendAuthenticatedRequest:[FLZfHttpRequest loadPrivateProfileHttpRequest] 
                                                  userLogin:authenticatedUser];
    
    FLZfUser* publicProfile =  [self sendAuthenticatedRequest:[FLZfHttpRequest loadPublicProfileHttpRequest:userLogin.userName] 
                                                  userLogin:authenticatedUser];
    
    NSNumber* videoBool =  [self sendAuthenticatedRequest:[FLZfHttpRequest checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                                     privilegeName:FLZfVideoPrivilege] 
                                                  userLogin:authenticatedUser];
                                                  

    NSNumber* scrapbookBool =  [self sendAuthenticatedRequest:[FLZfHttpRequest checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                                         privilegeName:FLZfScrapbookPrivilege] 
                                                    userLogin:authenticatedUser];


    authenticatedUser.email =  [privateProfile PrimaryEmail];
    authenticatedUser.userName = [privateProfile LoginName];
    authenticatedUser.rootGroupID = [publicProfile RootGroup].Id;

    if(videoBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:FLZfVideoPrivilege];
    }
    
    if(scrapbookBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:FLZfScrapbookPrivilege];
    }
    
    authenticatedUser.isAuthenticatedValue = YES;

    return authenticatedUser;
}

@end

@implementation FLZfGuestUserHttpRequestAuthenticator

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin {
    FLTrace(@"Authenticating %@:", userLogin.userName );
    FLHttpRequest* httpRequest = [FLZfHttpRequest authenticateVisitorHttpRequest];
    NSString* token = FLThrowError([httpRequest sendSynchronouslyInContext:self]);
    userLogin.authTokenLastUpdateTimeValue = [NSDate timeIntervalSinceReferenceDate];
    userLogin.authToken = token;
    return userLogin;
}

@end
