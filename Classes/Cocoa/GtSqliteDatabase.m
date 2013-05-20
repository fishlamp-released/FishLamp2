//
//  GtSqliteDatabase.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSqliteDatabase.h"
#import "NSFileManager+GtExtras.h"


@implementation GtSqliteDatabase

@synthesize sqlite3 = m_database;
@synthesize filePath = m_filePath;
@synthesize historyTable = m_historyTable;

- (id) initWithFilePath:(NSString*) filePath
{
	if((self = [super init]))
	{
		m_filePath = GtRetain(filePath);
		m_database = nil;

		m_historyTable = [[GtSqliteTable alloc] initWithTableName:@"history"];
		
		[m_historyTable addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"name" 
			columnType:GtSqliteTypeText 
			columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];

		[m_historyTable addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"entry" 
			columnType:GtSqliteTypeText 
			columnConstraints:nil]];

		[m_historyTable addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"written_date" 
			columnType:GtSqliteTypeDate 
			columnConstraints:nil]];

	}
	
	return self;
}

- (void) dealloc
{
	GtAssertNil(m_database);
	GtRelease(m_filePath);
	GtRelease(m_historyTable);
	GtSuperDealloc();
}

- (void) deleteOnDisk
{
	NSError* error = nil;
	[[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:&error];
	        if(error)
        {
            GtThrowError(GtReturnAutoreleased(error));
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
            GtThrowError(GtReturnAutoreleased(error));
        }

	return size;
}

- (void) cancelCurrentOperation
{
	if(m_database)
	{
		@synchronized(self) {
			sqlite3_interrupt(m_database);
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
		if(sqlite3_exec(m_database, c_sql, NULL, NULL, nil))
		{
			[self throwSqliteError:c_sql];
		}	
	}
}

- (BOOL) isOpen
{
	return m_database != nil;
}

- (void) openDatabase:(GtSqliteDatabaseOpenFlags) flags
{
	GtFailIf(m_database != nil, 
		GtSqliteDatabaseErrorDomain, 
		GtSqliteDatabaseErrorDatabaseAlreadyOpen, 
		@"Database is already open");
	
	@synchronized(self) 
	{
		if(sqlite3_open_v2([m_filePath UTF8String], &m_database, flags, nil))
		{
			[self throwSqliteError:nil];
		}
	}
}

- (void) forgetTables
{
	GtReleaseWithNil(m_tables);
}

- (void) closeDatabase 
{
	GtFailIf(m_database == nil, 
		GtSqliteDatabaseErrorDomain, 
		GtSqliteDatabaseErrorDatabaseAlreadyOpen, 
		@"Database is already closed");

	@synchronized(self) {
		if(sqlite3_close(m_database))
		{
			[self throwSqliteError:nil];
		}
		
		m_database = nil;
		GtReleaseWithNil(m_tables);
	}
}

- (void) throwSqliteError:(const char*) sql
{

	GtThrowError([NSError sqliteError:m_database sql:sql]);
}

- (void) runQueryNonAtomic:(GtSqliteStatement*) statement outRows:(NSArray**) outRows
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
			*outRows = GtRetain(columns);
		}
	}
	@finally
	{
		[statement finalizeStatement];
		GtRelease(columns);
	}
}

- (void) runQueryWithString:(NSString*) statementString outRows:(NSArray**) outRows
{
	[self runQueryWithString:statementString outRows:outRows columnDecoder:nil];
}

