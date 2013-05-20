//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlComplexType.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlComplexType.h"
#import "GtWsdlChoiceArray.h"
#import "GtWsdlComplexContent.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtWsdlComplexType


@synthesize choice = m_choice;

// Getter will create m_choice if nil. Alternately, use the choiceObject property, which will not lazy create it.
- (GtWsdlChoiceArray*) choice
{
	if(!m_choice)
	{
		m_choice = [[GtWsdlChoiceArray alloc] init];
	}
	return m_choice;
}
@synthesize complexContent = m_complexContent;

// Getter will create m_complexContent if nil. Alternately, use the complexContentObject property, which will not lazy create it.
- (GtWsdlComplexContent*) complexContent
{
	if(!m_complexContent)
	{
		m_complexContent = [[GtWsdlComplexContent alloc] init];
	}
	return m_complexContent;
}
@synthesize name = m_name;

+ (NSString*) choiceKey
{
	return @"choice";
}

+ (NSString*) complexContentKey
{
	return @"complexContent";
}

+ (NSString*) nameKey
{
	return @"name";
}

- (void) dealloc
{
	[m_name release];
	[m_choice release];
	[m_complexContent release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"choice" propertyClass:[GtWsdlChoiceArray class] propertyType:GtDataTypeObject] forPropertyName:@"choice"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"complexContent" propertyClass:[GtWsdlComplexContent class] propertyType:GtDataTypeObject] forPropertyName:@"complexContent"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"choice" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"complexContent" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlComplexType*) wsdlComplexType
{
	return [[[GtWsdlComplexType alloc] init] autorelease];
}

@end

@implementation GtWsdlComplexType (ValueProperties) 
@end


@implementation GtWsdlComplexType (ObjectMembers) 

// This returns m_choice. It does NOT create it if it's NIL.
- (GtWsdlChoiceArray*) choiceObject
{
	return m_choice;
}

// This returns m_complexContent. It does NOT create it if it's NIL.
- (GtWsdlComplexContent*) complexContentObject
{
	return m_complexContent;
}

- (void) createChoiceIfNil
{
	if(!m_choice)
	{
		m_choice = [[GtWsdlChoiceArray alloc] init];
	}
}

- (void) createComplexContentIfNil
{
	if(!m_complexContent)
	{
		m_complexContent = [[GtWsdlComplexContent alloc] init];
	}
}
@end

