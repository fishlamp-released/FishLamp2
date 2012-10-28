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
#import "FLObjectInflator.h"
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
    return FLReturnAutoreleased([[FLFacebookUser alloc] init]);
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
        __first_name = FLReturnRetained([aDecoder decodeObjectForKey:@"__first_name"]);
        __last_name = FLReturnRetained([aDecoder decodeObjectForKey:@"__last_name"]);
        __gender = FLReturnRetained([aDecoder decodeObjectForKey:@"__gender"]);
        __locale = FLReturnRetained([aDecoder decodeObjectForKey:@"__locale"]);
        __link = FLReturnRetained([aDecoder decodeObjectForKey:@"__link"]);
        __username = FLReturnRetained([aDecoder decodeObjectForKey:@"__username"]);
        __third_party_id = FLReturnRetained([aDecoder decodeObjectForKey:@"__third_party_id"]);
        __timezone = FLReturnRetained([aDecoder decodeObjectForKey:@"__timezone"]);
        __updated_time = FLReturnRetained([aDecoder decodeObjectForKey:@"__updated_time"]);
        __verified = FLReturnRetained([aDecoder decodeObjectForKey:@"__verified"]);
        __about = FLReturnRetained([aDecoder decodeObjectForKey:@"__about"]);
        __bio = FLReturnRetained([aDecoder decodeObjectForKey:@"__bio"]);
        __birthday = FLReturnRetained([aDecoder decodeObjectForKey:@"__birthday"]);
        __education = FLReturnRetained([aDecoder decodeObjectForKey:@"__education"]);
        __hometown = FLReturnRetained([aDecoder decodeObjectForKey:@"__hometown"]);
        __interested_in = FLReturnRetained([aDecoder decodeObjectForKey:@"__interested_in"]);
        __location = FLReturnRetained([aDecoder decodeObjectForKey:@"__location"]);
        __political = FLReturnRetained([aDecoder decodeObjectForKey:@"__political"]);
        __quotes = FLReturnRetained([aDecoder decodeObjectForKey:@"__quotes"]);
        __relationship_status = FLReturnRetained([aDecoder decodeObjectForKey:@"__relationship_status"]);
        __religion = FLReturnRetained([aDecoder decodeObjectForKey:@"__religion"]);
        __significant_other = FLReturnRetained([aDecoder decodeObjectForKey:@"__significant_other"]);
        __website = FLReturnRetained([aDecoder decodeObjectForKey:@"__website"]);
        __work = [[aDecoder decodeObjectForKey:@"__work"] mutableCopy];
    }
    return self;
}

+ (FLObjectDescriber*) sharedObjectDescriber
{
    static FLObjectDescriber* s_describer = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_describer = [[super sharedObjectDescriber] copy];
        if(!s_describer)
        {
            s_describer = [[FLObjectDescriber alloc] init];
        }
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"first_name" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"first_name"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"last_name" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"last_name"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"gender" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"gender"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"locale" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"locale"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"link"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"username" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"username"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"third_party_id" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"third_party_id"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"timezone" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"timezone"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"updated_time"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"verified" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"verified"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"about" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"about"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"bio" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"bio"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"birthday" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"birthday"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"education" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"education"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"hometown" propertyClass:[FLFacebookNamedObject class] propertyType:FLDataTypeObject] forPropertyName:@"hometown"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"interested_in" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"interested_in"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"location" propertyClass:[FLFacebookNamedObject class] propertyType:FLDataTypeObject] forPropertyName:@"location"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"political" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"political"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"quotes" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"quotes"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"relationship_status" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"relationship_status"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"religion" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"religion"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"significant_other" propertyClass:[FLFacebookNamedObject class] propertyType:FLDataTypeObject] forPropertyName:@"significant_other"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"website" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"website"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"work" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"work_history" propertyClass:[FLFacebookWorkHistory class] propertyType:FLDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"work"];
    });
    return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
    static FLObjectInflator* s_inflator = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
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
