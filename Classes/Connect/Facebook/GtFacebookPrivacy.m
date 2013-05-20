//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPrivacy.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookPrivacy.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookPrivacy


@synthesize deny = m_deny;
@synthesize description = m_description;
@synthesize friends = m_friends;
@synthesize networks = m_networks;
@synthesize value = m_value;

+ (NSString*) denyKey
{
	return @"deny";
}

+ (NSString*) descriptionKey
{
	return @"description";
}

+ (NSString*) friendsKey
{
	return @"friends";
}

+ (NSString*) networksKey
{
	return @"networks";
}

+ (NSString*) valueKey
{
	return @"value";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookPrivacy*)object).value = GtCopyOrRetainObject(m_value);
	((GtFacebookPrivacy*)object).friends = GtCopyOrRetainObject(m_friends);
	((GtFacebookPrivacy*)object).networks = GtCopyOrRetainObject(m_networks);
	((GtFacebookPrivacy*)object).deny = GtCopyOrRetainObject(m_deny);
	((GtFacebookPrivacy*)object).description = GtCopyOrRetainObject(m_description);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_value);
	GtRelease(m_friends);
	GtRelease(m_networks);
	GtRelease(m_deny);
	GtRelease(m_description);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_value) [aCoder encodeObject:m_value forKey:@"m_value"];
	if(m_friends) [aCoder encodeObject:m_friends forKey:@"m_friends"];
	if(m_networks) [aCoder encodeObject:m_networks forKey:@"m_networks"];
	if(m_deny) [aCoder encodeObject:m_deny forKey:@"m_deny"];
	if(m_description) [aCoder encodeObject:m_description forKey:@"m_description"];
}

+ (GtFacebookPrivacy*) facebookPrivacy
{
	return GtReturnAutoreleased([[GtFacebookPrivacy alloc] init]);
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
		m_value = [[aDecoder decodeObjectForKey:@"m_value"] retain];
		m_friends = [[aDecoder decodeObjectForKey:@"m_friends"] retain];
		m_networks = [[aDecoder decodeObjectForKey:@"m_networks"] retain];
		m_deny = [[aDecoder decodeObjectForKey:@"m_deny"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"value" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"value"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"friends" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"friends"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"networks" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"networks"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"deny" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"deny"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"value" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"friends" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"networks" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"deny" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"description" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookPrivacy (ValueProperties) 
@end

