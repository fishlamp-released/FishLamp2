//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlComplexContent.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlComplexContent.h"
#import "GtWsdlExtension.h"
#import "GtWsdlRestrictionArray.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtWsdlComplexContent


@synthesize extension = m_extension;

// Getter will create m_extension if nil. Alternately, use the extensionObject property, which will not lazy create it.
- (GtWsdlExtension*) extension
{
	if(!m_extension)
	{
		m_extension = [[GtWsdlExtension alloc] init];
	}
	return m_extension;
}
@synthesize mixed = m_mixed;
@synthesize restriction = m_restriction;

// Getter will create m_restriction if nil. Alternately, use the restrictionObject property, which will not lazy create it.
- (GtWsdlRestrictionArray*) restriction
{
	if(!m_restriction)
	{
		m_restriction = [[GtWsdlRestrictionArray alloc] init];
	}
	return m_restriction;
}

+ (NSString*) extensionKey
{
	return @"extension";
}

+ (NSString*) mixedKey
{
	return @"mixed";
}

+ (NSString*) restrictionKey
{
	return @"restriction";
}

- (void) dealloc
{
	[m_mixed release];
	[m_extension release];
	[m_restriction release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"mixed" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"mixed"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"extension" propertyClass:[GtWsdlExtension class] propertyType:GtDataTypeObject] forPropertyName:@"extension"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"restriction" propertyClass:[GtWsdlRestrictionArray class] propertyType:GtDataTypeObject] forPropertyName:@"restriction"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"mixed" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"extension" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"restriction" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlComplexContent*) wsdlComplexContent
{
	return [[[GtWsdlComplexContent alloc] init] autorelease];
}

@end

@implementation GtWsdlComplexContent (ValueProperties) 
@end


@implementation GtWsdlComplexContent (ObjectMembers) 

// This returns m_extension. It does NOT create it if it's NIL.
- (GtWsdlExtension*) extensionObject
{
	return m_extension;
}

// This returns m_restriction. It does NOT create it if it's NIL.
- (GtWsdlRestrictionArray*) restrictionObject
{
	return m_restriction;
}

- (void) createExtensionIfNil
{
	if(!m_extension)
	{
		m_extension = [[GtWsdlExtension alloc] init];
	}
}

- (void) createRestrictionIfNil
{
	if(!m_restriction)
	{
		m_restriction = [[GtWsdlRestrictionArray alloc] init];
	}
}
@end

