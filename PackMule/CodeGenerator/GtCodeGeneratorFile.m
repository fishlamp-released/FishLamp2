//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorFile.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorFile.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCodeGeneratorFile


@synthesize contents = m_contents;
@synthesize name = m_name;

+ (NSString*) contentsKey
{
	return @"contents";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (GtCodeGeneratorFile*) codeGeneratorFile
{
	return [[[GtCodeGeneratorFile alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorFile*)object).name = GtCopyOrRetainObject(m_name);
	((GtCodeGeneratorFile*)object).contents = GtCopyOrRetainObject(m_contents);
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
	[m_contents release];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"contents" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"contents"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"contents" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorFile (ValueProperties) 
@end


@implementation GtCodeGeneratorFile (ObjectMembers) 
@end

