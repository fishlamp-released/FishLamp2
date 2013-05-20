//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorProperty.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorProperty.h"
#import "GtCodeGeneratorStorageOptions.h"
#import "GtCodeGeneratorMethod.h"
#import "GtCodeGeneratorEnumType.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtCodeGeneratorArrayType.h"

@implementation GtCodeGeneratorProperty


@synthesize arrayTypes = m_arrayTypes;

// Getter will create m_arrayTypes if nil. Alternately, use the arrayTypesObject property, which will not lazy create it.
- (NSMutableArray*) arrayTypes
{
	if(!m_arrayTypes)
	{
		m_arrayTypes = [[NSMutableArray alloc] init];
	}
	return m_arrayTypes;
}
@synthesize canLazyCreate = m_canLazyCreate;
@synthesize comment = m_comment;
@synthesize defaultValue = m_defaultValue;
@synthesize enumType = m_enumType;

// Getter will create m_enumType if nil. Alternately, use the enumTypeObject property, which will not lazy create it.
- (GtCodeGeneratorEnumType*) enumType
{
	if(!m_enumType)
	{
		m_enumType = [[GtCodeGeneratorEnumType alloc] init];
	}
	return m_enumType;
}
@synthesize getter = m_getter;

// Getter will create m_getter if nil. Alternately, use the getterObject property, which will not lazy create it.
- (GtCodeGeneratorMethod*) getter
{
	if(!m_getter)
	{
		m_getter = [[GtCodeGeneratorMethod alloc] init];
	}
	return m_getter;
}
@synthesize hasCustomCode = m_hasCustomCode;
@synthesize isImmutable = m_isImmutable;
@synthesize isPrivate = m_isPrivate;
@synthesize isReadOnly = m_isReadOnly;
@synthesize isStatic = m_isStatic;
@synthesize isWildcardArray = m_isWildcardArray;
@synthesize memberName = m_memberName;
@synthesize name = m_name;
@synthesize originalName = m_originalName;
@synthesize originalType = m_originalType;
@synthesize setter = m_setter;

