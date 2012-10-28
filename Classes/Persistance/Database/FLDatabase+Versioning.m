//
//  FLDatabase+Versioning.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDatabase+Versioning.h"
#import "FLDatabase.h"
#import "FLDatabase_Internal.h"
#import "NSFileManager+FLExtras.h"
#import "FLSqlBuilder.h"

/*
- (NSDictionary*) historyForName:(NSString*) name;
/// writes current version of app to database for the database version
- (void) writeDatabaseVersion:(NSString*) version;

/// write current version (same as app version) to database
- (void) writeCurrentAppVersionToDatabaseVersion;

- (BOOL) databaseVersionEqualsVersion:(NSString*) version;

- (void) upgradeDatabaseToVersion:(NSString*) version
                         progress:(FLDatabaseUpgradeProgressBlock) progress
                    tableUpgraded:(FLDatabaseTableUpgradedBlock) progressBlock;

*/

static NSString* kVersionId = nil;
static NSString* kVersion = nil;
static NSString* kName = nil;
static NSString* kEntry = nil;
static NSString* kWrittenDate = nil;
static NSString* kHistory = nil;

@implementation FLDatabase (VersioningInternal)

- (void) initializeVersioning {

    kVersionId = FLReturnRetained(FLDatabaseNameEncode(@"version_id"));
    kVersion = FLReturnRetained(FLDatabaseNameEncode(@"version"));
    kHistory = FLReturnRetained(FLDatabaseNameEncode(@"history"));
    kName = FLReturnRetained(FLDatabaseNameEncode(@"name"));
    kEntry = FLReturnRetained(FLDatabaseNameEncode(@"entry"));
    kWrittenDate = FLReturnRetained(FLDatabaseNameEncode(@"written_date"));

    FLDatabaseTable* historyTable = [FLDatabaseTable databaseTableWithTableName:kHistory];
    
    [historyTable addColumn:[FLDatabaseColumn databaseColumnWithName:kName
        columnType:FLDatabaseTypeText 
        columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];

    [historyTable addColumn:[FLDatabaseColumn databaseColumnWithName:kEntry
        columnType:FLDatabaseTypeText 
        columnConstraints:nil]];

    [historyTable addColumn:[FLDatabaseColumn databaseColumnWithName:kWrittenDate
        columnType:FLDatabaseTypeDate
        columnConstraints:nil]];

	[self createTableIfNeeded:historyTable];

    FLDatabaseTable* versionTable = [FLDatabaseTable databaseTableWithTableName:kVersion];
    
    [versionTable addColumn:[FLDatabaseColumn databaseColumnWithName:kVersionId
            columnType:FLDatabaseTypeInteger 
            columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]
            ]];

    [versionTable addColumn:[FLDatabaseColumn databaseColumnWithName:kVersion
            columnType:SQLITE_TEXT 
            columnConstraints:nil
            ]];
	[self createTableIfNeeded:versionTable];

}

- (void) writeHistoryForTable:(FLDatabaseTable*) table entry:(NSString*) entry {
	
    NSDictionary* row = [NSDictionary dictionaryWithObjectsAndKeys:table.tableName, kName,
                         entry, kEntry,
                         [NSDate date], kWrittenDate,
                         nil];
	[self insertOrReplaceRowInTable:kHistory row:row];
}


@end

@implementation FLDatabase (Versioning)

static NSString* s_version;

+ (void) setCurrentRuntimeVersion:(NSString*) version {
    FLAssignObject(s_version, version);
}

+ (NSString*) currentRuntimeVersion {
    return s_version;
}

- (NSDictionary*) readHistoryForTable:(FLDatabaseTable*) table {
	NSArray* rows = nil;

	[self runQueryWithString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@='%@'", 
		kHistory,
		kName,
		table.tableName]
		outRows:&rows];
		
	return rows.count == 1 ? rows.firstObject : nil;
}

- (NSString*) readDatabaseVersion {
    
    __block NSString* version = nil;

	FLDatabaseIterator* statement = [FLDatabaseIterator databaseIterator:self table:nil];
    [statement appendFormat:@"SELECT %@ FROM %@ WHERE %@=1",
        kVersion,
        kVersion,
        kVersionId];

    [statement execute:^(NSDictionary* row, BOOL* stop) {
        version = [row objectForKey:kVersion];
    }];

    return version;
}

- (void) writeDatabaseVersion:(NSString*) version {

    NSDictionary* newData = [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:1], kVersionId,
            version, kVersion,
            nil
            ] ;

    [self insertOrReplaceRowInTable:kVersion row:newData];
}

- (BOOL) databaseNeedsUpgrade {
    
    NSString* version = [self readDatabaseVersion];
    if(FLStringIsNotEmpty(version)) {
        return FLStringsAreNotEqual( version, [FLDatabase currentRuntimeVersion]);
    }

    return YES;
}

