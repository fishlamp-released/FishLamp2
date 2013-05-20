//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorOptions.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorOptions.h"
#import "GtCodeGeneratorDefine.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCodeGeneratorOptions


@synthesize codeFileFolderName = m_codeFileFolderName;
@synthesize comment = m_comment;
@synthesize disabled = m_disabled;
@synthesize generateAllIncludesFile = m_generateAllIncludesFile;
@synthesize globalDefine = m_globalDefine;

// Getter will create m_globalDefine if nil. Alternately, use the globalDefineObject property, which will not lazy create it.
- (GtCodeGeneratorDefine*) globalDefine
{
	if(!m_globalDefine)
	{
		m_globalDefine = [[GtCodeGeneratorDefine alloc] init];
	}
	return m_globalDefine;
}
@synthesize objectsFolderName = m_objectsFolderName;
@synthesize typePrefix = m_typePrefix;

+ (NSString*) codeFileFolderNameKey
{
	return @"codeFileFolderName";
}

+ (NSString*) commentKey
{
	return @"comment";
}

+ (NSString*) disabledKey
{
	return @"disabled";
}

+ (NSString*) generateAllIncludesFileKey
{
	return @"generateAllIncludesFile";
}

+ (NSString*) globalDefineKey
{
	return @"globalDefine";
}

+ (NSString*) objectsFolderNameKey
{
	return @"objectsFolderName";
}

+ (NSString*) typePrefixKey
{
	return @"typePrefix";
}

+ (GtCodeGeneratorOptions*) codeGeneratorOptions
{
	return [[[GtCodeGeneratorOptions alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorOptions*)object).typePrefix = GtCopyOrRetainObject(m_typePrefix);
	((GtCodeGeneratorOptions*)object).objectsFolderName = GtCopyOrRetainObject(m_objectsFolderName);
	((GtCodeGeneratorOptions*)object).generateAllIncludesFile = GtCopyOrRetainObject(m_generateAllIncludesFile);
	((GtCodeGeneratorOptions*)object).codeFileFolderName = GtCopyOrRetainObject(m_codeFileFolderName);
	((GtCodeGeneratorOptions*)object).comment = GtCopyOrRetainObject(m_comment);
	((GtCodeGeneratorOptions*)object).globalDefine = GtCopyOrRetainObject(m_globalDefine);
	((GtCodeGeneratorOptions*)object).disabled = GtCopyOrRetainObject(m_disabled);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_disabled release];
	[m_typePrefix release];
	[m_comment release];
	[m_globalDefine release];
	[m_generateAllIncludesFile release];
	[m_objectsFolderName release];
	[m_codeFileFolderName release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"disabled" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"disabled"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"typePrefix" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"typePrefix"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"comment" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"comment"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"globalDefine" propertyClass:[GtCodeGeneratorDefine class] propertyType:GtDataTypeObject] forPropertyName:@"globalDefine"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"generateAllIncludesFile" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"generateAllIncludesFile"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"objectsFolderName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"objectsFolderName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"codeFileFolderName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"codeFileFolderName"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"disabled" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"typePrefix" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"comment" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"globalDefine" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"generateAllIncludesFile" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"objectsFolderName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"codeFileFolderName" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorOptions (ValueProperties) 

// don't compile this object is set to YES
- (BOOL) disabledValue
{
	return [self.disabled boolValue];
}

- (void) setDisabledValue:(BOOL) value
{
	self.disabled = [NSNumber numberWithBool:value];
}

// set this to YES to create an includes file that includes all the generated headers
- (BOOL) generateAllIncludesFileValue
{
	return [self.generateAllIncludesFile boolValue];
}

- (void) setGenerateAllIncludesFileValue:(BOOL) value
{
	self.generateAllIncludesFile = [NSNumber numberWithBool:value];
}
@end


@implementation GtCodeGeneratorOptions (ObjectMembers) 

// This returns m_globalDefine. It does NOT create it if it's NIL.
- (GtCodeGeneratorDefine*) globalDefineObject
{
	return m_globalDefine;
}

- (void) createGlobalDefineIfNil
{
	if(!m_globalDefine)
	{
		m_globalDefine = [[GtCodeGeneratorDefine alloc] init];
	}
}
@end

