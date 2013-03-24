//
//  FLDatabase+FLTables.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDatabase+Tables.h"
#import "FLDatabase.h"
#import "FLDatabase_Internal.h"

@implementation FLDatabase (FLTables)

- (FLDatabaseTable*) tableForName:(NSString*) name {

    NSString* className = FLDatabaseNameDecode(name);
    FLDatabaseTable* table = [_tables objectForKey:className];
    if(!table) {
        Class theClass = NSClassFromString(className);
        if(theClass) {
            table = [theClass sharedDatabaseTable];
        }
	}
    return table;
}

- (void) _createTableIfNotInDatabase:(FLDatabaseTable*) table {

	FLAssertIsNotNil(table);
	FLAssertIsNotNil(table.columns);
	FLAssertWithComment([self isOpen], @"Database isn't open");
	FLAssertWithComment([table.columns count] > 0, @"no columns in the table, bub");

    if(![self tableExists:table]) {
        [self execute:[table createTableSql]];
        for(NSArray* indexes in table.indexes.objectEnumerator) {
            for(FLDatabaseIndex* idx in indexes) {
                NSString* createIndex = [idx createIndexSqlForTableName:table.tableName];
                
                if(FLStringIsNotEmpty(createIndex)) {
                    [self execute:createIndex];
                }
            }
        }
        [self writeHistoryForTable:table entry:[table createTableSqlWithIndexes]];
    }
}

- (void) createTableIfNeeded:(FLDatabaseTable*) table  {
	
    if(![_tables objectForKey:table.decodedTableName]) {
        [self _createTableIfNotInDatabase:table];
        [_tables setObject:table forKey:table.decodedTableName];
    }
}

- (void) dropTable:(FLDatabaseTable*) table {
	[self dropTableByName:table.tableName];
}

- (BOOL) tableExists:(FLDatabaseTable*) table {
	return [self tableExistsByName:table.tableName];
}

- (NSUInteger) rowCountForTable:(FLDatabaseTable*) table {
	[self createTableIfNeeded:table];
	return [self rowCountForTableByName:table.tableName];
}

- (NSUInteger) rowCountForTableByName:(NSString*) table {
	
    __block NSUInteger count = 0;
    
    FLSqlBuilder* sql = [FLSqlBuilder sqlBuilder];
    [sql appendFormat:@"SELECT COUNT(*) FROM %@", table];
    
    [self executeSql:sql rowResultBlock: ^(NSDictionary* row, BOOL* stop) {
        NSNumber* number = [row objectForKey:@"COUNT(*)"];
        if(number) {
            count = [number integerValue];
        }
    }];

    return count;
}

- (BOOL) tableExistsByName:(NSString*) tableName
{
	FLAssertStringIsNotEmpty(tableName);
    
    __block BOOL exists = NO;

    FLSqlBuilder* sql = [FLSqlBuilder sqlBuilder];
    [sql appendFormat:@"SELECT name FROM sqlite_master WHERE name='%@'", tableName];

    [self executeSql:sql rowResultBlock:^(NSDictionary* row, BOOL* stop) {
        exists = FLStringsAreEqual([row objectForKey:@"name"], tableName);
        if(exists) {
            *stop = YES;
        }
    }];

    return exists;
}

- (void) dropTableByName:(NSString*) tableName {
	FLAssertStringIsNotEmpty(tableName);

	@try  {
		[self execute:[NSString stringWithFormat:@"DROP TABLE %@", tableName]];
	}
	@catch(NSException* ex) {
		if(!ex.error.isTableDoesNotExistError) {
			@throw;
		}
	}
	
	[_tables removeObjectForKey:tableName];
	[_tables removeObjectForKey:FLDatabaseNameDecode(tableName)];
}

- (void) _insertOrUpdateRowInTable:(NSString*) tableName
                               row:(NSDictionary*) row
                            action:(NSString*) action {

//    FLDatabaseTable* table = [[object class] sharedDatabaseTable];
//    [self createTableIfNeeded:table];

    FLSqlBuilder* sql = [FLSqlBuilder sqlBuilder];
    sql.sqlString = action;
    [sql appendString:SQL_INTO andString:tableName];
    [sql appendInsertClauseForRow:row];

    [self executeSql:sql rowResultBlock:nil];
}

- (void) replaceRowInTable:(NSString*) tableName 
			          row:(NSDictionary*) row   {
	[self _insertOrUpdateRowInTable:tableName row:row action:@"REPLACE"];
}

- (void) insertRowInTable:(NSString*) tableName 
			          row:(NSDictionary*) row  {
	[self _insertOrUpdateRowInTable:tableName row:row action:@"INSERT"];
}

- (void) insertOrReplaceRowInTable:(NSString*) tableName row:(NSDictionary*) row {
	[self _insertOrUpdateRowInTable:tableName row:row action:@"INSERT OR REPLACE"];
}

- (void) runQueryOnTable:(FLDatabaseTable*) table
              withString:(NSString*) statementString
                 outRows:(NSArray**) outRows {
    
    NSMutableArray* result = [NSMutableArray array];

    FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];
    [statement appendString:statementString];
    
    statement.rowResultBlock = ^(NSDictionary* row, BOOL* stop) {
        [result addObject:row];
    };
     
    [self executeStatement:statement];

    *outRows = FLRetain(result);
}

@end