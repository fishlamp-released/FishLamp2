//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookUser.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookUser.h"
#import "GtFacebookNamedObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtFacebookWorkHistory.h"

@implementation GtFacebookUser


@synthesize about = m_about;
@synthesize bio = m_bio;
@synthesize birthday = m_birthday;
@synthesize education = m_education;
@synthesize first_name = m_first_name;
@synthesize gender = m_gender;
@synthesize hometown = m_hometown;
@synthesize interested_in = m_interested_in;
@synthesize last_name = m_last_name;
@synthesize link = m_link;
@synthesize locale = m_locale;
@synthesize location = m_location;
@synthesize political = m_political;
@synthesize quotes = m_quotes;
@synthesize relationship_status = m_relationship_status;
@synthesize religion = m_religion;
@synthesize significant_other = m_significant_other;
@synthesize third_party_id = m_third_party_id;
@synthesize timezone = m_timezone;
@synthesize updated_time = m_updated_time;
@synthesize username = m_username;
@synthesize verified = m_verified;
@synthesize website = m_website;
@synthesize work = m_work;

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
	((GtFacebookUser*)object).third_party_id = GtCopyOrRetainObject(m_third_party_id);
	((GtFacebookUser*)object).location = GtCopyOrRetainObject(m_location);
	((GtFacebookUser*)object).birthday = GtCopyOrRetainObject(m_birthday);
	((GtFacebookUser*)object).education = GtCopyOrRetainObject(m_education);
	((GtFacebookUser*)object).link = GtCopyOrRetainObject(m_link);
	((GtFacebookUser*)object).hometown = GtCopyOrRetainObject(m_hometown);
	((GtFacebookUser*)object).religion = GtCopyOrRetainObject(m_religion);
	((GtFacebookUser*)object).work = GtCopyOrRetainObject(m_work);
	((GtFacebookUser*)object).significant_other = GtCopyOrRetainObject(m_significant_other);
	((GtFacebookUser*)object).relationship_status = GtCopyOrRetainObject(m_relationship_status);
	((GtFacebookUser*)object).bio = GtCopyOrRetainObject(m_bio);
	((GtFacebookUser*)object).locale = GtCopyOrRetainObject(m_locale);
	((GtFacebookUser*)object).last_name = GtCopyOrRetainObject(m_last_name);
	((GtFacebookUser*)object).verified = GtCopyOrRetainObject(m_verified);
	((GtFacebookUser*)object).quotes = GtCopyOrRetainObject(m_quotes);
	((GtFacebookUser*)object).gender = GtCopyOrRetainObject(m_gender);
	((GtFacebookUser*)object).website = GtCopyOrRetainObject(m_website);
	((GtFacebookUser*)object).about = GtCopyOrRetainObject(m_about);
	((GtFacebookUser*)object).timezone = GtCopyOrRetainObject(m_timezone);
	((GtFacebookUser*)object).political = GtCopyOrRetainObject(m_political);
	((GtFacebookUser*)object).interested_in = GtCopyOrRetainObject(m_interested_in);
	((GtFacebookUser*)object).updated_time = GtCopyOrRetainObject(m_updated_time);
	((GtFacebookUser*)object).first_name = GtCopyOrRetainObject(m_first_name);
	((GtFacebookUser*)object).username = GtCopyOrRetainObject(m_username);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_first_name);
	GtRelease(m_last_name);
	GtRelease(m_gender);
	GtRelease(m_locale);
	GtRelease(m_link);
	GtRelease(m_username);
	GtRelease(m_third_party_id);
	GtRelease(m_timezone);
	GtRelease(m_updated_time);
	GtRelease(m_verified);
	GtRelease(m_about);
	GtRelease(m_bio);
	GtRelease(m_birthday);
	GtRelease(m_education);
	GtRelease(m_hometown);
	GtRelease(m_interested_in);
	GtRelease(m_location);
	GtRelease(m_political);
	GtRelease(m_quotes);
	GtRelease(m_relationship_status);
	GtRelease(m_religion);
	GtRelease(m_significant_other);
	GtRelease(m_website);
	GtRelease(m_work);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_first_name) [aCoder encodeObject:m_first_name forKey:@"m_first_name"];
	if(m_last_name) [aCoder encodeObject:m_last_name forKey:@"m_last_name"];
	if(m_gender) [aCoder encodeObject:m_gender forKey:@"m_gender"];
	if(m_locale) [aCoder encodeObject:m_locale forKey:@"m_locale"];
	if(m_link) [aCoder encodeObject:m_link forKey:@"m_link"];
	if(m_username) [aCoder encodeObject:m_username forKey:@"m_username"];
	if(m_third_party_id) [aCoder encodeObject:m_third_party_id forKey:@"m_third_party_id"];
	if(m_timezone) [aCoder encodeObject:m_timezone forKey:@"m_timezone"];
	if(m_updated_time) [aCoder encodeObject:m_updated_time forKey:@"m_updated_time"];
	if(m_verified) [aCoder encodeObject:m_verified forKey:@"m_verified"];
	if(m_about) [aCoder encodeObject:m_about forKey:@"m_about"];
	if(m_bio) [aCoder encodeObject:m_bio forKey:@"m_bio"];
	if(m_birthday) [aCoder encodeObject:m_birthday forKey:@"m_birthday"];
	if(m_education) [aCoder encodeObject:m_education forKey:@"m_education"];
	if(m_hometown) [aCoder encodeObject:m_hometown forKey:@"m_hometown"];
	if(m_interested_in) [aCoder encodeObject:m_interested_in forKey:@"m_interested_in"];
	if(m_location) [aCoder encodeObject:m_location forKey:@"m_location"];
	if(m_political) [aCoder encodeObject:m_political forKey:@"m_political"];
	if(m_quotes) [aCoder encodeObject:m_quotes forKey:@"m_quotes"];
	if(m_relationship_status) [aCoder encodeObject:m_relationship_status forKey:@"m_relationship_status"];
	if(m_religion) [aCoder encodeObject:m_religion forKey:@"m_religion"];
	if(m_significant_other) [aCoder encodeObject:m_significant_other forKey:@"m_significant_other"];
	if(m_website) [aCoder encodeObject:m_website forKey:@"m_website"];
	if(m_work) [aCoder encodeObject:m_work forKey:@"m_work"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookUser*) facebookUser
{
	return GtReturnAutoreleased([[GtFacebookUser alloc] init]);
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
		m_first_name = [[aDecoder decodeObjectForKey:@"m_first_name"] retain];
		m_last_name = [[aDecoder decodeObjectForKey:@"m_last_name"] retain];
		m_gender = [[aDecoder decodeObjectForKey:@"m_gender"] retain];
		m_locale = [[aDecoder decodeObjectForKey:@"m_locale"] retain];
		m_link = [[aDecoder decodeObjectForKey:@"m_link"] retain];
		m_username = [[aDecoder decodeObjectForKey:@"m_username"] retain];
		m_third_party_id = [[aDecoder decodeObjectForKey:@"m_third_party_id"] retain];
		m_timezone = [[aDecoder decodeObjectForKey:@"m_timezone"] retain];
		m_updated_time = [[aDecoder decodeObjectForKey:@"m_updated_time"] retain];
		m_verified = [[aDecoder decodeObjectForKey:@"m_verified"] retain];
		m_about = [[aDecoder decodeObjectForKey:@"m_about"] retain];
		m_bio = [[aDecoder decodeObjectForKey:@"m_bio"] retain];
		m_birthday = [[aDecoder decodeObjectForKey:@"m_birthday"] retain];
		m_education = [[aDecoder decodeObjectForKey:@"m_education"] retain];
		m_hometown = [[aDecoder decodeObjectForKey:@"m_hometown"] retain];
		m_interested_in = [[aDecoder decodeObjectForKey:@"m_interested_in"] retain];
		m_location = [[aDecoder decodeObjectForKey:@"m_location"] retain];
		m_political = [[aDecoder decodeObjectForKey:@"m_political"] retain];
		m_quotes = [[aDecoder decodeObjectForKey:@"m_quotes"] retain];
		m_relationship_status = [[aDecoder decodeObjectForKey:@"m_relationship_status"] retain];
		m_religion = [[aDecoder decodeObjectForKey:@"m_religion"] retain];
		m_significant_other = [[aDecoder decodeObjectForKey:@"m_significant_other"] retain];
		m_website = [[aDecoder decodeObjectForKey:@"m_website"] retain];
		m_work = [[aDecoder decodeObjectForKey:@"m_work"] mutableCopy];
	}
	return self;
}

