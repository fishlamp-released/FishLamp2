//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookCommentList.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookCommentList.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtFacebookComment.h"

@implementation GtFacebookCommentList


@synthesize count = m_count;
@synthesize data = m_data;

+ (NSString*) countKey
{
	return @"count";
}

+ (NSString*) dataKey
{
	return @"data";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookCommentList*)object).count = GtCopyOrRetainObject(m_count);
	((GtFacebookCommentList*)object).data = GtCopyOrRetainObject(m_data);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_count);
	GtRelease(m_data);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_count) [aCoder encodeObject:m_count forKey:@"m_count"];
	if(m_data) [aCoder encodeObject:m_data forKey:@"m_data"];
}

+ (GtFacebookCommentList*) facebookCommentList
{
	return GtReturnAutoreleased([[GtFacebookCommentList alloc] init]);
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
		m_count = [[aDecoder decodeObjectForKey:@"m_count"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"count" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"count"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"data" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"comment" propertyClass:[GtFacebookComment class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"data"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"count" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"data" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookCommentList (ValueProperties) 

- (int) countValue
{
	return [self.count intValue];
}

- (void) setCountValue:(int) value
{
	self.count = [NSNumber numberWithInt:value];
}
@end
