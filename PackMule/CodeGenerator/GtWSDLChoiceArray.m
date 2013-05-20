//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlChoiceArray.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlChoiceArray.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtWsdlElement.h"

@implementation GtWsdlChoiceArray


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
@synthesize maxOccurs = m_maxOccurs;
@synthesize minOccurs = m_minOccurs;

+ (NSString*) elementsKey
{
	return @"elements";
}

+ (NSString*) maxOccursKey
{
	return @"maxOccurs";
}

+ (NSString*) minOccursKey
{
	return @"minOccurs";
}

- (void) dealloc
{
	[m_minOccurs release];
	[m_maxOccurs release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"minOccurs" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"minOccurs"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"maxOccurs" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"maxOccurs"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"elements" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"element" propertyClass:[GtWsdlElement class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"elements"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"elements" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlChoiceArray*) wsdlChoiceArray
{
	return [[[GtWsdlChoiceArray alloc] init] autorelease];
}

@end

@implementation GtWsdlChoiceArray (ValueProperties) 
@end


@implementation GtWsdlChoiceArray (ObjectMembers) 

// This returns m_elements. It does NOT create it if it's NIL.
- (NSMutableArray*) elementsObject
{
	return m_elements;
}

- (void) createElementsIfNil
{
	if(!m_elements)
	{
		m_elements = [[NSMutableArray alloc] init];
	}
}
@end

