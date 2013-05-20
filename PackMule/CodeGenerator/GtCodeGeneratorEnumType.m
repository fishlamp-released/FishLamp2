//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorEnumType.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorEnumType.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtCodeGeneratorEnum.h"

@implementation GtCodeGeneratorEnumType


@synthesize enums = m_enums;

// Getter will create m_enums if nil. Alternately, use the enumsObject property, which will not lazy create it.
- (NSMutableArray*) enums
{
	if(!m_enums)
	{
		m_enums = [[NSMutableArray alloc] init];
	}
	return m_enums;
}

+ (NSString*) enumsKey
{
	return @"enums";
}

+ (GtCodeGeneratorEnumType*) codeGeneratorEnumType
{
	return [[[GtCodeGeneratorEnumType alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorEnumType*)object).enums = GtCopyOrRetainObject(m_enums);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_enums release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"enums" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"enum" propertyClass:[GtCodeGeneratorEnum class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"enums"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"enums" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorEnumType (ValueProperties) 
@end


@implementation GtCodeGeneratorEnumType (ObjectMembers) 

// This returns m_enums. It does NOT create it if it's NIL.
- (NSMutableArray*) enumsObject
{
	return m_enums;
}

- (void) createEnumsIfNil
{
	if(!m_enums)
	{
		m_enums = [[NSMutableArray alloc] init];
	}
}
@end

