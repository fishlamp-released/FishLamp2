//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtTwitterStatusUpdate.m
//	Project: FishLamp
//	Schema: Twitter
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwitterStatusUpdate.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtTwitterStatusUpdate


@synthesize display_coordinates = m_display_coordinates;
@synthesize in_reply_to_status_id = m_in_reply_to_status_id;
@synthesize include_entities = m_include_entities;
@synthesize place_id = m_place_id;
@synthesize status = m_status;
@synthesize trim_user = m_trim_user;

+ (NSString*) display_coordinatesKey
{
	return @"display_coordinates";
}

+ (NSString*) in_reply_to_status_idKey
{
	return @"in_reply_to_status_id";
}

+ (NSString*) include_entitiesKey
{
	return @"include_entities";
}

+ (NSString*) place_idKey
{
	return @"place_id";
}

+ (NSString*) statusKey
{
	return @"status";
}

+ (NSString*) trim_userKey
{
	return @"trim_user";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtTwitterStatusUpdate*)object).status = GtCopyOrRetainObject(m_status);
	((GtTwitterStatusUpdate*)object).include_entities = GtCopyOrRetainObject(m_include_entities);
	((GtTwitterStatusUpdate*)object).in_reply_to_status_id = GtCopyOrRetainObject(m_in_reply_to_status_id);
	((GtTwitterStatusUpdate*)object).place_id = GtCopyOrRetainObject(m_place_id);
	((GtTwitterStatusUpdate*)object).display_coordinates = GtCopyOrRetainObject(m_display_coordinates);
	((GtTwitterStatusUpdate*)object).trim_user = GtCopyOrRetainObject(m_trim_user);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_status);
	GtRelease(m_in_reply_to_status_id);
	GtRelease(m_place_id);
	GtRelease(m_display_coordinates);
	GtRelease(m_trim_user);
	GtRelease(m_include_entities);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_status) [aCoder encodeObject:m_status forKey:@"m_status"];
	if(m_in_reply_to_status_id) [aCoder encodeObject:m_in_reply_to_status_id forKey:@"m_in_reply_to_status_id"];
	if(m_place_id) [aCoder encodeObject:m_place_id forKey:@"m_place_id"];
	if(m_display_coordinates) [aCoder encodeObject:m_display_coordinates forKey:@"m_display_coordinates"];
	if(m_trim_user) [aCoder encodeObject:m_trim_user forKey:@"m_trim_user"];
	if(m_include_entities) [aCoder encodeObject:m_include_entities forKey:@"m_include_entities"];
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
	if((self = [super init]))
	{
		m_status = [[aDecoder decodeObjectForKey:@"m_status"] retain];
		m_in_reply_to_status_id = [[aDecoder decodeObjectForKey:@"m_in_reply_to_status_id"] retain];
		m_place_id = [[aDecoder decodeObjectForKey:@"m_place_id"] retain];
		m_display_coordinates = [[aDecoder decodeObjectForKey:@"m_display_coordinates"] retain];
		m_trim_user = [[aDecoder decodeObjectForKey:@"m_trim_user"] retain];
		m_include_entities = [[aDecoder decodeObjectForKey:@"m_include_entities"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"status" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"status"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"in_reply_to_status_id" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"in_reply_to_status_id"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"place_id" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"place_id"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"display_coordinates" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"display_coordinates"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"trim_user" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"trim_user"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"include_entities" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"include_entities"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"status" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"in_reply_to_status_id" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"place_id" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"display_coordinates" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"trim_user" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"include_entities" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtTwitterStatusUpdate*) twitterStatusUpdate
{
	return GtReturnAutoreleased([[GtTwitterStatusUpdate alloc] init]);
}

@end

@implementation GtTwitterStatusUpdate (ValueProperties) 
@end

