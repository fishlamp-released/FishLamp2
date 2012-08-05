// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookUser.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"
@class FLFacebookNamedObject;
@class FLFacebookWorkHistory;

// --------------------------------------------------------------------
// FLFacebookUser
// --------------------------------------------------------------------
@interface FLFacebookUser : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSString* __first_name;
    NSString* __last_name;
    NSString* __gender;
    NSString* __locale;
    NSString* __link;
    NSString* __username;
    NSString* __third_party_id;
    NSNumber* __timezone;
    NSDate* __updated_time;
    NSNumber* __verified;
    NSString* __about;
    NSString* __bio;
    NSString* __birthday;
    NSString* __education;
    FLFacebookNamedObject* __hometown;
    NSString* __interested_in;
    FLFacebookNamedObject* __location;
    NSString* __political;
    NSString* __quotes;
    NSString* __relationship_status;
    NSString* __religion;
    FLFacebookNamedObject* __significant_other;
    NSString* __website;
    NSMutableArray* __work;
} 


@property (readwrite, strong, nonatomic) NSString* about;

@property (readwrite, strong, nonatomic) NSString* bio;

@property (readwrite, strong, nonatomic) NSString* birthday;

@property (readwrite, strong, nonatomic) NSString* education;

@property (readwrite, strong, nonatomic) NSString* first_name;

@property (readwrite, strong, nonatomic) NSString* gender;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* hometown;

@property (readwrite, strong, nonatomic) NSString* interested_in;

@property (readwrite, strong, nonatomic) NSString* last_name;

@property (readwrite, strong, nonatomic) NSString* link;

@property (readwrite, strong, nonatomic) NSString* locale;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* location;

@property (readwrite, strong, nonatomic) NSString* political;

@property (readwrite, strong, nonatomic) NSString* quotes;

@property (readwrite, strong, nonatomic) NSString* relationship_status;

@property (readwrite, strong, nonatomic) NSString* religion;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* significant_other;

@property (readwrite, strong, nonatomic) NSString* third_party_id;

@property (readwrite, strong, nonatomic) NSNumber* timezone;

@property (readwrite, strong, nonatomic) NSDate* updated_time;

@property (readwrite, strong, nonatomic) NSString* username;

@property (readwrite, strong, nonatomic) NSNumber* verified;

@property (readwrite, strong, nonatomic) NSString* website;

@property (readwrite, strong, nonatomic) NSMutableArray* work;
/// Type: FLFacebookWorkHistory*, forKey: work_history

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

+ (FLFacebookUser*) facebookUser; 

@end

@interface FLFacebookUser (ValueProperties) 

@property (readwrite, assign, nonatomic) int timezoneValue;

@property (readwrite, assign, nonatomic) BOOL verifiedValue;
@end

// [/Generated]
