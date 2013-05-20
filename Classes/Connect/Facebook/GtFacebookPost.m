//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPost.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookPost.h"
#import "GtFacebookNamedObject.h"
#import "GtFacebookNamedObjectList.h"
#import "GtFacebookPrivacy.h"
#import "GtFacebookCommentList.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtFacebookAction.h"
#import "GtFacebookProperty.h"

@implementation GtFacebookPost


@synthesize actions = m_actions;
@synthesize application = m_application;
@synthesize caption = m_caption;
@synthesize comments = m_comments;
@synthesize created_time = m_created_time;
@synthesize description = m_description;
@synthesize from = m_from;
@synthesize icon = m_icon;
@synthesize likes = m_likes;
@synthesize link = m_link;
@synthesize message = m_message;
@synthesize object_id = m_object_id;
@synthesize picture = m_picture;
@synthesize privacy = m_privacy;
@synthesize properties = m_properties;
@synthesize source = m_source;
@synthesize to = m_to;
@synthesize type = m_type;
@synthesize updated_time = m_updated_time;

+ (NSString*) actionsKey
{
	return @"actions";
}

+ (NSString*) applicationKey
{
	return @"application";
}

+ (NSString*) captionKey
{
	return @"caption";
}

+ (NSString*) commentsKey
{
	return @"comments";
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

+ (NSString*) likesKey
{
	return @"likes";
}

+ (NSString*) linkKey
{
	return @"link";
}

+ (NSString*) messageKey
{
	return @"message";
}

+ (NSString*) object_idKey
{
	return @"object_id";
}

+ (NSString*) pictureKey
{
	return @"picture";
}

+ (NSString*) privacyKey
{
	return @"privacy";
}

+ (NSString*) propertiesKey
{
	return @"properties";
}

+ (NSString*) sourceKey
{
	return @"source";
}

+ (NSString*) toKey
{
	return @"to";
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
	((GtFacebookPost*)object).description = GtCopyOrRetainObject(m_description);
	((GtFacebookPost*)object).comments = GtCopyOrRetainObject(m_comments);
	((GtFacebookPost*)object).caption = GtCopyOrRetainObject(m_caption);
	((GtFacebookPost*)object).message = GtCopyOrRetainObject(m_message);
	((GtFacebookPost*)object).actions = GtCopyOrRetainObject(m_actions);
	((GtFacebookPost*)object).created_time = GtCopyOrRetainObject(m_created_time);
	((GtFacebookPost*)object).picture = GtCopyOrRetainObject(m_picture);
	((GtFacebookPost*)object).from = GtCopyOrRetainObject(m_from);
	((GtFacebookPost*)object).link = GtCopyOrRetainObject(m_link);
	((GtFacebookPost*)object).source = GtCopyOrRetainObject(m_source);
	((GtFacebookPost*)object).application = GtCopyOrRetainObject(m_application);
	((GtFacebookPost*)object).likes = GtCopyOrRetainObject(m_likes);
	((GtFacebookPost*)object).type = GtCopyOrRetainObject(m_type);
	((GtFacebookPost*)object).icon = GtCopyOrRetainObject(m_icon);
	((GtFacebookPost*)object).updated_time = GtCopyOrRetainObject(m_updated_time);
	((GtFacebookPost*)object).properties = GtCopyOrRetainObject(m_properties);
	((GtFacebookPost*)object).object_id = GtCopyOrRetainObject(m_object_id);
	((GtFacebookPost*)object).privacy = GtCopyOrRetainObject(m_privacy);
	((GtFacebookPost*)object).to = GtCopyOrRetainObject(m_to);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_object_id);
	GtRelease(m_from);
	GtRelease(m_to);
	GtRelease(m_message);
	GtRelease(m_picture);
	GtRelease(m_link);
	GtRelease(m_caption);
	GtRelease(m_description);
	GtRelease(m_source);
	GtRelease(m_icon);
	GtRelease(m_properties);
	GtRelease(m_application);
	GtRelease(m_privacy);
	GtRelease(m_comments);
	GtRelease(m_likes);
	GtRelease(m_actions);
	GtRelease(m_type);
	GtRelease(m_updated_time);
	GtRelease(m_created_time);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_object_id) [aCoder encodeObject:m_object_id forKey:@"m_object_id"];
	if(m_from) [aCoder encodeObject:m_from forKey:@"m_from"];
	if(m_to) [aCoder encodeObject:m_to forKey:@"m_to"];
	if(m_message) [aCoder encodeObject:m_message forKey:@"m_message"];
	if(m_picture) [aCoder encodeObject:m_picture forKey:@"m_picture"];
	if(m_link) [aCoder encodeObject:m_link forKey:@"m_link"];
	if(m_caption) [aCoder encodeObject:m_caption forKey:@"m_caption"];
	if(m_description) [aCoder encodeObject:m_description forKey:@"m_description"];
	if(m_source) [aCoder encodeObject:m_source forKey:@"m_source"];
	if(m_icon) [aCoder encodeObject:m_icon forKey:@"m_icon"];
	if(m_properties) [aCoder encodeObject:m_properties forKey:@"m_properties"];
	if(m_application) [aCoder encodeObject:m_application forKey:@"m_application"];
	if(m_privacy) [aCoder encodeObject:m_privacy forKey:@"m_privacy"];
	if(m_comments) [aCoder encodeObject:m_comments forKey:@"m_comments"];
	if(m_likes) [aCoder encodeObject:m_likes forKey:@"m_likes"];
	if(m_actions) [aCoder encodeObject:m_actions forKey:@"m_actions"];
	if(m_type) [aCoder encodeObject:m_type forKey:@"m_type"];
	if(m_updated_time) [aCoder encodeObject:m_updated_time forKey:@"m_updated_time"];
	if(m_created_time) [aCoder encodeObject:m_created_time forKey:@"m_created_time"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookPost*) facebookPost
{
	return GtReturnAutoreleased([[GtFacebookPost alloc] init]);
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
		m_object_id = [[aDecoder decodeObjectForKey:@"m_object_id"] retain];
		m_from = [[aDecoder decodeObjectForKey:@"m_from"] retain];
		m_to = [[aDecoder decodeObjectForKey:@"m_to"] retain];
		m_message = [[aDecoder decodeObjectForKey:@"m_message"] retain];
		m_picture = [[aDecoder decodeObjectForKey:@"m_picture"] retain];
		m_link = [[aDecoder decodeObjectForKey:@"m_link"] retain];
		m_caption = [[aDecoder decodeObjectForKey:@"m_caption"] retain];
		m_description = [[aDecoder decodeObjectForKey:@"m_description"] retain];
		m_source = [[aDecoder decodeObjectForKey:@"m_source"] retain];
		m_icon = [[aDecoder decodeObjectForKey:@"m_icon"] retain];
		m_properties = [[aDecoder decodeObjectForKey:@"m_properties"] mutableCopy];
		m_application = [[aDecoder decodeObjectForKey:@"m_application"] retain];
		m_privacy = [[aDecoder decodeObjectForKey:@"m_privacy"] retain];
		m_comments = [[aDecoder decodeObjectForKey:@"m_comments"] retain];
		m_likes = [[aDecoder decodeObjectForKey:@"m_likes"] retain];
		m_actions = [[aDecoder decodeObjectForKey:@"m_actions"] mutableCopy];
		m_type = [[aDecoder decodeObjectForKey:@"m_type"] retain];
		m_updated_time = [[aDecoder decodeObjectForKey:@"m_updated_time"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"object_id" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"object_id"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"from" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"from"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"to" propertyClass:[GtFacebookNamedObjectList class] propertyType:GtDataTypeObject] forPropertyName:@"to"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"message" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"message"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"picture" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"picture"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"link"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"caption" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"caption"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"description"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"source" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"source"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"icon"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"properties" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"property" propertyClass:[GtFacebookProperty class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"properties"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"application" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"application"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"privacy" propertyClass:[GtFacebookPrivacy class] propertyType:GtDataTypeObject] forPropertyName:@"privacy"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"comments" propertyClass:[GtFacebookCommentList class] propertyType:GtDataTypeObject] forPropertyName:@"comments"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"likes" propertyClass:[GtFacebookNamedObjectList class] propertyType:GtDataTypeObject] forPropertyName:@"likes"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"actions" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"action" propertyClass:[GtFacebookAction class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"actions"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"type"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"updated_time"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"object_id" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"from" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"to" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"message" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"picture" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"link" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"caption" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"description" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"source" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"icon" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"properties" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"application" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"privacy" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"comments" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"likes" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"actions" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"type" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"type" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"updated_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"updated_time" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"created_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"created_time" indexProperties:GtSqliteColumnIndexPropertyNone]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookPost (ValueProperties) 
@end

