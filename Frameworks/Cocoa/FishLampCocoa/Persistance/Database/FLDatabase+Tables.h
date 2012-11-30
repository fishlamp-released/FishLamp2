//
//  FLDatabase+FLTables.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDatabase.h"
#import "FLDatabaseStatement.h"

@interface FLDatabase (FLTables)

/// does the table exist in the db?
- (BOOL) tableExists:(FLDatabaseTable*) table;

- (FLDatabaseTable*) tableForName:(NSString*) name;

/// if the table doesn't exist in the db, create it.
- (void) createTableIfNeeded:(FLDatabaseTable*) table;

/// remove table from db
- (void) dropTable:(FLDatabaseTable*) table;

/// returns row count for this table
- (NSUInteger) rowCountForTable:(FLDatabaseTable*) table;

// runs the queury and dumps the resulting rows into the array
// just here for convienience.
- (void) runQueryOnTable:(FLDatabaseTable*) table
              withString:(NSString*) statementString
                 outRows:(NSArray**) outRows;

- (NSUInteger) rowCountForTableByName:(NSString*) tableName;

- (BOOL) tableExistsByName:(NSString*) tableName;

- (void) dropTableByName:(NSString*) tableName;

- (void) insertOrReplaceRowInTable:(NSString*) tableName 
                               row:(NSDictionary*) row;

- (void) insertRowInTable:(NSString*) tableName
			          row:(NSDictionary*) row;

- (void) replaceRowInTable:(NSString*) tableName
			          row:(NSDictionary*) row;

@end
