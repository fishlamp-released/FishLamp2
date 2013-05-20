//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlRestrictionArray.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlRestrictionArray.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtWsdlElement.h"
#import "GtWsdlEnumeration.h"

@implementation GtWsdlRestrictionArray


@synthesize base = m_base;
@synthesize elements = m_elements;

// Getter will create m_elements if nil. Alternately, use the elementsObject property, which will not lazy create it.
- (NSMutableArray*) elements
{
	if(!m_elements)
	{
		m_elements = [[NSMutableArray alloc] init];
	}
	return m_elements;
}
@synthesize enumerations = m_enumerations;

// Getter will create m_enumerations if nil. Alternately, use the enumerationsObject property, which will not lazy create it.
- (NSMutableArray*) enumerations
{
	if(!m_enumerations)
	{
		m_enumerations = [[NSMutableArray alloc] init];
	}
	return m_enumerations;
}

+ (NSString*) baseKey
{
	return @"base";
}

+ (NSString*) elementsKey
{
	return @"elements";
}

+ (NSString*) enumerationsKey
{
	return @"enumerations";
}

- (void) dealloc
{
	[m_base release];
	[m_enumerations release];
	[m_elements release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"base" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"base"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"enumerations" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"enumeration" propertyClass:[GtWsdlEnumeration class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"enumerations"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"elements" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"element" propertyClass:[GtWsdlElement class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"elements"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"base" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"enumerations" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"elements" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlRestrictionArray*) wsdlRestrictionArray
{
	return [[[GtWsdlRestrictionArray alloc] init] autorelease];
}

@end

@implementation GtWsdlRestrictionArray (ValueProperties) 
@end


@implementation GtWsdlRestrictionArray (ObjectMembers) 

// This returns m_enumerations. It does NOT create it if it's NIL.
- (NSMutableArray*) enumerationsObject
{
	return m_enumerations;
}

// This returns m_elements. It does NOT create it if it's NIL.
- (NSMutableArray*) elementsObject
{
	return m_elements;
}

- (void) createEnumerationsIfNil
{
	if(!m_enumerations)
	{
		m_enumerations = [[NSMutableArray alloc] init];
	}
}

- (void) createElementsIfNil
{
	if(!m_elements)
	{
		m_elements = [[NSMutableArray alloc] init];
	}
}
@end

