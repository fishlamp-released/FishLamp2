//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlDefinitions.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlDefinitions.h"
#import "GtWsdlService.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtWsdlBinding.h"
#import "GtWsdlMessage.h"
#import "GtWsdlPortType.h"
#import "GtWsdlSchema.h"

@implementation GtWsdlDefinitions


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
@synthesize documentation = m_documentation;
@synthesize messages = m_messages;

// Getter will create m_messages if nil. Alternately, use the messagesObject property, which will not lazy create it.
- (NSMutableArray*) messages
{
	if(!m_messages)
	{
		m_messages = [[NSMutableArray alloc] init];
	}
	return m_messages;
}
@synthesize portTypes = m_portTypes;

// Getter will create m_portTypes if nil. Alternately, use the portTypesObject property, which will not lazy create it.
- (NSMutableArray*) portTypes
{
	if(!m_portTypes)
	{
		m_portTypes = [[NSMutableArray alloc] init];
	}
	return m_portTypes;
}
@synthesize service = m_service;

// Getter will create m_service if nil. Alternately, use the serviceObject property, which will not lazy create it.
- (GtWsdlService*) service
{
	if(!m_service)
	{
		m_service = [[GtWsdlService alloc] init];
	}
	return m_service;
}
@synthesize targetNamespace = m_targetNamespace;
@synthesize types = m_types;

// Getter will create m_types if nil. Alternately, use the typesObject property, which will not lazy create it.
- (NSMutableArray*) types
{
	if(!m_types)
	{
		m_types = [[NSMutableArray alloc] init];
	}
	return m_types;
}

+ (NSString*) bindingsKey
{
	return @"bindings";
}

+ (NSString*) documentationKey
{
	return @"documentation";
}

+ (NSString*) messagesKey
{
	return @"messages";
}

+ (NSString*) portTypesKey
{
	return @"portTypes";
}

+ (NSString*) serviceKey
{
	return @"service";
}

+ (NSString*) targetNamespaceKey
{
	return @"targetNamespace";
}

+ (NSString*) typesKey
{
	return @"types";
}

- (void) dealloc
{
	[m_types release];
	[m_messages release];
	[m_portTypes release];
	[m_bindings release];
	[m_service release];
	[m_targetNamespace release];
	[m_documentation release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"types" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"schema" propertyClass:[GtWsdlSchema class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"types"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"messages" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"message" propertyClass:[GtWsdlMessage class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"messages"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"portTypes" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"portType" propertyClass:[GtWsdlPortType class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"portTypes"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"bindings" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"binding" propertyClass:[GtWsdlBinding class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"bindings"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"service" propertyClass:[GtWsdlService class] propertyType:GtDataTypeObject] forPropertyName:@"service"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"targetNamespace" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"targetNamespace"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"documentation" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"documentation"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"types" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"messages" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"portTypes" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"bindings" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"service" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"targetNamespace" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"documentation" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlDefinitions*) wsdlDefinitions
{
	return [[[GtWsdlDefinitions alloc] init] autorelease];
}

@end

@implementation GtWsdlDefinitions (ValueProperties) 
@end


@implementation GtWsdlDefinitions (ObjectMembers) 

// This returns m_types. It does NOT create it if it's NIL.
- (NSMutableArray*) typesObject
{
	return m_types;
}

// This returns m_messages. It does NOT create it if it's NIL.
- (NSMutableArray*) messagesObject
{
	return m_messages;
}

// This returns m_portTypes. It does NOT create it if it's NIL.
- (NSMutableArray*) portTypesObject
{
	return m_portTypes;
}

// This returns m_bindings. It does NOT create it if it's NIL.
- (NSMutableArray*) bindingsObject
{
	return m_bindings;
}

// This returns m_service. It does NOT create it if it's NIL.
- (GtWsdlService*) serviceObject
{
	return m_service;
}

- (void) createTypesIfNil
{
	if(!m_types)
	{
		m_types = [[NSMutableArray alloc] init];
	}
}

- (void) createMessagesIfNil
{
	if(!m_messages)
	{
		m_messages = [[NSMutableArray alloc] init];
	}
}

- (void) createPortTypesIfNil
{
	if(!m_portTypes)
	{
		m_portTypes = [[NSMutableArray alloc] init];
	}
}

- (void) createBindingsIfNil
{
	if(!m_bindings)
	{
		m_bindings = [[NSMutableArray alloc] init];
	}
}

- (void) createServiceIfNil
{
	if(!m_service)
	{
		m_service = [[GtWsdlService alloc] init];
	}
}
@end

