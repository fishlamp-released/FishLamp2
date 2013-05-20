//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtOAuthSession.h
//	Project: FishLamp
//	Schema: GtOauth
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtOAuthSession
// --------------------------------------------------------------------
@interface GtOAuthSession : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_userGuid;
	NSString* m_appName;
	NSString* m_oauth_token;
	NSString* m_oauth_token_secret;
	NSString* m_user_id;
	NSString* m_screen_name;
} 


@property (readwrite, retain, nonatomic) NSString* appName;

@property (readwrite, retain, nonatomic) NSString* oauth_token;

@property (readwrite, retain, nonatomic) NSString* oauth_token_secret;

@property (readwrite, retain, nonatomic) NSString* screen_name;

@property (readwrite, retain, nonatomic) NSString* userGuid;

@property (readwrite, retain, nonatomic) NSString* user_id;

+ (NSString*) appNameKey;

+ (NSString*) oauth_tokenKey;

+ (NSString*) oauth_token_secretKey;

+ (NSString*) screen_nameKey;

+ (NSString*) userGuidKey;

+ (NSString*) user_idKey;

+ (GtOAuthSession*) oAuthSession; 

@end

@interface GtOAuthSession (ValueProperties) 
@end

