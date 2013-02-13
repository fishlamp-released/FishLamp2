//
//  FLZenfolioHttpRequestAuthenticator.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioHttpRequestAuthenticator.h"
#import "FLZenfolioAuthenticator.h"

#import "FLReachableNetwork.h"
#import "FLTraceOn.h"

#import "FLZenfolioWebApi.h"
#import "FLUserLogin+ZenfolioAdditions.h"
#import "FLZenfolioErrors.h"
#import "FLZenfolioUserContext.h"

@implementation FLHttpRequest (ZenAuth)

- (void) setAuthenticationToken:(NSString*) token {
    [self.headers setValue:token forHTTPHeaderField:@"X-Zenfolio-Token"];
    [self.headers setValue:self.headers.userAgentHeader forHTTPHeaderField:@"X-Zenfolio-User-Agent"];
}
@end

@implementation FLZenfolioHttpRequestAuthenticator

@synthesize userContext = _userContext;

- (id) initWithUserContext:(FLZenfolioUserContext*) userContext {
    self = [super init];
    if(self) {
        _userContext = userContext;
    }
    return self;
}

+ (id) httpRequestAuthenticator:(FLZenfolioUserContext*) userContext {
    return FLAutorelease([[[self class] alloc] initWithUserContext:userContext]);
}

- (void) httpRequestAuthenticateSynchronously:(FLHttpRequest*) httpRequest 
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

@implementation FLZenfolioRegisteredUserHttpRequestAuthenticator 


- (FLResult) sendAuthenticatedRequest:(FLHttpRequest*) request 
                            userLogin:(FLUserLogin*) userLogin {

    [request setAuthenticationToken:userLogin.authToken];

    FLResult result = [self sendHttpRequest:request];
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

#if REFACTOR

// if IOS
    int rootGroupId = userLogin.userValueValue; // YUCK. 

    if(rootGroupId == 0) {
       return NO;
    }

    if(token) {
        FLZenfolioPreferences* prefs = [[FLZenfolioPrefsService serviceFromContext:operation.context] loadPreferences];
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
        
        FLThrowError( [NSError errorWithDomain:FLZenfolioErrorDomain
                                           code:FLZenfolioErrorCodeInvalidCredentials
                           localizedDescription:NSLocalizedString(@"Password is incorrect", nil)]);
    }
    
    FLZenfolioAuthenticator* authenticator = [FLZenfolioAuthenticator userAuthenticator:userLogin];
    [self.userContext addObject:authenticator];
    
    FLUserLogin* authenticatedUser = [authenticator runSynchronously];
    
    FLZenfolioUser* privateProfile = [self sendAuthenticatedRequest:[FLZenfolioHttpRequest loadPrivateProfileHttpRequest] 
                                                          userLogin:authenticatedUser];
    
    FLZenfolioUser* publicProfile =  [self sendAuthenticatedRequest:[FLZenfolioHttpRequest loadPublicProfileHttpRequest:userLogin.userName] 
                                                          userLogin:authenticatedUser];
    
    NSNumber* videoBool =  [self sendAuthenticatedRequest:[FLZenfolioHttpRequest checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                                             privilegeName:FLZenfolioVideoPrivilege] 
                                                userLogin:authenticatedUser];
    

    NSNumber* scrapbookBool =  [self sendAuthenticatedRequest:[FLZenfolioHttpRequest checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                                                 privilegeName:FLZenfolioScrapbookPrivilege] 
                                                    userLogin:authenticatedUser];


    authenticatedUser.email =  [privateProfile PrimaryEmail];
    authenticatedUser.userName = [privateProfile LoginName];
    authenticatedUser.rootGroupID = [publicProfile RootGroup].Id;

    if(videoBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:FLZenfolioVideoPrivilege];
    }
    
    if(scrapbookBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:FLZenfolioScrapbookPrivilege];
    }
    
    authenticatedUser.isAuthenticatedValue = YES;

    return authenticatedUser;
}

@end

@implementation FLZenfolioGuestUserHttpRequestAuthenticator

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin {
    FLTrace(@"Authenticating %@:", userLogin.userName );
    FLHttpRequest* httpRequest = [FLZenfolioHttpRequest authenticateVisitorHttpRequest];
    NSString* token = FLThrowError([self sendHttpRequest:httpRequest]);
    userLogin.authTokenLastUpdateTimeValue = [NSDate timeIntervalSinceReferenceDate];
    userLogin.authToken = token;
    return userLogin;
}

@end
