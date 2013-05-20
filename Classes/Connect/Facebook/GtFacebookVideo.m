//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookVideo.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookVideo.h"
#import "GtFacebookNamedObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtFacebookTag.h"

@implementation GtFacebookVideo


@synthesize created_time = m_created_time;
@synthesize embed_html = m_embed_html;
@synthesize from = m_from;
@synthesize icon = m_icon;
@synthesize source = m_source;
@synthesize tags = m_tags;
@synthesize updated_time = m_updated_time;

+ (NSString*) created_timeKey
{
	return @"created_time";
}

+ (NSString*) embed_htmlKey
{
	return @"embed_html";
}

+ (NSString*) fromKey
{
	return @"from";
}

+ (NSString*) iconKey
{
	return @"icon";
}

+ (NSString*) sourceKey
{
	return @"source";
}

+ (NSString*) tagsKey
{
	return @"tags";
}

+ (NSString*) updated_timeKey
{
	return @"updated_time";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookVideo*)object).from = GtCopyOrRetainObject(m_from);
	((GtFacebookVideo*)object).source = GtCopyOrRetainObject(m_source);
	((GtFacebookVideo*)object).tags = GtCopyOrRetainObject(m_tags);
	((GtFacebookVideo*)object).updated_time = GtCopyOrRetainObject(m_updated_time);
	((GtFacebookVideo*)object).embed_html = GtCopyOrRetainObject(m_embed_html);
	((GtFacebookVideo*)object).icon = GtCopyOrRetainObject(m_icon);
	((GtFacebookVideo*)object).created_time = GtCopyOrRetainObject(m_created_time);
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
	GtRelease(m_updated_time);
	GtRelease(m_created_time);
	GtRelease(m_embed_html);
	GtRelease(m_icon);
	GtRelease(m_source);
	GtRelease(m_tags);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_from) [aCoder encodeObject:m_from forKey:@"m_from"];
	if(m_updated_time) [aCoder encodeObject:m_updated_time forKey:@"m_updated_time"];
	if(m_created_time) [aCoder encodeObject:m_created_time forKey:@"m_created_time"];
	if(m_embed_html) [aCoder encodeObject:m_embed_html forKey:@"m_embed_html"];
	if(m_icon) [aCoder encodeObject:m_icon forKey:@"m_icon"];
	if(m_source) [aCoder encodeObject:m_source forKey:@"m_source"];
	if(m_tags) [aCoder encodeObject:m_tags forKey:@"m_tags"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookVideo*) facebookVideo
{
	return GtReturnAutoreleased([[GtFacebookVideo alloc] init]);
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
		m_updated_time = [[aDecoder decodeObjectForKey:@"m_updated_time"] retain];
		m_created_time = [[aDecoder decodeObjectForKey:@"m_created_time"] retain];
		m_embed_html = [[aDecoder decodeObjectForKey:@"m_embed_html"] retain];
		m_icon = [[aDecoder decodeObjectForKey:@"m_icon"] retain];
		m_source = [[aDecoder decodeObjectForKey:@"m_source"] retain];
		m_tags = [[aDecoder decodeObjectForKey:@"m_tags"] mutableCopy];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"from" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"from"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"updated_time"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"created_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"created_time"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"embed_html" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"embed_html"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"icon"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"source" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"source"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"tags" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"tag" propertyClass:[GtFacebookTag class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"tags"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"updated_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"created_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"embed_html" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"icon" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"source" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"tags" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookVideo (ValueProperties) 
@end

