//	This file was generated at 7/8/11 6:43 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPrivacy.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtFacebookPrivacy
// --------------------------------------------------------------------
@interface GtFacebookPrivacy : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_value;
	NSString* m_friends;
	NSString* m_networks;
	NSString* m_deny;
	NSString* m_description;
} 


@property (readwrite, retain, nonatomic) NSString* deny;

@property (readwrite, retain, nonatomic) NSString* description;

@property (readwrite, retain, nonatomic) NSString* friends;

@property (readwrite, retain, nonatomic) NSString* networks;

@property (readwrite, retain, nonatomic) NSString* value;

+ (NSString*) denyKey;

+ (NSString*) descriptionKey;

+ (NSString*) friendsKey;

+ (NSString*) networksKey;

+ (NSString*) valueKey;

+ (GtFacebookPrivacy*) facebookPrivacy; 

@end

@interface GtFacebookPrivacy (ValueProperties) 
@end

