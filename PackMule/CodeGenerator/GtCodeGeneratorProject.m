//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorProject.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorProject.h"
#import "GtCodeGeneratorOptions.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtCodeGeneratorArray.h"
#import "GtCodeGeneratorDefine.h"
#import "GtCodeGeneratorTypeDefinition.h"
#import "GtCodeGeneratorEnumType.h"
#import "GtCodeGeneratorProject.h"
#import "GtCodeGeneratorObject.h"

@implementation GtCodeGeneratorProject


@synthesize arrays = m_arrays;

// Getter will create m_arrays if nil. Alternately, use the arraysObject property, which will not lazy create it.
- (NSMutableArray*) arrays
{
	if(!m_arrays)
	{
		m_arrays = [[NSMutableArray alloc] init];
	}
	return m_arrays;
}
@synthesize canLazyCreate = m_canLazyCreate;
@synthesize comment = m_comment;
@synthesize companyName = m_companyName;
@synthesize defines = m_defines;

// Getter will create m_defines if nil. Alternately, use the definesObject property, which will not lazy create it.
- (NSMutableArray*) defines
{
	if(!m_defines)
	{
		m_defines = [[NSMutableArray alloc] init];
	}
	return m_defines;
}
@synthesize dependencies = m_dependencies;

// Getter will create m_dependencies if nil. Alternately, use the dependenciesObject property, which will not lazy create it.
- (NSMutableArray*) dependencies
{
	if(!m_dependencies)
	{
		m_dependencies = [[NSMutableArray alloc] init];
	}
	return m_dependencies;
}
@synthesize disabled = m_disabled;
@synthesize enumTypes = m_enumTypes;

// Getter will create m_enumTypes if nil. Alternately, use the enumTypesObject property, which will not lazy create it.
- (NSMutableArray*) enumTypes
{
	if(!m_enumTypes)
	{
		m_enumTypes = [[NSMutableArray alloc] init];
	}
	return m_enumTypes;
}
@synthesize fileUrl = m_fileUrl;
@synthesize generatorOptions = m_generatorOptions;

// Getter will create m_generatorOptions if nil. Alternately, use the generatorOptionsObject property, which will not lazy create it.
- (GtCodeGeneratorOptions*) generatorOptions
{
	if(!m_generatorOptions)
	{
		m_generatorOptions = [[GtCodeGeneratorOptions alloc] init];
	}
	return m_generatorOptions;
}
@synthesize ifDef = m_ifDef;
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
@synthesize isWildcardArray = m_isWildcardArray;
@synthesize objects = m_objects;

// Getter will create m_objects if nil. Alternately, use the objectsObject property, which will not lazy create it.
- (NSMutableArray*) objects
{
	if(!m_objects)
	{
		m_objects = [[NSMutableArray alloc] init];
	}
	return m_objects;
}
@synthesize parentProjectPath = m_parentProjectPath;
@synthesize projectName = m_projectName;
@synthesize schemaName = m_schemaName;
@synthesize typeDefinitions = m_typeDefinitions;

// Getter will create m_typeDefinitions if nil. Alternately, use the typeDefinitionsObject property, which will not lazy create it.
- (NSMutableArray*) typeDefinitions
{
	if(!m_typeDefinitions)
	{
		m_typeDefinitions = [[NSMutableArray alloc] init];
	}
	return m_typeDefinitions;
}

+ (NSString*) arraysKey
{
	return @"arrays";
}

+ (NSString*) canLazyCreateKey
{
	return @"canLazyCreate";
}

+ (NSString*) commentKey
{
	return @"comment";
}

+ (NSString*) companyNameKey
{
	return @"companyName";
}

+ (NSString*) definesKey
{
	return @"defines";
}

+ (NSString*) dependenciesKey
{
	return @"dependencies";
}

+ (NSString*) disabledKey
{
	return @"disabled";
}

+ (NSString*) enumTypesKey
{
	return @"enumTypes";
}

+ (NSString*) fileUrlKey
{
	return @"fileUrl";
}

+ (NSString*) generatorOptionsKey
{
	return @"generatorOptions";
}

