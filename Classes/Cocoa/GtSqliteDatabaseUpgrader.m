//
//  GtSqliteDatabaseUpgrader.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSqliteDatabaseUpgrader.h"
#import "GtSqliteDatabaseVersioner.h"

@interface GtSqliteDatabaseUpgrader ()

#if GT_LEGACY_DB_ENCODING
- (BOOL) _renameColumnsInTableIfNeeded:(GtSqliteTable*) table
		tableInfoList:(NSDictionary*) tableInfoList;
		
			
#endif

- (void) _updateTableSchema:(GtSqliteTable*) table tableInfoList:(NSDictionary*) tableInfoList;

@end


@implementation GtSqliteDatabaseUpgrader

@synthesize database = m_database;

- (id) initWithSqliteDatabase:(GtSqliteDatabase*) database
{
	if((self = [super init]))
	{
		m_database = GtRetain(database);
	}

	return self;
}

+ (GtSqliteDatabaseUpgrader*) sqliteDatabaseUpgrader:(GtSqliteDatabase*) database
{
	return GtReturnAutoreleased([[GtSqliteDatabaseUpgrader alloc] initWithSqliteDatabase:database]);
}

- (void) dealloc
{
	GtRelease(m_database);
	GtSuperDealloc();
}

- (NSUInteger) calculateTotalStepCount
{
	return [m_database tableCount];
}

- (void) doExecuteTask
{
	self.taskName = NSLocalizedString(@"Upgrading Database", nil);
	
	NSArray* tableNames = [self.database selectTableNames];
	for(NSString* internalTableName in tableNames)
	{
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		@try 
		{
			if(![[GtSqliteDatabaseVersioner instance] isVersionTableName:internalTableName])
			{
				NSDictionary* tableInfoList = [self.database loadTableDetailsForTableName:internalTableName];
				NSString* className = GtSqliteNameDecode(internalTableName);
				
				GtSqliteTable* table = [NSClassFromString(className) sharedSqliteTable];
				if(table)
				{				
#if GT_LEGACY_DB_ENCODING
					if([self _renameColumnsInTableIfNeeded:table tableInfoList:tableInfoList])
					{
						// need to reload current info after rename.
						tableInfoList = [self.database loadTableDetailsForTableName:internalTableName];
					}
#endif			
					[self _updateTableSchema:table tableInfoList:tableInfoList];
				}
			}
		
			GtDrainPool(&pool);
		}
		@catch(NSException* ex)
		{
			GtDrainPoolAndRethrow(&pool, ex);
		}
		
		[self incrementStep];
	}
	
	[[GtSqliteDatabaseVersioner instance] writeCurrentAppVersionToDatabase:self.database];

}

- (void) _updateTableSchema:(GtSqliteTable*) table tableInfoList:(NSDictionary*) tableInfoList
{
	BOOL foundDifference = YES;
	NSDictionary* history = [self.database historyForName:table.tableName];
	if(history)
	{
		NSString* expected = [table createTableSqlWithIndexes];
		foundDifference = !GtStringsAreEqual(expected, [history objectForKey:GtSqliteNameEncode(@"entry")]);
	}
	
	if(foundDifference)
	{
		GtLog(@"upgrading table: %@", table.tableName);
	
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
				
				GtLog(@"Table upgraded ok: %@", table.tableName);
			}
			@catch(NSException* ex)
			{
				[self.database exec:@"ROLLBACK"];
			}
		}

	}
}


#if GT_LEGACY_DB_ENCODING


- (BOOL) _renameColumnsInTableIfNeeded:(GtSqliteTable*) table
		tableInfoList:(NSDictionary*) tableInfoList
{
	BOOL needsToRenameColumns = NO;
	
	for(NSString* colName in tableInfoList)
	{
		if(!GtSqliteIsInternalNameEncoded(colName))
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
			NSString* encodedName = GtSqliteNameEncode(colName);
			
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
			
			if([table.columns objectForKey:encodedName] /*|| [table.columns objectForKey:GtSqlDatabaseInternalNameDecode(colName)]*/)
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
			
			GtSqliteColumn* col = [table.columns objectForKey:columnName];
			
			NSString* constraints = col.columnConstraintsAsString;

			BOOL isPrimaryKey = [constraints rangeOfString:@"PRIMARY KEY"].length > 0;
			BOOL isNotNull = [constraints rangeOfString:@"NOT NULL"].length > 0;
			
			if([pk boolValue] != isPrimaryKey || [notnull boolValue] != isNotNull)
			{
				foundDifference = YES;
			}
			
			if(!GtStringsAreEqual(type, GtSqliteTypeToString(col.columnType)))
			{
				foundDifference = YES;
			}
		}
		else 
		{
			foundDifference = YES;
#if DEBUG
			GtLog(@"will add column: %@", columnName);
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
				GtLog(@"will delete column: %@", colName);
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
	
		
		for(GtSqliteColumn* column in table.columns.objectEnumerator)
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
				
				GtLog(@"index count changed for column: %@", column.columnName);
			}

			// TODO: do a better job of comparing 
		
		}
	}
#endif