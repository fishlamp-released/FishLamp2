//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtOAuthApp.h
//	Project: FishLamp
//	Schema: GtOauth
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtNetworkServerContext.h"

// --------------------------------------------------------------------
// GtOAuthApp
// --------------------------------------------------------------------
@interface GtOAuthApp : GtNetworkServerContext{ 
@private
	NSString* m_appId;
	NSString* m_apiKey;
	NSString* m_consumerKey;
	NSString* m_consumerSecret;
	NSString* m_requestTokenUrl;
	NSString* m_accessTokenUrl;
	NSString* m_authorizeUrl;
	NSString* m_callback;
} 


@property (readwrite, retain, nonatomic) NSString* accessTokenUrl;

@property (readwrite, retain, nonatomic) NSString* apiKey;

@property (readwrite, retain, nonatomic) NSString* appId;

@property (readwrite, retain, nonatomic) NSString* authorizeUrl;

@property (readwrite, retain, nonatomic) NSString* callback;

@property (readwrite, retain, nonatomic) NSString* consumerKey;

@property (readwrite, retain, nonatomic) NSString* consumerSecret;

@property (readwrite, retain, nonatomic) NSString* requestTokenUrl;

+ (NSString*) accessTokenUrlKey;

+ (NSString*) apiKeyKey;

+ (NSString*) appIdKey;

+ (NSString*) authorizeUrlKey;

+ (NSString*) callbackKey;

+ (NSString*) consumerKeyKey;

+ (NSString*) consumerSecretKey;

+ (NSString*) requestTokenUrlKey;

+ (GtOAuthApp*) oAuthApp; 

@end

@interface GtOAuthApp (ValueProperties) 
@end

