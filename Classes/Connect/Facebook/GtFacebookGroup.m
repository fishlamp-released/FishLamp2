//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookGroup.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookGroup.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookGroup


@synthesize description = m_description;
@synthesize icon = m_icon;
@synthesize link = m_link;
@synthesize owner = m_owner;
@synthesize privacy = m_privacy;
@synthesize updated_time = m_updated_time;

+ (NSString*) descriptionKey
{
	return @"description";
}

+ (NSString*) iconKey
{
	return @"icon";
}

+ (NSString*) linkKey
{
	return @"link";
}

+ (NSString*) ownerKey
{
	return @"owner";
}

+ (NSString*) privacyKey
{
	return @"privacy";
}

+ (NSString*) updated_timeKey
{
	return @"updated_time";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookGroup*)object).updated_time = GtCopyOrRetainObject(m_updated_time);
	((GtFacebookGroup*)object).owner = GtCopyOrRetainObject(m_owner);
	((GtFacebookGroup*)object).icon = GtCopyOrRetainObject(m_icon);
	((GtFacebookGroup*)object).description = GtCopyOrRetainObject(m_description);
	((GtFacebookGroup*)object).privacy = GtCopyOrRetainObject(m_privacy);
	((GtFacebookGroup*)object).link = GtCopyOrRetainObject(m_link);
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
	GtRelease(m_icon);
	GtRelease(m_description);
	GtRelease(m_link);
	GtRelease(m_privacy);
	GtRelease(m_updated_time);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_owner) [aCoder encodeObject:m_owner forKey:@"m_owner"];
	if(m_icon) [aCoder encodeObject:m_icon forKey:@"m_icon"];
	if(m_description) [aCoder encodeObject:m_description forKey:@"m_description"];
	if(m_link) [aCoder encodeObject:m_link forKey:@"m_link"];
	if(m_privacy) [aCoder encodeObject:m_privacy forKey:@"m_privacy"];
	if(m_updated_time) [aCoder encodeObject:m_updated_time forKey:@"m_updated_time"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookGroup*) facebookGroup
{
	return GtReturnAutoreleased([[GtFacebookGroup alloc] init]);
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
		m_icon = [[aDecoder decodeObjectForKey:@"m_icon"] retain];
		m_description = [[aDecoder decodeObjectForKey:@"m_description"] retain];
		m_link = [[aDecoder decodeObjectForKey:@"m_link"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"icon"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"description"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"link"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"icon" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"description" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"link" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"privacy" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"updated_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookGroup (ValueProperties) 
@end

