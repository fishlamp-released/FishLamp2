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

- (id) initWithPermissions:(NSArray*) permissions
{
	if((self = [self initWithURL:[FLFacebookMgr buildOAuthUrl:permissions forAppId:[FLFacebookMgr instance].appId]]))
	{
	}
	return self;
}

+ (id) facebookBeginAuthorizationOperation:(NSArray*) permissions
{
	return FLReturnAutoreleased([[FLFacebookBeginAuthorizationOperation alloc] initWithPermissions:permissions]);
}

- (void) willOpenConnection:(FLHttpConnection*) connection
{
    [[FLFacebookMgr instance] clearFacebookCookies];

    [super willOpenConnection:connection];
}

- (void) didCloseConnection:(FLHttpConnection*) connection
{
    NSError* error = nil;
    self.output = [FLFacebookMgr authenticationResponseFromURL:connection.httpRequest.requestUrl outError:&error];
    if(error) {
        FLThrowError(error);
    }
    
    [super didCloseConnection:connection];
}

- (BOOL) httpConnection:(FLHttpConnection*) connection shouldRedirectToURL:(NSURL*) url
{
    return NO;
}

@end
