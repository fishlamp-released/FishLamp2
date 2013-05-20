//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlList.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlList.h"
#import "GtWsdlSimpleType.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtWsdlList


@synthesize simpleType = m_simpleType;

// Getter will create m_simpleType if nil. Alternately, use the simpleTypeObject property, which will not lazy create it.
- (GtWsdlSimpleType*) simpleType
{
	if(!m_simpleType)
	{
		m_simpleType = [[GtWsdlSimpleType alloc] init];
	}
	return m_simpleType;
}

+ (NSString*) simpleTypeKey
{
	return @"simpleType";
}

- (void) dealloc
{
	[m_simpleType release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"simpleType" propertyClass:[GtWsdlSimpleType class] propertyType:GtDataTypeObject] forPropertyName:@"simpleType"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"simpleType" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlList*) wsdlList
{
	return [[[GtWsdlList alloc] init] autorelease];
}

@end

@implementation GtWsdlList (ValueProperties) 
@end


@implementation GtWsdlList (ObjectMembers) 

// This returns m_simpleType. It does NOT create it if it's NIL.
- (GtWsdlSimpleType*) simpleTypeObject
{
	return m_simpleType;
}

- (void) createSimpleTypeIfNil
{
	if(!m_simpleType)
	{
		m_simpleType = [[GtWsdlSimpleType alloc] init];
	}
}
@end

