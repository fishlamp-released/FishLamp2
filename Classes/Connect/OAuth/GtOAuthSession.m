//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtOAuthSession.m
//	Project: FishLamp
//	Schema: GtOauth
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOAuthSession.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtOAuthSession


@synthesize appName = m_appName;
@synthesize oauth_token = m_oauth_token;
@synthesize oauth_token_secret = m_oauth_token_secret;
@synthesize screen_name = m_screen_name;
@synthesize userGuid = m_userGuid;
@synthesize user_id = m_user_id;

+ (NSString*) appNameKey
{
	return @"appName";
}

+ (NSString*) oauth_tokenKey
{
	return @"oauth_token";
}

+ (NSString*) oauth_token_secretKey
{
	return @"oauth_token_secret";
}

+ (NSString*) screen_nameKey
{
	return @"screen_name";
}

+ (NSString*) userGuidKey
{
	return @"userGuid";
}

+ (NSString*) user_idKey
{
	return @"user_id";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtOAuthSession*)object).userGuid = GtCopyOrRetainObject(m_userGuid);
	((GtOAuthSession*)object).appName = GtCopyOrRetainObject(m_appName);
	((GtOAuthSession*)object).oauth_token_secret = GtCopyOrRetainObject(m_oauth_token_secret);
	((GtOAuthSession*)object).user_id = GtCopyOrRetainObject(m_user_id);
	((GtOAuthSession*)object).screen_name = GtCopyOrRetainObject(m_screen_name);
	((GtOAuthSession*)object).oauth_token = GtCopyOrRetainObject(m_oauth_token);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_userGuid);
	GtRelease(m_appName);
	GtRelease(m_oauth_token);
	GtRelease(m_oauth_token_secret);
	GtRelease(m_user_id);
	GtRelease(m_screen_name);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_userGuid) [aCoder encodeObject:m_userGuid forKey:@"m_userGuid"];
	if(m_appName) [aCoder encodeObject:m_appName forKey:@"m_appName"];
	if(m_oauth_token) [aCoder encodeObject:m_oauth_token forKey:@"m_oauth_token"];
	if(m_oauth_token_secret) [aCoder encodeObject:m_oauth_token_secret forKey:@"m_oauth_token_secret"];
	if(m_user_id) [aCoder encodeObject:m_user_id forKey:@"m_user_id"];
	if(m_screen_name) [aCoder encodeObject:m_screen_name forKey:@"m_screen_name"];
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
		m_userGuid = [[aDecoder decodeObjectForKey:@"m_userGuid"] retain];
		m_appName = [[aDecoder decodeObjectForKey:@"m_appName"] retain];
		m_oauth_token = [[aDecoder decodeObjectForKey:@"m_oauth_token"] retain];
		m_oauth_token_secret = [[aDecoder decodeObjectForKey:@"m_oauth_token_secret"] retain];
		m_user_id = [[aDecoder decodeObjectForKey:@"m_user_id"] retain];
		m_screen_name = [[aDecoder decodeObjectForKey:@"m_screen_name"] retain];
	}
	return self;
}

+ (GtOAuthSession*) oAuthSession
{
	return GtReturnAutoreleased([[GtOAuthSession alloc] init]);
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"userGuid" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"userGuid"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"appName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"appName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"oauth_token" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"oauth_token"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"oauth_token_secret" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"oauth_token_secret"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"user_id" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"user_id"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"screen_name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"screen_name"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"userGuid" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"appName" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"appName" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"oauth_token" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"oauth_token_secret" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"user_id" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"user_id" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"screen_name" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtOAuthSession (ValueProperties) 
@end

