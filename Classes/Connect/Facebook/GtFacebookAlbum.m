//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookAlbum.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookAlbum.h"
#import "GtFacebookNamedObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookAlbum


@synthesize count = m_count;
@synthesize cover_photo = m_cover_photo;
@synthesize created_time = m_created_time;
@synthesize description = m_description;
@synthesize from = m_from;
@synthesize link = m_link;
@synthesize location = m_location;
@synthesize privacy = m_privacy;
@synthesize type = m_type;
@synthesize updated_time = m_updated_time;

+ (NSString*) countKey
{
	return @"count";
}

+ (NSString*) cover_photoKey
{
	return @"cover_photo";
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

+ (NSString*) linkKey
{
	return @"link";
}

+ (NSString*) locationKey
{
	return @"location";
}

+ (NSString*) privacyKey
{
	return @"privacy";
}

+ (NSString*) typeKey
{
	return @"type";
}

+ (NSString*) updated_timeKey
{
	return @"updated_time";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookAlbum*)object).location = GtCopyOrRetainObject(m_location);
	((GtFacebookAlbum*)object).cover_photo = GtCopyOrRetainObject(m_cover_photo);
	((GtFacebookAlbum*)object).from = GtCopyOrRetainObject(m_from);
	((GtFacebookAlbum*)object).privacy = GtCopyOrRetainObject(m_privacy);
	((GtFacebookAlbum*)object).count = GtCopyOrRetainObject(m_count);
	((GtFacebookAlbum*)object).updated_time = GtCopyOrRetainObject(m_updated_time);
	((GtFacebookAlbum*)object).link = GtCopyOrRetainObject(m_link);
	((GtFacebookAlbum*)object).description = GtCopyOrRetainObject(m_description);
	((GtFacebookAlbum*)object).type = GtCopyOrRetainObject(m_type);
	((GtFacebookAlbum*)object).created_time = GtCopyOrRetainObject(m_created_time);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_description);
	GtRelease(m_from);
	GtRelease(m_location);
	GtRelease(m_link);
	GtRelease(m_cover_photo);
	GtRelease(m_privacy);
	GtRelease(m_count);
	GtRelease(m_type);
	GtRelease(m_created_time);
	GtRelease(m_updated_time);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_description) [aCoder encodeObject:m_description forKey:@"m_description"];
	if(m_from) [aCoder encodeObject:m_from forKey:@"m_from"];
	if(m_location) [aCoder encodeObject:m_location forKey:@"m_location"];
	if(m_link) [aCoder encodeObject:m_link forKey:@"m_link"];
	if(m_cover_photo) [aCoder encodeObject:m_cover_photo forKey:@"m_cover_photo"];
	if(m_privacy) [aCoder encodeObject:m_privacy forKey:@"m_privacy"];
	if(m_count) [aCoder encodeObject:m_count forKey:@"m_count"];
	if(m_type) [aCoder encodeObject:m_type forKey:@"m_type"];
	if(m_created_time) [aCoder encodeObject:m_created_time forKey:@"m_created_time"];
	if(m_updated_time) [aCoder encodeObject:m_updated_time forKey:@"m_updated_time"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookAlbum*) facebookAlbum
{
	return GtReturnAutoreleased([[GtFacebookAlbum alloc] init]);
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
		m_description = [[aDecoder decodeObjectForKey:@"m_description"] retain];
		m_from = [[aDecoder decodeObjectForKey:@"m_from"] retain];
		m_location = [[aDecoder decodeObjectForKey:@"m_location"] retain];
		m_link = [[aDecoder decodeObjectForKey:@"m_link"] retain];
		m_cover_photo = [[aDecoder decodeObjectForKey:@"m_cover_photo"] retain];
		m_privacy = [[aDecoder decodeObjectForKey:@"m_privacy"] retain];
		m_count = [[aDecoder decodeObjectForKey:@"m_count"] retain];
		m_type = [[aDecoder decodeObjectForKey:@"m_type"] retain];
		m_created_time = [[aDecoder decodeObjectForKey:@"m_created_time"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"description"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"from" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"from"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"location" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"location"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"link"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"cover_photo" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"cover_photo"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"privacy" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"privacy"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"count" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"count"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"type"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"created_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"created_time"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"description" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"from" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"location" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"link" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"cover_photo" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"privacy" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"count" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"type" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"created_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"updated_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookAlbum (ValueProperties) 
@end

