//
//  FLOAuthRequestAccessTokenNetworkOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLOAuthRequestAccessTokenNetworkOperation.h"
#import "FLOAuthSignature.h"
#import "NSString+URL.h"
#import "FLOAuthSession.h"
#import "FLUrlParameterParser.h"

@implementation FLOAuthRequestAccessTokenNetworkOperation

#if DEBUG
- (void) testMe
{
//	FLOAuthSignature* sig = [FLOAuthSignature OAuthSignature:@"POST" url:[NSURL URLWithString:@"https://api.twitter.com/oauth/access_token"]];
//
//	[sig addParameter:kFLOAuthHeaderConsumerKey value:@"GDdmIQH6jhtmLUypg82g"];
//	[sig addParameter:kFLOAuthHeaderNonce value:@"9zWH6qe0qG7Lc1telCn7FhUbLyVdjEaL3MO5uHxn8"];
//	[sig addParameter:kFLOAuthHeaderTimestamp value:@"1272323047"];
//	[sig addParameter:kFLOAuthHeaderSignatureMethod value:kFLOAuthSignatureMethodHMAC_SHA1];
//	[sig addParameter:kFLOAuthHeaderVersion value:FLOAuthVersion];
//	
//	[sig addParameter:kFLOAuthHeaderToken value:@"8ldIZyxQeVrFZXFOZH5tAwj6vzJYuLQpl0WUEYtWc"];
//	[sig addParameter:@"oauth_verifier" value:@"pDNg57prOHapMbhv25RNf75lVRd6JDsni1AJJIDYoTY"];
//	
//	NSString* baseUrlString = [sig computeBaseURL];
//	
//	FLDebugCompareStrings(baseUrlString,
//		@"POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Faccess_token&oauth_consumer_key%3DGDdmIQH6jhtmLUypg82g%26oauth_nonce%3D9zWH6qe0qG7Lc1telCn7FhUbLyVdjEaL3MO5uHxn8%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1272323047%26oauth_token%3D8ldIZyxQeVrFZXFOZH5tAwj6vzJYuLQpl0WUEYtWc%26oauth_verifier%3DpDNg57prOHapMbhv25RNf75lVRd6JDsni1AJJIDYoTY%26oauth_version%3D1.0");
//    
//
//	NSString* key = [sig buildHMAC_SHA1Signature:[NSString stringWithFormat:@"%@&%@", 
//		@"MCD8BKwGdgPHvAuvgvz4EQpqDAtx89grbuNMRd7Eh98", // consumer secret
//		@"x6qpRnlEmW9JbQn4PQVVeVG8ZLPEx6A0TOebgwcuA"]]; // oauth_token_secret
//
//	FLDebugCompareStrings(@"PUw/dHA4fnlJYM6RhXk5IU/0fCc=", key);
//
//	[sig addParameter:kFLOAuthHeaderSignature value:key];
//
//	NSString* authHeader = [sig buildAuthorizationHeader];
//	
//	FLDebugCompareHeaders([authHeader substringFromIndex:6],
//	@"oauth_nonce=\"9zWH6qe0qG7Lc1telCn7FhUbLyVdjEaL3MO5uHxn8\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1272323047\", oauth_consumer_key=\"GDdmIQH6jhtmLUypg82g\", oauth_token=\"8ldIZyxQeVrFZXFOZH5tAwj6vzJYuLQpl0WUEYtWc\", oauth_verifier=\"pDNg57prOHapMbhv25RNf75lVRd6JDsni1AJJIDYoTY\", oauth_signature=\"PUw%2FdHA4fnlJYM6RhXk5IU%2F0fCc%3D\", oauth_version=\"1.0\"");

}
#endif

- (id) initWithOAuthApp:(FLOAuthApp*) app authData:(FLOAuthAuthencationData*) data
{
	if((self = [super initWithURL:[NSURL URLWithString:app.accessTokenUrl]]))
	{
		m_app = FLReturnRetained(app);
		m_authData = FLReturnRetained(data);
	}
	
	return self;
}

+ (FLOAuthRequestAccessTokenNetworkOperation*) OAuthRequestAccessTokenNetworkOperation:(FLOAuthApp*) app authData:(FLOAuthAuthencationData*) data
{
	return FLReturnAutoreleased([[FLOAuthRequestAccessTokenNetworkOperation alloc] initWithOAuthApp:app authData:data]);
}

- (void) dealloc 
{
	FLRelease(m_app);
	FLRelease(m_authData);
	FLSuperDealloc();
}

- (void) willBeginRequestWithNetworkConnection:(FLHttpConnection*) connection
{
	[connection.httpRequest setHTTPMethodToPost];
	
	FLOAuthSignature* sig = [[FLOAuthSignature alloc] init];
	[sig beginSigningRequest:connection consumerKey:m_app.consumerKey];
	[sig addParameter:kFLOAuthHeaderToken value:m_authData.oauth_token];
	[sig addParameter:@"oauth_verifier" value:m_authData.oauth_verifier];

	[sig signRequest:connection withSecret:[NSString stringWithFormat:@"%@&%@", m_app.consumerSecret, m_authData.oauth_token_secret]]; 
	[sig addAuthenticationHeaderToRequest:connection oauthParametersOnly:YES];
	FLRelease(sig);
}

- (void) didCloseConnection:(FLHttpConnection*) connection;
{
	[super didCloseConnection:connection];
    FLOAuthSession* session = [FLOAuthSession oAuthSession];
    [FLUrlParameterParser parseData:self.httpConnection.httpResponse.responseData 
        intoObject:session 
        strict:YES 
        requiredKeys:[NSArray arrayWithObjects:@"oauth_token", @"oauth_token_secret", @"user_id", @"screen_name", nil]];

    self.output = session;
}

@end
