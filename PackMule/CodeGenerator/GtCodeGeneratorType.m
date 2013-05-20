//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorType.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorType.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCodeGeneratorType


@synthesize defaultValue = m_defaultValue;
@synthesize originalType = m_originalType;
@synthesize typeName = m_typeName;

+ (NSString*) defaultValueKey
{
	return @"defaultValue";
}

+ (NSString*) originalTypeKey
{
	return @"originalType";
}

+ (NSString*) typeNameKey
{
	return @"typeName";
}

+ (GtCodeGeneratorType*) codeGeneratorType
{
	return [[[GtCodeGeneratorType alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorType*)object).originalType = GtCopyOrRetainObject(m_originalType);
	((GtCodeGeneratorType*)object).defaultValue = GtCopyOrRetainObject(m_defaultValue);
	((GtCodeGeneratorType*)object).typeName = GtCopyOrRetainObject(m_typeName);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_typeName release];
	[m_defaultValue release];
	[m_originalType release];
	[super dealloc];
}

- (NSUInteger) hash
{
	return [[self typeName] hash];
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
	return [object isKindOfClass:[self class]] && [[object typeName] isEqual:[self typeName]];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"typeName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"typeName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"defaultValue" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"defaultValue"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"originalType" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"originalType"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"typeName" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"defaultValue" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"originalType" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorType (ValueProperties) 
@end


@implementation GtCodeGeneratorType (ObjectMembers) 
@end

