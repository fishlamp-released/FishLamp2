//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookEvent.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookEvent.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookEvent


@synthesize description = m_description;
@synthesize end_time = m_end_time;
@synthesize location = m_location;
@synthesize owner = m_owner;
@synthesize privacy = m_privacy;
@synthesize start_time = m_start_time;
@synthesize updated_time = m_updated_time;
@synthesize venue = m_venue;

+ (NSString*) descriptionKey
{
	return @"description";
}

+ (NSString*) end_timeKey
{
	return @"end_time";
}

+ (NSString*) locationKey
{
	return @"location";
}

+ (NSString*) ownerKey
{
	return @"owner";
}

+ (NSString*) privacyKey
{
	return @"privacy";
}

+ (NSString*) start_timeKey
{
	return @"start_time";
}

+ (NSString*) updated_timeKey
{
	return @"updated_time";
}

+ (NSString*) venueKey
{
	return @"venue";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookEvent*)object).location = GtCopyOrRetainObject(m_location);
	((GtFacebookEvent*)object).owner = GtCopyOrRetainObject(m_owner);
	((GtFacebookEvent*)object).venue = GtCopyOrRetainObject(m_venue);
	((GtFacebookEvent*)object).end_time = GtCopyOrRetainObject(m_end_time);
	((GtFacebookEvent*)object).privacy = GtCopyOrRetainObject(m_privacy);
	((GtFacebookEvent*)object).start_time = GtCopyOrRetainObject(m_start_time);
	((GtFacebookEvent*)object).updated_time = GtCopyOrRetainObject(m_updated_time);
	((GtFacebookEvent*)object).description = GtCopyOrRetainObject(m_description);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_owner);
	GtRelease(m_description);
	GtRelease(m_start_time);
	GtRelease(m_end_time);
	GtRelease(m_location);
	GtRelease(m_venue);
	GtRelease(m_privacy);
	GtRelease(m_updated_time);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_owner) [aCoder encodeObject:m_owner forKey:@"m_owner"];
	if(m_description) [aCoder encodeObject:m_description forKey:@"m_description"];
	if(m_start_time) [aCoder encodeObject:m_start_time forKey:@"m_start_time"];
	if(m_end_time) [aCoder encodeObject:m_end_time forKey:@"m_end_time"];
	if(m_location) [aCoder encodeObject:m_location forKey:@"m_location"];
	if(m_venue) [aCoder encodeObject:m_venue forKey:@"m_venue"];
	if(m_privacy) [aCoder encodeObject:m_privacy forKey:@"m_privacy"];
	if(m_updated_time) [aCoder encodeObject:m_updated_time forKey:@"m_updated_time"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookEvent*) facebookEvent
{
	return GtReturnAutoreleased([[GtFacebookEvent alloc] init]);
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
		m_owner = [[aDecoder decodeObjectForKey:@"m_owner"] retain];
		m_description = [[aDecoder decodeObjectForKey:@"m_description"] retain];
		m_start_time = [[aDecoder decodeObjectForKey:@"m_start_time"] retain];
		m_end_time = [[aDecoder decodeObjectForKey:@"m_end_time"] retain];
		m_location = [[aDecoder decodeObjectForKey:@"m_location"] retain];
		m_venue = [[aDecoder decodeObjectForKey:@"m_venue"] retain];
		m_privacy = [[aDecoder decodeObjectForKey:@"m_privacy"] retain];
		m_updated_time = [[aDecoder decodeObjectForKey:@"m_updated_time"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"owner" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"owner"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"description"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"start_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"start_time"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"end_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"end_time"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"location" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"location"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"venue" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"venue"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"privacy" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"privacy"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"updated_time"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"owner" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"description" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"start_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"end_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"location" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"venue" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"privacy" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"updated_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookEvent (ValueProperties) 
@end

