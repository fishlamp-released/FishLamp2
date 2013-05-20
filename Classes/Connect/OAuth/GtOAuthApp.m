//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtOAuthApp.m
//	Project: FishLamp
//	Schema: GtOauth
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOAuthApp.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtOAuthApp


@synthesize accessTokenUrl = m_accessTokenUrl;
@synthesize apiKey = m_apiKey;
@synthesize appId = m_appId;
@synthesize authorizeUrl = m_authorizeUrl;
@synthesize callback = m_callback;
@synthesize consumerKey = m_consumerKey;
@synthesize consumerSecret = m_consumerSecret;
@synthesize requestTokenUrl = m_requestTokenUrl;

+ (NSString*) accessTokenUrlKey
{
	return @"accessTokenUrl";
}

+ (NSString*) apiKeyKey
{
	return @"apiKey";
}

+ (NSString*) appIdKey
{
	return @"appId";
}

+ (NSString*) authorizeUrlKey
{
	return @"authorizeUrl";
}

+ (NSString*) callbackKey
{
	return @"callback";
}

+ (NSString*) consumerKeyKey
{
	return @"consumerKey";
}

+ (NSString*) consumerSecretKey
{
	return @"consumerSecret";
}

+ (NSString*) requestTokenUrlKey
{
	return @"requestTokenUrl";
}

- (void) dealloc
{
	GtRelease(m_appId);
	GtRelease(m_apiKey);
	GtRelease(m_consumerKey);
	GtRelease(m_consumerSecret);
	GtRelease(m_requestTokenUrl);
	GtRelease(m_accessTokenUrl);
	GtRelease(m_authorizeUrl);
	GtRelease(m_callback);
	GtSuperDealloc();
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

+ (GtOAuthApp*) oAuthApp
{
	return GtReturnAutoreleased([[GtOAuthApp alloc] init]);
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"appId" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"appId"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"apiKey" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"apiKey"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"consumerKey" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"consumerKey"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"consumerSecret" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"consumerSecret"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"requestTokenUrl" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"requestTokenUrl"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"accessTokenUrl" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"accessTokenUrl"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"authorizeUrl" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"authorizeUrl"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"callback" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"callback"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"appId" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"apiKey" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"consumerKey" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"consumerSecret" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"requestTokenUrl" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"accessTokenUrl" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"authorizeUrl" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"callback" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtOAuthApp (ValueProperties) 
@end

