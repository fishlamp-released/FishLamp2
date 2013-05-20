//
//  GtOAuthRequestAccessTokenNetworkOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOAuthRequestAccessTokenNetworkOperation.h"
#import "GtOAuthSignature.h"
#import "NSString+URL.h"
#import "GtOAuthSession.h"
#import "GtUrlParameterParser.h"

@implementation GtOAuthRequestAccessTokenNetworkOperation

#if DEBUG
- (void) testMe
{
//	GtOAuthSignature* sig = [GtOAuthSignature OAuthSignature:@"POST" url:[NSURL URLWithString:@"https://api.twitter.com/oauth/access_token"]];
//
//	[sig addParameter:kGtOAuthHeaderConsumerKey value:@"GDdmIQH6jhtmLUypg82g"];
//	[sig addParameter:kGtOAuthHeaderNonce value:@"9zWH6qe0qG7Lc1telCn7FhUbLyVdjEaL3MO5uHxn8"];
//	[sig addParameter:kGtOAuthHeaderTimestamp value:@"1272323047"];
//	[sig addParameter:kGtOAuthHeaderSignatureMethod value:kGtOAuthSignatureMethodHMAC_SHA1];
//	[sig addParameter:kGtOAuthHeaderVersion value:GtOAuthVersion];
//	
//	[sig addParameter:kGtOAuthHeaderToken value:@"8ldIZyxQeVrFZXFOZH5tAwj6vzJYuLQpl0WUEYtWc"];
//	[sig addParameter:@"oauth_verifier" value:@"pDNg57prOHapMbhv25RNf75lVRd6JDsni1AJJIDYoTY"];
//	
//	NSString* baseUrlString = [sig computeBaseURL];
//	
//	GtDebugCompareStrings(baseUrlString,
//		@"POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Faccess_token&oauth_consumer_key%3DGDdmIQH6jhtmLUypg82g%26oauth_nonce%3D9zWH6qe0qG7Lc1telCn7FhUbLyVdjEaL3MO5uHxn8%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1272323047%26oauth_token%3D8ldIZyxQeVrFZXFOZH5tAwj6vzJYuLQpl0WUEYtWc%26oauth_verifier%3DpDNg57prOHapMbhv25RNf75lVRd6JDsni1AJJIDYoTY%26oauth_version%3D1.0");
//    
//
//	NSString* key = [sig buildHMAC_SHA1Signature:[NSString stringWithFormat:@"%@&%@", 
//		@"MCD8BKwGdgPHvAuvgvz4EQpqDAtx89grbuNMRd7Eh98", // consumer secret
//		@"x6qpRnlEmW9JbQn4PQVVeVG8ZLPEx6A0TOebgwcuA"]]; // oauth_token_secret
//
//	GtDebugCompareStrings(@"PUw/dHA4fnlJYM6RhXk5IU/0fCc=", key);
//
//	[sig addParameter:kGtOAuthHeaderSignature value:key];
//
//	NSString* authHeader = [sig buildAuthorizationHeader];
//	
//	GtDebugCompareHeaders([authHeader substringFromIndex:6],
//	@"oauth_nonce=\"9zWH6qe0qG7Lc1telCn7FhUbLyVdjEaL3MO5uHxn8\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1272323047\", oauth_consumer_key=\"GDdmIQH6jhtmLUypg82g\", oauth_token=\"8ldIZyxQeVrFZXFOZH5tAwj6vzJYuLQpl0WUEYtWc\", oauth_verifier=\"pDNg57prOHapMbhv25RNf75lVRd6JDsni1AJJIDYoTY\", oauth_signature=\"PUw%2FdHA4fnlJYM6RhXk5IU%2F0fCc%3D\", oauth_version=\"1.0\"");

}
#endif

- (id) initWithOAuthApp:(GtOAuthApp*) app authData:(GtOAuthAuthencationData*) data
{
	if((self = [super initWithURL:[NSURL URLWithString:app.accessTokenUrl]]))
	{
		m_app = GtRetain(app);
		m_authData = GtRetain(data);
	}
	
	return self;
}

+ (GtOAuthRequestAccessTokenNetworkOperation*) OAuthRequestAccessTokenNetworkOperation:(GtOAuthApp*) app authData:(GtOAuthAuthencationData*) data
{
	return GtReturnAutoreleased([[GtOAuthRequestAccessTokenNetworkOperation alloc] initWithOAuthApp:app authData:data]);
}

- (void) dealloc 
{
	GtRelease(m_app);
	GtRelease(m_authData);
	GtSuperDealloc();
}

- (void) willBeginRequestWithNetworkConnection:(GtHttpConnection*) connection
{
	[connection.httpRequest setHTTPMethodToPost];
	
	GtOAuthSignature* sig = [[GtOAuthSignature alloc] init];
	[sig beginSigningRequest:connection consumerKey:m_app.consumerKey];
	[sig addParameter:kGtOAuthHeaderToken value:m_authData.oauth_token];
	[sig addParameter:@"oauth_verifier" value:m_authData.oauth_verifier];

	[sig signRequest:connection withSecret:[NSString stringWithFormat:@"%@&%@", m_app.consumerSecret, m_authData.oauth_token_secret]]; 
	[sig addAuthenticationHeaderToRequest:connection oauthParametersOnly:YES];
	GtRelease(sig);
}

- (NSError*) didCompleteRequestWithNetworkConnection:(GtHttpConnection*) connection;
{
	NSError* error = [super didCompleteRequestWithNetworkConnection:connection];
	if(!error)
	{
		GtOAuthSession* session = [GtOAuthSession oAuthSession];
		[GtUrlParameterParser parseData:self.httpConnection.httpResponse.responseData 
			intoObject:session 
			strict:YES 
			requiredKeys:[NSArray arrayWithObjects:@"oauth_token", @"oauth_token_secret", @"user_id", @"screen_name", nil]];

		self.output = session;
	}
	
	return error;
}

@end
