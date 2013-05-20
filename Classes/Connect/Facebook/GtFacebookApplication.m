//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookApplication.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookApplication.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookApplication


@synthesize category = m_category;
@synthesize description = m_description;
@synthesize link = m_link;

+ (NSString*) categoryKey
{
	return @"category";
}

+ (NSString*) descriptionKey
{
	return @"description";
}

+ (NSString*) linkKey
{
	return @"link";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookApplication*)object).link = GtCopyOrRetainObject(m_link);
	((GtFacebookApplication*)object).category = GtCopyOrRetainObject(m_category);
	((GtFacebookApplication*)object).description = GtCopyOrRetainObject(m_description);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_category);
	GtRelease(m_link);
	GtRelease(m_description);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_category) [aCoder encodeObject:m_category forKey:@"m_category"];
	if(m_link) [aCoder encodeObject:m_link forKey:@"m_link"];
	if(m_description) [aCoder encodeObject:m_description forKey:@"m_description"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookApplication*) facebookApplication
{
	return GtReturnAutoreleased([[GtFacebookApplication alloc] init]);
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
		m_category = [[aDecoder decodeObjectForKey:@"m_category"] retain];
		m_link = [[aDecoder decodeObjectForKey:@"m_link"] retain];
		m_description = [[aDecoder decodeObjectForKey:@"m_description"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"category" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"category"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"link"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"description"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"category" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"link" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"description" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookApplication (ValueProperties) 
@end

