//
//  FLSqlStatement.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSqlStatement.h"
#import "FLGuid.h"
#import "FLSqlBuilder.h"
#import "FLDatabase_Internal.h"
#import "FLCoreTypes.h"

NS_INLINE
sqlite3_stmt* FLStatmentFailed(	sqlite3_stmt* stmt) {
    FLConfirmationFailureWithComment(@"sqlite statement is nil");
    return stmt;
}

#define statement_ (_sqlite3_stmt != nil ? _sqlite3_stmt : FLStatmentFailed(_sqlite3_stmt))

@interface FLSqlStatement ()
@property (readwrite, strong) FLDatabase* database;
@property (readwrite, copy) FLDecodeColumnObjectBlock columnDecoder;
@end

@implementation FLSqlStatement

@synthesize database = _database;
@synthesize columnDecoder = _columnDecoder;
@synthesize stepValue = _stepValue;

+ (id) sqlStatement:(FLDatabase*) database columnDecoder:(FLDecodeColumnObjectBlock) columnDecoder {
    return FLAutorelease([[[self class] alloc] initWithDatabase:database columnDecoder:columnDecoder]);
}

- (id) initWithDatabase:(FLDatabase*) database columnDecoder:(FLDecodeColumnObjectBlock) columnDecoder {
    self = [super init];
    if(self) {
        self.database = database;
        self.columnDecoder = columnDecoder;
        
        FLAssertNotNil(_database);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_columnDecoder release];
    [_database release];
    [super dealloc];
}
#endif

- (void) prepareWithSql:(FLSqlBuilder*) sql {

    FLAssertNotNilWithComment(sql, @"empty sql");
    FLAssertIsNilWithComment(_sqlite3_stmt, @"statement already open");

    const char* sql_c = [[sql sqlString] UTF8String];
    
    if(sqlite3_prepare_v2(_database.sqlite3, sql_c, -1, &_sqlite3_stmt, nil)) {
        [_database throwSqliteError:sql_c];
    }
    
    [sql bindToSqlStatement:self];
}

//- (void) bindAndPrepareStatementForWrite:(NSString *)sqlStatement forObject:(id) object {
//
//    int idx = 1;
//    for(FLDatabaseColumn* column in self.table.columns.objectEnumerator)
//    {
//        id dataToSave = [object valueForKey:column.decodedColumnName];
//                                        
//        if(dataToSave) {
//            [dataToSave bindToStatement:self parameterIndex:idx];
//        }
//        else {
//            [self bindNull:idx];
//        }
//        
//        ++idx;
//    }
//}

- (void) bindBlob:(int) parameterIndex data:(NSData*) data {
	if(!data || data.length == 0) {
		[self bindNull:parameterIndex];
	}
	else {
		if(sqlite3_bind_blob(statement_, parameterIndex, data.bytes, (int) data.length, SQLITE_TRANSIENT)) {
			[_database throwSqliteError:nil];
		}	
	}
}

