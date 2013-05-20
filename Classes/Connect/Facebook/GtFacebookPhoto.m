//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPhoto.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookPhoto.h"
#import "GtFacebookNamedObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtFacebookTag.h"

@implementation GtFacebookPhoto


@synthesize created_time = m_created_time;
@synthesize from = m_from;
@synthesize height = m_height;
@synthesize icon = m_icon;
@synthesize link = m_link;
@synthesize source = m_source;
@synthesize tags = m_tags;
@synthesize updated_time = m_updated_time;
@synthesize width = m_width;

+ (NSString*) created_timeKey
{
	return @"created_time";
}

+ (NSString*) fromKey
{
	return @"from";
}

+ (NSString*) heightKey
{
	return @"height";
}

+ (NSString*) iconKey
{
	return @"icon";
}

+ (NSString*) linkKey
{
	return @"link";
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

+ (NSString*) widthKey
{
	return @"width";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookPhoto*)object).from = GtCopyOrRetainObject(m_from);
	((GtFacebookPhoto*)object).source = GtCopyOrRetainObject(m_source);
	((GtFacebookPhoto*)object).height = GtCopyOrRetainObject(m_height);
	((GtFacebookPhoto*)object).tags = GtCopyOrRetainObject(m_tags);
	((GtFacebookPhoto*)object).updated_time = GtCopyOrRetainObject(m_updated_time);
	((GtFacebookPhoto*)object).width = GtCopyOrRetainObject(m_width);
	((GtFacebookPhoto*)object).link = GtCopyOrRetainObject(m_link);
	((GtFacebookPhoto*)object).icon = GtCopyOrRetainObject(m_icon);
	((GtFacebookPhoto*)object).created_time = GtCopyOrRetainObject(m_created_time);
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
	GtRelease(m_link);
	GtRelease(m_icon);
	GtRelease(m_source);
	GtRelease(m_height);
	GtRelease(m_width);
	GtRelease(m_tags);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_from) [aCoder encodeObject:m_from forKey:@"m_from"];
	if(m_updated_time) [aCoder encodeObject:m_updated_time forKey:@"m_updated_time"];
	if(m_created_time) [aCoder encodeObject:m_created_time forKey:@"m_created_time"];
	if(m_link) [aCoder encodeObject:m_link forKey:@"m_link"];
	if(m_icon) [aCoder encodeObject:m_icon forKey:@"m_icon"];
	if(m_source) [aCoder encodeObject:m_source forKey:@"m_source"];
	if(m_height) [aCoder encodeObject:m_height forKey:@"m_height"];
	if(m_width) [aCoder encodeObject:m_width forKey:@"m_width"];
	if(m_tags) [aCoder encodeObject:m_tags forKey:@"m_tags"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookPhoto*) facebookPhoto
{
	return GtReturnAutoreleased([[GtFacebookPhoto alloc] init]);
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
		m_link = [[aDecoder decodeObjectForKey:@"m_link"] retain];
		m_icon = [[aDecoder decodeObjectForKey:@"m_icon"] retain];
		m_source = [[aDecoder decodeObjectForKey:@"m_source"] retain];
		m_height = [[aDecoder decodeObjectForKey:@"m_height"] retain];
		m_width = [[aDecoder decodeObjectForKey:@"m_width"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"link"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"icon"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"source" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"source"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"height" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"height"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"width" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"width"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"link" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"icon" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"source" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"height" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"width" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"tags" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookPhoto (ValueProperties) 

- (int) heightValue
{
	return [self.height intValue];
}

- (void) setHeightValue:(int) value
{
	self.height = [NSNumber numberWithInt:value];
}

- (int) widthValue
{
	return [self.width intValue];
}

- (void) setWidthValue:(int) value
{
	self.width = [NSNumber numberWithInt:value];
}
@end

