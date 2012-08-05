//
//  FLOAuthRequestTokenNetworkOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLOAuthRequestTokenNetworkOperation.h"
#import "NSString+URL.h"
#import "FLOAuthAuthencationData.h"
#import "FLUrlParameterParser.h"
#import "FLOAuthSignature.h"

@implementation FLOAuthRequestTokenNetworkOperation

@synthesize OAuthApp = m_app;

- (id) initWithOAuthApp:(FLOAuthApp*) app
{
	if((self = [super initWithURL:[NSURL URLWithString:app.requestTokenUrl]]))
	{
		m_app = FLReturnRetained(app);
	}
	
	return self;
}

+ (FLOAuthRequestTokenNetworkOperation*) OAuthRequestTokenNetworkOperation:(FLOAuthApp*) app
{
	return FLReturnAutoreleased([[FLOAuthRequestTokenNetworkOperation alloc] initWithOAuthApp:app]);
}

- (void) dealloc
{
	FLRelease(m_app);
	FLSuperDealloc();
}

- (void) willBeginRequestWithNetworkConnection:(FLHttpConnection*) connection
{
	[connection.httpRequest setHTTPMethodToPost];
	
	FLOAuthSignature* sig = [[FLOAuthSignature alloc] init];
	[sig beginSigningRequest:connection consumerKey:m_app.consumerKey];
	[sig signRequest:connection withSecret:[NSString stringWithFormat:@"%@&", m_app.consumerSecret] ]; // forURL:m_app.requestTokenUrl
	[sig addAuthenticationHeaderToRequest:connection oauthParametersOnly:YES];
	FLRelease(sig);
}

- (BOOL) httpConnection:(FLHttpConnection*) connection shouldRedirectToURL:(NSURL*) url
{
    return NO;
}

- (void) didCloseConnection:(FLNetworkConnection*) connection
{
    [super didCloseConnection:connection];

    NSData* data = self.httpConnection.httpResponse.responseData;

#if DEBUG
    NSString* responseStr = FLReturnAutoreleased([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    FLDebugLog(@"FL OAuthRequestToken response: %@", responseStr);
#endif	
    FLOAuthAuthencationData* response = [FLOAuthAuthencationData oAuthAuthencationData];
    [FLUrlParameterParser parseData:data intoObject:response strict:YES 
        requiredKeys:[NSArray arrayWithObjects:@"oauth_token_secret", @"oauth_token", @"oauth_callback_confirmed", nil]];
    self.output = response;
}

@end
