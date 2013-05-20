//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorObjectCategory.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorObjectCategory.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtCodeGeneratorMethod.h"
#import "GtCodeGeneratorProperty.h"

@implementation GtCodeGeneratorObjectCategory


@synthesize categoryName = m_categoryName;
@synthesize methods = m_methods;

// Getter will create m_methods if nil. Alternately, use the methodsObject property, which will not lazy create it.
- (NSMutableArray*) methods
{
	if(!m_methods)
	{
		m_methods = [[NSMutableArray alloc] init];
	}
	return m_methods;
}
@synthesize objectName = m_objectName;
@synthesize properties = m_properties;

// Getter will create m_properties if nil. Alternately, use the propertiesObject property, which will not lazy create it.
- (NSMutableArray*) properties
{
	if(!m_properties)
	{
		m_properties = [[NSMutableArray alloc] init];
	}
	return m_properties;
}

+ (NSString*) categoryNameKey
{
	return @"categoryName";
}

+ (NSString*) methodsKey
{
	return @"methods";
}

+ (NSString*) objectNameKey
{
	return @"objectName";
}

+ (NSString*) propertiesKey
{
	return @"properties";
}

+ (GtCodeGeneratorObjectCategory*) codeGeneratorObjectCategory
{
	return [[[GtCodeGeneratorObjectCategory alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorObjectCategory*)object).properties = GtCopyOrRetainObject(m_properties);
	((GtCodeGeneratorObjectCategory*)object).methods = GtCopyOrRetainObject(m_methods);
	((GtCodeGeneratorObjectCategory*)object).objectName = GtCopyOrRetainObject(m_objectName);
	((GtCodeGeneratorObjectCategory*)object).categoryName = GtCopyOrRetainObject(m_categoryName);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_objectName release];
	[m_categoryName release];
	[m_properties release];
	[m_methods release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"objectName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"objectName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"categoryName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"categoryName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"properties" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"property" propertyClass:[GtCodeGeneratorProperty class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"properties"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"methods" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"method" propertyClass:[GtCodeGeneratorMethod class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"methods"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"objectName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"categoryName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"properties" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"methods" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorObjectCategory (ValueProperties) 
@end


@implementation GtCodeGeneratorObjectCategory (ObjectMembers) 

// This returns m_properties. It does NOT create it if it's NIL.
- (NSMutableArray*) propertiesObject
{
	return m_properties;
}

// This returns m_methods. It does NOT create it if it's NIL.
- (NSMutableArray*) methodsObject
{
	return m_methods;
}

- (void) createPropertiesIfNil
{
	if(!m_properties)
	{
		m_properties = [[NSMutableArray alloc] init];
	}
}

- (void) createMethodsIfNil
{
	if(!m_methods)
	{
		m_methods = [[NSMutableArray alloc] init];
	}
}
@end

