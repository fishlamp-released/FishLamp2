//
//  GtSqliteTable.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtSqlite.h"
#import "GtSqliteColumn.h"
#import "GtSqliteIndex.h"

@interface GtSqliteTable : NSObject<NSCopying> {
@private
	NSString* m_tableName;
	NSString* m_decodedTableName;
	
	NSMutableDictionary* m_columns;
	NSMutableDictionary* m_indexes;
	Class m_tableClass;
}

@property (readwrite, retain, nonatomic) NSString* tableName;
@property (readonly, retain, nonatomic) NSString* decodedTableName;
@property (readonly, assign, nonatomic) Class classRepresentedByTable;

@property (readwrite, copy, nonatomic) NSDictionary* columns;
@property (readwrite, copy, nonatomic) NSDictionary* indexes;

- (void) addColumn:(GtSqliteColumn*) column;
- (void) setColumn:(GtSqliteColumn*) column forColumnName:(NSString*) columnName;

- (void) addIndex:(GtSqliteIndex*) sqliteIndex;
- (NSArray*) indexesForColumn:(NSString*) columnName;

- (void) removeColumnWithName:(NSString*) name;
- (GtSqliteColumn*) columnByName:(NSString*) name;

- (NSString*) createTableSql;

- (id) initWithTableName:(NSString*) tableName;

+ (GtSqliteTable*) sqliteTableWithTableName:(NSString*) tableName;

//- (id) initWithClass:(Class) aClass;

//- (id) sqliteTableWithClass:(Class) aClass;

- (NSString*) createTableSqlWithIndexes;

@end

@interface NSObject (GtSqliteTable) 

+ (GtSqliteTable*) sharedSqliteTable;
+ (NSString*) sqliteTableName; // returns NSStringFromClass(self) by default.

@end
