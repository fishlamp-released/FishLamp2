//
//  GtSqliteStatementIterator.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtSqlite.h"
@class GtSqliteDatabase;

@interface GtSqliteStatement : NSObject {
@private
	GtSqliteDatabase* m_database;
	sqlite3_stmt* m_statement;
	NSInteger m_stepValue;
	NSDictionary* m_lastRow;
	GtSqliteColumnDecoder m_columnDecoder;
}

- (id) initWithSqliteDatabase:(GtSqliteDatabase*) database;

+ (GtSqliteStatement*) sqliteStatement:(GtSqliteDatabase*) database;

@property (readwrite, assign, nonatomic) GtSqliteColumnDecoder columnDecoder;

@property (readonly, assign, nonatomic) sqlite3_stmt* statement;
@property (readonly, assign, nonatomic) GtSqliteDatabase* database;

@property (readonly, assign, nonatomic) NSInteger stepValue; // last SQLLITE value from step.
@property (readonly, retain, nonatomic) NSDictionary* lastRow;

- (void) prepareStatement:(NSString*) sqlStatement;

@property (readonly, assign, nonatomic) BOOL willStep;

- (NSDictionary*) step;

- (void) finalizeStatement; // automatically called when done stepping. be sure to call this if you terminate early.
- (void) resetStatement;

@end

@interface GtSqliteStatement (Binding)
- (void) bindBlob:(NSUInteger) parameterIndex data:(NSData*) data;
- (void) bindZeroBlob:(NSUInteger) parameterIndex size:(int) size;
- (void) bindDouble:(NSUInteger) parameterIndex doubleValue:(double) aDouble;
- (void) bindInt:(NSUInteger) parameterIndex intValue:(int) aInt;
- (void) bindInt64:(NSUInteger) parameterIndex intValue:(sqlite3_int64) aInt;
- (void) bindNull:(NSUInteger) parameterIndex;
- (void) bindText:(NSUInteger) parameterIndex text:(NSString*) text; // encodes as utf8

- (int) bindParameterCount;
- (const char *) bindParameterName:(int) idx;
- (int) bindParameterIndex:(const char*) zName;

- (void) clearBindings;
@end

@interface GtSqliteStatement (Decoding)
- (NSNumber*) integerForColumn:(int) col;
- (NSNumber*) doubleForColumn:(int) col;
- (NSData*) blobForColumn:(int) col;
- (NSString*) textForColumn:(int) col;
@end

@interface NSObject (GtSqlite)
- (void) bindToStatement:(GtSqliteStatement*) statement parameterIndex:(int) parameterIndex;
+ (GtSqliteType) sqlType;
@end