// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookUser.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookUser.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLFacebookWorkHistory.h"

@implementation FLFacebookUser


@synthesize about = __about;
@synthesize bio = __bio;
@synthesize birthday = __birthday;
@synthesize education = __education;
@synthesize first_name = __first_name;
@synthesize gender = __gender;
@synthesize hometown = __hometown;
@synthesize interested_in = __interested_in;
@synthesize last_name = __last_name;
@synthesize link = __link;
@synthesize locale = __locale;
@synthesize location = __location;
@synthesize political = __political;
@synthesize quotes = __quotes;
@synthesize relationship_status = __relationship_status;
@synthesize religion = __religion;
@synthesize significant_other = __significant_other;
@synthesize third_party_id = __third_party_id;
@synthesize timezone = __timezone;
@synthesize updated_time = __updated_time;
@synthesize username = __username;
@synthesize verified = __verified;
@synthesize website = __website;
@synthesize work = __work;

+ (NSString*) aboutKey
{
    return @"about";
}

+ (NSString*) bioKey
{
    return @"bio";
}

+ (NSString*) birthdayKey
{
    return @"birthday";
}

+ (NSString*) educationKey
{
    return @"education";
}

+ (NSString*) first_nameKey
{
    return @"first_name";
}

+ (NSString*) genderKey
{
    return @"gender";
}

+ (NSString*) hometownKey
{
    return @"hometown";
}

+ (NSString*) interested_inKey
{
    return @"interested_in";
}

+ (NSString*) last_nameKey
{
    return @"last_name";
}

+ (NSString*) linkKey
{
    return @"link";
}

+ (NSString*) localeKey
{
    return @"locale";
}

+ (NSString*) locationKey
{
    return @"location";
}

+ (NSString*) politicalKey
{
    return @"political";
}

+ (NSString*) quotesKey
{
    return @"quotes";
}

+ (NSString*) relationship_statusKey
{
    return @"relationship_status";
}

+ (NSString*) religionKey
{
    return @"religion";
}

+ (NSString*) significant_otherKey
{
    return @"significant_other";
}

+ (NSString*) third_party_idKey
{
    return @"third_party_id";
}

+ (NSString*) timezoneKey
{
    return @"timezone";
}

+ (NSString*) updated_timeKey
{
    return @"updated_time";
}

+ (NSString*) usernameKey
{
    return @"username";
}

+ (NSString*) verifiedKey
{
    return @"verified";
}

+ (NSString*) websiteKey
{
    return @"website";
}

