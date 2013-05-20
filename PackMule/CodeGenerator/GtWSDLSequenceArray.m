//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlSequenceArray.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlSequenceArray.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtWsdlElement.h"

@implementation GtWsdlSequenceArray


@synthesize maxOccurs = m_maxOccurs;
@synthesize minOccurs = m_minOccurs;
@synthesize sequence = m_sequence;

// Getter will create m_sequence if nil. Alternately, use the sequenceObject property, which will not lazy create it.
- (NSMutableArray*) sequence
{
	if(!m_sequence)
	{
		m_sequence = [[NSMutableArray alloc] init];
	}
	return m_sequence;
}

+ (NSString*) maxOccursKey
{
	return @"maxOccurs";
}

+ (NSString*) minOccursKey
{
	return @"minOccurs";
}

+ (NSString*) sequenceKey
{
	return @"sequence";
}

- (void) dealloc
{
	[m_minOccurs release];
	[m_maxOccurs release];
	[m_sequence release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"minOccurs" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"minOccurs"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"maxOccurs" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"maxOccurs"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"sequence" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"element" propertyClass:[GtWsdlElement class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"sequence"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"minOccurs" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"maxOccurs" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"sequence" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlSequenceArray*) wsdlSequenceArray
{
	return [[[GtWsdlSequenceArray alloc] init] autorelease];
}

@end

@implementation GtWsdlSequenceArray (ValueProperties) 
@end


@implementation GtWsdlSequenceArray (ObjectMembers) 

// This returns m_sequence. It does NOT create it if it's NIL.
- (NSMutableArray*) sequenceObject
{
	return m_sequence;
}

- (void) createSequenceIfNil
{
	if(!m_sequence)
	{
		m_sequence = [[NSMutableArray alloc] init];
	}
}
@end

