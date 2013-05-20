//	This file was generated at 7/20/11 6:48 PM by PackMule. DO NOT MODIFY!!
//
//	GtOauthEnums.h
//	Project: FishLamp
//	Schema: GtOauth
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#define GtOAuthHttpAuthorizationHeader @"Authorization" // for http header
#define GtOAuthVersion @"1.0" 
#define GtOAuthHttpAuthorizationHeader @"Authorization" // for http header
#define GtOAuthVersion @"1.0" 

#define kGtOAuthHeaderConsumerKey @"oauth_consumer_key"
#define kGtOAuthHeaderToken @"oauth_token"
#define kGtOAuthHeaderSignatureMethod @"oauth_signature_method"
#define kGtOAuthHeaderTimestamp @"oauth_timestamp"
#define kGtOAuthHeaderNonce @"oauth_nonce"
#define kGtOAuthHeaderSignature @"oauth_signature"
#define kGtOAuthHeaderCallback @"oauth_callback"
#define kGtOAuthHeaderVersion @"oauth_version"
#define kGtOAuthSignatureMethodHMAC_SHA1 @"HMAC-SHA1"
#define kGtOAuthSignatureMethodRSA_SHA1 @"RSA-SHA1"
#define kGtOAuthSignatureMethodPlaintext @"PLAINTEXT"

typedef enum {
	GtOAuthHeaderConsumerKey,
	GtOAuthHeaderToken,
	GtOAuthHeaderSignatureMethod,
	GtOAuthHeaderTimestamp,
	GtOAuthHeaderNonce,
	GtOAuthHeaderSignature,
	GtOAuthHeaderCallback,
	GtOAuthHeaderVersion,
} GtOAuthHeader;

typedef enum {
	GtOAuthSignatureMethodHMAC_SHA1,
	GtOAuthSignatureMethodRSA_SHA1,
	GtOAuthSignatureMethodPlaintext,
} GtOAuthSignatureMethod;


@interface GtOauthEnumLookup : NSObject {
	NSDictionary* m_strings;
}
GtSingletonProperty(GtOauthEnumLookup);
- (NSString*) stringFromOAuthHeader:(GtOAuthHeader) inEnum;
- (GtOAuthHeader) oAuthHeaderFromString:(NSString*) inString;
- (NSString*) stringFromOAuthSignatureMethod:(GtOAuthSignatureMethod) inEnum;
- (GtOAuthSignatureMethod) oAuthSignatureMethodFromString:(NSString*) inString;
@end
