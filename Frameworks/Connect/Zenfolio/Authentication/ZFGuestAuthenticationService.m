//
//  ZFGuestAuthenticationService.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFGuestAuthenticationService.h"

@implementation ZFGuestAuthenticationService

- (void) authenticateUser:(FLHttpUser*) user {
                                    
    FLUserLogin* userLogin = user.credentials;                                
                                    
    FLTrace(@"Authenticating %@:", userLogin.userName );
    
    FLHttpRequest* request = [ZFHttpRequestFactory authenticateVisitorHttpRequest];
    request.context = self.operationContext;
    
    id<FLAsyncResult> result = [request runSynchronously];
    FLThrowIfError(result);

    NSString* token = result.returnedObject;
    
    userLogin.authTokenLastUpdateTimeValue = [NSDate timeIntervalSinceReferenceDate];
    userLogin.authToken = token;
    
    [user setCredentials:userLogin];
}

@end