+ (NSString*) ifDefKey
{
	return @"ifDef";
}

+ (NSString*) importsKey
{
	return @"imports";
}

+ (NSString*) isWildcardArrayKey
{
	return @"isWildcardArray";
}

+ (NSString*) objectsKey
{
	return @"objects";
}

+ (NSString*) parentProjectPathKey
{
	return @"parentProjectPath";
}

+ (NSString*) projectNameKey
{
	return @"projectName";
}

+ (NSString*) schemaNameKey
{
	return @"schemaName";
}

+ (NSString*) typeDefinitionsKey
{
	return @"typeDefinitions";
}

+ (GtCodeGeneratorProject*) codeGeneratorProject
{
	return [[[GtCodeGeneratorProject alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorProject*)object).ifDef = GtCopyOrRetainObject(m_ifDef);
	((GtCodeGeneratorProject*)object).projectName = GtCopyOrRetainObject(m_projectName);
	((GtCodeGeneratorProject*)object).enumTypes = GtCopyOrRetainObject(m_enumTypes);
	((GtCodeGeneratorProject*)object).defines = GtCopyOrRetainObject(m_defines);
	((GtCodeGeneratorProject*)object).imports = GtCopyOrRetainObject(m_imports);
	((GtCodeGeneratorProject*)object).parentProjectPath = GtCopyOrRetainObject(m_parentProjectPath);
	((GtCodeGeneratorProject*)object).disabled = GtCopyOrRetainObject(m_disabled);
	((GtCodeGeneratorProject*)object).canLazyCreate = GtCopyOrRetainObject(m_canLazyCreate);
	((GtCodeGeneratorProject*)object).comment = GtCopyOrRetainObject(m_comment);
	((GtCodeGeneratorProject*)object).schemaName = GtCopyOrRetainObject(m_schemaName);
	((GtCodeGeneratorProject*)object).objects = GtCopyOrRetainObject(m_objects);
	((GtCodeGeneratorProject*)object).arrays = GtCopyOrRetainObject(m_arrays);
	((GtCodeGeneratorProject*)object).isWildcardArray = GtCopyOrRetainObject(m_isWildcardArray);
	((GtCodeGeneratorProject*)object).companyName = GtCopyOrRetainObject(m_companyName);
	((GtCodeGeneratorProject*)object).dependencies = GtCopyOrRetainObject(m_dependencies);
	((GtCodeGeneratorProject*)object).typeDefinitions = GtCopyOrRetainObject(m_typeDefinitions);
	((GtCodeGeneratorProject*)object).fileUrl = GtCopyOrRetainObject(m_fileUrl);
	((GtCodeGeneratorProject*)object).generatorOptions = GtCopyOrRetainObject(m_generatorOptions);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_projectName release];
	[m_companyName release];
	[m_schemaName release];
	[m_isWildcardArray release];
	[m_disabled release];
	[m_canLazyCreate release];
	[m_ifDef release];
	[m_fileUrl release];
	[m_comment release];
	[m_generatorOptions release];
	[m_enumTypes release];
	[m_objects release];
	[m_dependencies release];
	[m_defines release];
	[m_arrays release];
	[m_imports release];
	[m_typeDefinitions release];
	[m_parentProjectPath release];
	[super dealloc];
}

