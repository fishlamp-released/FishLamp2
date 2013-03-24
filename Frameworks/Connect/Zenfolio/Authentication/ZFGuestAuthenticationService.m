//
//  ZFGuestAuthenticationService.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFGuestAuthenticationService.h"

@implementation ZFGuestAuthenticationService

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin inContext:(id) context {
                                    
    FLTrace(@"Authenticating %@:", userLogin.userName );
    
    NSString* token = FLThrowIfError([context runWorker:[ZFHttpRequest authenticateVisitorHttpRequest] withObserver:nil]);
    userLogin.authTokenLastUpdateTimeValue = [NSDate timeIntervalSinceReferenceDate];
    userLogin.authToken = token;
    return userLogin;
}

@end
