//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorStorageOptions.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorStorageOptions.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCodeGeneratorStorageOptions


@synthesize isIndexed = m_isIndexed;
@synthesize isPrimaryKey = m_isPrimaryKey;
@synthesize isRequired = m_isRequired;
@synthesize isStorable = m_isStorable;
@synthesize isUnique = m_isUnique;

+ (NSString*) isIndexedKey
{
	return @"isIndexed";
}

+ (NSString*) isPrimaryKeyKey
{
	return @"isPrimaryKey";
}

+ (NSString*) isRequiredKey
{
	return @"isRequired";
}

+ (NSString*) isStorableKey
{
	return @"isStorable";
}

+ (NSString*) isUniqueKey
{
	return @"isUnique";
}

+ (GtCodeGeneratorStorageOptions*) codeGeneratorStorageOptions
{
	return [[[GtCodeGeneratorStorageOptions alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorStorageOptions*)object).isStorable = GtCopyOrRetainObject(m_isStorable);
	((GtCodeGeneratorStorageOptions*)object).isIndexed = GtCopyOrRetainObject(m_isIndexed);
	((GtCodeGeneratorStorageOptions*)object).isRequired = GtCopyOrRetainObject(m_isRequired);
	((GtCodeGeneratorStorageOptions*)object).isPrimaryKey = GtCopyOrRetainObject(m_isPrimaryKey);
	((GtCodeGeneratorStorageOptions*)object).isUnique = GtCopyOrRetainObject(m_isUnique);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_isStorable release];
	[m_isPrimaryKey release];
	[m_isIndexed release];
	[m_isUnique release];
	[m_isRequired release];
	[super dealloc];
}

- (id) init
{
	if((self = [super init]))
	{
		self.isStorableValue = YES;
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isStorable" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isStorable"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isPrimaryKey" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isPrimaryKey"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isIndexed" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isIndexed"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isUnique" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isUnique"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isRequired" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isRequired"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isStorable" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isPrimaryKey" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isIndexed" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isUnique" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isRequired" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorStorageOptions (ValueProperties) 

// this defaults to NO. Note that storage options are ignored if the parent object is not storable.
- (BOOL) isStorableValue
{
	return [self.isStorable boolValue];
}

- (void) setIsStorableValue:(BOOL) value
{
	self.isStorable = [NSNumber numberWithBool:value];
}

// set this property to be a primary key in the data store
- (BOOL) isPrimaryKeyValue
{
	return [self.isPrimaryKey boolValue];
}

- (void) setIsPrimaryKeyValue:(BOOL) value
{
	self.isPrimaryKey = [NSNumber numberWithBool:value];
}

// set this property to be indexed for fast searches on it
- (BOOL) isIndexedValue
{
	return [self.isIndexed boolValue];
}

- (void) setIsIndexedValue:(BOOL) value
{
	self.isIndexed = [NSNumber numberWithBool:value];
}

// make sure this value is unique is the data store for this type
- (BOOL) isUniqueValue
{
	return [self.isUnique boolValue];
}

- (void) setIsUniqueValue:(BOOL) value
{
	self.isUnique = [NSNumber numberWithBool:value];
}

// make sure this value isn't empty in the data store
- (BOOL) isRequiredValue
{
	return [self.isRequired boolValue];
}

- (void) setIsRequiredValue:(BOOL) value
{
	self.isRequired = [NSNumber numberWithBool:value];
}
@end


@implementation GtCodeGeneratorStorageOptions (ObjectMembers) 
@end

