//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlElement.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlElement.h"
#import "GtWsdlComplexType.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtWsdlElement


@synthesize complexType = m_complexType;

// Getter will create m_complexType if nil. Alternately, use the complexTypeObject property, which will not lazy create it.
- (GtWsdlComplexType*) complexType
{
	if(!m_complexType)
	{
		m_complexType = [[GtWsdlComplexType alloc] init];
	}
	return m_complexType;
}
@synthesize maxOccurs = m_maxOccurs;
@synthesize minOccurs = m_minOccurs;
@synthesize name = m_name;
@synthesize nillable = m_nillable;
@synthesize ref = m_ref;
@synthesize type = m_type;

+ (NSString*) complexTypeKey
{
	return @"complexType";
}

+ (NSString*) maxOccursKey
{
	return @"maxOccurs";
}

+ (NSString*) minOccursKey
{
	return @"minOccurs";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) nillableKey
{
	return @"nillable";
}

+ (NSString*) refKey
{
	return @"ref";
}

+ (NSString*) typeKey
{
	return @"type";
}

- (void) dealloc
{
	[m_minOccurs release];
	[m_maxOccurs release];
	[m_name release];
	[m_type release];
	[m_ref release];
	[m_nillable release];
	[m_complexType release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"minOccurs" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"minOccurs"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"maxOccurs" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"maxOccurs"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"name"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"type"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"ref" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"ref"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"nillable" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"nillable"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"complexType" propertyClass:[GtWsdlComplexType class] propertyType:GtDataTypeObject] forPropertyName:@"complexType"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"minOccurs" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"maxOccurs" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"name" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"type" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"ref" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"nillable" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"complexType" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlElement*) wsdlElement
{
	return [[[GtWsdlElement alloc] init] autorelease];
}

@end

@implementation GtWsdlElement (ValueProperties) 

- (BOOL) nillableValue
{
	return [self.nillable boolValue];
}

- (void) setNillableValue:(BOOL) value
{
	self.nillable = [NSNumber numberWithBool:value];
}
@end


@implementation GtWsdlElement (ObjectMembers) 

// This returns m_complexType. It does NOT create it if it's NIL.
- (GtWsdlComplexType*) complexTypeObject
{
	return m_complexType;
}

- (void) createComplexTypeIfNil
{
	if(!m_complexType)
	{
		m_complexType = [[GtWsdlComplexType alloc] init];
	}
}
@end