- (void) runQueryWithString:(NSString*) statementString outRows:(NSArray**) outRows columnDecoder:(GtSqliteColumnDecoder) columnDecoder
{
	@synchronized(self) {
		GtSqliteStatement* statement = [GtSqliteStatement sqliteStatement:self];
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
	GtRelease(rows);
	
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
	GtRelease(rows);
	
	return info;
}

- (NSArray*) indexesForTableName:(NSString*) tableName
{
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA index_list(%@)", tableName] outRows:&rows];
	return GtAutorelease(rows);
}

- (NSArray*) indexDetailsForIndex:(NSString*) indexName
{
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA index_info(%@)", indexName] outRows:&rows];
	return GtAutorelease(rows);
}

- (NSUInteger) rowCountForTableByName:(NSString*) table
{
	@synchronized(self) {
	
		GtSqliteStatement* statement = [GtSqliteStatement sqliteStatement:self];
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
	GtAssertIsValidString(tableName);
	
	@synchronized(self) {	 
		
		GtSqliteStatement* statement = [GtSqliteStatement sqliteStatement:self];
		
		@try {
			[statement prepareStatement:
				[NSString stringWithFormat:@"SELECT name FROM sqlite_master WHERE name='%@'", tableName]];
			
			while(statement.willStep)
			{
				NSDictionary* row = [statement step];
				if(row && row.count && GtStringsAreEqual([row objectForKey:@"name"], tableName))
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
	GtAssertIsValidString(tableName);

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
	
	[m_tables removeObject:tableName];
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
		
		GtSqliteStatement* statement = [GtSqliteStatement sqliteStatement:self];
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



//- (void) addColumnsToTable:(GtSqliteTable*) table newColumns:(NSDictionary*) newColumns
//{
//	NSMutableString* sqlBuilder = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ", GtSqlDatabaseInternalNameEncode(table.tableName)]; 
//	int i = 0;
//	for(GtDataType* col in newColumns.objectEnumerator)
//	{			 
//		[sqlBuilder appendFormat:@"%@ADD COLUMN %@ %@", (i++ > 0 ? @", " : @""), GtSqlDatabaseInternalNameEncode(col.key), SqlTypeFromGtType(col)];
//	}
//
//	@synchronized(m_sqlDatabase) {
//		[m_sqlDatabase exec:sqlBuilder];
//
//		NSArray* indexes = [self _indexesForTableName:GtSqlDatabaseInternalNameEncode(table.tableName) columnsToIndex:newColumns];
//		for(NSString* createIndex in indexes)
//		{
//			[m_sqlDatabase exec:createIndex];
//		}
//	}
//}

- (void) writeHistoryForName:(NSString*) name entry:(NSString*) entry
{
	[self createTableIfNeeded:self.historyTable];

	NSDictionary* row = [NSDictionary dictionaryWithObjectsAndKeys:name, GtSqliteNameEncode(@"name"), entry, GtSqliteNameEncode(@"entry"), [NSDate date], GtSqliteNameEncode(@"written_date"), nil];
	[self insertOrUpdateRowInTable:self.historyTable.tableName row:row];
}

- (NSDictionary*) historyForName:(NSString*) name
{
	NSArray* rows = nil;
	[self createTableIfNeeded:self.historyTable];

	[self runQueryWithString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@='%@'", 
		self.historyTable.tableName,
		GtSqliteNameEncode(@"name"),
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

@end

@implementation GtSqliteDatabase (Tables)

- (NSUInteger) tableCount
{
	@synchronized(self) {
		GtSqliteStatement* statement = [GtSqliteStatement sqliteStatement:self];
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


- (void) createTableIfNeeded:(GtSqliteTable*) table 
{
	GtAssertNotNil(table);
	GtAssertNotNil(table);
	GtAssert([table.columns count] > 0, @"no columns");
   
	GtAssert([self isOpen], @"Database isn't open");
	
//	@synchronized(self) 
	{
		if(!m_tables)
		{
			m_tables = [[NSMutableSet alloc] init];
		}
		
		if(![m_tables containsObject:table.tableName] && ![self tableExists:table])
		{
			@try {
//				[self exec:@"BEGIN TRANSACTION"];
				
				[self exec:[table createTableSql]];
				for(NSArray* indexes in table.indexes.objectEnumerator)
				{
					for(GtSqliteIndex* idx in indexes)
					{
						NSString* createIndex = [idx createIndexSqlForTableName:table.tableName];
						
						if(GtStringIsNotEmpty(createIndex))
						{
							[self exec:createIndex];
						}
					}
				}
				
				[m_tables addObject:table.tableName];
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

- (void) dropTable:(GtSqliteTable*) table
{
	[self dropTableByName:table.tableName];
}

- (BOOL) tableExists:(GtSqliteTable*) table
{
	return [self tableExistsByName:table.tableName];
}

- (NSUInteger) rowCountForTable:(GtSqliteTable*) table
{
	[self createTableIfNeeded:table];

	return [self rowCountForTableByName:table.tableName];
}



@end



