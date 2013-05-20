//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookCheckin.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookCheckin.h"
#import "GtFacebookObject.h"
#import "GtFacebookDataList.h"
#import "GtFacebookPlace.h"
#import "GtFacebookNamedObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookCheckin


@synthesize application = m_application;
@synthesize created_time = m_created_time;
@synthesize from = m_from;
@synthesize message = m_message;
@synthesize place = m_place;
@synthesize tags = m_tags;

+ (NSString*) applicationKey
{
	return @"application";
}

+ (NSString*) created_timeKey
{
	return @"created_time";
}

+ (NSString*) fromKey
{
	return @"from";
}

+ (NSString*) messageKey
{
	return @"message";
}

+ (NSString*) placeKey
{
	return @"place";
}

+ (NSString*) tagsKey
{
	return @"tags";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookCheckin*)object).place = GtCopyOrRetainObject(m_place);
	((GtFacebookCheckin*)object).tags = GtCopyOrRetainObject(m_tags);
	((GtFacebookCheckin*)object).message = GtCopyOrRetainObject(m_message);
	((GtFacebookCheckin*)object).application = GtCopyOrRetainObject(m_application);
	((GtFacebookCheckin*)object).created_time = GtCopyOrRetainObject(m_created_time);
	((GtFacebookCheckin*)object).from = GtCopyOrRetainObject(m_from);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_from);
	GtRelease(m_tags);
	GtRelease(m_place);
	GtRelease(m_message);
	GtRelease(m_application);
	GtRelease(m_created_time);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_from) [aCoder encodeObject:m_from forKey:@"m_from"];
	if(m_tags) [aCoder encodeObject:m_tags forKey:@"m_tags"];
	if(m_place) [aCoder encodeObject:m_place forKey:@"m_place"];
	if(m_message) [aCoder encodeObject:m_message forKey:@"m_message"];
	if(m_application) [aCoder encodeObject:m_application forKey:@"m_application"];
	if(m_created_time) [aCoder encodeObject:m_created_time forKey:@"m_created_time"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookCheckin*) facebookCheckin
{
	return GtReturnAutoreleased([[GtFacebookCheckin alloc] init]);
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
		m_from = [[aDecoder decodeObjectForKey:@"m_from"] retain];
		m_tags = [[aDecoder decodeObjectForKey:@"m_tags"] retain];
		m_place = [[aDecoder decodeObjectForKey:@"m_place"] retain];
		m_message = [[aDecoder decodeObjectForKey:@"m_message"] retain];
		m_application = [[aDecoder decodeObjectForKey:@"m_application"] retain];
		m_created_time = [[aDecoder decodeObjectForKey:@"m_created_time"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"from" propertyClass:[GtFacebookObject class] propertyType:GtDataTypeObject] forPropertyName:@"from"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"tags" propertyClass:[GtFacebookDataList class] propertyType:GtDataTypeObject] forPropertyName:@"tags"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"place" propertyClass:[GtFacebookPlace class] propertyType:GtDataTypeObject] forPropertyName:@"place"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"message" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"message"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"application" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"application"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"created_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"created_time"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"from" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"tags" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"place" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"message" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"application" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"created_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookCheckin (ValueProperties) 
@end

