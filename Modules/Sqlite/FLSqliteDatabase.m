//
//  FLSqliteDatabase.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSqliteDatabase.h"
#import "NSFileManager+FLExtras.h"


@implementation FLSqliteDatabase

@synthesize sqlite3 = _database;
@synthesize filePath = _filePath;
@synthesize historyTable = _historyTable;

- (id) initWithFilePath:(NSString*) filePath
{
	if((self = [super init]))
	{
		_filePath = FLReturnRetained(filePath);
		_database = nil;

		_historyTable = [[FLSqliteTable alloc] initWithTableName:@"history"];
		
		[_historyTable addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"name" 
			columnType:FLSqliteTypeText 
			columnConstraints:[NSArray arrayWithObject:[FLSqliteColumn primaryKeyConstraint]]]];

		[_historyTable addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"entry" 
			columnType:FLSqliteTypeText 
			columnConstraints:nil]];

		[_historyTable addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"written_date" 
			columnType:FLSqliteTypeDate 
			columnConstraints:nil]];

	}
	
	return self;
}

- (void) dealloc
{
	FLAssertIsNil(_database);
	FLRelease(_filePath);
	FLRelease(_historyTable);
	FLSuperDealloc();
}

- (void) deleteOnDisk
{
	NSError* error = nil;
	[[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:&error];
	        if(error)
        {
            FLThrowError(FLReturnAutoreleased(error));
        }

}

- (BOOL) databaseFileExistsOnDisk
{
	return [[NSFileManager defaultManager] fileExistsAtPath:[self filePath]];
}

- (unsigned long long) databaseFileSize
{
	unsigned long long size = 0;
	NSError* error = nil;
	[NSFileManager getFileSize:self.filePath outSize:&size outError:&error];
	        if(error)
        {
            FLThrowError(FLReturnAutoreleased(error));
        }

	return size;
}

- (void) cancelCurrentOperation
{
	if(_database)
	{
		@synchronized(self) {
			sqlite3_interrupt(_database);
		}
	}
}

- (void) purgeMemoryIfPossible
{
	@synchronized(self) {
		sqlite3_release_memory(INT32_MAX);
	}
}

- (void) exec:(NSString*) sql
{	
	@synchronized(self) {
		const char* c_sql = [sql UTF8String];
		if(sqlite3_exec(_database, c_sql, NULL, NULL, nil))
		{
			[self throwSqliteError:c_sql];
		}	
	}
}

- (BOOL) isOpen
{
	return _database != nil;
}

- (void) openDatabase:(FLSqliteDatabaseOpenFlags) flags
{
	if(_database != nil) {
        FLThrowErrorCode( 
            FLSqliteDatabaseErrorDomain, 
            FLSqliteDatabaseErrorDatabaseAlreadyOpen, 
            @"Database is already open");
    }
	
	@synchronized(self) 
	{
		if(sqlite3_open_v2([_filePath UTF8String], &_database, flags, nil))
		{
			[self throwSqliteError:nil];
		}
	}
}

- (void) forgetTables
{
	FLReleaseWithNil(_tables);
}

- (void) closeDatabase 
{
	if(_database == nil) {
        FLThrowErrorCode( 
            FLSqliteDatabaseErrorDomain, 
            FLSqliteDatabaseErrorDatabaseAlreadyOpen, 
            @"Database is already closed");
    }

	@synchronized(self) {
		if(sqlite3_close(_database))
		{
			[self throwSqliteError:nil];
		}
		
		_database = nil;
		FLReleaseWithNil(_tables);
	}
}

- (void) throwSqliteError:(const char*) sql
{
	FLThrowError([NSError sqliteError:_database sql:sql]);
}

- (void) runQueryNonAtomic:(FLSqliteStatement*) statement outRows:(NSArray**) outRows
{
	NSMutableArray* columns = nil;
	@try
	{
		while(statement.willStep)
		{
			NSDictionary* row = [statement step];
			if(row && row.count)
			{
				if(!columns)
				{
					columns = [[NSMutableArray alloc] init];
				}
			
				[columns addObject:row];
			}
		}
		
		if(outRows)
		{
			*outRows = FLReturnRetained(columns);
		}
	}
	@finally
	{
		[statement finalizeStatement];
		FLRelease(columns);
	}
}

- (void) runQueryWithString:(NSString*) statementString outRows:(NSArray**) outRows
{
	[self runQueryWithString:statementString outRows:outRows columnDecoder:nil];
}

- (void) runQueryWithString:(NSString*) statementString outRows:(NSArray**) outRows columnDecoder:(FLSqliteColumnDecoder) columnDecoder
{
	@synchronized(self) {
		FLSqliteStatement* statement = [FLSqliteStatement sqliteStatement:self];
		if(columnDecoder)
		{
			statement.columnDecoder = columnDecoder;
		}
		[statement prepareStatement:statementString];
		[self runQueryNonAtomic:statement outRows:outRows];
	}
}

- (NSArray*) selectTableNames
{
	NSArray* rows = nil; 
	[self runQueryWithString:@"SELECT name FROM sqlite_master WHERE type='table'" outRows:&rows];
	
	NSMutableArray* outArray = [NSMutableArray arrayWithCapacity:rows.count];
	for(NSDictionary* row in rows)
	{	
		NSString* name = [row objectForKey:@"name"];
		if(name)
		{
			[outArray addObject:name];
		}
	}
	FLRelease(rows);
	
	return outArray;
}

- (NSDictionary*) loadTableDetailsForTableName:(NSString*) tableName
{
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA table_info(%@)", tableName] outRows:&rows];
	
	NSMutableDictionary* info = [NSMutableDictionary dictionary];
	for(NSDictionary* row in rows)
	{
		[info setObject:row forKey:[row objectForKey:@"name"]];
	}
	FLRelease(rows);
	
	return info;
}

- (NSArray*) indexesForTableName:(NSString*) tableName
{
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA index_list(%@)", tableName] outRows:&rows];
	return FLReturnAutoreleased(rows);
}

- (NSArray*) indexDetailsForIndex:(NSString*) indexName
{
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA index_info(%@)", indexName] outRows:&rows];
	return FLReturnAutoreleased(rows);
}

- (NSUInteger) rowCountForTableByName:(NSString*) table
{
	@synchronized(self) {
	
		FLSqliteStatement* statement = [FLSqliteStatement sqliteStatement:self];
		@try {
			[statement prepareStatement:
				[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@", table]];

			while(statement.willStep)
			{
				NSDictionary* row = [statement step];
				if(row)
				{	
					NSNumber* number = [row objectForKey:@"COUNT(*)"];
					if(number)
					{	 
						return [number integerValue];
					}
				}
			}
		}
		@catch(NSException* ex) {
			if(ex.error.isTableDoesNotExistError)
			{
				return 0;
			}
			@throw;
		}
		@finally {
			[statement finalizeStatement];
		}
	}
	return 0;
}

- (BOOL) tableExistsByName:(NSString*) tableName
{
	FLAssertStringIsNotEmpty(tableName);
	
	@synchronized(self) {	 
		
		FLSqliteStatement* statement = [FLSqliteStatement sqliteStatement:self];
		
		@try {
			[statement prepareStatement:
				[NSString stringWithFormat:@"SELECT name FROM sqlite_master WHERE name='%@'", tableName]];
			
			while(statement.willStep)
			{
				NSDictionary* row = [statement step];
				if(row && row.count && FLStringsAreEqual([row objectForKey:@"name"], tableName))
				{
					return YES;
				}
			}
		}
		@finally {
			[statement finalizeStatement];
		}
	}
	
	return NO;
}

- (void) dropTableByName:(NSString*) tableName
{
	FLAssertStringIsNotEmpty(tableName);

	@try 
	{
		[self exec:[NSString stringWithFormat:@"DROP TABLE %@", tableName]];
	}
	@catch(NSException* ex)
	{
		if(!ex.error.isTableDoesNotExistError)
		{
			@throw;
		}
	}
	
	[_tables removeObject:tableName];
}

- (void) _insertOrUpdateRowInTable:(NSString*) tableName row:(NSDictionary*) row action:(NSString*) action
{
	NSMutableString* sql = [NSMutableString stringWithFormat:@"%@ INTO %@ (", action, tableName];
	NSMutableString* values = [NSMutableString string];

	int itemCount = 0;
	for(NSString* colName in row)
	{
		if(itemCount++ == 0)
		{	
			[values appendString:@"?"];
			[sql appendString:colName];
		}
		else
		{
			[values appendString:@", ?"];
			[sql appendFormat:@", %@", colName]; 
		}
	}

	[sql appendFormat:@") VALUES (%@);", values];

	@synchronized(self) {
		
		FLSqliteStatement* statement = [FLSqliteStatement sqliteStatement:self];
		[statement prepareStatement:sql];
		int idx = 0;
		for(NSString* colName in row)
		{
			[[row objectForKey:colName] bindToStatement:statement parameterIndex:++idx];
		}
		[self runQueryNonAtomic:statement outRows:nil];
	}
}

- (void) updateRowInTable:(NSString*) tableName 
			          row:(NSDictionary*) row  
{
	[self _insertOrUpdateRowInTable:tableName row:row action:@"REPLACE"];
}

- (void) insertRowInTable:(NSString*) tableName 
			          row:(NSDictionary*) row 
{
	[self _insertOrUpdateRowInTable:tableName row:row action:@"INSERT"];
}

- (void) insertOrUpdateRowInTable:(NSString*) tableName row:(NSDictionary*) row
{
	[self _insertOrUpdateRowInTable:tableName row:row action:@"INSERT OR REPLACE"];
}



//- (void) addColumnsToTable:(FLSqliteTable*) table newColumns:(NSDictionary*) newColumns
//{
//	NSMutableString* sqlBuilder = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ", FLSqlDatabaseInternalNameEncode(table.tableName)]; 
//	int i = 0;
//	for(FLDataType* col in newColumns.objectEnumerator)
//	{			 
//		[sqlBuilder appendFormat:@"%@ADD COLUMN %@ %@", (i++ > 0 ? @", " : @""), FLSqlDatabaseInternalNameEncode(col.key), SqlTypeFromFLType(col)];
//	}
//
//	@synchronized(_sqlDatabase) {
//		[_sqlDatabase exec:sqlBuilder];
//
//		NSArray* indexes = [self _indexesForTableName:FLSqlDatabaseInternalNameEncode(table.tableName) columnsToIndex:newColumns];
//		for(NSString* createIndex in indexes)
//		{
//			[_sqlDatabase exec:createIndex];
//		}
//	}
//}

- (void) writeHistoryForName:(NSString*) name entry:(NSString*) entry
{
	[self createTableIfNeeded:self.historyTable];

	NSDictionary* row = [NSDictionary dictionaryWithObjectsAndKeys:name, FLSqliteNameEncode(@"name"), entry, FLSqliteNameEncode(@"entry"), [NSDate date], FLSqliteNameEncode(@"written_date"), nil];
	[self insertOrUpdateRowInTable:self.historyTable.tableName row:row];
}

- (NSDictionary*) historyForName:(NSString*) name
{
	NSArray* rows = nil;
	[self createTableIfNeeded:self.historyTable];

	[self runQueryWithString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@='%@'", 
		self.historyTable.tableName,
		FLSqliteNameEncode(@"name"),
		name]
		outRows:&rows];
		
	return rows.count == 1 ? rows.firstObject : nil;
}

- (void) appendHistoryEntryToString:(NSMutableString*) string entry:(NSString*) entry
{
	if(string.length)
	{
		[string appendFormat:@"; %@", entry];
	}
	else
	{
		[string appendString:entry];
	}
}

- (void) beginAsyncBlock:(void(^)(FLSqliteDatabase*)) asyncBlock
              errorBlock:(void(^)(FLSqliteDatabase*, NSError*)) errorBlock;
{
    asyncBlock = FLReturnAutoreleased([asyncBlock copy]);
    errorBlock = FLReturnAutoreleased([errorBlock copy]);

    dispatch_async(
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
        ^{
            @try {
                if(asyncBlock) {
                    asyncBlock(self);
                }
            }
            @catch(NSException* ex) {
                if(errorBlock) {
                    errorBlock(self, ex.error); 
                }
            }
        });
}                       


@end

@implementation FLSqliteDatabase (Tables)

- (NSUInteger) tableCount
{
	@synchronized(self) {
		FLSqliteStatement* statement = [FLSqliteStatement sqliteStatement:self];
		@try {
			[statement prepareStatement:@"SELECT COUNT(*) FROM sqlite_master WHERE type='table'"];

			while(statement.willStep)
			{
				NSDictionary* row = [statement step];
				if(row)
				{	
					NSNumber* number = [row objectForKey:@"COUNT(*)"];
					if(number)
					{	 
						return [number integerValue];
					}
				}
			}
		}
		@finally {
			[statement finalizeStatement];
		}
	}
	return 0;
}


- (void) createTableIfNeeded:(FLSqliteTable*) table 
{
	FLAssertIsNotNil(table);
	FLAssertIsNotNil(table.columns);
	FLAssert([table.columns count] > 0, @"no columns in the table, bub");
   
	FLAssert([self isOpen], @"Database isn't open");
	
//	@synchronized(self) 
	{
		if(!_tables)
		{
			_tables = [[NSMutableSet alloc] init];
		}
		
		if(![_tables containsObject:table.tableName] && ![self tableExists:table])
		{
			@try {
//				[self exec:@"BEGIN TRANSACTION"];
				
				[self exec:[table createTableSql]];
				for(NSArray* indexes in table.indexes.objectEnumerator)
				{
					for(FLSqliteIndex* idx in indexes)
					{
						NSString* createIndex = [idx createIndexSqlForTableName:table.tableName];
						
						if(FLStringIsNotEmpty(createIndex))
						{
							[self exec:createIndex];
						}
					}
				}
				
				[_tables addObject:table.tableName];
				[self writeHistoryForName:table.tableName entry:[table createTableSqlWithIndexes]];
				
//				[self exec:@"COMMIT"];
				
			}
			@catch(NSException* ex)
			{
//				[self exec:@"ROLLBACK"];
				@throw;
			}

		}
	}
}

- (void) dropTable:(FLSqliteTable*) table
{
	[self dropTableByName:table.tableName];
}

- (BOOL) tableExists:(FLSqliteTable*) table
{
	return [self tableExistsByName:table.tableName];
}

- (NSUInteger) rowCountForTable:(FLSqliteTable*) table
{
	[self createTableIfNeeded:table];

	return [self rowCountForTableByName:table.tableName];
}

@end






