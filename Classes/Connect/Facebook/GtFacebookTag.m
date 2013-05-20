//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookTag.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookTag.h"
#import "GtFacebookNamedObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookTag


@synthesize user = m_user;
@synthesize x = m_x;
@synthesize y = m_y;

+ (NSString*) userKey
{
	return @"user";
}

+ (NSString*) xKey
{
	return @"x";
}

+ (NSString*) yKey
{
	return @"y";
}

- (void) dealloc
{
	GtRelease(m_user);
	GtRelease(m_x);
	GtRelease(m_y);
	GtSuperDealloc();
}

+ (GtFacebookTag*) facebookTag
{
	return GtReturnAutoreleased([[GtFacebookTag alloc] init]);
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"user" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"user"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"x" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"x"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"y" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"y"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"user" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"x" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"y" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookTag (ValueProperties) 

- (int) xValue
{
	return [self.x intValue];
}

- (void) setXValue:(int) value
{
	self.x = [NSNumber numberWithInt:value];
}

- (int) yValue
{
	return [self.y intValue];
}

- (void) setYValue:(int) value
{
	self.y = [NSNumber numberWithInt:value];
}
@end

