//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlBinding.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlBinding.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtWsdlBinding.h"
#import "GtWsdlOperation.h"

@implementation GtWsdlBinding


@synthesize bindings = m_bindings;

// Getter will create m_bindings if nil. Alternately, use the bindingsObject property, which will not lazy create it.
- (NSMutableArray*) bindings
{
	if(!m_bindings)
	{
		m_bindings = [[NSMutableArray alloc] init];
	}
	return m_bindings;
}
@synthesize name = m_name;
@synthesize operations = m_operations;

// Getter will create m_operations if nil. Alternately, use the operationsObject property, which will not lazy create it.
- (NSMutableArray*) operations
{
	if(!m_operations)
	{
		m_operations = [[NSMutableArray alloc] init];
	}
	return m_operations;
}
@synthesize transport = m_transport;
@synthesize type = m_type;
@synthesize verb = m_verb;

+ (NSString*) bindingsKey
{
	return @"bindings";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) operationsKey
{
	return @"operations";
}

+ (NSString*) transportKey
{
	return @"transport";
}

+ (NSString*) typeKey
{
	return @"type";
}

+ (NSString*) verbKey
{
	return @"verb";
}

- (void) dealloc
{
	[m_name release];
	[m_transport release];
	[m_verb release];
	[m_type release];
	[m_bindings release];
	[m_operations release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"transport" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"transport"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"verb" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"verb"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"type"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"bindings" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"binding" propertyClass:[GtWsdlBinding class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"bindings"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"operations" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"operation" propertyClass:[GtWsdlOperation class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"operations"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"transport" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"verb" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"type" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"bindings" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"operations" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlBinding*) wsdlBinding
{
	return [[[GtWsdlBinding alloc] init] autorelease];
}

@end

@implementation GtWsdlBinding (ValueProperties) 
@end


@implementation GtWsdlBinding (ObjectMembers) 

// This returns m_bindings. It does NOT create it if it's NIL.
- (NSMutableArray*) bindingsObject
{
	return m_bindings;
}

// This returns m_operations. It does NOT create it if it's NIL.
- (NSMutableArray*) operationsObject
{
	return m_operations;
}

- (void) createBindingsIfNil
{
	if(!m_bindings)
	{
		m_bindings = [[NSMutableArray alloc] init];
	}
}

- (void) createOperationsIfNil
{
	if(!m_operations)
	{
		m_operations = [[NSMutableArray alloc] init];
	}
}
@end

