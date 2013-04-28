//
//  ZFAuthenticationOperation.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFAuthenticationOperation.h"
#import "ZFWebApi.h"
#import "FLHttpRequest+ZenfolioAuthentication.h"

@implementation ZFAuthenticationOperation

@synthesize user = _credentials;

- (id) initWithHttpUser:(ZFHttpUser*) user {
    self = [super init];
    if(self) {
        _credentials = FLRetain(user);
    }
    
    return self;
}

+ (id) authenticationOperation:(ZFHttpUser*) user {
    return FLAutorelease([[[self class] alloc] initWithHttpUser:user]);
}

- (id) sendAuthenticatedRequest:(FLHttpRequest*) request 
                            userLogin:(FLUserLogin*) userLogin {

    request.streamSecurity = FLNetworkStreamSecuritySSL;
    request.disableAuthenticator = YES;
    request.canRetry = NO;
    [request setAuthenticationToken:userLogin.authToken];
    
    FLPromisedResult result = [self runChildSynchronously:request];
    FLThrowIfError(result);
    
    return result;
}

#if FL_MRC
- (void) dealloc {
    [_credentials release];
    [super dealloc];
}
#endif

- (id) performSynchronously {

    FLUserLogin* authenticatedUser = self.user.credentials;

    ZFUser* privateProfile = 
        [self sendAuthenticatedRequest:[ZFHttpRequestFactory loadPrivateProfileHttpRequest] 
                             userLogin:authenticatedUser ];
    
    ZFUser* publicProfile =  
        [self sendAuthenticatedRequest:[ZFHttpRequestFactory loadPublicProfileHttpRequest:authenticatedUser.userName] 
                             userLogin:authenticatedUser ];
    
    
    NSNumber* videoBool =  
        [self sendAuthenticatedRequest:[ZFHttpRequestFactory checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                  privilegeName:ZFVideoPrivilege] 
                             userLogin:authenticatedUser ];
    
    
    
    NSNumber* scrapbookBool =  
        [self sendAuthenticatedRequest:[ZFHttpRequestFactory checkPrivilegeHttpRequest:authenticatedUser.userName
                                                                  privilegeName:ZFScrapbookPrivilege] 
                             userLogin:authenticatedUser ];



    authenticatedUser.email =  [privateProfile PrimaryEmail];
    authenticatedUser.userName = [privateProfile LoginName];
    authenticatedUser.rootGroupID = [publicProfile RootGroup].Id;

    if(videoBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:ZFVideoPrivilege];
    }
    
    if(scrapbookBool.boolValue) {
        [authenticatedUser setPrivilegeEnabled:ZFScrapbookPrivilege];
    }
    
    authenticatedUser.isAuthenticatedValue = YES;
    self.user.privateProfile = privateProfile;
    self.user.publicProfile = publicProfile;
    
    FLLog(@"Authentication completed");
    
    return authenticatedUser;
}
@end
