//
//  FLDatabaseTable.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@class FLDatabase;
@class FLDatabaseTable;

#import "FLDatabaseColumn.h"
#import "FLDatabaseIndex.h"
#import "FLSqlBuilder.h"
#import "FLDatabaseColumnDecoder.h"
#import "FLDatabaseStatement.h"

@interface FLDatabaseTable : NSObject<NSCopying> {
@private
	NSString* _tableName;
	NSString* _decodedTableName;
	
	NSMutableDictionary* _columns;
	NSMutableDictionary* _indexes;
	Class _tableClass;
    FLDatabaseColumnDecoder _columnDecoder;
    
    NSArray* _primaryKeyColumns;
    NSArray* _indexedColumns;
}

@property (readwrite, assign, nonatomic) FLDatabaseColumnDecoder columnDecoder;

@property (readwrite, strong, nonatomic) NSString* tableName;
@property (readonly, strong, nonatomic) NSString* decodedTableName;
@property (readonly, assign, nonatomic) Class classRepresentedByTable;

@property (readwrite, copy, nonatomic) NSDictionary* columns;
@property (readwrite, copy, nonatomic) NSDictionary* indexes;

@property (readonly, strong, nonatomic) NSArray* primaryKeyColumns;
@property (readonly, strong, nonatomic) NSArray* indexedColumns;

- (void) addColumn:(FLDatabaseColumn*) column;

- (void) setColumn:(FLDatabaseColumn*) column
     forColumnName:(NSString*) columnName;

- (void) addIndex:(FLDatabaseIndex*) databaseIndex;

- (NSArray*) indexesForColumn:(NSString*) columnName;

- (void) removeColumnWithName:(NSString*) name;

- (FLDatabaseColumn*) columnByName:(NSString*) name;

- (NSString*) createTableSql;

- (id) initWithTableName:(NSString*) tableName;

+ (FLDatabaseTable*) databaseTableWithTableName:(NSString*) tableName;

- (id) initWithClass:(Class) aClass;

- (id) databaseTableWithClass:(Class) aClass;

- (NSString*) createTableSqlWithIndexes;

- (NSDictionary*) filterColumnsForObject:(id) object
                                  filter:(void (^)(FLDatabaseColumn* column, BOOL* useIt, BOOL* cancel)) filter;

- (id) objectForRow:(NSDictionary*) row;

@end

@interface NSObject (FLDatabaseTable) 
+ (FLDatabaseTable*) sharedDatabaseTable;
+ (NSString*) databaseTableName; // returns NSStringFromClass(self) by default.

- (FLDatabaseTable*) databaseTable;

- (NSDictionary*) valuesForColumns:(NSArray*) arrayOfColumns;

@end

@interface FLSqlBuilder (FLSqlTable)
- (BOOL) appendWhereClauseForSelectingObject:(id) object;
- (void) appendInsertClauseForObject:(id) object;
@end