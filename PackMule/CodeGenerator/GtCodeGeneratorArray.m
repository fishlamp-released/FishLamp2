//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorArray.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorArray.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtCodeGeneratorArrayType.h"

@implementation GtCodeGeneratorArray


@synthesize name = m_name;
@synthesize types = m_types;

// Getter will create m_types if nil. Alternately, use the typesObject property, which will not lazy create it.
- (NSMutableArray*) types
{
	if(!m_types)
	{
		m_types = [[NSMutableArray alloc] init];
	}
	return m_types;
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) typesKey
{
	return @"types";
}

+ (GtCodeGeneratorArray*) codeGeneratorArray
{
	return [[[GtCodeGeneratorArray alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorArray*)object).name = GtCopyOrRetainObject(m_name);
	((GtCodeGeneratorArray*)object).types = GtCopyOrRetainObject(m_types);
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
	[m_types release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"types" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"arrayType" propertyClass:[GtCodeGeneratorArrayType class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"types"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"types" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorArray (ValueProperties) 
@end


@implementation GtCodeGeneratorArray (ObjectMembers) 

// This returns m_types. It does NOT create it if it's NIL.
- (NSMutableArray*) typesObject
{
	return m_types;
}

- (void) createTypesIfNil
{
	if(!m_types)
	{
		m_types = [[NSMutableArray alloc] init];
	}
}
@end

