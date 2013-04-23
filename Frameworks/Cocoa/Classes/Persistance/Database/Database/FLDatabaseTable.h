//
//  FLDatabaseTable.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

@class FLDatabase;
@class FLDatabaseTable;

#import "FLDatabaseColumn.h"
#import "FLDatabaseIndex.h"
#import "FLSqlBuilder.h"
#import "FLDatabaseColumnDecoder.h"
#import "FLDatabaseStatement.h"
#import "FLObjectDescriber.h"

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

- (id) initWithTableName:(NSString*) tableName;
- (id) initWithClass:(Class) aClass;

+ (id) databaseTableWithTableName:(NSString*) tableName;
+ (id) databaseTableWithClass:(Class) aClass;

//
// columns
//
@property (readwrite, copy, nonatomic) NSDictionary* columns;
@property (readonly, strong, nonatomic) NSArray* primaryKeyColumns;
@property (readonly, strong, nonatomic) NSArray* indexedColumns;

- (void) addColumn:(FLDatabaseColumn*) column;

- (void) setColumn:(FLDatabaseColumn*) column
     forColumnName:(NSString*) columnName;

- (void) removeColumnWithName:(NSString*) name;

- (FLDatabaseColumn*) columnByName:(NSString*) name;

- (FLDatabaseColumn*) columnForPropertySelector:(SEL) selector; 
//
// indexes
//
@property (readwrite, copy, nonatomic) NSDictionary* indexes;

- (void) addIndex:(FLDatabaseIndex*) databaseIndex;

- (NSArray*) indexesForColumn:(NSString*) columnName;

//
// sql
//

- (NSString*) createTableSql;

- (NSString*) createTableSqlWithIndexes;

//
// object interaction 
//

- (NSDictionary*) valuesForColumns:(NSArray*) columns inObject:(id) object;

- (NSDictionary*) propertyValuesForObject:(id) object
                         withColumnFilter:(void (^)(FLDatabaseColumn* column, BOOL* useIt, BOOL* cancel)) filter;

- (id) objectForRow:(NSDictionary*) row;

@end

@protocol FLDatabaseStorable <NSObject>
@optional

+ (NSString*) databaseTableName; // returns NSStringFromClass(self) by default.

+ (FLDatabaseTable*) sharedDatabaseTable;
- (FLDatabaseTable*) databaseTable;

+ (void) databaseTableWillAddColumns:(FLDatabaseTable*) table;
+ (void) databaseTable:(FLDatabaseTable*) table willAddDatabaseColumn:(FLDatabaseColumn*) column;
+ (void) databaseTableDidAddColumns:(FLDatabaseTable*) table;
+ (void) databaseTableWasCreated:(FLDatabaseTable*) table;
@end


@interface NSObject (FLDatabaseTable) 
+ (NSString*) databaseTableName; // returns NSStringFromClass(self) by default.

+ (FLDatabaseTable*) sharedDatabaseTable;
- (FLDatabaseTable*) databaseTable;

+ (void) databaseTableWillAddColumns:(FLDatabaseTable*) table;
+ (void) databaseTable:(FLDatabaseTable*) table willAddDatabaseColumn:(FLDatabaseColumn*) column;
+ (void) databaseTableDidAddColumns:(FLDatabaseTable*) table;
+ (void) databaseTableWasCreated:(FLDatabaseTable*) table;
@end

@interface FLSqlBuilder (FLSqlTable)
- (BOOL) appendWhereClauseForSelectingObject:(id) object;
- (void) appendInsertClauseForObject:(id) object;
@end