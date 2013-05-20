//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookAuthenticationResponse.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookAuthenticationResponse.h"
#import "GtFacebookNetworkSession.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookAuthenticationResponse


@synthesize redirectURL = m_redirectURL;
@synthesize session = m_session;

+ (NSString*) redirectURLKey
{
	return @"redirectURL";
}

+ (NSString*) sessionKey
{
	return @"session";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookAuthenticationResponse*)object).session = GtCopyOrRetainObject(m_session);
	((GtFacebookAuthenticationResponse*)object).redirectURL = GtCopyOrRetainObject(m_redirectURL);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_session);
	GtRelease(m_redirectURL);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_session) [aCoder encodeObject:m_session forKey:@"m_session"];
	if(m_redirectURL) [aCoder encodeObject:m_redirectURL forKey:@"m_redirectURL"];
}

+ (GtFacebookAuthenticationResponse*) facebookAuthenticationResponse
{
	return GtReturnAutoreleased([[GtFacebookAuthenticationResponse alloc] init]);
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
		m_session = [[aDecoder decodeObjectForKey:@"m_session"] retain];
		m_redirectURL = [[aDecoder decodeObjectForKey:@"m_redirectURL"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"session" propertyClass:[GtFacebookNetworkSession class] propertyType:GtDataTypeObject] forPropertyName:@"session"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"redirectURL" propertyClass:[NSURL class] propertyType:GtDataTypeObject] forPropertyName:@"redirectURL"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"session" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"redirectURL" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookAuthenticationResponse (ValueProperties) 
@end