- (void) bindZeroBlob:(int) parameterIndex size:(int) size  {
	if(sqlite3_bind_zeroblob(statement_, parameterIndex, size)) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindDouble:(int) parameterIndex doubleValue:(double) aDouble {
	if(sqlite3_bind_double(statement_, parameterIndex, aDouble)) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindInt:(int) parameterIndex intValue:(int) aInt {
	if(sqlite3_bind_int(statement_, parameterIndex, aInt)) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindInt64:(int) parameterIndex intValue:(sqlite3_int64) aInt {
	if(sqlite3_bind_int64(statement_, parameterIndex, aInt)) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindNull:(int) parameterIndex {
	int result = sqlite3_bind_null(statement_, parameterIndex);
	if(result) {
		[_database throwSqliteError:nil];
	}	
}

- (void) bindText:(int) parameterIndex text:(NSString*) text 
{
	if(!text || text.length == 0) {
		[self bindNull:parameterIndex];
	}
	else {
		const char* utf8String = [text UTF8String];
		if(sqlite3_bind_text(statement_, parameterIndex, utf8String, (int) strlen(utf8String), SQLITE_TRANSIENT)) {
			[_database throwSqliteError:nil];
		}	
	}
}

- (int) bindParameterCount {
	return sqlite3_bind_parameter_count(statement_);
}

- (const char *) bindParameterName:(int) idx {
	return sqlite3_bind_parameter_name(statement_, idx);
}

- (int) bindParameterIndex:(const char*) zName {
	return sqlite3_bind_parameter_index(statement_, zName);
}

- (void) clearBindings {
	if(sqlite3_clear_bindings(statement_)) {
		[_database throwSqliteError:nil];
	}	
}

- (const void *) column_blob:(int) columnIndex {
    return sqlite3_column_blob(statement_, columnIndex);
}

- (int) column_bytes:(int) columnIndex {
    return sqlite3_column_bytes(statement_, columnIndex);
}

- (int) column_bytes16:(int) columnIndex {
    return sqlite3_column_bytes16(statement_, columnIndex);
}

- (double) column_double:(int) columnIndex {
    return sqlite3_column_double(statement_, columnIndex);
}

- (int) column_int:(int) columnIndex {
    return sqlite3_column_int(statement_, columnIndex);
}

- (sqlite3_int64) column_int64:(int) columnIndex {
    return sqlite3_column_int64(statement_, columnIndex);
}

- (const unsigned char*) column_text:(int) columnIndex {
    return sqlite3_column_text(statement_, columnIndex);
}

- (const void *) column_text16:(int) columnIndex {
    return sqlite3_column_text16(statement_, columnIndex);
}

- (int) column_type:(int) columnIndex {
    return sqlite3_column_type(statement_, columnIndex);
}

- (sqlite3_value*) column_value:(int) columnIndex {
    return sqlite3_column_value(statement_, columnIndex);
}

- (NSNumber*) integerForColumn:(int) col {
	long long intValue = [self column_int64:col];
	
    if(intValue == 0) {
		return [NSNumber numberWithInt:(int)0];
	}
	else if(intValue >= INT32_MAX || intValue <= INT32_MIN) {
		return [NSNumber numberWithLongLong:intValue];
	}
	else if(intValue >= INT16_MAX || intValue <= INT16_MIN) {
		return [NSNumber numberWithLong:(long)intValue];
	}
	else if(intValue >= INT8_MAX || intValue <= INT8_MIN) {
		return [NSNumber numberWithShort:(short)intValue];
	}
	else {
		return [NSNumber numberWithChar:(char)intValue];
	}

	return nil;
}

- (NSString*) textForColumn:(int) col {
	NSString* outString = nil;
	const char* cstr = (const char*) sqlite3_column_text(statement_, col);
	if(cstr) {
		outString = FLAutorelease([[NSString alloc] initWithUTF8String:cstr]);
	}
	
	return outString;
}

- (NSData*) blobForColumn:(int) col {
	return [NSData dataWithBytes:sqlite3_column_blob(statement_, col) 
													length:sqlite3_column_bytes(statement_, col)];
}


- (BOOL) isDone {
    return self.stepValue == SQLITE_DONE;
}

- (NSDictionary*) nextRow {

	int columnCount = self.columnCount;
	NSMutableDictionary* row = nil;
	
	if(columnCount) {
        row = [NSMutableDictionary dictionaryWithCapacity:columnCount]; 
        for(int i = 0; i < columnCount; i++) {
            NSString* colName = [self nameForColumn:i];
            
            FLDatabaseType type = [self typeForColumn:i]; 
            id data = nil;
            switch(type)
            {
                case SQLITE_INTEGER:
                    data = [self integerForColumn:i];
                    FLAssertIsNotNil(data);
                break;
                
                case SQLITE_FLOAT:
                    data = [self doubleForColumn:i];
                    FLAssertIsNotNil(data);
                break;
                
                case SQLITE_BLOB:
                    data = [self blobForColumn:i];
                    FLAssertIsNotNil(data);
                break;
                
                case SQLITE_NULL:
                    data = nil; // to be clear, we don't inflate to NSNULL
                break;
                
                case SQLITE_TEXT:
                    data = [self textForColumn:i];
                    FLAssertIsNotNil(data);
                break;
                
                default:
                    FLAssertFailedWithComment(@"Unknown data type from sqlite: %d", type);
                    break;
            }
        
            if(data && _columnDecoder) {
                data = _columnDecoder(colName, data);
            }

            if(data) {
                [row setObject:data forKey:colName];
            }
        }
	}
    return row;
}

- (NSDictionary*) step {

    NSDictionary* row = nil;

    _stepValue = sqlite3_step(statement_);
    
    switch(_stepValue) {
        case SQLITE_ROW:
            row = [self nextRow];

            FLDbLog(@"%@ -> %@", self.database.fileName, [row description]);
        break;

        case SQLITE_DONE:
            [self finalizeStatement];
        break;

        case SQLITE_BUSY:
        // start over. note we don't support transaction yet, but if we do it will need to be rolled back here
            [self resetStatement];
        break;

        case SQLITE_OK:
            FLAssertFailedWithComment(@"not expecting SQLITE_OK here");
            break;
            
        default:
        case SQLITE_MISUSE:
        case SQLITE_ERROR:
            [_database throwSqliteError:sqlite3_sql(statement_)];
            break;
    } 

	return row;
}

- (NSNumber*) doubleForColumn:(int) col {
	return [NSNumber numberWithDouble:sqlite3_column_double(statement_, col)] ;
}

- (int) columnCount {
    return sqlite3_column_count(statement_);
}

- (NSString*) nameForColumn:(int) column {
    const char* c_colName = sqlite3_column_name(statement_, column);
    NSString* colName = [NSString stringWithCString:c_colName encoding:NSUTF8StringEncoding];
    FLAssertStringIsNotEmptyWithComment(colName, nil);
                
    return colName;
}

- (int) typeForColumn:(int) column {
    return sqlite3_column_type(statement_, column);
}

- (void) resetStatement {
	sqlite3_reset(statement_);
    _stepValue = 0;
}

- (void) finalizeStatement {
	if(_sqlite3_stmt) {
        FLDbLog(@"%@ -> DONE", self.database.fileName);
		sqlite3_finalize(_sqlite3_stmt);
		_sqlite3_stmt = nil;
	}
}

@end

@implementation FLValueEncoder (FLSqlStatement)
+ (FLDatabaseType) sqlType {
    return FLDatabaseTypeObject;
}
@end

@implementation FLNumberObject (FLSqlStatement)
//- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
//	[statement bindInt64:parameterIndex intValue:[self longLongValue]];
//}
+ (FLDatabaseType) sqlType {
    return FLDatabaseTypeInteger;
}
@end

@implementation FLFloatNumber  (FLSqlStatement)
//- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
//	[statement bindDouble:parameterIndex intValue:[self longLongValue]];
//}
+ (FLDatabaseType) sqlType {
    return FLDatabaseTypeFloat;
}
@end

@implementation NSNumber (FLSqlStatement)
- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
	
    switch(CFNumberGetType(bridge_(CFNumberRef, self))) {
		case kCFNumberCGFloatType: 
		case kCFNumberDoubleType:
		case kCFNumberFloatType:
		case kCFNumberFloat32Type:
		case kCFNumberFloat64Type:
			[statement bindDouble:parameterIndex doubleValue:[self doubleValue]];
		break;
		
		case kCFNumberSInt64Type:
		case kCFNumberLongLongType:
			[statement bindInt64:parameterIndex intValue:[self longLongValue]];
		break;
		
		case kCFNumberCFIndexType:
		case kCFNumberCharType:
		case kCFNumberShortType:
		case kCFNumberIntType:
		case kCFNumberLongType:
		case kCFNumberSInt8Type:
		case kCFNumberSInt16Type:
		case kCFNumberSInt32Type:
        case kCFNumberNSIntegerType:
			[statement bindInt:parameterIndex intValue:[self intValue]];
		break;
	}
}
+ (FLDatabaseType) sqlType
{
//	switch(CFNumberGetType((CFNumberRef) self))
//	{
//		case kCFNumberCGFloatType: 
//		case kCFNumberDoubleType:
//		case kCFNumberFloatType:
//		case kCFNumberFloat32Type:
//		case kCFNumberFloat64Type:
//			return FLDatabaseTypeFloat;
//		break;
//		
//		case kCFNumberSInt64Type:
//		case kCFNumberLongLongType:
//		case kCFNumberCFIndexType:
//		case kCFNumberCharType:
//		case kCFNumberShortType:
//		case kCFNumberIntType:
//		case kCFNumberLongType:
//		case kCFNumberSInt8Type:
//		case kCFNumberSInt16Type:
//		case kCFNumberSInt32Type:
//			return FLDatabaseTypeInteger;
//		break;
//	}
	
	return FLDatabaseTypeFloat;
	
}
@end

@implementation NSString (FLSqlStatement) 
- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindText:parameterIndex text:self];
}
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    return string;
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeText;
}
@end

