//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookLink.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookLink.h"
#import "GtFacebookObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookLink


@synthesize caption = m_caption;
@synthesize created_time = m_created_time;
@synthesize description = m_description;
@synthesize from = m_from;
@synthesize icon = m_icon;
@synthesize link = m_link;
@synthesize message = m_message;
@synthesize picture = m_picture;

+ (NSString*) captionKey
{
	return @"caption";
}

+ (NSString*) created_timeKey
{
	return @"created_time";
}

+ (NSString*) descriptionKey
{
	return @"description";
}

+ (NSString*) fromKey
{
	return @"from";
}

+ (NSString*) iconKey
{
	return @"icon";
}

+ (NSString*) linkKey
{
	return @"link";
}

+ (NSString*) messageKey
{
	return @"message";
}

+ (NSString*) pictureKey
{
	return @"picture";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookLink*)object).from = GtCopyOrRetainObject(m_from);
	((GtFacebookLink*)object).created_time = GtCopyOrRetainObject(m_created_time);
	((GtFacebookLink*)object).picture = GtCopyOrRetainObject(m_picture);
	((GtFacebookLink*)object).link = GtCopyOrRetainObject(m_link);
	((GtFacebookLink*)object).message = GtCopyOrRetainObject(m_message);
	((GtFacebookLink*)object).description = GtCopyOrRetainObject(m_description);
	((GtFacebookLink*)object).icon = GtCopyOrRetainObject(m_icon);
	((GtFacebookLink*)object).caption = GtCopyOrRetainObject(m_caption);
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
	GtRelease(m_link);
	GtRelease(m_caption);
	GtRelease(m_description);
	GtRelease(m_icon);
	GtRelease(m_picture);
	GtRelease(m_message);
	GtRelease(m_created_time);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_from) [aCoder encodeObject:m_from forKey:@"m_from"];
	if(m_link) [aCoder encodeObject:m_link forKey:@"m_link"];
	if(m_caption) [aCoder encodeObject:m_caption forKey:@"m_caption"];
	if(m_description) [aCoder encodeObject:m_description forKey:@"m_description"];
	if(m_icon) [aCoder encodeObject:m_icon forKey:@"m_icon"];
	if(m_picture) [aCoder encodeObject:m_picture forKey:@"m_picture"];
	if(m_message) [aCoder encodeObject:m_message forKey:@"m_message"];
	if(m_created_time) [aCoder encodeObject:m_created_time forKey:@"m_created_time"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookLink*) facebookLink
{
	return GtReturnAutoreleased([[GtFacebookLink alloc] init]);
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
		m_link = [[aDecoder decodeObjectForKey:@"m_link"] retain];
		m_caption = [[aDecoder decodeObjectForKey:@"m_caption"] retain];
		m_description = [[aDecoder decodeObjectForKey:@"m_description"] retain];
		m_icon = [[aDecoder decodeObjectForKey:@"m_icon"] retain];
		m_picture = [[aDecoder decodeObjectForKey:@"m_picture"] retain];
		m_message = [[aDecoder decodeObjectForKey:@"m_message"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"link"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"caption" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"caption"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"description"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"icon"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"picture" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"picture"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"message" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"message"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"link" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"caption" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"description" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"icon" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"picture" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"message" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"created_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookLink (ValueProperties) 
@end

