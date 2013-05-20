//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlElementBaseType.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlElementBaseType.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtWsdlComplexType.h"
#import "GtWsdlElement.h"
#import "GtWsdlSimpleType.h"

@implementation GtWsdlElementBaseType


@synthesize complexTypes = m_complexTypes;

// Getter will create m_complexTypes if nil. Alternately, use the complexTypesObject property, which will not lazy create it.
- (NSMutableArray*) complexTypes
{
	if(!m_complexTypes)
	{
		m_complexTypes = [[NSMutableArray alloc] init];
	}
	return m_complexTypes;
}
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
@synthesize simpleTypes = m_simpleTypes;

// Getter will create m_simpleTypes if nil. Alternately, use the simpleTypesObject property, which will not lazy create it.
- (NSMutableArray*) simpleTypes
{
	if(!m_simpleTypes)
	{
		m_simpleTypes = [[NSMutableArray alloc] init];
	}
	return m_simpleTypes;
}

+ (NSString*) complexTypesKey
{
	return @"complexTypes";
}

+ (NSString*) elementsKey
{
	return @"elements";
}

+ (NSString*) simpleTypesKey
{
	return @"simpleTypes";
}

- (void) dealloc
{
	[m_elements release];
	[m_simpleTypes release];
	[m_complexTypes release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"elements" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"element" propertyClass:[GtWsdlElement class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"elements"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"simpleTypes" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"simpleType" propertyClass:[GtWsdlSimpleType class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"simpleTypes"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"complexTypes" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"complexType" propertyClass:[GtWsdlComplexType class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"complexTypes"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"elements" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"simpleTypes" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"complexTypes" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlElementBaseType*) wsdlElementBaseType
{
	return [[[GtWsdlElementBaseType alloc] init] autorelease];
}

@end

@implementation GtWsdlElementBaseType (ValueProperties) 
@end


@implementation GtWsdlElementBaseType (ObjectMembers) 

// This returns m_elements. It does NOT create it if it's NIL.
- (NSMutableArray*) elementsObject
{
	return m_elements;
}

// This returns m_simpleTypes. It does NOT create it if it's NIL.
- (NSMutableArray*) simpleTypesObject
{
	return m_simpleTypes;
}

// This returns m_complexTypes. It does NOT create it if it's NIL.
- (NSMutableArray*) complexTypesObject
{
	return m_complexTypes;
}

- (void) createElementsIfNil
{
	if(!m_elements)
	{
		m_elements = [[NSMutableArray alloc] init];
	}
}

- (void) createSimpleTypesIfNil
{
	if(!m_simpleTypes)
	{
		m_simpleTypes = [[NSMutableArray alloc] init];
	}
}

- (void) createComplexTypesIfNil
{
	if(!m_complexTypes)
	{
		m_complexTypes = [[NSMutableArray alloc] init];
	}
}
@end

