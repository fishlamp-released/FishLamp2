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
#import "FLPropertyAttributes.h"
#import "FLObjectDescriber.h"
#import "FLObjectDescriber.h"
#import "FLModelObject.h"

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
    FLAssertStringIsNotEmpty(tableName);
	
    FLSetObjectWithRetain(_tableName, FLDatabaseNameEncode(tableName));
	FLSetObjectWithRetain(_decodedTableName, FLDatabaseNameDecode(_tableName));
    _tableClass = NSClassFromString(_decodedTableName);
}

- (id) initWithTableName:(NSString*) tableName {
	if((self = [super init])) {
		self.tableName = tableName;
		_columns = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (id) initWithClass:(Class) aClass {
	if((self = [self initWithTableName:[aClass databaseTableName]])) {
        [aClass databaseTableWillAddColumns:self];
        
        if([aClass isModelObject]) {
            FLObjectDescriber* objectDescriber = [aClass objectDescriber];
            [self addColumnsWithTypeDesc:objectDescriber forClass:aClass];
        }

        [aClass databaseTableDidAddColumns:self];
        [aClass databaseTableWasCreated:self];
	}
	
	return self;
}

+ (id) databaseTableWithClass:(Class) aClass {
	return FLAutorelease([[FLDatabaseTable alloc] initWithClass:aClass]);
}

+ (FLDatabaseTable*) databaseTableWithTableName:(NSString*) tableName {
	return FLAutorelease([[FLDatabaseTable alloc] initWithTableName:tableName]);
}

- (NSArray*) primaryKeyColumns {
    if(!_primaryKeyColumns) {
        NSMutableArray* cols = [[NSMutableArray alloc] init];
    
        for(FLDatabaseColumn* col in _columns.objectEnumerator) {
            if(col.hasPrimaryKeyConstraint) {
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
            if(col.hasPrimaryKeyConstraint) {
                [cols addObject:col];
            }
        }

        _indexedColumns = cols;
    }
   
    return _indexedColumns;
}

- (void) dealloc {
    FLRelease(_primaryKeyColumns);
    FLRelease(_indexedColumns);
	FLRelease(_decodedTableName);
	FLRelease(_indexes);
	FLRelease(_tableName);
	FLRelease(_columns);
	FLSuperDealloc();
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
    
    FLReleaseWithNil(_indexedColumns);
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

//- (void) addPrimaryKey:(SEL) primaryKey {
//    FLDatabaseColumn* col = [self columnByName:NSStringFromSelector(primaryKey)];
//    [col ]
//}

- (void) addColumnsWithTypeDesc:(FLObjectDescriber*) describer forClass:(Class) aClass {

    for(NSUInteger i = 0; i < describer.subTypeCount; i++) {
        FLObjectDescriber* property = [describer subTypeForIndex:i];

        FLDatabaseColumn* col = [FLDatabaseColumn databaseColumnWithName:property.identifier
            columnType:[property.objectClass sqlType] 
            columnConstraints:nil]; 

        [aClass databaseTable:self willAddDatabaseColumn:col];            

        [self addColumn:col];
    }
}

- (id) copyWithZone:(NSZone *)zone {
	FLDatabaseTable* table = [[FLDatabaseTable alloc] initWithTableName:self.tableName];
	table.columns = self.columns;
	table.indexes = self.indexes;
	return table;
}

- (NSDictionary*) valuesForColumns:(NSArray*) columns inObject:(id) object {
                                
    NSMutableDictionary* outDictionary = nil;
    for(FLDatabaseColumn* col in columns) {
        
        id data = [object valueForKey:col.decodedColumnName];
        if(data) {
            if(!outDictionary) {
                outDictionary = [NSMutableDictionary dictionary];
            }
            
            [outDictionary setObject:data forKey:col.columnName];
        }
    }

    return outDictionary;
                        
}

- (NSDictionary*) propertyValuesForObject:(id) object
                         withColumnFilter:(void (^)(FLDatabaseColumn* column, BOOL* useIt, BOOL* cancel)) filter {
                         
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

    id newObject = FLAutorelease([[self.classRepresentedByTable alloc] init]);
    FLAssertIsNotNil(newObject);
    
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

+ (void) databaseTableWillAddColumns:(FLDatabaseTable*) table {
}

+ (void) databaseTable:(FLDatabaseTable*) table willAddDatabaseColumn:(FLDatabaseColumn*) column {
}

+ (void) databaseTableDidAddColumns:(FLDatabaseTable*) table {
}

+ (void) databaseTableWasCreated:(FLDatabaseTable*) table {

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

    NSDictionary* searchValues = [table valuesForColumns:table.primaryKeyColumns inObject:object];
    
    if(!searchValues) {
        searchValues = [table valuesForColumns:table.indexedColumns inObject:object];
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



