//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlImport.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlImport.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtWsdlImport


@synthesize import = m_import;
@synthesize namespace = m_namespace;

+ (NSString*) importKey
{
	return @"import";
}

+ (NSString*) namespaceKey
{
	return @"namespace";
}

- (void) dealloc
{
	[m_import release];
	[m_namespace release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"import" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"import"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"namespace" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"namespace"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"import" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"namespace" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlImport*) wsdlImport
{
	return [[[GtWsdlImport alloc] init] autorelease];
}

@end

@implementation GtWsdlImport (ValueProperties) 
@end


@implementation GtWsdlImport (ObjectMembers) 
@end

