//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookProperty.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookProperty.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookProperty


@synthesize href = m_href;
@synthesize name = m_name;
@synthesize text = m_text;

+ (NSString*) hrefKey
{
	return @"href";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) textKey
{
	return @"text";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookProperty*)object).name = GtCopyOrRetainObject(m_name);
	((GtFacebookProperty*)object).text = GtCopyOrRetainObject(m_text);
	((GtFacebookProperty*)object).href = GtCopyOrRetainObject(m_href);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_text);
	GtRelease(m_name);
	GtRelease(m_href);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_text) [aCoder encodeObject:m_text forKey:@"m_text"];
	if(m_name) [aCoder encodeObject:m_name forKey:@"m_name"];
	if(m_href) [aCoder encodeObject:m_href forKey:@"m_href"];
}

+ (GtFacebookProperty*) facebookProperty
{
	return GtReturnAutoreleased([[GtFacebookProperty alloc] init]);
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
		m_text = [[aDecoder decodeObjectForKey:@"m_text"] retain];
		m_name = [[aDecoder decodeObjectForKey:@"m_name"] retain];
		m_href = [[aDecoder decodeObjectForKey:@"m_href"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"text" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"text"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"name"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"href" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"href"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"text" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"name" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"href" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookProperty (ValueProperties) 
@end

