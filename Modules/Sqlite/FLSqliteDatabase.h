//
//  FLSqliteDatabase.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

/** 
	Abstraction for SqlDatabase that doesn't take a dependency on the rest of FishLamp.
*/
#import "FishLampCocoa.h"

#import <Foundation/Foundation.h>

#import "FLSqlite.h"
#import "FLSqliteStatement.h"
#import "FLSqliteTable.h"
#import "NSError+Sqlite.h"

@class FLSqliteStatement;

@interface FLSqliteDatabase : NSObject {
@private
	sqlite3* _database;
	NSString* _filePath;
	NSMutableSet* _tables;
	FLSqliteTable* _historyTable;
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

/// Open the database. Use the flags to specify the behavior, for example: @see FLSqliteDatabaseOpenFlagsDefault
- (void) openDatabase:(FLSqliteDatabaseOpenFlags) flags;

/// Close the database
- (void) closeDatabase;

/// Will cancel the current operation
- (void) cancelCurrentOperation; 

/// Exec a command. Threadsafe.
- (void) exec:(NSString*) sql;

// be sure to lock the database, e.g. @synchronized(myDatabase), before calling these
// note that runQueryNonAtomic will call finalizeStatement on statement, even if there is an exception.
- (void) runQueryNonAtomic:(FLSqliteStatement*) statement outRows:(NSArray**) outRows;

// runs the queury and dumps the resulting rows into the array
// just here for convienience.
- (void) runQueryWithString:(NSString*) statement outRows:(NSArray**) outRows;
- (void) runQueryWithString:(NSString*) statement outRows:(NSArray**) outRows columnDecoder:(FLSqliteColumnDecoder) columnDecoder;

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

@property (readonly, retain, nonatomic) FLSqliteTable* historyTable;
- (void) writeHistoryForName:(NSString*) name entry:(NSString*) entry;
- (NSDictionary*) historyForName:(NSString*) name;

- (void) throwSqliteError:(const char*) sql;

- (void) beginAsyncBlock:(void(^)(FLSqliteDatabase*)) asyncBlock
              errorBlock:(void(^)(FLSqliteDatabase*, NSError*)) errorBlock;
					  
@end

@interface FLSqliteDatabase (Introspection)
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

@interface FLSqliteDatabase (Tables)

/// if the table doesn't exist in the db, create it.
- (void) createTableIfNeeded:(FLSqliteTable*) table;

/// remove table from db
- (void) dropTable:(FLSqliteTable*) table;

/// does the table exist in the db?
- (BOOL) tableExists:(FLSqliteTable*) table;

/// returns row count for this table
- (NSUInteger) rowCountForTable:(FLSqliteTable*) table;

@end




