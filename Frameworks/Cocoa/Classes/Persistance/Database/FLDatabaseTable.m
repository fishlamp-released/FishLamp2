//
//  FLDatabaseTable.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDatabaseTable.h"
#import "FLDatabase_Internal.h"

#import "FLObjcRuntime.h"
#import "FLSqlStatement.h"

@interface FLDatabaseColumn (Internal)
- (void) setIndexed:(BOOL) isIndexed;
@property (readwrite, strong, nonatomic) NSArray* primaryKeyColumns;
@property (readwrite, strong, nonatomic) NSArray* indexedColumns;

@end

@implementation FLDatabaseTable

@synthesize tableName = _tableName;
@synthesize columns = _columns;
@synthesize indexes = _indexes;
@synthesize decodedTableName = _decodedTableName;
@synthesize classRepresentedByTable = _tableClass;
@synthesize columnDecoder = _columnDecoder;

- (void) setTableName:(NSString*) tableName {
    FLAssertStringIsNotEmpty_(tableName);
	
    FLRetainObject_(_tableName, FLDatabaseNameEncode(tableName));
	FLRetainObject_(_decodedTableName, FLDatabaseNameDecode(_tableName));
    _tableClass = NSClassFromString(_decodedTableName);
}

- (id) initWithTableName:(NSString*) tableName {
	if((self = [super init])) {
		self.tableName = tableName;
		_columns = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

+ (FLDatabaseTable*) databaseTableWithTableName:(NSString*) tableName {
	return autorelease_([[FLDatabaseTable alloc] initWithTableName:tableName]);
}

- (NSArray*) primaryKeyColumns {
    if(!_primaryKeyColumns) {
        NSMutableArray* cols = [[NSMutableArray alloc] init];
    
        for(FLDatabaseColumn* col in _columns.objectEnumerator) {
            if(col.isPrimaryKey) {
                [cols addObject:col];
            }
        }
        
        _primaryKeyColumns = cols;
    }
   
    return _primaryKeyColumns;
}

- (NSArray*) indexedColumns {
    if(!_indexedColumns) {
        NSMutableArray* cols = [[NSMutableArray alloc] init];
    
        for(FLDatabaseColumn* col in _columns.objectEnumerator) {
            if(col.isIndexed) {
                [cols addObject:col];
            }
        }

        _indexedColumns = cols;
    }
   
    return _indexedColumns;
}

- (void) dealloc {
    release_(_primaryKeyColumns);
    release_(_indexedColumns);
	release_(_decodedTableName);
	release_(_indexes);
	release_(_tableName);
	release_(_columns);
	super_dealloc_();
}

- (void) addIndex:(FLDatabaseIndex*) databaseIndex {
	if(!_indexes) {
		_indexes = [[NSMutableDictionary alloc] init];
	}
	
	NSMutableArray* indexes = [_indexes objectForKey:databaseIndex.columnName];
	if(indexes) {
		[indexes addObject:databaseIndex];
	}
	else {
		indexes = [NSMutableArray arrayWithObject:databaseIndex];
		[_indexes setObject:indexes forKey:databaseIndex.columnName];
	}
	
	[[self.columns objectForKey:databaseIndex.columnName] setIndexed:YES];
    
    FLReleaseWithNil_(_indexedColumns);
}

- (NSArray*) indexesForColumn:(NSString*) columnName {	
	return [_indexes objectForKey:columnName];
}

- (NSString*) createTableSqlWithIndexes {
	NSMutableString* sql = [NSMutableString stringWithString:[self createTableSql]];
	
	for(NSArray* indexes in self.indexes.objectEnumerator) {
		for(FLDatabaseIndex* idx in indexes) {
			NSString* createIndex = [idx createIndexSqlForTableName:self.tableName];
			[sql appendFormat:@"; %@", createIndex];
		}
	}
	
	return sql;
}

- (NSString*) createTableSql {
	NSMutableString* sql = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (", self.tableName]; //  IF NOT EXISTS
	int i = 0;
	for(FLDatabaseColumn* col in self.columns.objectEnumerator) {			
		if(col.columnType != FLDatabaseTypeNone) {
			if(col.columnConstraints && col.columnConstraints.count) {
				[sql appendFormat:@"%@%@ %@ %@", (i++ > 0 ? @", " : @""), col.columnName, FLDatabaseTypeToString(col.columnType), col.columnConstraintsAsString];
			}
			else {
				[sql appendFormat:@"%@%@ %@", (i++ > 0 ? @", " : @""), col.columnName, FLDatabaseTypeToString(col.columnType)];
			}
		}
	}

	[sql appendString:@")"];
	
	return sql;
}

- (void) addColumn:(FLDatabaseColumn*) column {
	[_columns setObject:column forKey:column.columnName];
}

- (void) setColumn:(FLDatabaseColumn*) column forColumnName:(NSString*) columnName {
	[_columns setObject:column forKey:columnName];
}

- (void) removeColumnWithName:(NSString*) name {
	[_columns removeObjectForKey:name];
}

- (FLDatabaseColumn*) columnByName:(NSString*) name {
	return [_columns objectForKey:name];
}

- (void) addColumnsForClass:(Class) class {

	if(class == [NSObject class]) {
		return;
	}

	Class superclass = class_getSuperclass(class);
	if(superclass) 	{
		[self addColumnsForClass:superclass];
	}

	unsigned int propertyCount = 0;
	objc_property_t* properties = class_copyPropertyList(class, &propertyCount);

	for(unsigned int i = 0; i < propertyCount; i++)	{
		char* className = copyTypeNameFromProperty(properties[i]);
	//	printf("name: %s, attributes %s\n",name, attributes);
		
		if(className) {
			Class c = objc_getClass(className);
			
			FLAssertIsNotNil_(c);
			   
			const char* propertyName = property_getName(properties[i]);
			FLDatabaseColumn* col = [FLDatabaseColumn databaseColumnWithName:[NSString stringWithCString:propertyName encoding:NSASCIIStringEncoding]
				columnType:[c sqlType] 
				columnConstraints:nil];
				
			[self addColumn:col];
							 
			free(className);
	
		//	printf("\tname: %s, value: '%s'\n", attrList[j].name, attrList[j].value);
		}
	}

    free(properties);
}

- (id) initWithClass:(Class) aClass {
	if((self = [self initWithTableName:NSStringFromClass(aClass)])) {
		[self addColumnsForClass:aClass];
	}
	
	return self;
}

- (id) databaseTableWithClass:(Class) aClass {
	return autorelease_([[FLDatabaseTable alloc] initWithClass:aClass]);
}

- (id) copyWithZone:(NSZone *)zone {
	FLDatabaseTable* table = [[FLDatabaseTable alloc] initWithTableName:self.tableName];
	table.columns = self.columns;
	table.indexes = self.indexes;
	return table;
}

- (NSDictionary*) filterColumnsForObject:(id) object
                                  filter:(void (^)(FLDatabaseColumn* column, BOOL* useIt, BOOL* cancel)) filter {
    NSMutableDictionary* values = nil;
    
    BOOL cancel = NO;

	for(FLDatabaseColumn* col in self.columns.objectEnumerator) {
        BOOL useIt = NO;
        filter(col, &useIt, &cancel);
        if(cancel) {
            return nil;
        }
        if(useIt) {
        
            id data = [object valueForKey:col.decodedColumnName];
			
			if(data) {
                if(!values) {
                    values = [NSMutableDictionary dictionaryWithCapacity:self.columns.count];
                }
            
                [values setObject:data forKey:col.columnName];
			}
		}
	}

    return values;
}

- (id) objectForRow:(NSDictionary*) row {

    id newObject = autorelease_([[self.classRepresentedByTable alloc] init]);
    FLAssertIsNotNil_(newObject);
    
    for(NSString* columnName in row) {
        id data = [row objectForKey:columnName];
        if(data && ![data isEqual:[NSNull null]]) {
            [newObject setValue:data forKey:FLDatabaseNameDecode(columnName)];
        }
    }
    
    return newObject;        
}

@end

@implementation NSObject (FLDatabaseTable) 

+ (FLDatabaseTable*) sharedDatabaseTable {
	return nil;
}

+ (NSString*) databaseTableName {
	return NSStringFromClass(self);
}

- (FLDatabaseTable*) databaseTable {
    return [[self class] sharedDatabaseTable];
}

- (NSDictionary*) valuesForColumns:(NSArray*) arrayOfColumns {
                        
    NSMutableDictionary* outDictionary = nil;
    for(FLDatabaseColumn* col in arrayOfColumns) {
        
        id data = [self valueForKey:col.decodedColumnName];
        if(data) {
            if(!outDictionary) {
                outDictionary = [NSMutableDictionary dictionary];
            }
            
            [outDictionary setObject:data forKey:col.columnName];
        }
    }

    return outDictionary;
}



//+ (FLDatabaseTable*) createEmptySqliteTable
//{
//	FLDatabaseTable* table = [[super sharedDatabaseTable] copy];
//	if(!table)
//	{
//		table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
//	}
//	
//	return table;
//}


//- (FLDatabaseTable*) databaseTable
//{
//	return [[self class] sharedDatabaseTable];
//}

@end

@implementation FLSqlBuilder (FLSqlTable)

- (BOOL) appendWhereClauseForSelectingObject:(id) object {

    FLDatabaseTable* table = [[object class] sharedDatabaseTable];

    NSDictionary* searchValues = [object valuesForColumns:table.primaryKeyColumns];
    if(!searchValues) {
        searchValues = [object valuesForColumns:table.indexedColumns];
    }
    else {
        return NO;
        // ??? 
    }

//    [self openListWithDelimiter:@", " withinParens:YES prefixDelimiterWithSpace:NO];
//
//    for(NSString* columnName in searchValue) {
//        [self appendString:columnName];
//    }
//
//    [self closeList];

    [self appendString:SQL_WHERE];
    
    [self openListWithDelimiter:SQL_AND withinParens:NO prefixDelimiterWithSpace:YES];
    for(NSString* colName in searchValues) {
        [self appendObject:[searchValues objectForKey:colName] comparedToString:colName withComparer:SQL_EQUAL];
    }
    [self closeList];

    return YES;
}

- (void) appendInsertClauseForObject:(id) object {

    FLDatabaseTable* table = [[object class] sharedDatabaseTable];
    
    [self openListWithDelimiter:@", " withinParens:YES prefixDelimiterWithSpace:NO];

    for(NSString* columnName in table.columns) {
        [self appendString:columnName];
    }

    [self closeList];

    [self appendString:SQL_VALUES];

    [self openListWithDelimiter:@", " withinParens:YES prefixDelimiterWithSpace:NO];

    for(FLDatabaseColumn* column in table.columns.objectEnumerator)
    {
        id obj = [object valueForKey:column.decodedColumnName];
        if(obj) {
            [self appendObject:obj];
        }
        else {
            [self appendObject:[NSNull null]]; // this binds to nil 
        }
    }

    [self closeList];
}


@end



