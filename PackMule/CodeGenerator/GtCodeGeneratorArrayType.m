//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorArrayType.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorArrayType.h"
#import "GtCodeGeneratorProperty.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCodeGeneratorArrayType


@synthesize wildcardProperty = m_wildcardProperty;

// Getter will create m_wildcardProperty if nil. Alternately, use the wildcardPropertyObject property, which will not lazy create it.
- (GtCodeGeneratorProperty*) wildcardProperty
{
	if(!m_wildcardProperty)
	{
		m_wildcardProperty = [[GtCodeGeneratorProperty alloc] init];
	}
	return m_wildcardProperty;
}

+ (NSString*) wildcardPropertyKey
{
	return @"wildcardProperty";
}

+ (GtCodeGeneratorArrayType*) codeGeneratorArrayType
{
	return [[[GtCodeGeneratorArrayType alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorArrayType*)object).wildcardProperty = GtCopyOrRetainObject(m_wildcardProperty);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_wildcardProperty release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"wildcardProperty" propertyClass:[GtCodeGeneratorProperty class] propertyType:GtDataTypeObject] forPropertyName:@"wildcardProperty"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"wildcardProperty" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorArrayType (ValueProperties) 
@end


@implementation GtCodeGeneratorArrayType (ObjectMembers) 

// This returns m_wildcardProperty. It does NOT create it if it's NIL.
- (GtCodeGeneratorProperty*) wildcardPropertyObject
{
	return m_wildcardProperty;
}

- (void) createWildcardPropertyIfNil
{
	if(!m_wildcardProperty)
	{
		m_wildcardProperty = [[GtCodeGeneratorProperty alloc] init];
	}
}
@end