//- (BOOL) _renameColumnsInTableIfNeeded:(FLDatabaseTable*) table
//                         columnNames:(NSArray*) columnNames
//{
//	BOOL needsToRenameColumns = NO;
//	
//	for(NSString* colName in tableInfoList) {
//		if(!FLDatabaseIsInternalNameEncoded(colName)) {
//			needsToRenameColumns = YES;
//            break;
//		}
//	}
//	
//	if(needsToRenameColumns) {
//		NSString* tempTableName = [NSString stringWithFormat:@"%@_backup", table.tableName];
//
//		NSMutableString* encodedColumnNames = [NSMutableString string]; // a,b
//		NSMutableString* columnNames = [NSMutableString string];
//		NSMutableString* columnsToCopyBack = [NSMutableString string]; // a,b
//		
//		for(NSString* colName in tableInfoList) {
//        
//            colName = FLLegacyDecodeString(colName);
//        
//			NSString* encodedName = FLDatabaseNameEncode(colName);
//			
//			if(columnNames.length == 0) {
//				[encodedColumnNames appendString:encodedName];
//				[columnNames appendString:colName];
//			}
//			else {	
//				[encodedColumnNames appendFormat:@", %@", encodedName];
//				[columnNames appendFormat:@", %@", colName];
//			}
//			
//			if([table.columns objectForKey:encodedName] /*|| [table.columns objectForKey:FLSqlDatabaseInternalNameDecode(colName)]*/) {
//				if(columnsToCopyBack.length == 0) {
//					[columnsToCopyBack appendString:encodedName];
//				}
//				else {	
//					[columnsToCopyBack appendFormat:@", %@", encodedName];
//				}
//			}
//		}
//
//		@synchronized(self) {
//			@try {
//			
//				[self exec:@"BEGIN TRANSACTION"];
//		
//				[self exec:[NSString stringWithFormat:@"CREATE TEMPORARY TABLE %@(%@)", tempTableName, encodedColumnNames]];
//				[self exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", tempTableName, encodedColumnNames, columnNames, table.tableName]];
//
//				[self dropTable:table];
//				[self createTableIfNeeded:table];
//				
//				[self exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", table.tableName, columnsToCopyBack, columnsToCopyBack, tempTableName]];
//
//				[self exec:[NSString stringWithFormat:@"DROP TABLE %@", tempTableName]];
//	
//				[self exec:@"COMMIT"];
//			}
//			@catch(NSException* ex) {
//				[self exec:@"ROLLBACK"];
//                @throw;
//			}
//		}
//	}
//	
//	return needsToRenameColumns;
//}

//    BOOL upgraded = NO;
//    NSDictionary* tableInfoList = [self detailsForTableNamed:table.tableName];
//	
//    if([self _renameColumnsInTableIfNeeded:table tableInfoList:tableInfoList]) {
//        upgraded = YES;
//        
//        // need to reload current info after rename.
//        tableInfoList = [self detailsForTableNamed:table.tableName];
//    }
//
//    if([self _updateTableSchema:table tableInfoList:tableInfoList]) {
//        upgraded = YES;
//    }
    


//- (BOOL) _updateTableSchema:(FLDatabaseTable*) table existingColumnNames:(NSArray*) existingColumnNames {
//	
//    BOOL foundDifference = YES;
//	
//    NSDictionary* history = [self readHistoryForTable:table];
//	if(history) {
//		NSString* expected = [table createTableSqlWithIndexes];
//		foundDifference = !FLStringsAreEqual(expected, [history objectForKey:kEntry]);
//	}
//	
//	if(foundDifference) {
//		FLDebugLog(@"upgrading table: %@", table.tableName);
//	
//		NSString* tempTableName = [NSString stringWithFormat:@"%@_backup", table.tableName];
//
//        NSMutableArray* oldNames = [NSMutableArray array];
//        NSMutableArray* newNames = [NSMutableArray array];
//
//        for(NSString* existingColumnName in existingColumnNames) {
//        
//            NSString* decodedName = FLDatabaseNameDecode(existingColumnName);
//            decodedName = FLLegacyDecodeString(decodedName);
//
//            NSString* encodedName = FLDatabaseNameEncode(decodedName);
//
//            if([table.columns objectForKey:encodedName] != nil) {
//                [oldNames addObject:existingColumnName];
//                [newNames addObject:encodedName];
//            }
//        }
//
//		NSMutableString* existingColsSql = [FLSqlBuilder sqlListFromArray:existingColumnNames withinParens:NO delimiter:@", " ];
//		NSMutableString* existingColsToCopyBackSql = [FLSqlBuilder sqlListFromArray:oldNames withinParens:NO delimiter:@", " ];
//		NSMutableString* newColNamesToCopyBacsSql = [FLSqlBuilder sqlListFromArray:newNames withinParens:NO delimiter:@", " ];
//
//		@synchronized(self) {
//			@try {
//                
//                // use a transaction to protect data from failures
//				[self exec:@"BEGIN TRANSACTION"];
//
//                // create a temp table
//				[self exec:[NSString stringWithFormat:@"CREATE TEMPORARY TABLE %@(%@)", tempTableName, existingColsSql]];
//
//                // copy the whole table to a temp table.
//				[self exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", tempTableName, existingColsSql, existingColsSql, table.tableName]];
//
//                // drip the original table.
//				[self dropTable:table];
//                
//                // create the new table
//				[self createTableIfNeeded:table];
//				
//                // only copy back the rows we want, renaming on the way
//				[self exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", table.tableName, existingColsToCopyBackSql, newColNamesToCopyBacsSql, tempTableName]];
//
//                // delete temp table.
//				[self exec:[NSString stringWithFormat:@"DROP TABLE %@", tempTableName]];
//
//                // commit the whole thing
//				[self exec:@"COMMIT"];
//				
//				FLDebugLog(@"Table upgraded ok: %@", table.tableName);
//			}
//			@catch(NSException* ex) {
//				[self exec:@"ROLLBACK"];
//                @throw;
//			}
//		}
//	}
//    
//    return foundDifference;
//}

