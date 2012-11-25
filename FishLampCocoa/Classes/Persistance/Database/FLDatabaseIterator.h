//
//  FLDatabaseIteratorIterator.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLDatabaseColumn.h"
#import "FLSqlBuilder.h"
#import "FLDatabaseColumnDecoder.h"

@class FLDatabase;
@class FLDatabaseTable;

@interface FLDatabaseIterator : FLSqlBuilder {
@private
    FLDatabase* _database;
    FLDatabaseTable* _table;
	sqlite3_stmt* _statement;
	NSInteger _stepValue;
	NSDictionary* _lastRow;
	FLDatabaseColumnDecoder _columnDecoder;
}

- (id) initWithDatabase:(FLDatabase*) database table:(FLDatabaseTable*) table;

+ (id) databaseIterator:(FLDatabase*) database table:(FLDatabaseTable*) table;

@property (readonly, assign, nonatomic) sqlite3_stmt* statement;

@property (readonly, strong, nonatomic) FLDatabase* database;
@property (readonly, strong, nonatomic) FLDatabaseTable* table;

@property (readonly, assign, nonatomic) NSInteger stepValue; // last SQLLITE value from step.
@property (readonly, strong, nonatomic) NSDictionary* lastRow;

- (void) resetStatement;

- (void) execute;

- (void) execute:(void (^)(NSDictionary* row, BOOL* stop)) resultRow;

- (void) execute:(void (^)(NSDictionary* row, BOOL* stop)) resultRow
          failed:(void (^)(NSError* ex)) failed;


@end

@interface FLDatabaseIterator (Sql)
- (BOOL) appendWhereClauseForSelectingObject:(id) object;
@end

@interface FLDatabaseIterator (Binding)

- (NSDictionary*) filterColumnsForObject:(id) object
                                  filter:(void (^)(FLDatabaseColumn* column, BOOL* useIt, BOOL* cancel)) filter;

- (void) bindBlob:(int) parameterIndex data:(NSData*) data;
- (void) bindZeroBlob:(int) parameterIndex size:(int) size;
- (void) bindDouble:(int) parameterIndex doubleValue:(double) aDouble;
- (void) bindInt:(int) parameterIndex intValue:(int) aInt;
- (void) bindInt64:(int) parameterIndex intValue:(sqlite3_int64) aInt;
- (void) bindNull:(int) parameterIndex;
- (void) bindText:(int) parameterIndex text:(NSString*) text; // encodes as utf8

- (int) bindParameterCount;
- (const char *) bindParameterName:(int) idx;
- (int) bindParameterIndex:(const char*) zName;

- (void) clearBindings;
@end

@interface FLDatabaseIterator (Decoding)
- (NSNumber*) integerForColumn:(int) col;
- (NSNumber*) doubleForColumn:(int) col;
- (NSData*) blobForColumn:(int) col;
- (NSString*) textForColumn:(int) col;
@end

@interface FLDatabaseIterator (ComplexSelect)

// will throw error on failure
- (void) selectRows:(void (^)(BOOL* stop)) prepareStatement
       didSelectRow:(void (^)(NSDictionary* row, BOOL* stop)) didSelectRow
          didFinish:(void (^)()) didFinish;
          
- (void) selectObjects:(void (^)(BOOL* stop)) prepareSqlQuery
       didSelectObject:(void (^)(id object, BOOL* stop)) didSelectObject
             didFinish:(void (^)()) didFinishBlock;

@end

@interface NSObject (FLDatabaseIterator)
- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex;
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data;
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string;
+ (FLDatabaseType) sqlType;
@end

// returns NO if there is no data in the object to bind to, e.g. search would result in no rows
// this uses the FLSqlTable and keyValue coding to get the values for the search for primary keys
// and indexes.
//- (BOOL) bindAndPrepareStatementForSelect:(NSString*) sqlStatement forObject:(id) forObject;

//- (void) bindAndPrepareStatementForWrite:(NSString *)sqlStatement forObject:(id) object;
