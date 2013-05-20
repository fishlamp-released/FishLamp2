//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlOperation.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlOperation.h"
#import "GtWsdlInputOutput.h"
#import "GtWsdlOperation.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtWsdlOperation


@synthesize documentation = m_documentation;
@synthesize input = m_input;

// Getter will create m_input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (GtWsdlInputOutput*) input
{
	if(!m_input)
	{
		m_input = [[GtWsdlInputOutput alloc] init];
	}
	return m_input;
}
@synthesize location = m_location;
@synthesize name = m_name;
@synthesize operation = m_operation;

// Getter will create m_operation if nil. Alternately, use the operationObject property, which will not lazy create it.
- (GtWsdlOperation*) operation
{
	if(!m_operation)
	{
		m_operation = [[GtWsdlOperation alloc] init];
	}
	return m_operation;
}
@synthesize output = m_output;

// Getter will create m_output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (GtWsdlInputOutput*) output
{
	if(!m_output)
	{
		m_output = [[GtWsdlInputOutput alloc] init];
	}
	return m_output;
}
@synthesize soapAction = m_soapAction;
@synthesize style = m_style;

+ (NSString*) documentationKey
{
	return @"documentation";
}

+ (NSString*) inputKey
{
	return @"input";
}

+ (NSString*) locationKey
{
	return @"location";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) operationKey
{
	return @"operation";
}

+ (NSString*) outputKey
{
	return @"output";
}

+ (NSString*) soapActionKey
{
	return @"soapAction";
}

+ (NSString*) styleKey
{
	return @"style";
}

- (void) dealloc
{
	[m_name release];
	[m_location release];
	[m_soapAction release];
	[m_style release];
	[m_documentation release];
	[m_input release];
	[m_output release];
	[m_operation release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"location" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"location"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"soapAction" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"soapAction"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"style" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"style"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"documentation" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"documentation"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"input" propertyClass:[GtWsdlInputOutput class] propertyType:GtDataTypeObject] forPropertyName:@"input"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"output" propertyClass:[GtWsdlInputOutput class] propertyType:GtDataTypeObject] forPropertyName:@"output"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"operation" propertyClass:[GtWsdlOperation class] propertyType:GtDataTypeObject] forPropertyName:@"operation"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"location" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"soapAction" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"style" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"documentation" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"input" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"output" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"operation" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlOperation*) wsdlOperation
{
	return [[[GtWsdlOperation alloc] init] autorelease];
}

@end

@implementation GtWsdlOperation (ValueProperties) 
@end


@implementation GtWsdlOperation (ObjectMembers) 

// This returns m_input. It does NOT create it if it's NIL.
- (GtWsdlInputOutput*) inputObject
{
	return m_input;
}

// This returns m_output. It does NOT create it if it's NIL.
- (GtWsdlInputOutput*) outputObject
{
	return m_output;
}

// This returns m_operation. It does NOT create it if it's NIL.
- (GtWsdlOperation*) operationObject
{
	return m_operation;
}

- (void) createInputIfNil
{
	if(!m_input)
	{
		m_input = [[GtWsdlInputOutput alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!m_output)
	{
		m_output = [[GtWsdlInputOutput alloc] init];
	}
}

- (void) createOperationIfNil
{
	if(!m_operation)
	{
		m_operation = [[GtWsdlOperation alloc] init];
	}
}
@end

