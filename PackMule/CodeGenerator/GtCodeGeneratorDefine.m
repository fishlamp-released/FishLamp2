//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorDefine.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorDefine.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCodeGeneratorDefine


@synthesize comment = m_comment;
@synthesize define = m_define;
@synthesize isString = m_isString;
@synthesize value = m_value;

+ (NSString*) commentKey
{
	return @"comment";
}

+ (NSString*) defineKey
{
	return @"define";
}

+ (NSString*) isStringKey
{
	return @"isString";
}

+ (NSString*) valueKey
{
	return @"value";
}

+ (GtCodeGeneratorDefine*) codeGeneratorDefine
{
	return [[[GtCodeGeneratorDefine alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorDefine*)object).value = GtCopyOrRetainObject(m_value);
	((GtCodeGeneratorDefine*)object).comment = GtCopyOrRetainObject(m_comment);
	((GtCodeGeneratorDefine*)object).isString = GtCopyOrRetainObject(m_isString);
	((GtCodeGeneratorDefine*)object).define = GtCopyOrRetainObject(m_define);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_define release];
	[m_value release];
	[m_isString release];
	[m_comment release];
	[super dealloc];
}

- (NSUInteger) hash
{
	return [[self comment] hash];
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
	return [object isKindOfClass:[self class]] && [[object comment] isEqual:[self comment]];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"define" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"define"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"value" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"value"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isString" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isString"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"comment" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"comment"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"define" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"value" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isString" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"comment" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorDefine (ValueProperties) 

- (BOOL) isStringValue
{
	return [self.isString boolValue];
}

- (void) setIsStringValue:(BOOL) value
{
	self.isString = [NSNumber numberWithBool:value];
}
@end


@implementation GtCodeGeneratorDefine (ObjectMembers) 
@end

