//
//  FLSqliteDatabaseUpgrader.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSqliteDatabaseUpgrader.h"
#import "FLSqliteDatabaseVersioner.h"

@interface FLSqliteDatabaseUpgrader ()

#if FL_LEGACY_DB_ENCODING
- (BOOL) _renameColumnsInTableIfNeeded:(FLSqliteTable*) table
		tableInfoList:(NSDictionary*) tableInfoList;
		
			
#endif

- (void) _updateTableSchema:(FLSqliteTable*) table tableInfoList:(NSDictionary*) tableInfoList;

@end


@implementation FLSqliteDatabaseUpgrader

@synthesize database = _database;

- (id) initWithSqliteDatabase:(FLSqliteDatabase*) database
{
	if((self = [super init]))
	{
		_database = FLReturnRetained(database);
	}

	return self;
}

+ (FLSqliteDatabaseUpgrader*) sqliteDatabaseUpgrader:(FLSqliteDatabase*) database
{
	return FLReturnAutoreleased([[FLSqliteDatabaseUpgrader alloc] initWithSqliteDatabase:database]);
}

- (void) dealloc
{
	FLRelease(_database);
	FLSuperDealloc();
}

- (NSUInteger) calculateTotalStepCount
{
	return [_database tableCount];
}

- (void) doExecuteTask
{
	self.taskName = NSLocalizedString(@"Upgrading Database", nil);
	
	NSArray* tableNames = [self.database selectTableNames];
	for(NSString* internalTableName in tableNames)
	{
        FLPerformBlockInAutoreleasePool(^{

			if(![[FLSqliteDatabaseVersioner instance] isVersionTableName:internalTableName])
			{
				NSDictionary* tableInfoList = [self.database loadTableDetailsForTableName:internalTableName];
				NSString* className = FLSqliteNameDecode(internalTableName);
				
				FLSqliteTable* table = [NSClassFromString(className) sharedSqliteTable];
				if(table)
				{				
#if FL_LEGACY_DB_ENCODING
					if([self _renameColumnsInTableIfNeeded:table tableInfoList:tableInfoList])
					{
						// need to reload current info after rename.
						tableInfoList = [self.database loadTableDetailsForTableName:internalTableName];
					}
#endif			
					[self _updateTableSchema:table tableInfoList:tableInfoList];
				}
			}
		});
		
		[self incrementStep];
	}
	
	[[FLSqliteDatabaseVersioner instance] writeCurrentAppVersionToDatabase:self.database];

}

