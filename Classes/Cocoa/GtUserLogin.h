//	This file was generated at 7/3/11 10:38 AM by PackMule. DO NOT MODIFY!!
//
//	GtUserLogin.h
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtUserLogin
// --------------------------------------------------------------------
@interface GtUserLogin : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_userGuid;
	NSString* m_userName;
	NSString* m_password;
	NSNumber* m_isAuthenticated;
	NSString* m_authToken;
	NSString* m_email;
	NSNumber* m_authTokenLastUpdateTime;
	NSNumber* m_userValue;
} 


@property (readwrite, retain, nonatomic) NSString* authToken;

@property (readwrite, retain, nonatomic) NSNumber* authTokenLastUpdateTime;

@property (readwrite, retain, nonatomic) NSString* email;

@property (readwrite, retain, nonatomic) NSNumber* isAuthenticated;

@property (readwrite, retain, nonatomic) NSString* password;

@property (readwrite, retain, nonatomic) NSString* userGuid;

@property (readwrite, retain, nonatomic) NSString* userName;

@property (readwrite, retain, nonatomic) NSNumber* userValue;

+ (NSString*) authTokenKey;

+ (NSString*) authTokenLastUpdateTimeKey;

+ (NSString*) emailKey;

+ (NSString*) isAuthenticatedKey;

+ (NSString*) passwordKey;

+ (NSString*) userGuidKey;

+ (NSString*) userNameKey;

+ (NSString*) userValueKey;

+ (GtUserLogin*) userLogin; 

@end

@interface GtUserLogin (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isAuthenticatedValue;

@property (readwrite, assign, nonatomic) double authTokenLastUpdateTimeValue;

@property (readwrite, assign, nonatomic) long userValueValue;
@end

