//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookFetchStatusListResponse.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookFetchStatusListResponse.h"
#import "GtFacebookPagingResponse.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtFacebookPost.h"

@implementation GtFacebookFetchStatusListResponse


@synthesize data = m_data;
@synthesize paging = m_paging;

+ (NSString*) dataKey
{
	return @"data";
}

+ (NSString*) pagingKey
{
	return @"paging";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookFetchStatusListResponse*)object).data = GtCopyOrRetainObject(m_data);
	((GtFacebookFetchStatusListResponse*)object).paging = GtCopyOrRetainObject(m_paging);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_paging);
	GtRelease(m_data);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_paging) [aCoder encodeObject:m_paging forKey:@"m_paging"];
	if(m_data) [aCoder encodeObject:m_data forKey:@"m_data"];
}

+ (GtFacebookFetchStatusListResponse*) facebookFetchStatusListResponse
{
	return GtReturnAutoreleased([[GtFacebookFetchStatusListResponse alloc] init]);
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
		m_paging = [[aDecoder decodeObjectForKey:@"m_paging"] retain];
		m_data = [[aDecoder decodeObjectForKey:@"m_data"] mutableCopy];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"paging" propertyClass:[GtFacebookPagingResponse class] propertyType:GtDataTypeObject] forPropertyName:@"paging"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"data" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"post" propertyClass:[GtFacebookPost class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"data"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"paging" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"data" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookFetchStatusListResponse (ValueProperties) 
@end

