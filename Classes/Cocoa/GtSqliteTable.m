//
//  GtSqliteTable.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSqliteTable.h"
#import "GtSqliteStatement.h"

@interface GtSqliteColumn (Internal)
- (void) setIndexed:(BOOL) isIndexed;
@end

@implementation GtSqliteTable

@synthesize tableName = m_tableName;
@synthesize columns = m_columns;
@synthesize indexes = m_indexes;
@synthesize decodedTableName = m_decodedTableName;
@synthesize classRepresentedByTable = m_tableClass;

- (void) setColumns:(NSDictionary*) columns
{
	GtRelease(m_columns);
	m_columns = [columns mutableCopy];
}

- (void) setIndexes:(NSDictionary*) indexes
{
	GtRelease(m_indexes);
	m_indexes = [indexes mutableCopy];
}

- (void) setTableName:(NSString*) tableName
{
    GtAssertIsValidString(tableName);
	
    GtAssignObject(m_tableName, GtSqliteNameEncode(tableName));
	GtAssignObject(m_decodedTableName, GtSqliteNameDecode(m_tableName));
    m_tableClass = NSClassFromString(m_decodedTableName);
}

- (id) initWithTableName:(NSString*) tableName
{
	if((self = [super init]))
	{
		self.tableName = tableName;
		m_columns = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

+ (GtSqliteTable*) sqliteTableWithTableName:(NSString*) tableName
{
	return GtReturnAutoreleased([[GtSqliteTable alloc] initWithTableName:tableName]);
}

- (void) dealloc
{
	GtRelease(m_decodedTableName);
	GtRelease(m_indexes);
	GtRelease(m_tableName);
	GtRelease(m_columns);
	GtSuperDealloc();
}

- (void) addIndex:(GtSqliteIndex*) sqliteIndex
{
	if(!m_indexes)
	{
		m_indexes = [[NSMutableDictionary alloc] init];
	}
	
	NSMutableArray* indexes = [m_indexes objectForKey:sqliteIndex.columnName];
	if(indexes)
	{
		[indexes addObject:sqliteIndex];
	}
	else
	{
		indexes = [NSMutableArray arrayWithObject:sqliteIndex];
		[m_indexes setObject:indexes forKey:sqliteIndex.columnName];
	}
	
	[[self.columns objectForKey:sqliteIndex.columnName] setIndexed:YES];
}

- (NSArray*) indexesForColumn:(NSString*) columnName
{	
	return [m_indexes objectForKey:columnName];
}

- (NSString*) createTableSqlWithIndexes
{
	NSMutableString* sql = [NSMutableString stringWithString:[self createTableSql]];
	
	for(NSArray* indexes in self.indexes.objectEnumerator)
	{
		for(GtSqliteIndex* idx in indexes)
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
	for(GtSqliteColumn* col in self.columns.objectEnumerator)
	{			
		if(col.columnType != GtSqliteTypeNone)
		{
			if(col.columnConstraints && col.columnConstraints.count)
			{
				[sql appendFormat:@"%@%@ %@ %@", (i++ > 0 ? @", " : @""), col.columnName, GtSqliteTypeToString(col.columnType), col.columnConstraintsAsString];
			}
			else
			{
				[sql appendFormat:@"%@%@ %@", (i++ > 0 ? @", " : @""), col.columnName, GtSqliteTypeToString(col.columnType)];
			}
		}
	}

	[sql appendString:@")"];
	
	return sql;
}

- (void) addColumn:(GtSqliteColumn*) column
{
	[m_columns setObject:column forKey:column.columnName];
}

- (void) setColumn:(GtSqliteColumn*) column forColumnName:(NSString*) columnName
{
	[m_columns setObject:column forKey:columnName];
}

- (void) removeColumnWithName:(NSString*) name
{
	[m_columns removeObjectForKey:name];
}
- (GtSqliteColumn*) columnByName:(NSString*) name
{
	return [m_columns objectForKey:name];
}

//- (void) addColumnsForClass:(Class) class
//{
//	if(class == [NSObject class])
//	{
//		return;
//	}
//
//	Class superclass = class_getSuperclass(class);
//	if(superclass)
//	{
//		[self addColumnsForClass:superclass];
//	}
//
//	unsigned int propertyCount = 0;
//	objc_property_t* properties = class_copyPropertyList(class, &propertyCount);
//
//	for(unsigned int i = 0; i < propertyCount; i++)
//	{
//		char* className = copyTypeNameFromProperty(properties[i]);
//	//	printf("name: %s, attributes %s\n",name, attributes);
//		
//		if(className)
//		{
//			Class c = objc_getClass(className);
//			
//			GtAssertNotNil(c);
//			   
//			const char* propertyName = property_getName(properties[i]);
//			GtSqliteColumn* col = [GtSqliteColumn sqliteColumnWithColumnName:[NSString stringWithCString:propertyName encoding:NSASCIIStringEncoding]
//				columnType:[c sqlType] 
//				columnConstraints:nil];
//				
//			[self addColumn:col];
//							 
//			free(className);
//	
//		//	printf("\tname: %s, value: '%s'\n", attrList[j].name, attrList[j].value);
//		}
//		
//	}
//
//
//	free(properties);
//}

//- (id) initWithClass:(Class) aClass
//{
//	if((self = [self initWithTableName:NSStringFromClass(aClass)]))
//	{
//		[self addColumnsForClass:aClass];
//	}
//	
//	return self;
//}

//- (id) sqliteTableWithClass:(Class) aClass
//{
//	return GtReturnAutoreleased([[GtSqliteTable alloc] initWithClass:aClass]);
//}

- (id) copyWithZone:(NSZone *)zone
{
	GtSqliteTable* table = [[GtSqliteTable alloc] initWithTableName:self.tableName];
	table.columns = self.columns;
	table.indexes = self.indexes;
	return table;

}

@end

@implementation NSObject (GtSqliteTable) 

+ (GtSqliteTable*) sharedSqliteTable
{
	return nil;
}

+ (NSString*) sqliteTableName
{
	return NSStringFromClass(self);
} 

//+ (GtSqliteTable*) createEmptySqliteTable
//{
//	GtSqliteTable* table = [[super sharedSqliteTable] copy];
//	if(!table)
//	{
//		table = [[GtSqliteTable alloc] initWithTableName:[self sqliteTableName]];
//	}
//	
//	return table;
//}


//- (GtSqliteTable*) sqliteTable
//{
//	return [[self class] sharedSqliteTable];
//}

@end

