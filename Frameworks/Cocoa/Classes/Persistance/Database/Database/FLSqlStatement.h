//
//  FLSqlStatement.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLDatabase.h"
#import "FLSqlBuilder.h"

@interface FLSqlStatement : NSObject {
@private
    FLDatabase* _database;
	sqlite3_stmt* _sqlite3_stmt;
    FLDecodeColumnObjectBlock _columnDecoder;
    int _stepValue;
}

- (id) initWithDatabase:(FLDatabase*) database columnDecoder:(FLDecodeColumnObjectBlock) columnDecoder;
+ (id) sqlStatement:(FLDatabase*) database columnDecoder:(FLDecodeColumnObjectBlock) columnDecoder;

// iterating
@property (readonly, assign) int stepValue;
@property (readonly, assign) BOOL isDone;

- (void) prepareWithSql:(FLSqlBuilder*) sql;
- (NSDictionary*) step;
- (void) finalizeStatement;
- (void) resetStatement;

// column objects
@property (readonly, assign) int columnCount;
- (NSString*) nameForColumn:(int) column;
- (int) typeForColumn:(int) column;
- (NSNumber*) integerForColumn:(int) col;
- (NSNumber*) doubleForColumn:(int) col;
- (NSData*) blobForColumn:(int) col;
- (NSString*) textForColumn:(int) col;

// raw sql columns
- (const void *) column_blob:(int) columnIndex;
- (int) column_bytes:(int) columnIndex;
- (int) column_bytes16:(int) columnIndex;
- (double) column_double:(int) columnIndex;
- (int) column_int:(int) columnIndex;
- (sqlite3_int64) column_int64:(int) columnIndex;
- (const unsigned char*) column_text:(int) columnIndex;
- (const void *) column_text16:(int) columnIndex;
- (int) column_type:(int) columnIndex;
- (sqlite3_value*) column_value:(int) columnIndex;

// binding
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

@interface NSObject (FLSqlStatement)
- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex;
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data;
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string;
+ (FLDatabaseType) sqlType;
@end