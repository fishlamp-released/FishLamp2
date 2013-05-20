//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookInsight.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookInsight.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookInsight


@synthesize end_time = m_end_time;
@synthesize value = m_value;

+ (NSString*) end_timeKey
{
	return @"end_time";
}

+ (NSString*) valueKey
{
	return @"value";
}

- (void) dealloc
{
	GtRelease(m_value);
	GtRelease(m_end_time);
	GtSuperDealloc();
}

+ (GtFacebookInsight*) facebookInsight
{
	return GtReturnAutoreleased([[GtFacebookInsight alloc] init]);
}

- (id) init
{
	if((self = [super init]))
	{
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"value" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"value"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"end_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"end_time"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"value" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"end_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookInsight (ValueProperties) 

- (int) valueValue
{
	return [self.value intValue];
}

- (void) setValueValue:(int) value
{
	self.value = [NSNumber numberWithInt:value];
}
@end

