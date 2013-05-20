//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookUser.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"
@class GtFacebookNamedObject;
@class GtFacebookWorkHistory;

// --------------------------------------------------------------------
// GtFacebookUser
// --------------------------------------------------------------------
@interface GtFacebookUser : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_first_name;
	NSString* m_last_name;
	NSString* m_gender;
	NSString* m_locale;
	NSString* m_link;
	NSString* m_username;
	NSString* m_third_party_id;
	NSNumber* m_timezone;
	NSDate* m_updated_time;
	NSNumber* m_verified;
	NSString* m_about;
	NSString* m_bio;
	NSString* m_birthday;
	NSString* m_education;
	GtFacebookNamedObject* m_hometown;
	NSString* m_interested_in;
	GtFacebookNamedObject* m_location;
	NSString* m_political;
	NSString* m_quotes;
	NSString* m_relationship_status;
	NSString* m_religion;
	GtFacebookNamedObject* m_significant_other;
	NSString* m_website;
	NSMutableArray* m_work;
} 


@property (readwrite, retain, nonatomic) NSString* about;

@property (readwrite, retain, nonatomic) NSString* bio;

@property (readwrite, retain, nonatomic) NSString* birthday;

@property (readwrite, retain, nonatomic) NSString* education;

@property (readwrite, retain, nonatomic) NSString* first_name;

@property (readwrite, retain, nonatomic) NSString* gender;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* hometown;

@property (readwrite, retain, nonatomic) NSString* interested_in;

@property (readwrite, retain, nonatomic) NSString* last_name;

@property (readwrite, retain, nonatomic) NSString* link;

@property (readwrite, retain, nonatomic) NSString* locale;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* location;

@property (readwrite, retain, nonatomic) NSString* political;

@property (readwrite, retain, nonatomic) NSString* quotes;

@property (readwrite, retain, nonatomic) NSString* relationship_status;

@property (readwrite, retain, nonatomic) NSString* religion;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* significant_other;

@property (readwrite, retain, nonatomic) NSString* third_party_id;

@property (readwrite, retain, nonatomic) NSNumber* timezone;

@property (readwrite, retain, nonatomic) NSDate* updated_time;

@property (readwrite, retain, nonatomic) NSString* username;

@property (readwrite, retain, nonatomic) NSNumber* verified;

@property (readwrite, retain, nonatomic) NSString* website;

@property (readwrite, retain, nonatomic) NSMutableArray* work;
// Type: GtFacebookWorkHistory*, forKey: work_history

+ (NSString*) aboutKey;

+ (NSString*) bioKey;

+ (NSString*) birthdayKey;

+ (NSString*) educationKey;

+ (NSString*) first_nameKey;

+ (NSString*) genderKey;

+ (NSString*) hometownKey;

+ (NSString*) interested_inKey;

+ (NSString*) last_nameKey;

+ (NSString*) linkKey;

+ (NSString*) localeKey;

+ (NSString*) locationKey;

+ (NSString*) politicalKey;

+ (NSString*) quotesKey;

+ (NSString*) relationship_statusKey;

+ (NSString*) religionKey;

+ (NSString*) significant_otherKey;

+ (NSString*) third_party_idKey;

+ (NSString*) timezoneKey;

+ (NSString*) updated_timeKey;

+ (NSString*) usernameKey;

+ (NSString*) verifiedKey;

+ (NSString*) websiteKey;

+ (NSString*) workKey;

+ (GtFacebookUser*) facebookUser; 

@end

@interface GtFacebookUser (ValueProperties) 

@property (readwrite, assign, nonatomic) int timezoneValue;

@property (readwrite, assign, nonatomic) BOOL verifiedValue;
@end

