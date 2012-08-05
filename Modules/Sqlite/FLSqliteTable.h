//
//  FLSqliteTable.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLSqlite.h"
#import "FLSqliteColumn.h"
#import "FLSqliteIndex.h"

@interface FLSqliteTable : NSObject<NSCopying> {
@private
	NSString* _tableName;
	NSString* _decodedTableName;
	
	NSMutableDictionary* _columns;
	NSMutableDictionary* _indexes;
	Class _tableClass;
}

@property (readwrite, retain, nonatomic) NSString* tableName;
@property (readonly, retain, nonatomic) NSString* decodedTableName;
@property (readonly, assign, nonatomic) Class classRepresentedByTable;

@property (readwrite, copy, nonatomic) NSDictionary* columns;
@property (readwrite, copy, nonatomic) NSDictionary* indexes;

- (void) addColumn:(FLSqliteColumn*) column;
- (void) setColumn:(FLSqliteColumn*) column forColumnName:(NSString*) columnName;

- (void) addIndex:(FLSqliteIndex*) sqliteIndex;
- (NSArray*) indexesForColumn:(NSString*) columnName;

- (void) removeColumnWithName:(NSString*) name;
- (FLSqliteColumn*) columnByName:(NSString*) name;

- (NSString*) createTableSql;

- (id) initWithTableName:(NSString*) tableName;

+ (FLSqliteTable*) sqliteTableWithTableName:(NSString*) tableName;

- (id) initWithClass:(Class) aClass;

- (id) sqliteTableWithClass:(Class) aClass;

- (NSString*) createTableSqlWithIndexes;

@end

@interface NSObject (FLSqliteTable) 

+ (FLSqliteTable*) sharedSqliteTable;
+ (NSString*) sqliteTableName; // returns NSStringFromClass(self) by default.

@end
