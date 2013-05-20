//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookNetworkSession.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookNetworkSession.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookNetworkSession


@synthesize access_token = m_access_token;
@synthesize appId = m_appId;
@synthesize expiration_date = m_expiration_date;
@synthesize permissions = m_permissions;
@synthesize userId = m_userId;

+ (NSString*) access_tokenKey
{
	return @"access_token";
}

+ (NSString*) appIdKey
{
	return @"appId";
}

+ (NSString*) expiration_dateKey
{
	return @"expiration_date";
}

+ (NSString*) permissionsKey
{
	return @"permissions";
}

+ (NSString*) userIdKey
{
	return @"userId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookNetworkSession*)object).appId = GtCopyOrRetainObject(m_appId);
	((GtFacebookNetworkSession*)object).expiration_date = GtCopyOrRetainObject(m_expiration_date);
	((GtFacebookNetworkSession*)object).permissions = GtCopyOrRetainObject(m_permissions);
	((GtFacebookNetworkSession*)object).userId = GtCopyOrRetainObject(m_userId);
	((GtFacebookNetworkSession*)object).access_token = GtCopyOrRetainObject(m_access_token);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_userId);
	GtRelease(m_appId);
	GtRelease(m_access_token);
	GtRelease(m_expiration_date);
	GtRelease(m_permissions);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_userId) [aCoder encodeObject:m_userId forKey:@"m_userId"];
	if(m_appId) [aCoder encodeObject:m_appId forKey:@"m_appId"];
	if(m_access_token) [aCoder encodeObject:m_access_token forKey:@"m_access_token"];
	if(m_expiration_date) [aCoder encodeObject:m_expiration_date forKey:@"m_expiration_date"];
	if(m_permissions) [aCoder encodeObject:m_permissions forKey:@"m_permissions"];
}

+ (GtFacebookNetworkSession*) facebookNetworkSession
{
	return GtReturnAutoreleased([[GtFacebookNetworkSession alloc] init]);
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
		m_userId = [[aDecoder decodeObjectForKey:@"m_userId"] retain];
		m_appId = [[aDecoder decodeObjectForKey:@"m_appId"] retain];
		m_access_token = [[aDecoder decodeObjectForKey:@"m_access_token"] retain];
		m_expiration_date = [[aDecoder decodeObjectForKey:@"m_expiration_date"] retain];
		m_permissions = [[aDecoder decodeObjectForKey:@"m_permissions"] mutableCopy];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"userId" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"userId"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"appId" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"appId"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"access_token" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"access_token"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"expiration_date" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"expiration_date"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"permissions" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"permission" propertyClass:[NSString class] propertyType:GtDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"permissions"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"userId" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"userId" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"appId" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"access_token" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"expiration_date" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"permissions" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookNetworkSession (ValueProperties) 
@end

