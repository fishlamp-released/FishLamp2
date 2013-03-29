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
    
    NSString* token = [[ZFHttpRequest authenticateVisitorHttpRequest] runInContext:self.workerContext];
    
    userLogin.authTokenLastUpdateTimeValue = [NSDate timeIntervalSinceReferenceDate];
    userLogin.authToken = token;
    
    [user setCredentials:userLogin];
}

@end