- (NSUInteger) hash
{
	return [[self projectName] hash];
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (BOOL) isEqual:(id) object
{
	return [object isKindOfClass:[self class]] && [[object projectName] isEqual:[self projectName]];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"projectName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"projectName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"companyName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"companyName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"schemaName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"schemaName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isWildcardArray" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isWildcardArray"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"disabled" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"disabled"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"canLazyCreate" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"canLazyCreate"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"ifDef" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"ifDef"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"fileUrl" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"fileUrl"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"comment" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"comment"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"generatorOptions" propertyClass:[GtCodeGeneratorOptions class] propertyType:GtDataTypeObject] forPropertyName:@"generatorOptions"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"enumTypes" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"enumType" propertyClass:[GtCodeGeneratorEnumType class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"enumTypes"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"objects" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"object" propertyClass:[GtCodeGeneratorObject class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"objects"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"dependencies" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"dependency" propertyClass:[GtCodeGeneratorTypeDefinition class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"dependencies"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"defines" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"define" propertyClass:[GtCodeGeneratorDefine class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"defines"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"arrays" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"array" propertyClass:[GtCodeGeneratorArray class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"arrays"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"imports" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"import" propertyClass:[GtCodeGeneratorProject class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"imports"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"typeDefinitions" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"typeDefinition" propertyClass:[GtCodeGeneratorTypeDefinition class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"typeDefinitions"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"parentProjectPath" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"parentProjectPath"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"projectName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"companyName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"schemaName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isWildcardArray" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"disabled" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"canLazyCreate" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"ifDef" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"fileUrl" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"comment" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"generatorOptions" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"enumTypes" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"objects" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"dependencies" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"defines" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"arrays" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"imports" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"typeDefinitions" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"parentProjectPath" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorProject (ValueProperties) 

- (BOOL) isWildcardArrayValue
{
	return [self.isWildcardArray boolValue];
}

- (void) setIsWildcardArrayValue:(BOOL) value
{
	self.isWildcardArray = [NSNumber numberWithBool:value];
}

// don't compile this object is set to YES
- (BOOL) disabledValue
{
	return [self.disabled boolValue];
}

- (void) setDisabledValue:(BOOL) value
{
	self.disabled = [NSNumber numberWithBool:value];
}

- (BOOL) canLazyCreateValue
{
	return [self.canLazyCreate boolValue];
}

- (void) setCanLazyCreateValue:(BOOL) value
{
	self.canLazyCreate = [NSNumber numberWithBool:value];
}
@end


@implementation GtCodeGeneratorProject (ObjectMembers) 

// This returns m_generatorOptions. It does NOT create it if it's NIL.
- (GtCodeGeneratorOptions*) generatorOptionsObject
{
	return m_generatorOptions;
}

// This returns m_enumTypes. It does NOT create it if it's NIL.
- (NSMutableArray*) enumTypesObject
{
	return m_enumTypes;
}

// This returns m_objects. It does NOT create it if it's NIL.
- (NSMutableArray*) objectsObject
{
	return m_objects;
}

// This returns m_dependencies. It does NOT create it if it's NIL.
- (NSMutableArray*) dependenciesObject
{
	return m_dependencies;
}

// This returns m_defines. It does NOT create it if it's NIL.
- (NSMutableArray*) definesObject
{
	return m_defines;
}

// This returns m_arrays. It does NOT create it if it's NIL.
- (NSMutableArray*) arraysObject
{
	return m_arrays;
}

// This returns m_imports. It does NOT create it if it's NIL.
- (NSMutableArray*) importsObject
{
	return m_imports;
}

// This returns m_typeDefinitions. It does NOT create it if it's NIL.
- (NSMutableArray*) typeDefinitionsObject
{
	return m_typeDefinitions;
}

- (void) createGeneratorOptionsIfNil
{
	if(!m_generatorOptions)
	{
		m_generatorOptions = [[GtCodeGeneratorOptions alloc] init];
	}
}

- (void) createEnumTypesIfNil
{
	if(!m_enumTypes)
	{
		m_enumTypes = [[NSMutableArray alloc] init];
	}
}

- (void) createObjectsIfNil
{
	if(!m_objects)
	{
		m_objects = [[NSMutableArray alloc] init];
	}
}

- (void) createDependenciesIfNil
{
	if(!m_dependencies)
	{
		m_dependencies = [[NSMutableArray alloc] init];
	}
}

- (void) createDefinesIfNil
{
	if(!m_defines)
	{
		m_defines = [[NSMutableArray alloc] init];
	}
}

- (void) createArraysIfNil
{
	if(!m_arrays)
	{
		m_arrays = [[NSMutableArray alloc] init];
	}
}

- (void) createImportsIfNil
{
	if(!m_imports)
	{
		m_imports = [[NSMutableArray alloc] init];
	}
}

- (void) createTypeDefinitionsIfNil
{
	if(!m_typeDefinitions)
	{
		m_typeDefinitions = [[NSMutableArray alloc] init];
	}
}
@end

