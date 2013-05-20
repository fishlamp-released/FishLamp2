//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlSimpleType.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlSimpleType.h"
#import "GtWsdlRestrictionArray.h"
#import "GtWsdlList.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtWsdlSimpleType


@synthesize list = m_list;

// Getter will create m_list if nil. Alternately, use the listObject property, which will not lazy create it.
- (GtWsdlList*) list
{
	if(!m_list)
	{
		m_list = [[GtWsdlList alloc] init];
	}
	return m_list;
}
@synthesize name = m_name;
@synthesize restriction = m_restriction;

// Getter will create m_restriction if nil. Alternately, use the restrictionObject property, which will not lazy create it.
- (GtWsdlRestrictionArray*) restriction
{
	if(!m_restriction)
	{
		m_restriction = [[GtWsdlRestrictionArray alloc] init];
	}
	return m_restriction;
}

+ (NSString*) listKey
{
	return @"list";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) restrictionKey
{
	return @"restriction";
}

- (void) dealloc
{
	[m_name release];
	[m_restriction release];
	[m_list release];
	[super dealloc];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"name"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"restriction" propertyClass:[GtWsdlRestrictionArray class] propertyType:GtDataTypeObject] forPropertyName:@"restriction"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"list" propertyClass:[GtWsdlList class] propertyType:GtDataTypeObject] forPropertyName:@"list"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"name" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"restriction" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"list" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlSimpleType*) wsdlSimpleType
{
	return [[[GtWsdlSimpleType alloc] init] autorelease];
}

@end

@implementation GtWsdlSimpleType (ValueProperties) 
@end


@implementation GtWsdlSimpleType (ObjectMembers) 

// This returns m_restriction. It does NOT create it if it's NIL.
- (GtWsdlRestrictionArray*) restrictionObject
{
	return m_restriction;
}

// This returns m_list. It does NOT create it if it's NIL.
- (GtWsdlList*) listObject
{
	return m_list;
}

- (void) createRestrictionIfNil
{
	if(!m_restriction)
	{
		m_restriction = [[GtWsdlRestrictionArray alloc] init];
	}
}

- (void) createListIfNil
{
	if(!m_list)
	{
		m_list = [[GtWsdlList alloc] init];
	}
}
@end

