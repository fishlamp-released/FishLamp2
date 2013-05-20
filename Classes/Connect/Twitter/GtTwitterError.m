//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtTwitterError.m
//	Project: FishLamp
//	Schema: Twitter
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwitterError.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtTwitterError


@synthesize error = m_error;
@synthesize request = m_request;

+ (NSString*) errorKey
{
	return @"error";
}

+ (NSString*) requestKey
{
	return @"request";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtTwitterError*)object).error = GtCopyOrRetainObject(m_error);
	((GtTwitterError*)object).request = GtCopyOrRetainObject(m_request);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_error);
	GtRelease(m_request);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_error) [aCoder encodeObject:m_error forKey:@"m_error"];
	if(m_request) [aCoder encodeObject:m_request forKey:@"m_request"];
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
		m_error = [[aDecoder decodeObjectForKey:@"m_error"] retain];
		m_request = [[aDecoder decodeObjectForKey:@"m_request"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"error" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"error"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"request" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"request"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"error" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"request" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtTwitterError*) twitterError
{
	return GtReturnAutoreleased([[GtTwitterError alloc] init]);
}

@end

@implementation GtTwitterError (ValueProperties) 
@end

