//
//  GtSqliteDatabase.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

/** 
	Abstraction for SqlDatabase that doesn't take a dependency on the rest of FishLamp.
*/

#import <Foundation/Foundation.h>

#import "GtSqlite.h"
#import "GtSqliteStatement.h"
#import "GtSqliteTable.h"
#import "NSError+Sqlite.h"

@class GtSqliteStatement;

@interface GtSqliteDatabase : NSObject {
@private
	sqlite3* m_database;
	NSString* m_filePath;
	NSMutableSet* m_tables;
	GtSqliteTable* m_historyTable;
}


/// returns path to db file
@property (readonly, retain, nonatomic) NSString* filePath;

/// returns point to sqlite3 reference
@property (readonly, assign, nonatomic) sqlite3* sqlite3;

/// returns YES is db is open
@property (readonly, assign, nonatomic) BOOL isOpen;

/// Initialize database object. This doesn't open the db.
- (id) initWithFilePath:(NSString*) filePath;

/// Deletes the .sqlite file on disk.
- (void) deleteOnDisk;

/// Returns true if file exists on disk 
- (BOOL) databaseFileExistsOnDisk;

///	Size of file on disk 
- (unsigned long long) databaseFileSize;

/// Open the database. Use the flags to specify the behavior, for example: @see GtSqliteDatabaseOpenFlagsDefault
- (void) openDatabase:(GtSqliteDatabaseOpenFlags) flags;

/// Close the database
- (void) closeDatabase;

/// Will cancel the current operation
- (void) cancelCurrentOperation; 

/// Exec a command. Threadsafe.
- (void) exec:(NSString*) sql;

// be sure to lock the database, e.g. @synchronized(myDatabase), before calling these
// note that runQueryNonAtomic will call finalizeStatement on statement, even if there is an exception.
- (void) runQueryNonAtomic:(GtSqliteStatement*) statement outRows:(NSArray**) outRows;

// runs the queury and dumps the resulting rows into the array
// just here for convienience.
- (void) runQueryWithString:(NSString*) statement outRows:(NSArray**) outRows;
- (void) runQueryWithString:(NSString*) statement outRows:(NSArray**) outRows columnDecoder:(GtSqliteColumnDecoder) columnDecoder;

- (NSUInteger) rowCountForTableByName:(NSString*) tableName;
- (BOOL) tableExistsByName:(NSString*) tableName;
- (void) dropTableByName:(NSString*) tableName;

- (void) purgeMemoryIfPossible;

- (void) insertOrUpdateRowInTable:(NSString*) tableName 
						row:(NSDictionary*) row;
- (void) insertRowInTable:(NSString*) tableName 
			          row:(NSDictionary*) row;
- (void) updateRowInTable:(NSString*) tableName 
			          row:(NSDictionary*) row;

@property (readonly, retain, nonatomic) GtSqliteTable* historyTable;
- (void) writeHistoryForName:(NSString*) name entry:(NSString*) entry;
- (NSDictionary*) historyForName:(NSString*) name;

- (void) throwSqliteError:(const char*) sql;
					  
@end

@interface GtSqliteDatabase (Introspection)
//
// useful commands
// see http://sqlite.org/pragma.html#pragma_index_list
//

// This returns info from PRAGMA table_info
- (NSDictionary*) loadTableDetailsForTableName:(NSString*) tableName; // keys are columnname strings.

- (NSArray*) indexesForTableName:(NSString*) tableName;
- (NSArray*) indexDetailsForIndex:(NSString*) indexName;

/// returns array populated with all the names of the tables in the database.
- (NSArray*) selectTableNames;

/// returns total count of tables in database
- (NSUInteger) tableCount;

@end

@interface GtSqliteDatabase (Tables)

/// if the table doesn't exist in the db, create it.
- (void) createTableIfNeeded:(GtSqliteTable*) table;

/// remove table from db
- (void) dropTable:(GtSqliteTable*) table;

/// does the table exist in the db?
- (BOOL) tableExists:(GtSqliteTable*) table;

/// returns row count for this table
- (NSUInteger) rowCountForTable:(GtSqliteTable*) table;

@end




