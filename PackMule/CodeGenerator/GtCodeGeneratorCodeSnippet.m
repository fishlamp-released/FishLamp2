//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorCodeSnippet.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorCodeSnippet.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCodeGeneratorCodeSnippet


@synthesize comment = m_comment;
@synthesize lines = m_lines;
@synthesize name = m_name;
@synthesize scopedBy = m_scopedBy;

+ (NSString*) commentKey
{
	return @"comment";
}

+ (NSString*) linesKey
{
	return @"lines";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) scopedByKey
{
	return @"scopedBy";
}

+ (GtCodeGeneratorCodeSnippet*) codeGeneratorCodeSnippet
{
	return [[[GtCodeGeneratorCodeSnippet alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorCodeSnippet*)object).comment = GtCopyOrRetainObject(m_comment);
	((GtCodeGeneratorCodeSnippet*)object).name = GtCopyOrRetainObject(m_name);
	((GtCodeGeneratorCodeSnippet*)object).scopedBy = GtCopyOrRetainObject(m_scopedBy);
	((GtCodeGeneratorCodeSnippet*)object).lines = GtCopyOrRetainObject(m_lines);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_scopedBy release];
	[m_name release];
	[m_comment release];
	[m_lines release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"scopedBy" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"scopedBy"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"name"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"comment" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"comment"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"lines" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"lines"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"scopedBy" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"name" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"comment" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"lines" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorCodeSnippet (ValueProperties) 
@end


@implementation GtCodeGeneratorCodeSnippet (ObjectMembers) 
@end

