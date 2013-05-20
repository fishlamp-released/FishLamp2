//	This file was generated at 11/26/11 5:25 PM by PackMule. DO NOT MODIFY!!
//
//	GtApplicationDataVersion.m
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtApplicationDataVersion.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtApplicationDataVersion


@synthesize userGuid = m_userGuid;
@synthesize versionString = m_versionString;

+ (NSString*) userGuidKey
{
	return @"userGuid";
}

+ (NSString*) versionStringKey
{
	return @"versionString";
}

+ (GtApplicationDataVersion*) applicationDataVersion
{
	return GtReturnAutoreleased([[GtApplicationDataVersion alloc] init]);
}

- (void) dealloc
{
	GtRelease(m_userGuid);
	GtRelease(m_versionString);
	GtSuperDealloc();
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"userGuid" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"userGuid"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"versionString" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"versionString"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"userGuid" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"versionString" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtApplicationDataVersion (ValueProperties) 
@end