NS_INLINE
NSString* FLLegacyDecodeString(NSString* string) {
    if([string hasPrefix:@"FL_"] || [string hasPrefix:@"gt_"]) {
        string = [string substringFromIndex:3];
    }
    return string;
}

- (BOOL) upgradeTable:(FLDatabaseTable*) table allTableNames:(NSSet*) tableNames {

    NSString* originalTableName = nil;
    
    if([tableNames containsObject:table.tableName]) {
    
        originalTableName = table.tableName;
        
// easier and more common case - the table hasn't been renamed
        NSDictionary* history = [self readHistoryForTable:table];
        if(history) {
 
            NSString* expected = [table createTableSqlWithIndexes];
            if(FLStringsAreEqual(expected, [history objectForKey:kEntry])) {
                originalTableName = nil;
            }
        }
    }
    else {

// look for legacy named tables
        
        NSString* decodedTableName = table.decodedTableName;
        for(NSString* oldName in tableNames) {
        
            NSString* decodedName = FLLegacyDecodeString(oldName);
        
            if(FLStringsAreEqual(decodedName, decodedTableName)) {
                originalTableName = oldName;
                break;
            }
        }
    }
	   
    if(originalTableName) {

		FLDebugLog(@"upgrading table: %@", originalTableName, table.tableName);
        
        if(FLStringsAreNotEqual(originalTableName, table.tableName)) {
            FLDebugLog(@"renaming table %@ to %@", originalTableName, table.tableName);
        }
	
		NSString* tempTableName = [NSString stringWithFormat:@"%@_backup", originalTableName];

        NSMutableArray* oldNames = [NSMutableArray array];
        NSMutableArray* newNames = [NSMutableArray array];

        NSArray* existingColNames = [self columnNamesForTableNamed:originalTableName];
        for(NSString* oldName in existingColNames) {

            // checking for renamed columns
            NSString* decodedName = FLLegacyDecodeString(FLDatabaseNameDecode(oldName));

            NSString* newName = FLDatabaseNameEncode(decodedName);

            // is the renamed column in the new schema?
            if([table.columns objectForKey:newName] != nil) {
            
            // if yes then save old and new names
                [oldNames addObject:oldName];
                [newNames addObject:newName];
            }
        }

		NSString* existingColNamesSql = [FLSqlBuilder sqlListFromArray:existingColNames  delimiter:@"," withinParens:NO prefixDelimiterWithSpace:NO ];
		NSString* oldNamesSql = [FLSqlBuilder sqlListFromArray:oldNames delimiter:@"," withinParens:NO prefixDelimiterWithSpace:NO ];
		NSString* newNamesSql = [FLSqlBuilder sqlListFromArray:newNames delimiter:@"," withinParens:NO prefixDelimiterWithSpace:NO ];

		@synchronized(self) {
			@try {
                
                FLRetain(table);
                
                // use a transaction to protect data from failures
				[self exec:@"BEGIN TRANSACTION"];

                // create a temp table
				[self exec:[NSString stringWithFormat:@"CREATE TEMPORARY TABLE %@(%@)", tempTableName, existingColNamesSql]];

                // copy the whole table to a temp table.
				[self exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", tempTableName, existingColNamesSql, existingColNamesSql, table.tableName]];

                // drip the original table.
				[self dropTable:table];
                
                // create the new table
				[self createTableIfNeeded:table];
				
                // only copy back the rows we want, renaming on the way
				[self exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", table.tableName, newNamesSql, oldNamesSql, tempTableName]];

                // delete temp table.
				[self exec:[NSString stringWithFormat:@"DROP TABLE %@", tempTableName]];

                // commit the whole thing
				[self exec:@"COMMIT"];
				
				FLDebugLog(@"Table upgraded ok: %@", table.tableName);
			
                return YES;
            }
			@catch(NSException* ex) {
				[self exec:@"ROLLBACK"];
                @throw;
			}
            @finally {
                FLRelease(table);
            }
		}
	}

    return NO;
}

- (void) upgradeDatabaseToVersion:(NSString*) version
                         progress:(FLDatabaseUpgradeProgressBlock) progress
                    tableUpgraded:(FLDatabaseTableUpgradedBlock) tableUpgraded {

	NSSet* tableNames = [NSSet setWithArray:[self tableNamesInDatabase]];
	NSUInteger total = tableNames.count;
    __block NSUInteger count = 0;
    
    for(NSString* tableName in tableNames) {
        
        FLPerformBlockInAutoreleasePool(^{
            FLDatabaseTable* table = [self tableForName:tableName];
            if(table && [self upgradeTable:table allTableNames:tableNames]) {
                if(tableUpgraded) {
                    tableUpgraded(table, version);
                }
            }
            
            if(progress) {
                progress(count, total);
            }
            
            ++count;
        });
	}
    
    [self writeDatabaseVersion:version];
}

- (void) upgradeDatabase:(FLDatabaseUpgradeProgressBlock) progress
           tableUpgraded:(FLDatabaseTableUpgradedBlock) tableUpgraded {

    [self upgradeDatabaseToVersion:[[self class] currentRuntimeVersion]
                          progress:progress
                     tableUpgraded:tableUpgraded];
}

@end


//#if 0	
//	// see if there's a new column
//	for(NSString* columnName in table.columns)
//	{
//		NSDictionary* columnInfo = [tableInfoList objectForKey:columnName];
//		if(columnInfo)
//		{
//			NSNumber* pk		= [columnInfo objectForKey:@"pk"];
//			NSNumber* notnull	= [columnInfo objectForKey:@"notnull"];
//			NSString* type		= [columnInfo objectForKey:@"type"];
//			
//			FLDatabaseColumn* col = [table.columns objectForKey:columnName];
//			
//			NSString* constraints = col.columnConstraintsAsString;
//
//			BOOL isPrimaryKey = [constraints rangeOfString:@"PRIMARY KEY"].length > 0;
//			BOOL isNotNull = [constraints rangeOfString:@"NOT NULL"].length > 0;
//			
//			if([pk boolValue] != isPrimaryKey || [notnull boolValue] != isNotNull)
//			{
//				foundDifference = YES;
//			}
//			
//			if(!FLStringsAreEqual(type, FLDatabaseTypeToString(col.columnType)))
//			{
//				foundDifference = YES;
//			}
//		}
//		else 
//		{
//			foundDifference = YES;
//#if DEBUG
//			FLDebugLog(@"will add column: %@", columnName);
//#else
//			break;
//#endif
//		}
//	}
//
//#ifndef DEBUG
//	if(!foundDifference)
//#endif
//	{
//	// see if there's a deleted column.
//		for(NSString* colName in tableInfoList)
//		{
//			if(![table.columns objectForKey:colName])
//			{
//				foundDifference = YES;
//#if DEBUG
//				FLDebugLog(@"will delete column: %@", colName);
//#else
//				break;
//#endif
//			}
//		}
//	}
////	
//	if(!foundDifference) 
//	{
//		NSArray* indexes = [self.database indexesForTableNamed:table.tableName];
//		NSMutableDictionary* allDetails = [NSMutableDictionary dictionary];
//		
//		for(NSDictionary* indexRow in indexes)
//		{
//			NSArray* details = [self.database detailsForIndexedNamed:[indexRow objectForKey:@"name"]];
//	
//			[allDetails setObject:details.firstObject forKey:[indexRow objectForKey:@"name"]];
//		}
//	
//		
//		for(FLDatabaseColumn* column in table.columns.objectEnumerator)
//		{
//			NSArray* newIndexes = [table indexesForColumn:column.columnName];
//			NSUInteger countForColumn = newIndexes.count;
//			if(column.isPrimaryKey)
//			{
//				++countForColumn;
//			}
//		
//			NSUInteger countFromDatabase = 0;
//			
//			if(countFromDatabase != countForColumn)
//			{
//				foundDifference = YES;
//				
//				FLDebugLog(@"index count changed for column: %@", column.columnName);
//			}
//
//			// TODO: do a better job of comparing 
//		
//		}
//	}
