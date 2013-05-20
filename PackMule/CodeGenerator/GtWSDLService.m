//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlService.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlService.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtWsdlPortType.h"

@implementation GtWsdlService


@synthesize documentation = m_documentation;
@synthesize name = m_name;
@synthesize ports = m_ports;

// Getter will create m_ports if nil. Alternately, use the portsObject property, which will not lazy create it.
- (NSMutableArray*) ports
{
	if(!m_ports)
	{
		m_ports = [[NSMutableArray alloc] init];
	}
	return m_ports;
}

+ (NSString*) documentationKey
{
	return @"documentation";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) portsKey
{
	return @"ports";
}

- (void) dealloc
{
	[m_name release];
	[m_documentation release];
	[m_ports release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"documentation" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"documentation"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"ports" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"port" propertyClass:[GtWsdlPortType class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"ports"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"documentation" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"ports" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlService*) wsdlService
{
	return [[[GtWsdlService alloc] init] autorelease];
}

@end

@implementation GtWsdlService (ValueProperties) 
@end


@implementation GtWsdlService (ObjectMembers) 

// This returns m_ports. It does NOT create it if it's NIL.
- (NSMutableArray*) portsObject
{
	return m_ports;
}

- (void) createPortsIfNil
{
	if(!m_ports)
	{
		m_ports = [[NSMutableArray alloc] init];
	}
}
@end

