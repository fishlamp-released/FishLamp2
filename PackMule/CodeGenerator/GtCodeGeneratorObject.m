//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorObject.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorObject.h"
#import "GtCodeGeneratorStorageOptions.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtCodeGeneratorObjectCategory.h"
#import "GtCodeGeneratorTypeDefinition.h"
#import "GtCodeGeneratorVariable.h"
#import "GtCodeGeneratorMethod.h"
#import "GtCodeGeneratorProperty.h"
#import "GtCodeGeneratorCodeSnippet.h"

@implementation GtCodeGeneratorObject


@synthesize canLazyCreate = m_canLazyCreate;
@synthesize categories = m_categories;

// Getter will create m_categories if nil. Alternately, use the categoriesObject property, which will not lazy create it.
- (NSMutableArray*) categories
{
	if(!m_categories)
	{
		m_categories = [[NSMutableArray alloc] init];
	}
	return m_categories;
}
@synthesize comment = m_comment;
@synthesize deallocLines = m_deallocLines;

// Getter will create m_deallocLines if nil. Alternately, use the deallocLinesObject property, which will not lazy create it.
- (NSMutableArray*) deallocLines
{
	if(!m_deallocLines)
	{
		m_deallocLines = [[NSMutableArray alloc] init];
	}
	return m_deallocLines;
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
@synthesize headerFileName = m_headerFileName;
@synthesize ifDef = m_ifDef;
@synthesize initLines = m_initLines;

// Getter will create m_initLines if nil. Alternately, use the initLinesObject property, which will not lazy create it.
- (NSMutableArray*) initLines
{
	if(!m_initLines)
	{
		m_initLines = [[NSMutableArray alloc] init];
	}
	return m_initLines;
}
@synthesize isSingleton = m_isSingleton;
@synthesize isWildcardArray = m_isWildcardArray;
@synthesize members = m_members;

// Getter will create m_members if nil. Alternately, use the membersObject property, which will not lazy create it.
- (NSMutableArray*) members
{
	if(!m_members)
	{
		m_members = [[NSMutableArray alloc] init];
	}
	return m_members;
}
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
@synthesize name = m_name;
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
@synthesize protocols = m_protocols;
@synthesize sourceFileName = m_sourceFileName;
@synthesize sourceSnippets = m_sourceSnippets;

// Getter will create m_sourceSnippets if nil. Alternately, use the sourceSnippetsObject property, which will not lazy create it.
- (NSMutableArray*) sourceSnippets
{
	if(!m_sourceSnippets)
	{
		m_sourceSnippets = [[NSMutableArray alloc] init];
	}
	return m_sourceSnippets;
}
@synthesize storageOptions = m_storageOptions;

// Getter will create m_storageOptions if nil. Alternately, use the storageOptionsObject property, which will not lazy create it.
- (GtCodeGeneratorStorageOptions*) storageOptions
{
	if(!m_storageOptions)
	{
		m_storageOptions = [[GtCodeGeneratorStorageOptions alloc] init];
	}
	return m_storageOptions;
}
@synthesize superclass = m_superclass;

+ (NSString*) canLazyCreateKey
{
	return @"canLazyCreate";
}

+ (NSString*) categoriesKey
{
	return @"categories";
}

+ (NSString*) commentKey
{
	return @"comment";
}

+ (NSString*) deallocLinesKey
{
	return @"deallocLines";
}

+ (NSString*) dependenciesKey
{
	return @"dependencies";
}

+ (NSString*) disabledKey
{
	return @"disabled";
}

+ (NSString*) headerFileNameKey
{
	return @"headerFileName";
}

+ (NSString*) ifDefKey
{
	return @"ifDef";
}

+ (NSString*) initLinesKey
{
	return @"initLines";
}

+ (NSString*) isSingletonKey
{
	return @"isSingleton";
}

+ (NSString*) isWildcardArrayKey
{
	return @"isWildcardArray";
}

+ (NSString*) membersKey
{
	return @"members";
}

+ (NSString*) methodsKey
{
	return @"methods";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) propertiesKey
{
	return @"properties";
}

+ (NSString*) protocolsKey
{
	return @"protocols";
}

+ (NSString*) sourceFileNameKey
{
	return @"sourceFileName";
}

+ (NSString*) sourceSnippetsKey
{
	return @"sourceSnippets";
}

+ (NSString*) storageOptionsKey
{
	return @"storageOptions";
}

+ (NSString*) superclassKey
{
	return @"superclass";
}

+ (GtCodeGeneratorObject*) codeGeneratorObject
{
	return [[[GtCodeGeneratorObject alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorObject*)object).isSingleton = GtCopyOrRetainObject(m_isSingleton);
	((GtCodeGeneratorObject*)object).superclass = GtCopyOrRetainObject(m_superclass);
	((GtCodeGeneratorObject*)object).protocols = GtCopyOrRetainObject(m_protocols);
	((GtCodeGeneratorObject*)object).dependencies = GtCopyOrRetainObject(m_dependencies);
	((GtCodeGeneratorObject*)object).sourceSnippets = GtCopyOrRetainObject(m_sourceSnippets);
	((GtCodeGeneratorObject*)object).name = GtCopyOrRetainObject(m_name);
	((GtCodeGeneratorObject*)object).deallocLines = GtCopyOrRetainObject(m_deallocLines);
	((GtCodeGeneratorObject*)object).members = GtCopyOrRetainObject(m_members);
	((GtCodeGeneratorObject*)object).sourceFileName = GtCopyOrRetainObject(m_sourceFileName);
	((GtCodeGeneratorObject*)object).properties = GtCopyOrRetainObject(m_properties);
	((GtCodeGeneratorObject*)object).isWildcardArray = GtCopyOrRetainObject(m_isWildcardArray);
	((GtCodeGeneratorObject*)object).storageOptions = GtCopyOrRetainObject(m_storageOptions);
	((GtCodeGeneratorObject*)object).disabled = GtCopyOrRetainObject(m_disabled);
	((GtCodeGeneratorObject*)object).methods = GtCopyOrRetainObject(m_methods);
	((GtCodeGeneratorObject*)object).initLines = GtCopyOrRetainObject(m_initLines);
	((GtCodeGeneratorObject*)object).canLazyCreate = GtCopyOrRetainObject(m_canLazyCreate);
	((GtCodeGeneratorObject*)object).ifDef = GtCopyOrRetainObject(m_ifDef);
	((GtCodeGeneratorObject*)object).comment = GtCopyOrRetainObject(m_comment);
	((GtCodeGeneratorObject*)object).categories = GtCopyOrRetainObject(m_categories);
	((GtCodeGeneratorObject*)object).headerFileName = GtCopyOrRetainObject(m_headerFileName);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_protocols release];
	[m_name release];
	[m_storageOptions release];
	[m_comment release];
	[m_superclass release];
	[m_disabled release];
	[m_canLazyCreate release];
	[m_isWildcardArray release];
	[m_ifDef release];
	[m_isSingleton release];
	[m_properties release];
	[m_dependencies release];
	[m_members release];
	[m_methods release];
	[m_sourceSnippets release];
	[m_initLines release];
	[m_deallocLines release];
	[m_categories release];
	[m_sourceFileName release];
	[m_headerFileName release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"protocols" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"protocols"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"name"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"storageOptions" propertyClass:[GtCodeGeneratorStorageOptions class] propertyType:GtDataTypeObject] forPropertyName:@"storageOptions"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"comment" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"comment"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"superclass" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"superclass"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"disabled" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"disabled"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"canLazyCreate" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"canLazyCreate"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isWildcardArray" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isWildcardArray"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"ifDef" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"ifDef"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isSingleton" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isSingleton"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"properties" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"property" propertyClass:[GtCodeGeneratorProperty class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"properties"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"dependencies" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"dependency" propertyClass:[GtCodeGeneratorTypeDefinition class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"dependencies"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"members" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"member" propertyClass:[GtCodeGeneratorVariable class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"members"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"methods" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"method" propertyClass:[GtCodeGeneratorMethod class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"methods"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"sourceSnippets" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"code" propertyClass:[GtCodeGeneratorCodeSnippet class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"sourceSnippets"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"initLines" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"initLine" propertyClass:[NSString class] propertyType:GtDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"initLines"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"deallocLines" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"deallocLine" propertyClass:[NSString class] propertyType:GtDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"deallocLines"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"categories" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"category" propertyClass:[GtCodeGeneratorObjectCategory class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"categories"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"sourceFileName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"sourceFileName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"headerFileName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"headerFileName"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"protocols" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"name" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"storageOptions" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"comment" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"superclass" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"disabled" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"canLazyCreate" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isWildcardArray" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"ifDef" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isSingleton" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"properties" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"dependencies" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"members" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"methods" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"sourceSnippets" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"initLines" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"deallocLines" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"categories" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"sourceFileName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"headerFileName" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorObject (ValueProperties) 

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

- (BOOL) isWildcardArrayValue
{
	return [self.isWildcardArray boolValue];
}

- (void) setIsWildcardArrayValue:(BOOL) value
{
	self.isWildcardArray = [NSNumber numberWithBool:value];
}

// if set to YES the standard FishLamp singleton objects will be generated for this object
- (BOOL) isSingletonValue
{
	return [self.isSingleton boolValue];
}

- (void) setIsSingletonValue:(BOOL) value
{
	self.isSingleton = [NSNumber numberWithBool:value];
}
@end


@implementation GtCodeGeneratorObject (ObjectMembers) 

// This returns m_storageOptions. It does NOT create it if it's NIL.
- (GtCodeGeneratorStorageOptions*) storageOptionsObject
{
	return m_storageOptions;
}

// This returns m_properties. It does NOT create it if it's NIL.
- (NSMutableArray*) propertiesObject
{
	return m_properties;
}

// This returns m_dependencies. It does NOT create it if it's NIL.
- (NSMutableArray*) dependenciesObject
{
	return m_dependencies;
}

// This returns m_members. It does NOT create it if it's NIL.
- (NSMutableArray*) membersObject
{
	return m_members;
}

// This returns m_methods. It does NOT create it if it's NIL.
- (NSMutableArray*) methodsObject
{
	return m_methods;
}

// This returns m_sourceSnippets. It does NOT create it if it's NIL.
- (NSMutableArray*) sourceSnippetsObject
{
	return m_sourceSnippets;
}

// This returns m_initLines. It does NOT create it if it's NIL.
- (NSMutableArray*) initLinesObject
{
	return m_initLines;
}

// This returns m_deallocLines. It does NOT create it if it's NIL.
- (NSMutableArray*) deallocLinesObject
{
	return m_deallocLines;
}

// This returns m_categories. It does NOT create it if it's NIL.
- (NSMutableArray*) categoriesObject
{
	return m_categories;
}

- (void) createStorageOptionsIfNil
{
	if(!m_storageOptions)
	{
		m_storageOptions = [[GtCodeGeneratorStorageOptions alloc] init];
	}
}

- (void) createPropertiesIfNil
{
	if(!m_properties)
	{
		m_properties = [[NSMutableArray alloc] init];
	}
}

- (void) createDependenciesIfNil
{
	if(!m_dependencies)
	{
		m_dependencies = [[NSMutableArray alloc] init];
	}
}

- (void) createMembersIfNil
{
	if(!m_members)
	{
		m_members = [[NSMutableArray alloc] init];
	}
}

- (void) createMethodsIfNil
{
	if(!m_methods)
	{
		m_methods = [[NSMutableArray alloc] init];
	}
}

- (void) createSourceSnippetsIfNil
{
	if(!m_sourceSnippets)
	{
		m_sourceSnippets = [[NSMutableArray alloc] init];
	}
}

- (void) createInitLinesIfNil
{
	if(!m_initLines)
	{
		m_initLines = [[NSMutableArray alloc] init];
	}
}

- (void) createDeallocLinesIfNil
{
	if(!m_deallocLines)
	{
		m_deallocLines = [[NSMutableArray alloc] init];
	}
}

- (void) createCategoriesIfNil
{
	if(!m_categories)
	{
		m_categories = [[NSMutableArray alloc] init];
	}
}
@end

