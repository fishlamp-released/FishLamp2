//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlPortType.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlPortType.h"
#import "GtWsdlServiceAddress.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtWsdlOperation.h"

@implementation GtWsdlPortType


@synthesize address = m_address;

// Getter will create m_address if nil. Alternately, use the addressObject property, which will not lazy create it.
- (GtWsdlServiceAddress*) address
{
	if(!m_address)
	{
		m_address = [[GtWsdlServiceAddress alloc] init];
	}
	return m_address;
}
@synthesize binding = m_binding;
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

+ (NSString*) addressKey
{
	return @"address";
}

+ (NSString*) bindingKey
{
	return @"binding";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) operationsKey
{
	return @"operations";
}

- (void) dealloc
{
	[m_name release];
	[m_binding release];
	[m_address release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"binding" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"binding"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"address" propertyClass:[GtWsdlServiceAddress class] propertyType:GtDataTypeObject] forPropertyName:@"address"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"binding" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"address" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"operations" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlPortType*) wsdlPortType
{
	return [[[GtWsdlPortType alloc] init] autorelease];
}

@end

@implementation GtWsdlPortType (ValueProperties) 
@end


@implementation GtWsdlPortType (ObjectMembers) 

// This returns m_address. It does NOT create it if it's NIL.
- (GtWsdlServiceAddress*) addressObject
{
	return m_address;
}

// This returns m_operations. It does NOT create it if it's NIL.
- (NSMutableArray*) operationsObject
{
	return m_operations;
}

- (void) createAddressIfNil
{
	if(!m_address)
	{
		m_address = [[GtWsdlServiceAddress alloc] init];
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

