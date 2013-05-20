//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlSchema.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlSchema.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtWsdlImport.h"

@implementation GtWsdlSchema


@synthesize elementFormDefault = m_elementFormDefault;
@synthesize imports = m_imports;

// Getter will create m_imports if nil. Alternately, use the importsObject property, which will not lazy create it.
- (NSMutableArray*) imports
{
	if(!m_imports)
	{
		m_imports = [[NSMutableArray alloc] init];
	}
	return m_imports;
}
@synthesize targetNamespace = m_targetNamespace;

+ (NSString*) elementFormDefaultKey
{
	return @"elementFormDefault";
}

+ (NSString*) importsKey
{
	return @"imports";
}

+ (NSString*) targetNamespaceKey
{
	return @"targetNamespace";
}

- (void) dealloc
{
	[m_elementFormDefault release];
	[m_targetNamespace release];
	[m_imports release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"elementFormDefault" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"elementFormDefault"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"targetNamespace" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"targetNamespace"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"imports" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"import" propertyClass:[GtWsdlImport class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"imports"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"elementFormDefault" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"targetNamespace" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"imports" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlSchema*) wsdlSchema
{
	return [[[GtWsdlSchema alloc] init] autorelease];
}

@end

@implementation GtWsdlSchema (ValueProperties) 
@end


@implementation GtWsdlSchema (ObjectMembers) 

// This returns m_imports. It does NOT create it if it's NIL.
- (NSMutableArray*) importsObject
{
	return m_imports;
}

- (void) createImportsIfNil
{
	if(!m_imports)
	{
		m_imports = [[NSMutableArray alloc] init];
	}
}
@end

