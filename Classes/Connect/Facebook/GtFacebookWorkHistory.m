//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookWorkHistory.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookWorkHistory.h"
#import "GtFacebookNamedObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookWorkHistory


@synthesize employer = m_employer;
@synthesize end_date = m_end_date;
@synthesize location = m_location;
@synthesize position = m_position;
@synthesize start_date = m_start_date;

+ (NSString*) employerKey
{
	return @"employer";
}

+ (NSString*) end_dateKey
{
	return @"end_date";
}

+ (NSString*) locationKey
{
	return @"location";
}

+ (NSString*) positionKey
{
	return @"position";
}

+ (NSString*) start_dateKey
{
	return @"start_date";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookWorkHistory*)object).employer = GtCopyOrRetainObject(m_employer);
	((GtFacebookWorkHistory*)object).start_date = GtCopyOrRetainObject(m_start_date);
	((GtFacebookWorkHistory*)object).end_date = GtCopyOrRetainObject(m_end_date);
	((GtFacebookWorkHistory*)object).position = GtCopyOrRetainObject(m_position);
	((GtFacebookWorkHistory*)object).location = GtCopyOrRetainObject(m_location);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_employer);
	GtRelease(m_location);
	GtRelease(m_position);
	GtRelease(m_start_date);
	GtRelease(m_end_date);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_employer) [aCoder encodeObject:m_employer forKey:@"m_employer"];
	if(m_location) [aCoder encodeObject:m_location forKey:@"m_location"];
	if(m_position) [aCoder encodeObject:m_position forKey:@"m_position"];
	if(m_start_date) [aCoder encodeObject:m_start_date forKey:@"m_start_date"];
	if(m_end_date) [aCoder encodeObject:m_end_date forKey:@"m_end_date"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookWorkHistory*) facebookWorkHistory
{
	return GtReturnAutoreleased([[GtFacebookWorkHistory alloc] init]);
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
		m_employer = [[aDecoder decodeObjectForKey:@"m_employer"] retain];
		m_location = [[aDecoder decodeObjectForKey:@"m_location"] retain];
		m_position = [[aDecoder decodeObjectForKey:@"m_position"] retain];
		m_start_date = [[aDecoder decodeObjectForKey:@"m_start_date"] retain];
		m_end_date = [[aDecoder decodeObjectForKey:@"m_end_date"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"employer" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"employer"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"location" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"location"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"position" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"position"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"start_date" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"start_date"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"end_date" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"end_date"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"employer" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"location" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"position" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"start_date" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"end_date" columnType:GtSqliteTypeDate columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookWorkHistory (ValueProperties) 
@end