// Getter will create m_setter if nil. Alternately, use the setterObject property, which will not lazy create it.
- (GtCodeGeneratorMethod*) setter
{
	if(!m_setter)
	{
		m_setter = [[GtCodeGeneratorMethod alloc] init];
	}
	return m_setter;
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
@synthesize type = m_type;
@synthesize useForEquality = m_useForEquality;

+ (NSString*) arrayTypesKey
{
	return @"arrayTypes";
}

+ (NSString*) canLazyCreateKey
{
	return @"canLazyCreate";
}

+ (NSString*) commentKey
{
	return @"comment";
}

+ (NSString*) defaultValueKey
{
	return @"defaultValue";
}

+ (NSString*) enumTypeKey
{
	return @"enumType";
}

+ (NSString*) getterKey
{
	return @"getter";
}

+ (NSString*) hasCustomCodeKey
{
	return @"hasCustomCode";
}

+ (NSString*) isImmutableKey
{
	return @"isImmutable";
}

+ (NSString*) isPrivateKey
{
	return @"isPrivate";
}

+ (NSString*) isReadOnlyKey
{
	return @"isReadOnly";
}

+ (NSString*) isStaticKey
{
	return @"isStatic";
}

+ (NSString*) isWildcardArrayKey
{
	return @"isWildcardArray";
}

+ (NSString*) memberNameKey
{
	return @"memberName";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) originalNameKey
{
	return @"originalName";
}

+ (NSString*) originalTypeKey
{
	return @"originalType";
}

+ (NSString*) setterKey
{
	return @"setter";
}

+ (NSString*) storageOptionsKey
{
	return @"storageOptions";
}

+ (NSString*) typeKey
{
	return @"type";
}

+ (NSString*) useForEqualityKey
{
	return @"useForEquality";
}

+ (GtCodeGeneratorProperty*) codeGeneratorProperty
{
	return [[[GtCodeGeneratorProperty alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorProperty*)object).originalType = GtCopyOrRetainObject(m_originalType);
	((GtCodeGeneratorProperty*)object).isStatic = GtCopyOrRetainObject(m_isStatic);
	((GtCodeGeneratorProperty*)object).isImmutable = GtCopyOrRetainObject(m_isImmutable);
	((GtCodeGeneratorProperty*)object).defaultValue = GtCopyOrRetainObject(m_defaultValue);
	((GtCodeGeneratorProperty*)object).originalName = GtCopyOrRetainObject(m_originalName);
	((GtCodeGeneratorProperty*)object).isReadOnly = GtCopyOrRetainObject(m_isReadOnly);
	((GtCodeGeneratorProperty*)object).useForEquality = GtCopyOrRetainObject(m_useForEquality);
	((GtCodeGeneratorProperty*)object).enumType = GtCopyOrRetainObject(m_enumType);
	((GtCodeGeneratorProperty*)object).isPrivate = GtCopyOrRetainObject(m_isPrivate);
	((GtCodeGeneratorProperty*)object).name = GtCopyOrRetainObject(m_name);
	((GtCodeGeneratorProperty*)object).type = GtCopyOrRetainObject(m_type);
	((GtCodeGeneratorProperty*)object).getter = GtCopyOrRetainObject(m_getter);
	((GtCodeGeneratorProperty*)object).isWildcardArray = GtCopyOrRetainObject(m_isWildcardArray);
	((GtCodeGeneratorProperty*)object).memberName = GtCopyOrRetainObject(m_memberName);
	((GtCodeGeneratorProperty*)object).storageOptions = GtCopyOrRetainObject(m_storageOptions);
	((GtCodeGeneratorProperty*)object).setter = GtCopyOrRetainObject(m_setter);
	((GtCodeGeneratorProperty*)object).arrayTypes = GtCopyOrRetainObject(m_arrayTypes);
	((GtCodeGeneratorProperty*)object).canLazyCreate = GtCopyOrRetainObject(m_canLazyCreate);
	((GtCodeGeneratorProperty*)object).hasCustomCode = GtCopyOrRetainObject(m_hasCustomCode);
	((GtCodeGeneratorProperty*)object).comment = GtCopyOrRetainObject(m_comment);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_name release];
	[m_type release];
	[m_storageOptions release];
	[m_memberName release];
	[m_defaultValue release];
	[m_comment release];
	[m_getter release];
	[m_setter release];
	[m_arrayTypes release];
	[m_canLazyCreate release];
	[m_isPrivate release];
	[m_isReadOnly release];
	[m_isImmutable release];
	[m_isStatic release];
	[m_useForEquality release];
	[m_isWildcardArray release];
	[m_originalType release];
	[m_originalName release];
	[m_enumType release];
	[m_hasCustomCode release];
	[super dealloc];
}

- (NSUInteger) hash
{
	return [[self name] hash];
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
	return [object isKindOfClass:[self class]] && [[object name] isEqual:[self name]];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"type"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"storageOptions" propertyClass:[GtCodeGeneratorStorageOptions class] propertyType:GtDataTypeObject] forPropertyName:@"storageOptions"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"memberName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"memberName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"defaultValue" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"defaultValue"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"comment" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"comment"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"getter" propertyClass:[GtCodeGeneratorMethod class] propertyType:GtDataTypeObject] forPropertyName:@"getter"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"setter" propertyClass:[GtCodeGeneratorMethod class] propertyType:GtDataTypeObject] forPropertyName:@"setter"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"arrayTypes" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"arrayType" propertyClass:[GtCodeGeneratorArrayType class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"arrayTypes"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"canLazyCreate" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"canLazyCreate"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isPrivate" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isPrivate"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isReadOnly" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isReadOnly"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isImmutable" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isImmutable"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isStatic" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isStatic"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"useForEquality" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"useForEquality"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isWildcardArray" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isWildcardArray"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"originalType" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"originalType"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"originalName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"originalName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"enumType" propertyClass:[GtCodeGeneratorEnumType class] propertyType:GtDataTypeObject] forPropertyName:@"enumType"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"hasCustomCode" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"hasCustomCode"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"type" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"storageOptions" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"memberName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"defaultValue" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"comment" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"getter" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"setter" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"arrayTypes" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"canLazyCreate" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isPrivate" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isReadOnly" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isImmutable" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isStatic" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"useForEquality" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isWildcardArray" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"originalType" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"originalName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"enumType" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"hasCustomCode" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorProperty (ValueProperties) 

