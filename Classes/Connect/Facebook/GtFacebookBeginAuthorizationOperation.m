//
//  GtFacebookBeginAuthorizationOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookBeginAuthorizationOperation.h"
#import "GtFacebookMgr.h"

@implementation GtFacebookBeginAuthorizationOperation

- (id) initWithPermissions:(NSArray*) permissions
{
	if((self = [self initWithURL:[GtFacebookMgr buildOAuthUrl:permissions forAppId:[GtFacebookMgr instance].appId]]))
	{
	}
	return self;
}

+ (id) facebookBeginAuthorizationOperation:(NSArray*) permissions
{
	return GtReturnAutoreleased([[GtFacebookBeginAuthorizationOperation alloc] initWithPermissions:permissions]);
}

- (void) willBeginRequestWithNetworkConnection:(GtHttpConnection *)connection
{
    [[GtFacebookMgr instance] clearFacebookCookies];

    [super willBeginRequestWithNetworkConnection:connection];
}

- (BOOL) httpConnection:(GtHttpConnection*) connection shouldRedirectToURL:(NSURL*) url
{
    return NO;
}

- (NSError*) didCompleteRequestWithNetworkConnection:(GtHttpConnection*) connection
{
	NSError* error = connection.error;
	if(!error)
	{
		self.output = [GtFacebookMgr authenticationResponseFromURL:connection.httpRequest.requestUrl outError:&error];
	}
	
	if(!error)
	{
		error = [super didCompleteRequestWithNetworkConnection:connection];
	}
	
	return error;
}

@end