- (void) _updateTableSchema:(FLSqliteTable*) table tableInfoList:(NSDictionary*) tableInfoList
{
	BOOL foundDifference = YES;
	NSDictionary* history = [self.database historyForName:table.tableName];
	if(history)
	{
		NSString* expected = [table createTableSqlWithIndexes];
		foundDifference = !FLStringsAreEqual(expected, [history objectForKey:FLSqliteNameEncode(@"entry")]);
	}
	
	if(foundDifference)
	{
		FLDebugLog(@"upgrading table: %@", table.tableName);
	
		NSString* tempTableName = [NSString stringWithFormat:@"%@_backup", table.tableName];

		NSMutableString* existingColumns = [NSMutableString string];
		
		for(NSString* colName in tableInfoList)
		{
			if(existingColumns.length == 0)
			{
				[existingColumns appendString:colName];
			}
			else
			{	
				[existingColumns appendFormat:@", %@", colName];
			}
		}
		
		
		NSMutableString* colsToCopyBack = [NSMutableString string];
		for(NSString* columnName in table.columns)
		{
			if([tableInfoList objectForKey:columnName])
			{
				if(colsToCopyBack.length == 0)
				{
					[colsToCopyBack appendString:columnName];
				}
				else
				{	
					[colsToCopyBack appendFormat:@", %@", columnName];
				}
			}
		}

		@synchronized(self.database) {
			@try {
			
				[self.database exec:@"BEGIN TRANSACTION"];
		
				[self.database exec:[NSString stringWithFormat:@"CREATE TEMPORARY TABLE %@(%@)", tempTableName, existingColumns]];
				[self.database exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", tempTableName, existingColumns, existingColumns, table.tableName]];

				[self.database dropTable:table];
				[self.database createTableIfNeeded:table];
				
				[self.database exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", table.tableName, colsToCopyBack, colsToCopyBack, tempTableName]];

				[self.database exec:[NSString stringWithFormat:@"DROP TABLE %@", tempTableName]];

				[self.database exec:@"COMMIT"];
				
				FLDebugLog(@"Table upgraded ok: %@", table.tableName);
			}
			@catch(NSException* ex)
			{
				[self.database exec:@"ROLLBACK"];
			}
		}

	}
}


#if FL_LEGACY_DB_ENCODING


- (BOOL) _renameColumnsInTableIfNeeded:(FLSqliteTable*) table
		tableInfoList:(NSDictionary*) tableInfoList
{
	BOOL needsToRenameColumns = NO;
	
	for(NSString* colName in tableInfoList)
	{
		if(!FLSqliteIsInternalNameEncoded(colName))
		{
			needsToRenameColumns = YES;
		}
	}
	
	if(needsToRenameColumns)
	{
		NSString* tempTableName = [NSString stringWithFormat:@"%@_backup", table.tableName];

		NSMutableString* encodedColumnNames = [NSMutableString string]; // a,b
		NSMutableString* columnNames = [NSMutableString string];
		NSMutableString* columnsToCopyBack = [NSMutableString string]; // a,b
		
		for(NSString* colName in tableInfoList)
		{
			NSString* encodedName = FLSqliteNameEncode(colName);
			
			if(columnNames.length == 0)
			{
				[encodedColumnNames appendString:encodedName];
				[columnNames appendString:colName];
			}
			else
			{	
				[encodedColumnNames appendFormat:@", %@", encodedName];
				[columnNames appendFormat:@", %@", colName];
			}
			
			if([table.columns objectForKey:encodedName] /*|| [table.columns objectForKey:FLSqlDatabaseInternalNameDecode(colName)]*/)
			{
				if(columnsToCopyBack.length == 0)
				{
					[columnsToCopyBack appendString:encodedName];
				}
				else
				{	
					[columnsToCopyBack appendFormat:@", %@", encodedName];
				}
			}
		}

		@synchronized(self.database) {
			@try {
			
				[self.database exec:@"BEGIN TRANSACTION"];
		
				[self.database exec:[NSString stringWithFormat:@"CREATE TEMPORARY TABLE %@(%@)", tempTableName, encodedColumnNames]];
				[self.database exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", tempTableName, encodedColumnNames, columnNames, table.tableName]];

				[self.database dropTable:table];
				[self.database createTableIfNeeded:table];
				
				[self.database exec:[NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@", table.tableName, columnsToCopyBack, columnsToCopyBack, tempTableName]];

				[self.database exec:[NSString stringWithFormat:@"DROP TABLE %@", tempTableName]];
	
				[self.database exec:@"COMMIT"];
			}
			@catch(NSException* ex)
			{
				[self.database exec:@"ROLLBACK"];
			}
		}
	}
	
	return needsToRenameColumns;
}
#endif

	




@end


#if 0	
	// see if there's a new column
	for(NSString* columnName in table.columns)
	{
		NSDictionary* columnInfo = [tableInfoList objectForKey:columnName];
		if(columnInfo)
		{
			NSNumber* pk		= [columnInfo objectForKey:@"pk"];
			NSNumber* notnull	= [columnInfo objectForKey:@"notnull"];
			NSString* type		= [columnInfo objectForKey:@"type"];
			
			FLSqliteColumn* col = [table.columns objectForKey:columnName];
			
			NSString* constraints = col.columnConstraintsAsString;

			BOOL isPrimaryKey = [constraints rangeOfString:@"PRIMARY KEY"].length > 0;
			BOOL isNotNull = [constraints rangeOfString:@"NOT NULL"].length > 0;
			
			if([pk boolValue] != isPrimaryKey || [notnull boolValue] != isNotNull)
			{
				foundDifference = YES;
			}
			
			if(!FLStringsAreEqual(type, FLSqliteTypeToString(col.columnType)))
			{
				foundDifference = YES;
			}
		}
		else 
		{
			foundDifference = YES;
#if DEBUG
			FLDebugLog(@"will add column: %@", columnName);
#else
			break;
#endif
		}
	}

#ifndef DEBUG
	if(!foundDifference)
#endif
	{
	// see if there's a deleted column.
		for(NSString* colName in tableInfoList)
		{
			if(![table.columns objectForKey:colName])
			{
				foundDifference = YES;
#if DEBUG
				FLDebugLog(@"will delete column: %@", colName);
#else
				break;
#endif
			}
		}
	}
//	
	if(!foundDifference) 
	{
		NSArray* indexes = [self.database indexesForTableName:table.tableName];
		NSMutableDictionary* allDetails = [NSMutableDictionary dictionary];
		
		for(NSDictionary* indexRow in indexes)
		{
			NSArray* details = [self.database indexDetailsForIndex:[indexRow objectForKey:@"name"]];
	
			[allDetails setObject:details.firstObject forKey:[indexRow objectForKey:@"name"]];
		}
	
		
		for(FLSqliteColumn* column in table.columns.objectEnumerator)
		{
			NSArray* newIndexes = [table indexesForColumn:column.columnName];
			NSUInteger countForColumn = newIndexes.count;
			if(column.isPrimaryKey)
			{
				++countForColumn;
			}
		
			NSUInteger countFromDatabase = 0;
			
			if(countFromDatabase != countForColumn)
			{
				foundDifference = YES;
				
				FLDebugLog(@"index count changed for column: %@", column.columnName);
			}

			// TODO: do a better job of comparing 
		
		}
	}
#endif