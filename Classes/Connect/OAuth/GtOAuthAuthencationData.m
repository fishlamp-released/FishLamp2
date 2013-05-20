//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtOAuthAuthencationData.m
//	Project: FishLamp
//	Schema: GtOauth
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOAuthAuthencationData.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtOAuthAuthencationData


@synthesize oauth_callback_confirmed = m_oauth_callback_confirmed;
@synthesize oauth_token = m_oauth_token;
@synthesize oauth_token_secret = m_oauth_token_secret;
@synthesize oauth_verifier = m_oauth_verifier;

+ (NSString*) oauth_callback_confirmedKey
{
	return @"oauth_callback_confirmed";
}

+ (NSString*) oauth_tokenKey
{
	return @"oauth_token";
}

+ (NSString*) oauth_token_secretKey
{
	return @"oauth_token_secret";
}

+ (NSString*) oauth_verifierKey
{
	return @"oauth_verifier";
}

- (void) dealloc
{
	GtRelease(m_oauth_token_secret);
	GtRelease(m_oauth_callback_confirmed);
	GtRelease(m_oauth_token);
	GtRelease(m_oauth_verifier);
	GtSuperDealloc();
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

+ (GtOAuthAuthencationData*) oAuthAuthencationData
{
	return GtReturnAutoreleased([[GtOAuthAuthencationData alloc] init]);
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"oauth_token_secret" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"oauth_token_secret"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"oauth_callback_confirmed" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"oauth_callback_confirmed"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"oauth_token" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"oauth_token"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"oauth_verifier" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"oauth_verifier"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"oauth_token_secret" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"oauth_callback_confirmed" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"oauth_token" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"oauth_verifier" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtOAuthAuthencationData (ValueProperties) 
@end