+ (NSString*) workKey
{
    return @"work";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookUser*)object).third_party_id = FLCopyOrRetainObject(__third_party_id);
    ((FLFacebookUser*)object).location = FLCopyOrRetainObject(__location);
    ((FLFacebookUser*)object).birthday = FLCopyOrRetainObject(__birthday);
    ((FLFacebookUser*)object).education = FLCopyOrRetainObject(__education);
    ((FLFacebookUser*)object).link = FLCopyOrRetainObject(__link);
    ((FLFacebookUser*)object).hometown = FLCopyOrRetainObject(__hometown);
    ((FLFacebookUser*)object).religion = FLCopyOrRetainObject(__religion);
    ((FLFacebookUser*)object).work = FLCopyOrRetainObject(__work);
    ((FLFacebookUser*)object).significant_other = FLCopyOrRetainObject(__significant_other);
    ((FLFacebookUser*)object).relationship_status = FLCopyOrRetainObject(__relationship_status);
    ((FLFacebookUser*)object).bio = FLCopyOrRetainObject(__bio);
    ((FLFacebookUser*)object).locale = FLCopyOrRetainObject(__locale);
    ((FLFacebookUser*)object).last_name = FLCopyOrRetainObject(__last_name);
    ((FLFacebookUser*)object).verified = FLCopyOrRetainObject(__verified);
    ((FLFacebookUser*)object).quotes = FLCopyOrRetainObject(__quotes);
    ((FLFacebookUser*)object).gender = FLCopyOrRetainObject(__gender);
    ((FLFacebookUser*)object).website = FLCopyOrRetainObject(__website);
    ((FLFacebookUser*)object).about = FLCopyOrRetainObject(__about);
    ((FLFacebookUser*)object).timezone = FLCopyOrRetainObject(__timezone);
    ((FLFacebookUser*)object).political = FLCopyOrRetainObject(__political);
    ((FLFacebookUser*)object).interested_in = FLCopyOrRetainObject(__interested_in);
    ((FLFacebookUser*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookUser*)object).first_name = FLCopyOrRetainObject(__first_name);
    ((FLFacebookUser*)object).username = FLCopyOrRetainObject(__username);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__first_name);
    FLRelease(__last_name);
    FLRelease(__gender);
    FLRelease(__locale);
    FLRelease(__link);
    FLRelease(__username);
    FLRelease(__third_party_id);
    FLRelease(__timezone);
    FLRelease(__updated_time);
    FLRelease(__verified);
    FLRelease(__about);
    FLRelease(__bio);
    FLRelease(__birthday);
    FLRelease(__education);
    FLRelease(__hometown);
    FLRelease(__interested_in);
    FLRelease(__location);
    FLRelease(__political);
    FLRelease(__quotes);
    FLRelease(__relationship_status);
    FLRelease(__religion);
    FLRelease(__significant_other);
    FLRelease(__website);
    FLRelease(__work);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__first_name) [aCoder encodeObject:__first_name forKey:@"__first_name"];
    if(__last_name) [aCoder encodeObject:__last_name forKey:@"__last_name"];
    if(__gender) [aCoder encodeObject:__gender forKey:@"__gender"];
    if(__locale) [aCoder encodeObject:__locale forKey:@"__locale"];
    if(__link) [aCoder encodeObject:__link forKey:@"__link"];
    if(__username) [aCoder encodeObject:__username forKey:@"__username"];
    if(__third_party_id) [aCoder encodeObject:__third_party_id forKey:@"__third_party_id"];
    if(__timezone) [aCoder encodeObject:__timezone forKey:@"__timezone"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    if(__verified) [aCoder encodeObject:__verified forKey:@"__verified"];
    if(__about) [aCoder encodeObject:__about forKey:@"__about"];
    if(__bio) [aCoder encodeObject:__bio forKey:@"__bio"];
    if(__birthday) [aCoder encodeObject:__birthday forKey:@"__birthday"];
    if(__education) [aCoder encodeObject:__education forKey:@"__education"];
    if(__hometown) [aCoder encodeObject:__hometown forKey:@"__hometown"];
    if(__interested_in) [aCoder encodeObject:__interested_in forKey:@"__interested_in"];
    if(__location) [aCoder encodeObject:__location forKey:@"__location"];
    if(__political) [aCoder encodeObject:__political forKey:@"__political"];
    if(__quotes) [aCoder encodeObject:__quotes forKey:@"__quotes"];
    if(__relationship_status) [aCoder encodeObject:__relationship_status forKey:@"__relationship_status"];
    if(__religion) [aCoder encodeObject:__religion forKey:@"__religion"];
    if(__significant_other) [aCoder encodeObject:__significant_other forKey:@"__significant_other"];
    if(__website) [aCoder encodeObject:__website forKey:@"__website"];
    if(__work) [aCoder encodeObject:__work forKey:@"__work"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookUser*) facebookUser
{
    return FLAutorelease([[FLFacebookUser alloc] init]);
}

- (id) init
{
    if((self = [super init]))
    {
    }
    return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        __first_name = FLRetain([aDecoder decodeObjectForKey:@"__first_name"]);
        __last_name = FLRetain([aDecoder decodeObjectForKey:@"__last_name"]);
        __gender = FLRetain([aDecoder decodeObjectForKey:@"__gender"]);
        __locale = FLRetain([aDecoder decodeObjectForKey:@"__locale"]);
        __link = FLRetain([aDecoder decodeObjectForKey:@"__link"]);
        __username = FLRetain([aDecoder decodeObjectForKey:@"__username"]);
        __third_party_id = FLRetain([aDecoder decodeObjectForKey:@"__third_party_id"]);
        __timezone = FLRetain([aDecoder decodeObjectForKey:@"__timezone"]);
        __updated_time = FLRetain([aDecoder decodeObjectForKey:@"__updated_time"]);
        __verified = FLRetain([aDecoder decodeObjectForKey:@"__verified"]);
        __about = FLRetain([aDecoder decodeObjectForKey:@"__about"]);
        __bio = FLRetain([aDecoder decodeObjectForKey:@"__bio"]);
        __birthday = FLRetain([aDecoder decodeObjectForKey:@"__birthday"]);
        __education = FLRetain([aDecoder decodeObjectForKey:@"__education"]);
        __hometown = FLRetain([aDecoder decodeObjectForKey:@"__hometown"]);
        __interested_in = FLRetain([aDecoder decodeObjectForKey:@"__interested_in"]);
        __location = FLRetain([aDecoder decodeObjectForKey:@"__location"]);
        __political = FLRetain([aDecoder decodeObjectForKey:@"__political"]);
        __quotes = FLRetain([aDecoder decodeObjectForKey:@"__quotes"]);
        __relationship_status = FLRetain([aDecoder decodeObjectForKey:@"__relationship_status"]);
        __religion = FLRetain([aDecoder decodeObjectForKey:@"__religion"]);
        __significant_other = FLRetain([aDecoder decodeObjectForKey:@"__significant_other"]);
        __website = FLRetain([aDecoder decodeObjectForKey:@"__website"]);
        __work = [[aDecoder decodeObjectForKey:@"__work"] mutableCopy];
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    static FLObjectDescriber* s_describer = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
        if(!s_describer)
        {
            s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
        }
        [s_describer addProperty:@"first_name" withClass:[NSString class]];
        [s_describer addProperty:@"last_name" withClass:[NSString class]];
        [s_describer addProperty:@"gender" withClass:[NSString class]];
        [s_describer addProperty:@"locale" withClass:[NSString class]];
        [s_describer addProperty:@"link" withClass:[NSString class]];
        [s_describer addProperty:@"username" withClass:[NSString class]];
        [s_describer addProperty:@"third_party_id" withClass:[NSString class]];
        [s_describer addProperty:@"timezone" withClass:[FLIntegerNumber class] ];
        [s_describer addProperty:@"updated_time" withClass:[NSDate class]];
        [s_describer addProperty:@"verified" withClass:[FLBoolNumber class] ];
        [s_describer addProperty:@"about" withClass:[NSString class]];
        [s_describer addProperty:@"bio" withClass:[NSString class]];
        [s_describer addProperty:@"birthday" withClass:[NSString class]];
        [s_describer addProperty:@"education" withClass:[NSString class]];
        [s_describer addProperty:@"hometown" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"interested_in" withClass:[NSString class]];
        [s_describer addProperty:@"location" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"political" withClass:[NSString class]];
        [s_describer addProperty:@"quotes" withClass:[NSString class]];
        [s_describer addProperty:@"relationship_status" withClass:[NSString class]];
        [s_describer addProperty:@"religion" withClass:[NSString class]];
        [s_describer addProperty:@"significant_other" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"website" withClass:[NSString class]];
        [s_describer addProperty:@"work" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"work_history" objectClass:[FLFacebookWorkHistory class]], nil]];
    });
    return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
    static FLObjectInflator* s_inflator = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
    });
    return s_inflator;
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
    static FLDatabaseTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        FLDatabaseTable* superTable = [super sharedDatabaseTable];
        if(superTable)
        {
            s_table = [superTable copy];
            s_table.tableName = [self databaseTableName];
        }
        else
        {
            s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
        }
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"first_name" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"last_name" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"gender" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"locale" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"link" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"username" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"third_party_id" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"timezone" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updated_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"verified" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"about" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"bio" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"birthday" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"education" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"hometown" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"interested_in" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"location" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"political" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"quotes" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"relationship_status" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"religion" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"significant_other" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"website" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"work" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookUser (ValueProperties) 

- (int) timezoneValue
{
    return [self.timezone intValue];
}

- (void) setTimezoneValue:(int) value
{
    self.timezone = [NSNumber numberWithInt:value];
}

- (BOOL) verifiedValue
{
    return [self.verified boolValue];
}

- (void) setVerifiedValue:(BOOL) value
{
    self.verified = [NSNumber numberWithBool:value];
}
@end

// [/Generated]
