//
//  FLSqliteTable.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSqliteTable.h"
#import "FLSqliteStatement.h"

#import "FLObjcRuntime.h"

@interface FLSqliteColumn (Internal)
- (void) setIndexed:(BOOL) isIndexed;
@end

@implementation FLSqliteTable

@synthesize tableName = _tableName;
@synthesize columns = _columns;
@synthesize indexes = _indexes;
@synthesize decodedTableName = _decodedTableName;
@synthesize classRepresentedByTable = _tableClass;

- (void) setColumns:(NSDictionary*) columns
{
	FLRelease(_columns);
	_columns = [columns mutableCopy];
}

- (void) setIndexes:(NSDictionary*) indexes
{
	FLRelease(_indexes);
	_indexes = [indexes mutableCopy];
}

- (void) setTableName:(NSString*) tableName
{
    FLAssertStringIsNotEmpty(tableName);
	
    FLAssignObject(_tableName, FLSqliteNameEncode(tableName));
	FLAssignObject(_decodedTableName, FLSqliteNameDecode(_tableName));
    _tableClass = NSClassFromString(_decodedTableName);
}

- (id) initWithTableName:(NSString*) tableName
{
	if((self = [super init]))
	{
		self.tableName = tableName;
		_columns = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

+ (FLSqliteTable*) sqliteTableWithTableName:(NSString*) tableName
{
	return FLReturnAutoreleased([[FLSqliteTable alloc] initWithTableName:tableName]);
}

- (void) dealloc
{
	FLRelease(_decodedTableName);
	FLRelease(_indexes);
	FLRelease(_tableName);
	FLRelease(_columns);
	FLSuperDealloc();
}

- (void) addIndex:(FLSqliteIndex*) sqliteIndex
{
	if(!_indexes)
	{
		_indexes = [[NSMutableDictionary alloc] init];
	}
	
	NSMutableArray* indexes = [_indexes objectForKey:sqliteIndex.columnName];
	if(indexes)
	{
		[indexes addObject:sqliteIndex];
	}
	else
	{
		indexes = [NSMutableArray arrayWithObject:sqliteIndex];
		[_indexes setObject:indexes forKey:sqliteIndex.columnName];
	}
	
	[[self.columns objectForKey:sqliteIndex.columnName] setIndexed:YES];
}

- (NSArray*) indexesForColumn:(NSString*) columnName
{	
	return [_indexes objectForKey:columnName];
}

- (NSString*) createTableSqlWithIndexes
{
	NSMutableString* sql = [NSMutableString stringWithString:[self createTableSql]];
	
	for(NSArray* indexes in self.indexes.objectEnumerator)
	{
		for(FLSqliteIndex* idx in indexes)
		{
			NSString* createIndex = [idx createIndexSqlForTableName:self.tableName];
			[sql appendFormat:@"; %@", createIndex];
		}
	}
	
	return sql;
}

- (NSString*) createTableSql
{
	NSMutableString* sql = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (", self.tableName]; //  IF NOT EXISTS
	int i = 0;
	for(FLSqliteColumn* col in self.columns.objectEnumerator)
	{			
		if(col.columnType != FLSqliteTypeNone)
		{
			if(col.columnConstraints && col.columnConstraints.count)
			{
				[sql appendFormat:@"%@%@ %@ %@", (i++ > 0 ? @", " : @""), col.columnName, FLSqliteTypeToString(col.columnType), col.columnConstraintsAsString];
			}
			else
			{
				[sql appendFormat:@"%@%@ %@", (i++ > 0 ? @", " : @""), col.columnName, FLSqliteTypeToString(col.columnType)];
			}
		}
	}

	[sql appendString:@")"];
	
	return sql;
}

- (void) addColumn:(FLSqliteColumn*) column
{
	[_columns setObject:column forKey:column.columnName];
}

- (void) setColumn:(FLSqliteColumn*) column forColumnName:(NSString*) columnName
{
	[_columns setObject:column forKey:columnName];
}

- (void) removeColumnWithName:(NSString*) name
{
	[_columns removeObjectForKey:name];
}
- (FLSqliteColumn*) columnByName:(NSString*) name
{
	return [_columns objectForKey:name];
}

- (void) addColumnsForClass:(Class) class
{
	if(class == [NSObject class])
	{
		return;
	}

	Class superclass = class_getSuperclass(class);
	if(superclass)
	{
		[self addColumnsForClass:superclass];
	}

	unsigned int propertyCount = 0;
	objc_property_t* properties = class_copyPropertyList(class, &propertyCount);

	for(unsigned int i = 0; i < propertyCount; i++)
	{
		char* className = copyTypeNameFromProperty(properties[i]);
	//	printf("name: %s, attributes %s\n",name, attributes);
		
		if(className)
		{
			Class c = objc_getClass(className);
			
			FLAssertIsNotNil(c);
			   
			const char* propertyName = property_getName(properties[i]);
			FLSqliteColumn* col = [FLSqliteColumn sqliteColumnWithColumnName:[NSString stringWithCString:propertyName encoding:NSASCIIStringEncoding]
				columnType:[c sqlType] 
				columnConstraints:nil];
				
			[self addColumn:col];
							 
			free(className);
	
		//	printf("\tname: %s, value: '%s'\n", attrList[j].name, attrList[j].value);
		}
		
	}


	free(properties);
}

- (id) initWithClass:(Class) aClass
{
	if((self = [self initWithTableName:NSStringFromClass(aClass)]))
	{
		[self addColumnsForClass:aClass];
	}
	
	return self;
}

- (id) sqliteTableWithClass:(Class) aClass
{
	return FLReturnAutoreleased([[FLSqliteTable alloc] initWithClass:aClass]);
}

- (id) copyWithZone:(NSZone *)zone
{
	FLSqliteTable* table = [[FLSqliteTable alloc] initWithTableName:self.tableName];
	table.columns = self.columns;
	table.indexes = self.indexes;
	return table;

}

@end

@implementation NSObject (FLSqliteTable) 

+ (FLSqliteTable*) sharedSqliteTable
{
	return nil;
}

+ (NSString*) sqliteTableName
{
	return NSStringFromClass(self);
} 

//+ (FLSqliteTable*) createEmptySqliteTable
//{
//	FLSqliteTable* table = [[super sharedSqliteTable] copy];
//	if(!table)
//	{
//		table = [[FLSqliteTable alloc] initWithTableName:[self sqliteTableName]];
//	}
//	
//	return table;
//}


//- (FLSqliteTable*) sqliteTable
//{
//	return [[self class] sharedSqliteTable];
//}

@end

