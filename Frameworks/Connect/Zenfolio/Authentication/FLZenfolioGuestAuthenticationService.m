//
//  FLZenfolioGuestAuthenticationService.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioGuestAuthenticationService.h"

@implementation FLZenfolioGuestAuthenticationService

- (FLUserLogin*) synchronouslyAuthenticateUser:(FLUserLogin*) userLogin inContext:(id) context withObserver:(id) observer{
                                    
    FLTrace(@"Authenticating %@:", userLogin.userName );
    
    NSString* token = FLThrowError([context runWorker:[FLZenfolioHttpRequest authenticateVisitorHttpRequest] withObserver:observer]);
    userLogin.authTokenLastUpdateTimeValue = [NSDate timeIntervalSinceReferenceDate];
    userLogin.authToken = token;
    return userLogin;
}

@end