// automatically create the data (if it's an object) when the property getter is called and the value is nil
- (BOOL) canLazyCreateValue
{
	return [self.canLazyCreate boolValue];
}

- (void) setCanLazyCreateValue:(BOOL) value
{
	self.canLazyCreate = [NSNumber numberWithBool:value];
}

// don't declare the property in the file header (good for overriding superclass methods)
- (BOOL) isPrivateValue
{
	return [self.isPrivate boolValue];
}

- (void) setIsPrivateValue:(BOOL) value
{
	self.isPrivate = [NSNumber numberWithBool:value];
}

// make this property readonly
- (BOOL) isReadOnlyValue
{
	return [self.isReadOnly boolValue];
}

- (void) setIsReadOnlyValue:(BOOL) value
{
	self.isReadOnly = [NSNumber numberWithBool:value];
}

// immutable means readonly, and directly return the default value without storing it in a member variable
- (BOOL) isImmutableValue
{
	return [self.isImmutable boolValue];
}

- (void) setIsImmutableValue:(BOOL) value
{
	self.isImmutable = [NSNumber numberWithBool:value];
}

// is this property a class method e.g. + (void) foo
- (BOOL) isStaticValue
{
	return [self.isStatic boolValue];
}

- (void) setIsStaticValue:(BOOL) value
{
	self.isStatic = [NSNumber numberWithBool:value];
}

- (BOOL) useForEqualityValue
{
	return [self.useForEquality boolValue];
}

- (void) setUseForEqualityValue:(BOOL) value
{
	self.useForEquality = [NSNumber numberWithBool:value];
}

- (BOOL) isWildcardArrayValue
{
	return [self.isWildcardArray boolValue];
}

- (void) setIsWildcardArrayValue:(BOOL) value
{
	self.isWildcardArray = [NSNumber numberWithBool:value];
}

// Properties by default have member data associated with them, set this to YES to disable this.
- (BOOL) hasCustomCodeValue
{
	return [self.hasCustomCode boolValue];
}

- (void) setHasCustomCodeValue:(BOOL) value
{
	self.hasCustomCode = [NSNumber numberWithBool:value];
}
@end


@implementation GtCodeGeneratorProperty (ObjectMembers) 

// This returns m_storageOptions. It does NOT create it if it's NIL.
- (GtCodeGeneratorStorageOptions*) storageOptionsObject
{
	return m_storageOptions;
}

// This returns m_getter. It does NOT create it if it's NIL.
- (GtCodeGeneratorMethod*) getterObject
{
	return m_getter;
}

// This returns m_setter. It does NOT create it if it's NIL.
- (GtCodeGeneratorMethod*) setterObject
{
	return m_setter;
}

// This returns m_arrayTypes. It does NOT create it if it's NIL.
- (NSMutableArray*) arrayTypesObject
{
	return m_arrayTypes;
}

// This returns m_enumType. It does NOT create it if it's NIL.
- (GtCodeGeneratorEnumType*) enumTypeObject
{
	return m_enumType;
}

- (void) createStorageOptionsIfNil
{
	if(!m_storageOptions)
	{
		m_storageOptions = [[GtCodeGeneratorStorageOptions alloc] init];
	}
}

- (void) createGetterIfNil
{
	if(!m_getter)
	{
		m_getter = [[GtCodeGeneratorMethod alloc] init];
	}
}

- (void) createSetterIfNil
{
	if(!m_setter)
	{
		m_setter = [[GtCodeGeneratorMethod alloc] init];
	}
}

- (void) createArrayTypesIfNil
{
	if(!m_arrayTypes)
	{
		m_arrayTypes = [[NSMutableArray alloc] init];
	}
}

- (void) createEnumTypeIfNil
{
	if(!m_enumType)
	{
		m_enumType = [[GtCodeGeneratorEnumType alloc] init];
	}
}
@end

