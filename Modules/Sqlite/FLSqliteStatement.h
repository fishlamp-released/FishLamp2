//
//  FLSqliteStatementIterator.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLSqlite.h"
@class FLSqliteDatabase;

@interface FLSqliteStatement : NSObject {
@private
	__unsafe_unretained FLSqliteDatabase* _database;
	sqlite3_stmt* _statement;
	NSInteger _stepValue;
	NSDictionary* _lastRow;
	__unsafe_unretained FLSqliteColumnDecoder _columnDecoder;
}

- (id) initWithSqliteDatabase:(FLSqliteDatabase*) database;

+ (FLSqliteStatement*) sqliteStatement:(FLSqliteDatabase*) database;

@property (readwrite, assign, nonatomic) FLSqliteColumnDecoder columnDecoder;

@property (readonly, assign, nonatomic) sqlite3_stmt* statement;
@property (readonly, assign, nonatomic) FLSqliteDatabase* database;

@property (readonly, assign, nonatomic) NSInteger stepValue; // last SQLLITE value from step.
@property (readonly, retain, nonatomic) NSDictionary* lastRow;

- (void) prepareStatement:(NSString*) sqlStatement;

@property (readonly, assign, nonatomic) BOOL willStep;

- (NSDictionary*) step;

- (void) finalizeStatement; // automatically called when done stepping. be sure to call this if you terminate early.
- (void) resetStatement;

@end

@interface FLSqliteStatement (Binding)
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

@interface FLSqliteStatement (Decoding)
- (NSNumber*) integerForColumn:(int) col;
- (NSNumber*) doubleForColumn:(int) col;
- (NSData*) blobForColumn:(int) col;
- (NSString*) textForColumn:(int) col;
@end

@interface NSObject (FLSqlite)
- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex;
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data;
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string;
+ (FLSqliteType) sqlType;
@end

extern FLSqliteColumnDecoder s_default_decoder;