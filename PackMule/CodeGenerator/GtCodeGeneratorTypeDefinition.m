//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorTypeDefinition.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorTypeDefinition.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCodeGeneratorTypeDefinition


@synthesize dataType = m_dataType;
@synthesize import = m_import;
@synthesize importIsPrivate = m_importIsPrivate;
@synthesize typeName = m_typeName;

+ (NSString*) dataTypeKey
{
	return @"dataType";
}

+ (NSString*) importIsPrivateKey
{
	return @"importIsPrivate";
}

+ (NSString*) importKey
{
	return @"import";
}

+ (NSString*) typeNameKey
{
	return @"typeName";
}

+ (GtCodeGeneratorTypeDefinition*) codeGeneratorTypeDefinition
{
	return [[[GtCodeGeneratorTypeDefinition alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorTypeDefinition*)object).typeName = GtCopyOrRetainObject(m_typeName);
	((GtCodeGeneratorTypeDefinition*)object).import = GtCopyOrRetainObject(m_import);
	((GtCodeGeneratorTypeDefinition*)object).dataType = GtCopyOrRetainObject(m_dataType);
	((GtCodeGeneratorTypeDefinition*)object).importIsPrivate = GtCopyOrRetainObject(m_importIsPrivate);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_dataType release];
	[m_typeName release];
	[m_import release];
	[m_importIsPrivate release];
	[super dealloc];
}

- (NSUInteger) hash
{
	return [[self typeName] hash] + [[self dataType] hash];
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
	return [object isKindOfClass:[self class]] && [[object typeName] isEqual:[self typeName]] && [[object dataType] isEqual:[self dataType]];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"dataType" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"dataType"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"typeName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"typeName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"import" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"import"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"importIsPrivate" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"importIsPrivate"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"dataType" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"typeName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"import" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"importIsPrivate" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorTypeDefinition (ValueProperties) 

- (BOOL) importIsPrivateValue
{
	return [self.importIsPrivate boolValue];
}

- (void) setImportIsPrivateValue:(BOOL) value
{
	self.importIsPrivate = [NSNumber numberWithBool:value];
}
@end


@implementation GtCodeGeneratorTypeDefinition (ObjectMembers) 
@end

