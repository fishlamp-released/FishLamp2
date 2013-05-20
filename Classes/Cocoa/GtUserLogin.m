//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtUserLogin.m
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserLogin.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtUserLogin


@synthesize authToken = m_authToken;
@synthesize authTokenLastUpdateTime = m_authTokenLastUpdateTime;
@synthesize email = m_email;
@synthesize isAuthenticated = m_isAuthenticated;
@synthesize password = m_password;
@synthesize userGuid = m_userGuid;
@synthesize userName = m_userName;
@synthesize userValue = m_userValue;

+ (NSString*) authTokenKey
{
	return @"authToken";
}

+ (NSString*) authTokenLastUpdateTimeKey
{
	return @"authTokenLastUpdateTime";
}

+ (NSString*) emailKey
{
	return @"email";
}

+ (NSString*) isAuthenticatedKey
{
	return @"isAuthenticated";
}

+ (NSString*) passwordKey
{
	return @"password";
}

+ (NSString*) userGuidKey
{
	return @"userGuid";
}

+ (NSString*) userNameKey
{
	return @"userName";
}

+ (NSString*) userValueKey
{
	return @"userValue";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtUserLogin*)object).password = GtCopyOrRetainObject(m_password);
	((GtUserLogin*)object).isAuthenticated = GtCopyOrRetainObject(m_isAuthenticated);
	((GtUserLogin*)object).authToken = GtCopyOrRetainObject(m_authToken);
	((GtUserLogin*)object).userName = GtCopyOrRetainObject(m_userName);
	((GtUserLogin*)object).authTokenLastUpdateTime = GtCopyOrRetainObject(m_authTokenLastUpdateTime);
	((GtUserLogin*)object).userGuid = GtCopyOrRetainObject(m_userGuid);
	((GtUserLogin*)object).email = GtCopyOrRetainObject(m_email);
	((GtUserLogin*)object).userValue = GtCopyOrRetainObject(m_userValue);
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
	GtRelease(m_userName);
	GtRelease(m_password);
	GtRelease(m_isAuthenticated);
	GtRelease(m_authToken);
	GtRelease(m_email);
	GtRelease(m_authTokenLastUpdateTime);
	GtRelease(m_userValue);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_userGuid) [aCoder encodeObject:m_userGuid forKey:@"m_userGuid"];
	if(m_userName) [aCoder encodeObject:m_userName forKey:@"m_userName"];
	if(m_password) [aCoder encodeObject:m_password forKey:@"m_password"];
	if(m_isAuthenticated) [aCoder encodeObject:m_isAuthenticated forKey:@"m_isAuthenticated"];
	if(m_authToken) [aCoder encodeObject:m_authToken forKey:@"m_authToken"];
	if(m_email) [aCoder encodeObject:m_email forKey:@"m_email"];
	if(m_authTokenLastUpdateTime) [aCoder encodeObject:m_authTokenLastUpdateTime forKey:@"m_authTokenLastUpdateTime"];
	if(m_userValue) [aCoder encodeObject:m_userValue forKey:@"m_userValue"];
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
		m_userName = [[aDecoder decodeObjectForKey:@"m_userName"] retain];
		m_password = [[aDecoder decodeObjectForKey:@"m_password"] retain];
		m_isAuthenticated = [[aDecoder decodeObjectForKey:@"m_isAuthenticated"] retain];
		m_authToken = [[aDecoder decodeObjectForKey:@"m_authToken"] retain];
		m_email = [[aDecoder decodeObjectForKey:@"m_email"] retain];
		m_authTokenLastUpdateTime = [[aDecoder decodeObjectForKey:@"m_authTokenLastUpdateTime"] retain];
		m_userValue = [[aDecoder decodeObjectForKey:@"m_userValue"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"userGuid" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"userGuid"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"userName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"userName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"password" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"password"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isAuthenticated" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isAuthenticated"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"authToken" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"authToken"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"email" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"email"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"authTokenLastUpdateTime" propertyClass:[NSNumber class] propertyType:GtDataTypeDouble] forPropertyName:@"authTokenLastUpdateTime"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"userValue" propertyClass:[NSNumber class] propertyType:GtDataTypeLong] forPropertyName:@"userValue"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"userName" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn uniqueConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"userName" indexProperties:GtSqliteColumnIndexPropertyUnique]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isAuthenticated" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"authToken" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"email" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn uniqueConstraint], nil]]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"email" indexProperties:GtSqliteColumnIndexPropertyUnique]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"authTokenLastUpdateTime" columnType:GtSqliteTypeFloat columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"userValue" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtUserLogin*) userLogin
{
	return GtReturnAutoreleased([[GtUserLogin alloc] init]);
}

@end

@implementation GtUserLogin (ValueProperties) 

- (BOOL) isAuthenticatedValue
{
	return [self.isAuthenticated boolValue];
}

- (void) setIsAuthenticatedValue:(BOOL) value
{
	self.isAuthenticated = [NSNumber numberWithBool:value];
}

- (double) authTokenLastUpdateTimeValue
{
	return [self.authTokenLastUpdateTime doubleValue];
}

- (void) setAuthTokenLastUpdateTimeValue:(double) value
{
	self.authTokenLastUpdateTime = [NSNumber numberWithDouble:value];
}

- (long) userValueValue
{
	return [self.userValue longValue];
}

- (void) setUserValueValue:(long) value
{
	self.userValue = [NSNumber numberWithLong:value];
}
@end

