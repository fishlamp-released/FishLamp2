//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtOAuthAuthencationData.h
//	Project: FishLamp
//	Schema: GtOauth
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtOAuthAuthencationData
// --------------------------------------------------------------------
@interface GtOAuthAuthencationData : NSObject{ 
@private
	NSString* m_oauth_token_secret;
	NSString* m_oauth_callback_confirmed;
	NSString* m_oauth_token;
	NSString* m_oauth_verifier;
} 


@property (readwrite, retain, nonatomic) NSString* oauth_callback_confirmed;

@property (readwrite, retain, nonatomic) NSString* oauth_token;

@property (readwrite, retain, nonatomic) NSString* oauth_token_secret;

@property (readwrite, retain, nonatomic) NSString* oauth_verifier;

+ (NSString*) oauth_callback_confirmedKey;

+ (NSString*) oauth_tokenKey;

+ (NSString*) oauth_token_secretKey;

+ (NSString*) oauth_verifierKey;

+ (GtOAuthAuthencationData*) oAuthAuthencationData; 

@end

@interface GtOAuthAuthencationData (ValueProperties) 
@end

