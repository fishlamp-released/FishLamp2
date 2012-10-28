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

- (id) initWithPermissions:(NSArray*) permissions {
	if((self = [self initWithURL:[FLFacebookMgr buildOAuthUrl:permissions
                                                     forAppId:[FLFacebookMgr instance].appId]])) {
	}
	return self;
}

+ (id) facebookBeginAuthorizationOperation:(NSArray*) permissions {
	return FLReturnAutoreleased([[FLFacebookBeginAuthorizationOperation alloc] initWithPermissions:permissions]);
}


- (void) runSelf {
    [[FLFacebookMgr instance] clearFacebookCookies];

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
