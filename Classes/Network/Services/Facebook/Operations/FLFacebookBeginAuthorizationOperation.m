//
//  FLFacebookBeginAuthorizationOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookBeginAuthorizationOperation.h"
#import "FLFacebookMgr.h"

@implementation FLFacebookBeginAuthorizationOperation

@synthesize permissions = _permissions;

#if FL_MRC
- (void) dealloc {
    [_permissions release];
    [super dealloc];
}
#endif

- (void) runSelf {

    self.URL = [FLFacebookMgr buildOAuthUrl:self.permissions
                                   forAppId:[[FLFacebookMgr serviceFromContext:self.context] appId]];

    [FLFacebookMgr clearFacebookCookies];

    [super runSelf];
        if(self.didSucceed) {

        NSError* error = nil;
        self.output = [FLFacebookMgr authenticationResponseFromURL:self.httpRequest.requestURL outError:&error];
        if(error) {
            FLThrowError_(error);
        }
    }
}

- (void) networkConnection:(FLNetworkConnection*) connection
            shouldRedirect:(BOOL*) redirect
                     toURL:(NSURL*) url {
    *redirect = NO;
}


@end