+ (GtObjectDescriber*) sharedObjectDescriber
{
	static GtObjectDescriber* s_describer = nil;
	if(!s_describer)
	{
		@synchronized(self) {
			if(!s_describer)
			{
				s_describer = [[super sharedObjectDescriber] copy];
				if(!s_describer)
				{
					s_describer = [[GtObjectDescriber alloc] init];
				}
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"first_name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"first_name"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"last_name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"last_name"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"gender" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"gender"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"locale" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"locale"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"link"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"username" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"username"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"third_party_id" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"third_party_id"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"timezone" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"timezone"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"updated_time"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"verified" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"verified"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"about" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"about"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"bio" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"bio"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"birthday" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"birthday"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"education" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"education"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"hometown" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"hometown"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"interested_in" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"interested_in"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"location" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"location"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"political" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"political"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"quotes" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"quotes"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"relationship_status" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"relationship_status"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"religion" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"religion"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"significant_other" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"significant_other"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"website" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"website"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"work" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"work_history" propertyClass:[GtFacebookWorkHistory class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"work"];
			}
		}
	}
	return s_describer;
}

+ (GtObjectInflator*) sharedObjectInflator
{
	static GtObjectInflator* s_inflator = nil;
	if(!s_inflator)
	{
		@synchronized(self) {
			if(!s_inflator)
			{
				s_inflator = [[GtObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
			}
		}
	}
	return s_inflator;
}

+ (GtSqliteTable*) sharedSqliteTable
{
	static GtSqliteTable* s_table = nil;
	if(!s_table)
	{
		@synchronized(self) {
			if(!s_table)
			{
				GtSqliteTable* superTable = [super sharedSqliteTable];
				if(superTable)
				{
					s_table = [superTable copy];
					s_table.tableName = [self sqliteTableName];
				}
				else
				{
					s_table = [[GtSqliteTable alloc] initWithTableName:[self sqliteTableName]];
				}
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"first_name" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"last_name" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"gender" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"locale" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"link" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"username" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"third_party_id" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"timezone" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"updated_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"verified" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"about" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"bio" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"birthday" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"education" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"hometown" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"interested_in" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"location" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"political" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"quotes" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"relationship_status" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"religion" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"significant_other" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"website" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"work" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookUser (ValueProperties) 

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

