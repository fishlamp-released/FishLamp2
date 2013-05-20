//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookInsights.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookInsights.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtFacebookInsight.h"

@implementation GtFacebookInsights


@synthesize period = m_period;
@synthesize values = m_values;

+ (NSString*) periodKey
{
	return @"period";
}

+ (NSString*) valuesKey
{
	return @"values";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookInsights*)object).period = GtCopyOrRetainObject(m_period);
	((GtFacebookInsights*)object).values = GtCopyOrRetainObject(m_values);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_period);
	GtRelease(m_values);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_period) [aCoder encodeObject:m_period forKey:@"m_period"];
	if(m_values) [aCoder encodeObject:m_values forKey:@"m_values"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookInsights*) facebookInsights
{
	return GtReturnAutoreleased([[GtFacebookInsights alloc] init]);
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
	if((self = [super initWithCoder:aDecoder]))
	{
		m_period = [[aDecoder decodeObjectForKey:@"m_period"] retain];
		m_values = [[aDecoder decodeObjectForKey:@"m_values"] mutableCopy];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"period" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"period"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"values" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"insights" propertyClass:[GtFacebookInsight class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"values"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"period" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"values" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookInsights (ValueProperties) 
@end

