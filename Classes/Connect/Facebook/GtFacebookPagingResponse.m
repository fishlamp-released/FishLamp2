//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPagingResponse.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookPagingResponse.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookPagingResponse


@synthesize next = m_next;
@synthesize previous = m_previous;

+ (NSString*) nextKey
{
	return @"next";
}

+ (NSString*) previousKey
{
	return @"previous";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookPagingResponse*)object).previous = GtCopyOrRetainObject(m_previous);
	((GtFacebookPagingResponse*)object).next = GtCopyOrRetainObject(m_next);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_previous);
	GtRelease(m_next);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_previous) [aCoder encodeObject:m_previous forKey:@"m_previous"];
	if(m_next) [aCoder encodeObject:m_next forKey:@"m_next"];
}

+ (GtFacebookPagingResponse*) facebookPagingResponse
{
	return GtReturnAutoreleased([[GtFacebookPagingResponse alloc] init]);
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
		m_previous = [[aDecoder decodeObjectForKey:@"m_previous"] retain];
		m_next = [[aDecoder decodeObjectForKey:@"m_next"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"previous" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"previous"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"next" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"next"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"previous" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"next" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookPagingResponse (ValueProperties) 
@end

