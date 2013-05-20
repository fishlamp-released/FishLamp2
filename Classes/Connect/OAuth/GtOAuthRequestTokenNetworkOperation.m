//
//  GtOAuthRequestTokenNetworkOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOAuthRequestTokenNetworkOperation.h"
#import "NSString+URL.h"
#import "GtOAuthAuthencationData.h"
#import "GtUrlParameterParser.h"
#import "GtOAuthSignature.h"

@implementation GtOAuthRequestTokenNetworkOperation

@synthesize OAuthApp = m_app;

- (id) initWithOAuthApp:(GtOAuthApp*) app
{
	if((self = [super initWithURL:[NSURL URLWithString:app.requestTokenUrl]]))
	{
		m_app = GtRetain(app);
	}
	
	return self;
}

+ (GtOAuthRequestTokenNetworkOperation*) OAuthRequestTokenNetworkOperation:(GtOAuthApp*) app
{
	return GtReturnAutoreleased([[GtOAuthRequestTokenNetworkOperation alloc] initWithOAuthApp:app]);
}

- (void) dealloc
{
	GtRelease(m_app);
	GtSuperDealloc();
}

- (void) willBeginRequestWithNetworkConnection:(GtHttpConnection*) connection
{
	[connection.httpRequest setHTTPMethodToPost];
	
	GtOAuthSignature* sig = [[GtOAuthSignature alloc] init];
	[sig beginSigningRequest:connection consumerKey:m_app.consumerKey];
	[sig signRequest:connection withSecret:[NSString stringWithFormat:@"%@&", m_app.consumerSecret] ]; // forURL:m_app.requestTokenUrl
	[sig addAuthenticationHeaderToRequest:connection oauthParametersOnly:YES];
	GtRelease(sig);
}

- (BOOL) httpConnection:(GtHttpConnection*) connection shouldRedirectToURL:(NSURL*) url
{
    return NO;
}

- (NSError*) didCompleteRequestWithNetworkConnection:(GtHttpConnection*) connection;
{
	NSError* error = [super didCompleteRequestWithNetworkConnection:connection];
	if(!error)
	{
		NSData* data = self.httpConnection.httpResponse.responseData;

#if DEBUG
		NSString* responseStr = GtReturnAutoreleased([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
		GtLog(@"Gt OAuthRequestToken response: %@", responseStr);
#endif	
		GtOAuthAuthencationData* response = [GtOAuthAuthencationData oAuthAuthencationData];
		[GtUrlParameterParser parseData:data intoObject:response strict:YES 
			requiredKeys:[NSArray arrayWithObjects:@"oauth_token_secret", @"oauth_token", @"oauth_callback_confirmed", nil]];
		self.output = response;
	}
	
	return error;
}

@end
