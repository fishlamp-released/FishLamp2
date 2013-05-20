//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookNetworkSession.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtFacebookNetworkSession
// --------------------------------------------------------------------
@interface GtFacebookNetworkSession : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_userId;
	NSString* m_appId;
	NSString* m_access_token;
	NSDate* m_expiration_date;
	NSMutableArray* m_permissions;
} 


@property (readwrite, retain, nonatomic) NSString* access_token;

@property (readwrite, retain, nonatomic) NSString* appId;

@property (readwrite, retain, nonatomic) NSDate* expiration_date;

@property (readwrite, retain, nonatomic) NSMutableArray* permissions;
// Type: NSString*, forKey: permission

@property (readwrite, retain, nonatomic) NSString* userId;

+ (NSString*) access_tokenKey;

+ (NSString*) appIdKey;

+ (NSString*) expiration_dateKey;

+ (NSString*) permissionsKey;

+ (NSString*) userIdKey;

+ (GtFacebookNetworkSession*) facebookNetworkSession; 

@end

@interface GtFacebookNetworkSession (ValueProperties) 
@end