@implementation NSData (FLSqlStatement) 
- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindBlob:parameterIndex data:self];
}

+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeBlob;
}

@end

@implementation NSNull (FLSqlStatement)
- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindNull:parameterIndex];
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeNull;
}

@end

@implementation NSDate (FLSqlStatement)
- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindInt64:parameterIndex intValue:(sqlite3_int64)[self timeIntervalSinceReferenceDate]];
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeFloat;
}
@end

@implementation NSURL (FLSqlStatement) 
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    return [NSURL URLWithString:string];
}
- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
	[statement bindText:parameterIndex text:[self absoluteString]];
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeText;
}
@end

@implementation NSObject (FLSqlStatement)
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data {
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    FLAssertFailedWithComment(@"can't decode an object with a string");
    return nil;
}
- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
	if([self conformsToProtocol:@protocol(NSCoding)]) {
		[statement bindBlob:parameterIndex data:[NSKeyedArchiver archivedDataWithRootObject:self]];
	}
	else {
		// throw error?
	}
}
+ (FLDatabaseType) sqlType {
	return [self conformsToProtocol:@protocol(NSCoding)] ? FLDatabaseTypeBlob : FLDatabaseTypeNone;
}
@end

#import "FLCocoaRequired.h"

@implementation SDKImage (FLSqlStatement)
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data {
	return [SDKImage imageWithData:data];
}
- (void) bindToStatement:(FLSqlStatement*) statement parameterIndex:(int) parameterIndex {
FIXME("osx");
#if IOS
	NSData* data = SDKImageJPEGRepresentation(self, 1.0f);
	[data bindToStatement:statement parameterIndex:parameterIndex];
#endif    
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeObject;
}
@end

//@implementation SDKColor (FLDatabaseIterator) 
//- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex
//{
//	[statement bindText:parameterIndex text:[self toRgbString]];
//}
//+ (FLDatabaseType) sqlType
//{
//	return FLDatabaseTypeColor;
//}
//@end

